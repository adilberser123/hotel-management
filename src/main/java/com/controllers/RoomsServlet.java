package com.controllers;

import com.dao.AdminDAO;
import com.dao.RoomDAO;
import com.dao.impl.AdminDAOImpl;
import com.dao.impl.RoomDAOImpl;
import com.entities.Admin;
import com.entities.Rooms;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/rooms")
public class RoomsServlet extends HttpServlet {
    private RoomDAO roomsDao;
    private AdminDAO adminDao;

    @Override
    public void init() {
        roomsDao = new RoomDAOImpl();
        adminDao = new AdminDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Rooms> roomsList = roomsDao.getAllRooms();
        request.setAttribute("rooms", roomsList);
        request.getRequestDispatcher("/rooms.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "ajouter":
                    ajouterRoom(request, response);
                    break;
                case "modifier":
                    modifierRoom(request, response);
                    break;
                case "supprimer":
                    supprimerRoom(request, response);
                    break;
                default:
                    doGet(request, response);
            }
        } else {
            doGet(request, response);
        }
    }

    private void ajouterRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type = request.getParameter("type");
        float prix = Float.parseFloat(request.getParameter("prix"));
        boolean disponible = request.getParameter("disponible") != null;
        int adminId = Integer.parseInt(request.getParameter("adminId"));
        String image = request.getParameter("image");

        Admin admin = adminDao.getById(adminId);
        Rooms room = new Rooms(type, prix, disponible, admin);
        room.setImage(image);
        roomsDao.addRoom(room);

        response.sendRedirect("rooms");
    }

    private void modifierRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String type = request.getParameter("type");
        float prix = Float.parseFloat(request.getParameter("prix"));
        boolean disponible = request.getParameter("disponible") != null;
        int adminId = Integer.parseInt(request.getParameter("adminId"));
        String image = request.getParameter("image");

        Admin admin = adminDao.getById(adminId);
        Rooms room = new Rooms(type, prix, disponible, admin);
        room.setId(id);
        room.setImage(image); // <-- ajout affectation image
        roomsDao.updateRoom(room);

        response.sendRedirect("rooms");
    }

    private void supprimerRoom(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        roomsDao.deleteRoom(id);
        response.sendRedirect("rooms");
    }
}
