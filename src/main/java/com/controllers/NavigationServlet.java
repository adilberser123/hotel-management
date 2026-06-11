package com.controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/navigate")
public class NavigationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");

        String destination = "";

        switch (page) {
            case "Dashboard":
                destination = "/dashboard.jsp";
                break;
            case "rooms":
                destination = "/rooms.jsp";
                break;
            case "bookings":
                destination = "/reservations.jsp";
                break;
            case "clients":
                destination = "/listeClients.jsp";
                break;
            case "invoice":
                destination = "/invoice.jsp";
                break;
            case "service":
                destination = "/service.jsp";
                break;
            default:
                destination = "/404.jsp"; // page erreur simple
        }

        request.getRequestDispatcher(destination).forward(request, response);
    }
}

