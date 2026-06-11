package com.controllers;

import com.dao.PlanningDAO;
import com.dao.RoomDAO;
import com.dao.impl.PlanningDAOImpl;
import com.dao.impl.RoomDAOImpl;
import com.entities.Rooms;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/searchRooms")
public class SearchRoomsServlet extends HttpServlet {
    private RoomDAO roomDAO;
    private PlanningDAO planningDAO;

    @Override
    public void init() throws ServletException {
        roomDAO = new RoomDAOImpl();
        planningDAO = new PlanningDAOImpl(); // Ajoute du PlanningDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");
        String capacity = request.getParameter("capacity");

        if (checkIn != null && checkOut != null && capacity != null &&
                !checkIn.isEmpty() && !checkOut.isEmpty() && !capacity.isEmpty()) {
            processRequest(request, response);
        } else {
            request.setAttribute("totalResults", 0);
            request.setAttribute("searchPerformed", false);
            request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);
        }
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String checkInStr = request.getParameter("checkIn");
            String checkOutStr = request.getParameter("checkOut");
            String capacityStr = request.getParameter("capacity");

            // Validation des paramètres
            if (checkInStr == null || checkOutStr == null || capacityStr == null ||
                    checkInStr.trim().isEmpty() || checkOutStr.trim().isEmpty() || capacityStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Veuillez sélectionner les dates et le nombre de personnes.");
                request.setAttribute("totalResults", 0);
                request.setAttribute("searchPerformed", true);
                request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);
                return;
            }

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            dateFormat.setLenient(false);

            Date checkIn = dateFormat.parse(checkInStr.trim());
            Date checkOut = dateFormat.parse(checkOutStr.trim());

            // Validation des dates
            Date today = new Date();
            today.setHours(0);
            today.setMinutes(0);
            today.setSeconds(0);

            if (checkIn.before(today)) {
                request.setAttribute("errorMessage", "La date d'arrivée ne peut pas être dans le passé.");
                request.setAttribute("totalResults", 0);
                request.setAttribute("searchPerformed", true);
                request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);
                return;
            }

            if (checkIn.after(checkOut) || checkIn.equals(checkOut)) {
                request.setAttribute("errorMessage", "La date d'arrivée doit être antérieure à la date de départ.");
                request.setAttribute("totalResults", 0);
                request.setAttribute("searchPerformed", true);
                request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);
                return;
            }

            int capacity;
            try {
                capacity = Integer.parseInt(capacityStr.trim());
                if (capacity < 1 || capacity > 10) {
                    throw new NumberFormatException("Capacité invalide");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Nombre de personnes invalide (entre 1 et 10).");
                request.setAttribute("totalResults", 0);
                request.setAttribute("searchPerformed", true);
                request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);
                return;
            }

            // Détermination du type de chambre
            String roomType;
            if (capacity == 1) {
                roomType = "Single";
            } else if (capacity == 2) {
                roomType = "Double";
            } else {
                roomType = "Suite";
            }

            // NOUVELLE APPROCHE : Recherche intégrée avec Planning
            List<Rooms> availableRooms = findAvailableRoomsWithPlanning(checkIn, checkOut, roomType);

            // Calcul du nombre de jours
            long diffInMillis = checkOut.getTime() - checkIn.getTime();
            long numberOfDays = diffInMillis / (1000 * 60 * 60 * 24);

            // Définition des attributs pour la JSP
            request.setAttribute("rooms", availableRooms);
            request.setAttribute("searchPerformed", true);
            request.setAttribute("totalResults", (availableRooms != null) ? availableRooms.size() : 0);
            request.setAttribute("numberOfDays", numberOfDays);
            request.setAttribute("selectedCheckIn", checkInStr);
            request.setAttribute("selectedCheckOut", checkOutStr);
            request.setAttribute("selectedCapacity", capacity);
            request.setAttribute("selectedRoomType", roomType);

            request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);


        } catch (ParseException e) {
            System.err.println("Erreur de format de date: " + e.getMessage());
            request.setAttribute("errorMessage", "Format de date invalide. Utilisez le format YYYY-MM-DD.");
            request.setAttribute("totalResults", 0);
            request.setAttribute("searchPerformed", true);
            request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Erreur générale dans SearchRoomsServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Une erreur s'est produite lors de la recherche. Veuillez réessayer.");
            request.setAttribute("totalResults", 0);
            request.setAttribute("searchPerformed", true);
            request.getRequestDispatcher("/searchRooms.jsp").forward(request, response);
        }
    }

    //  Recherche intégrée avec vérification du planning
    private List<Rooms> findAvailableRoomsWithPlanning(Date checkIn, Date checkOut, String roomType) {
        List<Rooms> availableRooms = new ArrayList<>();

        try {
            //  Récupérer toutes les chambres du type demandé
            List<Rooms> allRooms = roomDAO.getAllRooms();
            System.out.println("Total des chambres dans la base: " + allRooms.size());

            //  Filtrer par type et disponibilité de base
            List<Rooms> roomsByType = allRooms.stream()
                    .filter(room -> room.getType() != null &&
                            room.getType().equalsIgnoreCase(roomType) &&
                            room.getDisponible())
                    .collect(Collectors.toList());

            System.out.println("Chambres du type '" + roomType + "' et disponibles: " + roomsByType.size());

            //  Vérifier la disponibilité via le planning pour chaque chambre
            for (Rooms room : roomsByType) {
                boolean isAvailable = planningDAO.isRoomAvailable(room.getId(), checkIn, checkOut);
                System.out.println("Chambre " + room.getId() + " - Planning disponible: " + isAvailable);

                if (isAvailable) {
                    availableRooms.add(room);
                }
            }

            System.out.println("Chambres finalement disponibles: " + availableRooms.size());

        } catch (Exception e) {
            System.err.println("Erreur lors de la recherche avec planning: " + e.getMessage());
            e.printStackTrace();
        }

        return availableRooms;
    }
}