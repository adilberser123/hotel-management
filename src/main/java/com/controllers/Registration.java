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

@WebServlet("/Registration")
public class Registration extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Registration() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/registration.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// ── 1. Collect form data ──────────────────────────────────────────────
		String nom       = request.getParameter("nom");
		String prenom    = request.getParameter("prenom");
		String sexe      = request.getParameter("sexe");
		String adresse   = request.getParameter("adresse");
		String birthDate = request.getParameter("birthDate");
		String cin       = request.getParameter("cin");
		String telephone = request.getParameter("telephone");
		String email     = request.getParameter("email");
		String password  = request.getParameter("password");

		IClientDAO clientDAO = new ClientDAOImpl();

		// ── 2. Check if email is already taken ───────────────────────────────
		boolean isExist = clientDAO.isExist(email);

		if (isExist) {
			request.setAttribute("messageErreur", "Cette adresse email est déjà utilisée !");
			request.getRequestDispatcher("/registration.jsp").forward(request, response);
			return;
		}

		// ── 3. Generate OTP and send it by email ─────────────────────────────
		String codeOTP     = clientDAO.getRandom();
		boolean isSendEmail = clientDAO.sendEmail(email, codeOTP);

		System.out.println("sendEmail = " + isSendEmail); // debug

		if (!isSendEmail) {
			request.setAttribute("messageErreur", "Échec de l'envoi de l'e-mail de vérification !");
			request.getRequestDispatcher("/registration.jsp").forward(request, response);
			return;
		}

		// ── 4. Store OTP + expiry (5 min) + client data in session ───────────
		//      NOTE: client is NOT saved to the DB yet — only after OTP confirmed
		HttpSession session = request.getSession();
		session.setAttribute("codeOTP",    codeOTP);
		session.setAttribute("otpExpiry",  System.currentTimeMillis() + 5 * 60 * 1000L);
		session.setAttribute("clientInfo", new Client(email, password, cin, prenom, nom, birthDate, sexe, telephone, adresse));

		// ── 5. Forward to OTP verification page ──────────────────────────────
		request.getRequestDispatcher("/verificationOTP.jsp").forward(request, response);
	}
}