package com.controllers;

import com.dao.RoomDAO;
import com.dao.impl.RoomDAOImpl;
import com.entities.Rooms;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/roomss")
public class ClientRoomServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        RoomDAO roomDAO = new RoomDAOImpl();

        List<Rooms> roomsList = roomDAO.getAllAvailableRooms();

        request.setAttribute("rooms", roomsList);

        System.out.println("Nombre de chambres disponibles: " + roomsList.size());

        request.getRequestDispatcher("/partieRooms.jsp").forward(request, response);
    }
}