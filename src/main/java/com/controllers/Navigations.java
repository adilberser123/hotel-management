package com.controllers;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/navigates")
public class Navigations extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");

        String destination = "profileCLient.jsp";

        switch (page) {
            case "profileCLient":
                destination = "profileCLient.jsp";
                break;
            case "partieRooms":
                destination = "partieRooms.jsp";
                break;
            case "partieBookings":
                destination = "partieBookings.jsp";
                break;
            case "partieServices":
                destination = "partieServices.jsp";
                break;
            case "partieContact":
                destination = "partieContact.jsp";
                break;
            default:

        }

        request.getRequestDispatcher(destination).forward(request, response);
    }
}

