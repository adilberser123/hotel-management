package com.controllers;

import com.dao.BookingDAO;
import com.dao.PlanningDAO;
import com.dao.RoomDAO;
import com.dao.impl.BookingDAOImpl;
import com.dao.impl.PlanningDAOImpl;
import com.dao.impl.RoomDAOImpl;
import com.entities.Booking;
import com.entities.Client;
import com.entities.Planning;
import com.entities.Rooms;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@WebServlet("/bookRoom")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== BookingServlet - doGet appelé ===");

        HttpSession session = request.getSession(false);

        Client client = null;
        if (session != null) {
            client = (Client) session.getAttribute("user");
        }

        if (client == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String roomIdStr = request.getParameter("roomId");

        if (roomIdStr != null && !roomIdStr.trim().isEmpty()) {
            handleNewBooking(request, response, client, roomIdStr);
        } else {
            displayBookings(request, response, client);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    private void handleNewBooking(HttpServletRequest request, HttpServletResponse response,
                                  Client client, String roomIdStr) throws IOException, ServletException {
        System.out.println("=== Traitement nouvelle réservation avec planning ===");

        try {
            int roomId = Integer.parseInt(roomIdStr);
            String checkIn = request.getParameter("checkInDate");
            String checkOut = request.getParameter("checkOutDate");

            if (checkIn == null || checkIn.isEmpty() || checkOut == null || checkOut.isEmpty()) {
                request.setAttribute("errorMessage", "Veuillez fournir des dates d'arrivée et de départ valides.");
                request.getRequestDispatcher("/reservationForm.jsp").forward(request, response);
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date checkInDate = sdf.parse(checkIn);
            Date checkOutDate = sdf.parse(checkOut);

            PlanningDAO planningDAO = new PlanningDAOImpl();
            boolean disponible = planningDAO.isRoomAvailable(roomId, checkInDate, checkOutDate);

            if (!disponible) {
                request.setAttribute("errorMessage", "Cette chambre n'est pas disponible aux dates choisies.");
                request.getRequestDispatcher("/reservationForm.jsp").forward(request, response);
                return;
            }

            Booking booking = new Booking();
            booking.setUserId(client.getId());
            booking.setRoomId(roomId);
            booking.setDateBooking(java.sql.Date.valueOf(LocalDate.now()).toLocalDate());
            booking.setStatus("en_attente");
            booking.setCheckInDate(checkInDate);
            booking.setCheckOutDate(checkOutDate);

            RoomDAO roomDAO = new RoomDAOImpl();
            Rooms room = roomDAO.getRoomById(roomId);

            long diff = checkOutDate.getTime() - checkInDate.getTime();
            int numberOfNights = (int) (diff / (1000 * 60 * 60 * 24));
            if (numberOfNights <= 0) numberOfNights = 1;

            if (room != null && room.getPrix() != null) {
                double totalPrice = room.getPrix() * numberOfNights;
                booking.setTotalPrice(totalPrice);
            }

            BookingDAO bookingDAO = new BookingDAOImpl();
            boolean success = bookingDAO.addBooking(booking);

            if (success) {
                Booking lastBooking = bookingDAO.getLastBookingByUser(client.getId());
                Planning planning = new Planning();
                planning.setChambre_id(roomId);
                planning.setDateDebut(checkInDate);
                planning.setDateFin(checkOutDate);
                planning.setStatus("occupée");
                planning.setReservationId(lastBooking.getId());

                planningDAO.addPlanning(planning);

                response.sendRedirect(request.getContextPath() + "/bookRoom?success=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/bookRoom?error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/reservationForm.jsp?error=booking_failed");
        }
    }



    private void displayBookings(HttpServletRequest request, HttpServletResponse response,
                                 Client client) throws ServletException, IOException {
        try {
            BookingDAO bookingDAO = new BookingDAOImpl();
            RoomDAO roomDAO = new RoomDAOImpl();

            List<Booking> bookings = bookingDAO.getBookingsByUser(client.getId());

            for (Booking b : bookings) {
                Rooms room = roomDAO.getRoomById(b.getRoomId());
                b.setRoom(room); // image incluse ici
            }

            request.setAttribute("bookings", bookings);
            request.setAttribute("client", client);

            String success = request.getParameter("success");
            String error = request.getParameter("error");

            if ("1".equals(success)) {
                request.setAttribute("successMessage", "Réservation effectuée avec succès !");
            }
            if ("1".equals(error)) {
                request.setAttribute("errorMessage", "Erreur lors de la réservation. Veuillez réessayer.");
            }

            request.getRequestDispatcher("/partieBookings.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur lors de la récupération des réservations");
        }
    }
}
