<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.entities.Booking" %>
<%@ page import="com.dao.impl.BookingDAOImpl" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    // 1. First check if the servlet already put the booking in request scope (error forward)
    Booking booking = (Booking) request.getAttribute("booking");

    // 2. If not (first load via redirect from "modifier" action), fetch from DB
    if (booking == null) {
        // The servlet's "modifier" case redirects with ?id=..., so read "id"
        // The form itself sends "bookingId", so fall back to that too
        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            idParam = request.getParameter("bookingId");
        }
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/bookRoom");
            return;
        }
        try {
            int bookingId = Integer.parseInt(idParam);
            booking = new BookingDAOImpl().getBookingById(bookingId);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/bookRoom");
            return;
        }
    }

    // 3. If booking still null (id not found in DB), bail out cleanly
    if (booking == null) {
        response.sendRedirect(request.getContextPath() + "/bookRoom");
        return;
    }

    String checkInDateStr = "";
    String checkOutDateStr = "";
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    if (booking.getCheckInDate() != null) checkInDateStr = sdf.format(booking.getCheckInDate());
    if (booking.getCheckOutDate() != null) checkOutDateStr = sdf.format(booking.getCheckOutDate());
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier Réservation</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

<div class="max-w-2xl mx-auto bg-white shadow-lg mt-10 p-8 rounded-2xl">
    <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Modifier la réservation</h2>

    <form action="BookingActionServlet" method="post" class="space-y-6">
        <input type="hidden" name="action" value="modifierUpdate" />
        <input type="hidden" name="bookingId" value="<%= booking.getId() %>" />

        <!-- Room ID -->
        <div>
            <label class="block text-gray-700 font-semibold">ID Chambre</label>
            <input type="number" name="roomId" value="<%= booking.getRoomId() %>" class="w-full px-4 py-2 border rounded-lg focus:ring focus:ring-blue-200" required />
        </div>

        <!-- Check-in -->
        <div>
            <label class="block text-gray-700 font-semibold">Date d'arrivée</label>
            <input type="date" name="checkInDate" value="<%= checkInDateStr %>" class="w-full px-4 py-2 border rounded-lg focus:ring focus:ring-blue-200" required />
        </div>

        <!-- Check-out -->
        <div>
            <label class="block text-gray-700 font-semibold">Date de départ</label>
            <input type="date" name="checkOutDate" value="<%= checkOutDateStr %>" class="w-full px-4 py-2 border rounded-lg focus:ring focus:ring-blue-200" required />
        </div>

        <!-- Status -->
        <div>
            <label class="block text-gray-700 font-semibold">Statut</label>
            <select name="status" class="w-full px-4 py-2 border rounded-lg">
                <option value="en_attente" <%= "en_attente".equals(booking.getStatus()) ? "selected" : "" %>>En attente</option>
                <option value="confirme" <%= "confirme".equals(booking.getStatus()) ? "selected" : "" %>>Confirme</option>
                <option value="annule" <%= "annule".equals(booking.getStatus()) ? "selected" : "" %>>Annule</option>
            </select>
        </div>

        <!-- Submit -->
        <div class="text-center">
            <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded-lg hover:bg-blue-700">
                Enregistrer
            </button>
        </div>
    </form>
</div>

</body>
</html>
