package com.controllers;
import com.dao.AdminDAO;
import com.dao.IClientDAO;
import com.dao.impl.AdminDAOImpl;
import com.dao.impl.ClientDAOImpl;
import com.entities.Admin;
import com.entities.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accountType = request.getParameter("accountType");

		HttpSession session = request.getSession();
		session.setAttribute("accountType", accountType);

		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		HttpSession session = request.getSession();
		String accountType = (String) session.getAttribute("accountType");

		if (accountType != null && accountType.equalsIgnoreCase("client"))  {

			IClientDAO clientDAO = new ClientDAOImpl();
			Client client = clientDAO.checkLogin(email, password);

			if (client != null) {
				session.setAttribute("user", client);
				request.getRequestDispatcher("/profileCLient.jsp").forward(request, response);
				System.out.println("User login successful (client)");
			} else {
				String messageErreur = "L adresse email ou le mot de passe est incorrect !";
				request.setAttribute("messageErreur", messageErreur);
				request.getRequestDispatcher("/login.jsp").forward(request, response);
				System.out.println("User login failure (client)");
			}

		}else if (accountType.equalsIgnoreCase("admin")) {

			AdminDAO adminDAO = new AdminDAOImpl();
			Admin admin = adminDAO.checkLogin(email, password);

			if (admin != null) {
				session.setAttribute("user", admin);
				response.sendRedirect("dashboard");

				System.out.println("User login successful (admin)");
			} else {
				String messageErreur = "L'adresse email ou le mot de passe est incorrect !";
				request.setAttribute("messageErreur", messageErreur);
				request.getRequestDispatcher("/login.jsp").forward(request, response);
				System.out.println("User login failure (admin)");
			}
		}
	}
}
