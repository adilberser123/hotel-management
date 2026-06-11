package com.controllers;

import com.dao.IClientDAO;
import com.dao.impl.ClientDAOImpl;
import com.entities.Client;
import org.codehaus.jackson.map.ObjectMapper;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.StringTokenizer;

@WebServlet("/ListeClients/*")
public class ListesDesClients extends HttpServlet {
    private static final long serialVersionUID = 1L;

    IClientDAO clientDAO = null;

    @Override
    public void init(ServletConfig config) throws ServletException {
        clientDAO = new ClientDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("========== doGet appelé ==========");
        System.out.println("URL appelée : " + request.getRequestURL().toString());
        System.out.println("Path Info : " + request.getPathInfo());
        System.out.println("Servlet Path : " + request.getServletPath());
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/ListeClients/list");
            return;
        }

        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("ClientController, doPost method started");

        String action = request.getPathInfo();
        System.out.println("doPost, action ==> " + action);

        if (action != null) {
            switch (action) {
                case "/list":
                    getAllClient(request, response);
                    break;
                case "/create":
                    createNewClient(request, response);
                    break;
                case "/delete":
                    deleteClient(request, response);
                    break;
                case "/get":
                    getClient(request, response);
                    break;
                case "/update":
                    updateClient(request, response);
                    break;
            }
        } else {
            getAllClient(request, response);
        }
    }
    private void getAllClient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Start getting all Clients ...");

        List<Client> clients = clientDAO.getAll();

        System.out.println("getAllClient, clients size ==> " + clients.size());
        request.setAttribute("clients", clients);

        System.out.println("Dans Servlet - testAttribute : " + request.getAttribute("clients")); // test

        RequestDispatcher dispatcher = request.getRequestDispatcher("/listeClients.jsp");
        dispatcher.forward(request, response);
    }


    private void getClient(HttpServletRequest request, HttpServletResponse response) throws IOException {
        System.out.println("Start getting a client ...");

        int id = Integer.parseInt(request.getParameter("clientId"));
        Client client = clientDAO.getById(id);

        ObjectMapper mapper = new ObjectMapper();
        String clientString = mapper.writeValueAsString(client);

        ServletOutputStream servletOutputStream = response.getOutputStream();
        servletOutputStream.write(clientString.getBytes());
    }

    private void deleteClient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Start deleting a client ...");

        String clientIds = request.getParameter("clientIds");
        StringTokenizer tokenizer = new StringTokenizer(clientIds, ",");

        while (tokenizer.hasMoreElements()) {
            int clientId = Integer.parseInt(tokenizer.nextToken());
            clientDAO.delete(clientId);
        }

        // ✅ Correction ici : forward au lieu de redirect
        getAllClient(request, response);
    }

    private void updateClient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Start updating a client ...");

        int id = Integer.parseInt(request.getParameter("id"));
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cin = request.getParameter("cin");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String birthDate = request.getParameter("birthDate");
        String sexe = request.getParameter("sexe");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");

        Client client = new Client(id, email, password, cin, prenom, nom, birthDate, sexe, telephone, adresse);
        clientDAO.update(client);

        // ✅ Correction ici : forward au lieu de redirect
        getAllClient(request, response);
    }

    private void createNewClient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Start adding new client ...");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String cin = request.getParameter("cin");
        String prenom = request.getParameter("prenom");
        String nom = request.getParameter("nom");
        String birthDate = request.getParameter("birthDate");
        String sexe = request.getParameter("sexe");
        String telephone = request.getParameter("telephone");
        String adresse = request.getParameter("adresse");

        Client client = new Client(email, password, cin, prenom, nom, birthDate, sexe, telephone, adresse);
        clientDAO.create(client);

        // ✅ Correction ici : forward au lieu de redirect
        getAllClient(request, response);
    }
}
