package com.controllers;

import com.dao.IClientDAO;
import com.dao.impl.ClientDAOImpl;
import com.entities.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/verificationOTP")
public class verificationOTP extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/verificationOTP.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String enteredOtp = request.getParameter("otp");
        HttpSession session = request.getSession();

        String savedOtp  = (String) session.getAttribute("codeOTP");
        Long   expiry    = (Long)   session.getAttribute("otpExpiry");
        Client client    = (Client) session.getAttribute("clientInfo");

        // Guard: missing session data
        if (savedOtp == null || client == null) {
            request.setAttribute("messageErreur", "Session expirée. Veuillez vous réinscrire.");
            request.getRequestDispatcher("/verificationOTP.jsp").forward(request, response);
            return;
        }

        // Guard: OTP expired
        if (expiry != null && System.currentTimeMillis() > expiry) {
            session.removeAttribute("codeOTP");
            session.removeAttribute("otpExpiry");
            session.removeAttribute("clientInfo");
            request.setAttribute("messageErreur", "Le code a expiré. Veuillez vous réinscrire.");
            request.getRequestDispatcher("/verificationOTP.jsp").forward(request, response);
            return;
        }

        // Check OTP
        if (enteredOtp != null && enteredOtp.trim().equals(savedOtp)) {
            // ✅ OTP correct → save client to DB
            IClientDAO clientDAO = new ClientDAOImpl();
            boolean isRegistered = clientDAO.register(client);

            // Clean session
            session.removeAttribute("codeOTP");
            session.removeAttribute("otpExpiry");
            session.removeAttribute("clientInfo");

            if (isRegistered) {
                // Redirect to login
                response.sendRedirect(request.getContextPath() + "/Login?accountType=client");
            } else {
                request.setAttribute("messageErreur", "Erreur lors de l'inscription. Réessayez.");
                request.getRequestDispatcher("/registration.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("messageErreur", "Code incorrect. Réessayez.");
            request.getRequestDispatcher("/verificationOTP.jsp").forward(request, response);
        }
    }
}