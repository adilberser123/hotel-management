package com.controllers;

import com.dao.BookingDAO;
import com.dao.impl.BookingDAOImpl;
import com.entities.Booking;
import com.entities.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;

@WebServlet("/BookingActionServlet")
public class BookingActionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            // On peut loguer ou afficher une erreur propre
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Aucune action spécifiée.");
            return;
        }

        // Sécuriser aussi bookingId : uniquement si nécessaire
        String bookingIdParam = request.getParameter("bookingId");
        int bookingId = 0;
        if (bookingIdParam != null && !bookingIdParam.isEmpty()) {
            try {
                bookingId = Integer.parseInt(bookingIdParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID de réservation invalide.");
                return;
            }
        }

        BookingDAO bookingDAO = new BookingDAOImpl();

        switch (action) {
            case "annuler":
                bookingDAO.deleteBooking(bookingId);
                break;

            case "modifier":
                response.sendRedirect("editBooking.jsp?id=" + bookingId);
                return;

            case "modifierUpdate":
                Booking oldBooking = bookingDAO.getBookingById(bookingId);
                if (oldBooking != null) {
                    try {
                        Date newCheckIn = Date.valueOf(request.getParameter("checkInDate"));
                        Date newCheckOut = Date.valueOf(request.getParameter("checkOutDate"));

                        if (!newCheckIn.before(newCheckOut)) {
                            request.setAttribute("errorMessage", "La date d'arrivée doit être avant la date de départ.");
                            request.setAttribute("booking", oldBooking);
                            request.getRequestDispatcher("editBooking.jsp").forward(request, response);
                            return;
                        }

                        int roomId = Integer.parseInt(request.getParameter("roomId"));

                        boolean dispo = bookingDAO.isRoomAvailableForModification(bookingId, roomId, newCheckIn, newCheckOut);
                        if (!dispo) {
                            request.setAttribute("errorMessage", "La chambre n'est pas disponible aux nouvelles dates.");
                            request.setAttribute("booking", oldBooking);
                            request.getRequestDispatcher("editBooking.jsp").forward(request, response);
                            return;
                        }

                        Booking booking = new Booking();
                        booking.setId(bookingId);
                        booking.setRoomId(roomId);
                        booking.setCheckInDate(newCheckIn);
                        booking.setCheckOutDate(newCheckOut);
                        booking.setStatus(request.getParameter("status"));
                        booking.setUserId(oldBooking.getUserId());
                        booking.setDateBooking(oldBooking.getDateBooking());
                        booking.setTotalPrice(oldBooking.getTotalPrice());

                        bookingDAO.updateBooking(booking);

                    } catch (IllegalArgumentException e) {
                        request.setAttribute("errorMessage", "Format de date invalide.");
                        request.setAttribute("booking", oldBooking);
                        request.getRequestDispatcher("editBooking.jsp").forward(request, response);
                        return;
                    }
                }
                break;

            default:
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action inconnue : " + action);
                return;
        }

        response.sendRedirect(request.getContextPath() + "/bookRoom");
    }

}
