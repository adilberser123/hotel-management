package com.controllers;

import com.db.DBConnexion;
import com.entities.Admin;
import com.entities.Rooms;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/roomDetails")
public class RoomDetailServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String roomIdParam = request.getParameter("id");
        Rooms roomDetail = null;

        try (Connection conn = DBConnexion.getConnection()) {
            int roomId = Integer.parseInt(roomIdParam);
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM chambre WHERE id = ?");
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                roomDetail = new Rooms();
                roomDetail.setId(rs.getInt("id"));
                roomDetail.setType(rs.getString("type"));
                roomDetail.setPrix(rs.getFloat("prix"));
                roomDetail.setDisponible(rs.getBoolean("disponible"));
                roomDetail.setImage(rs.getString("image"));

                Admin admin = new Admin();
                admin.setId(rs.getInt("admin_id"));
                roomDetail.setAdministrateur(admin);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("roomDetail", roomDetail);
        request.getRequestDispatcher("/partieRoomDetail.jsp").forward(request, response);
    }
}

