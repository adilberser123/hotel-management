package com.dao.impl;

import com.dao.IClientDAO;
import com.db.DBConnexion;
import com.entities.Client;
import javax.mail.*;
import javax.mail.internet.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;


public class ClientDAOImpl implements IClientDAO {
    private Connection connection() throws SQLException {
        return DBConnexion.getConnection();
    }

    @Override
    public boolean create(Client client) {
        if (isExist(client.getEmail())) {
            return false;
        }

        String sql = "INSERT INTO clients (email, password, cin, prenom, nom, birthDate, sexe, telephone, adresse) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = connection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, client.getEmail());
            stmt.setString(2, client.getPassword());
            stmt.setString(3, client.getCin());
            stmt.setString(4, client.getPrenom());
            stmt.setString(5, client.getNom());
            stmt.setString(6, client.getBirthDate());
            stmt.setString(7, client.getSexe());
            stmt.setString(8, client.getTelephone());
            stmt.setString(9, client.getAdresse());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        client.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean isExist(String email) {

        try {
            String query = "SELECT id FROM clients WHERE email = ?";
            PreparedStatement preSt = connection().prepareStatement(query);

            preSt.setString(1, email);

            ResultSet rs = preSt.executeQuery();

            return rs.next() ? true : false;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    @Override
    public boolean register(Client client) {
        return create(client) ? true : false;
    }

    @Override
    public Client checkLogin(String email, String password) {

        try {
            String query = "SELECT * FROM clients WHERE email = ? AND password = ?";
            PreparedStatement preSt = connection().prepareStatement(query);

            preSt.setString(1, email);
            preSt.setString(2, password);

            ResultSet rs = preSt.executeQuery();

            Client client = null;

            if (rs.next()) {
                int id = rs.getInt("id");
                String cin = rs.getString("cin");
                String prenom = rs.getString("prenom");
                String nom = rs.getString("nom");
                String birthDate = rs.getString("birthDate");
                String sexe = rs.getString("sexe");
                String telephone = rs.getString("telephone");
                String adresse = rs.getString("adresse");

                client = new Client(id, email, password, cin, prenom, nom, birthDate, sexe, telephone, adresse);
            }

            return client;

        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Client getById(int id) {
        String sql = "SELECT * FROM clients WHERE id = ?";

        try (Connection conn = connection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Client(
                            rs.getInt("id"),
                            rs.getString("email"),
                            rs.getString("password"), // Mot de passe en clair
                            rs.getString("cin"),
                            rs.getString("prenom"),
                            rs.getString("nom"),
                            rs.getString("birthDate"),
                            rs.getString("sexe"),
                            rs.getString("telephone"),
                            rs.getString("adresse")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    @Override
    public List<Client> getAll() {
        List<Client> clients = new ArrayList<>();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Connection connection =null;

        try {
            connection = connection();
            System.out.println("Connection successful !");

            String sql = "SELECT * FROM clients";
            System.out.println("Execution de la requete SQL: " + sql);

            ps = connection.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Client client = new Client();
                client.setId(rs.getInt("id"));
                client.setEmail(rs.getString("email"));
                client.setPassword(rs.getString("password"));
                client.setCin(rs.getString("cin"));
                client.setPrenom(rs.getString("prenom"));
                client.setNom(rs.getString("nom"));

                // Conversion de la date
                java.sql.Date sqlDate = rs.getDate("birthDate");
                if (sqlDate != null) {
                    client.setBirthDate(String.valueOf(new java.util.Date(sqlDate.getTime())));
                }

                client.setSexe(rs.getString("sexe"));
                client.setTelephone(rs.getString("telephone"));
                client.setAdresse(rs.getString("adresse"));

                clients.add(client);
                System.out.println("Client ajouteela liste: " + client.getNom() + " " + client.getPrenom());
            }

            System.out.println("Nombre total de clients recuperes: " + clients.size());

        } catch (SQLException e) {
            System.out.println("Erreur lors de la récupération des clients: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Fermeture des ressources (connection, ps, rs)
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return clients;
    }
    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM clients WHERE id = ?";

        try (Connection conn = connection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean update(Client client) {
        String sql = "UPDATE clients SET email = ?, password = ?, cin = ?, prenom = ?, nom = ?, " +
                "birthDate = ?, sexe = ?, telephone = ?, adresse = ? WHERE id = ?";

        try (Connection conn = connection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, client.getEmail());
            stmt.setString(2, client.getPassword()); // Mot de passe en clair
            stmt.setString(3, client.getCin());
            stmt.setString(4, client.getPrenom());
            stmt.setString(5, client.getNom());
            stmt.setString(6, client.getBirthDate());
            stmt.setString(7, client.getSexe());
            stmt.setString(8, client.getTelephone());
            stmt.setString(9, client.getAdresse());
            stmt.setInt(10, client.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public String getRandom() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000); // always 6 digits
        return String.valueOf(otp);
    }

    @Override
    public boolean sendEmail(String toEmail, String otp) {
        final String fromEmail   = "adildaoudhd@gmail.com"; // 🔴 Replace
        final String appPassword = "fgqu ygod sxyn huqm";    // 🔴 Gmail App Password

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, appPassword);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Votre code de vérification - Hotel Management");

            String html =
                    "<div style='font-family:Arial,sans-serif;max-width:420px;margin:auto;"
                            + "border:1px solid #ddd;border-radius:12px;padding:32px;text-align:center;'>"
                            + "<h2 style='color:#0d6efd;'>🏨 Hotel Management</h2>"
                            + "<p style='color:#555;'>Merci de vous inscrire ! Votre code de vérification est :</p>"
                            + "<div style='font-size:40px;font-weight:bold;letter-spacing:10px;"
                            + "color:#0d6efd;margin:24px 0;'>" + otp + "</div>"
                            + "<p style='color:#999;font-size:12px;'>Ce code expire dans <strong>5 minutes</strong>.</p>"
                            + "</div>";

            message.setContent(html, "text/html; charset=utf-8");
            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

}


