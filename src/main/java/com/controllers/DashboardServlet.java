package com.controllers;


import com.dao.IClientDAO;
import com.dao.RoomDAO;
import com.dao.impl.ClientDAOImpl;
import com.dao.impl.RoomDAOImpl;
import com.entities.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        IClientDAO clientDAO = new ClientDAOImpl();
        RoomDAO roomDAO = new RoomDAOImpl();


        int nbrClients = clientDAO.getAll().size();
        int nbrChambres = roomDAO.getAllRooms().size();
        int nbrHomme = 0;
        int nbrFemme = 0;
        for (Client client : clientDAO.getAll()) {
            if ("Homme".equalsIgnoreCase(client.getSexe())) {
                nbrHomme++;
            } else if ("Femme".equalsIgnoreCase(client.getSexe())) {
                nbrFemme++;
            }
        }

        String currentDate = LocalDate.now().format(DateTimeFormatter.ofPattern("d MMMM yyyy", Locale.FRENCH));

// Injecter les données dans la requête
        request.setAttribute("nbrClients", nbrClients);
        request.setAttribute("nbrChambres", nbrChambres);
        request.setAttribute("chiffreAffaire", 0);
        request.setAttribute("currentDate", currentDate);
        request.setAttribute("nbrHomme", nbrHomme);
        request.setAttribute("nbrFemme", nbrFemme);

// Redirection vers la page
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);

    }
}

