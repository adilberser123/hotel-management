package com.dao.impl;

import com.dao.RoomDAO;
import com.db.DBConnexion;
import com.entities.Admin;
import com.entities.Rooms;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAOImpl implements RoomDAO {
    private static Connection connexion = DBConnexion.getConnection();


    @Override
    public boolean addRoom(Rooms room) {
        String sql = "INSERT INTO chambre (type, prix, disponible, admin_id, image) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connexion.prepareStatement(sql)) {
            stmt.setString(1, room.getType());
            stmt.setFloat(2, room.getPrix());
            stmt.setBoolean(3, room.getDisponible());
            stmt.setInt(4, room.getAdministrateur().getId());
            stmt.setString(5, room.getImage());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }





    @Override
    public Rooms getRoomById(int id) {
        String sql = "SELECT r.*, a.email, a.password, a.cin, a.prenom, a.nom " +
                "FROM chambre r JOIN admin a ON r.admin_id = a.id " +
                "WHERE r.id = ?";

        try (PreparedStatement stmt = connexion.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return extractRoomFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Rooms> getAllRooms() {
        List<Rooms> rooms = new ArrayList<>();
        String sql = "SELECT r.*, a.email, a.password, a.cin, a.prenom, a.nom " +
                "FROM chambre r JOIN admin a ON r.admin_id = a.id";
        try (Statement stmt = connexion.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                rooms.add(extractRoomFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    //   toutes les chambres disponibles (sans filtrage de dates)
    @Override
    public List<Rooms> getAllAvailableRooms() {
        List<Rooms> rooms = new ArrayList<>();
        String sql = "SELECT r.*, a.email, a.password, a.cin, a.prenom, a.nom " +
                "FROM chambre r " +
                "JOIN admin a ON r.admin_id = a.id " +
                "WHERE r.disponible = true";

        try (PreparedStatement stmt = connexion.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();

            System.out.println("=== TEST : TOUTES LES CHAMBRES DISPONIBLES ===");
            while (rs.next()) {
                Rooms room = extractRoomFromResultSet(rs);
                rooms.add(room);
                System.out.println("Chambre: ID=" + room.getId() +
                        ", Type=" + room.getType() +
                        ", Prix=" + room.getPrix());
            }
            System.out.println("Total: " + rooms.size() + " chambres disponibles");


        } catch (SQLException e) {
            System.err.println("Erreur SQL dans getAllAvailableRooms: " + e.getMessage());
            e.printStackTrace();
        }

        return rooms;
    }
    @Override
    public boolean updateRoom(Rooms room) {
        String sql = "UPDATE chambre SET type = ?, prix = ?, disponible = ?, admin_id = ?, image = ? WHERE id = ?";
        try (PreparedStatement stmt = connexion.prepareStatement(sql)) {
            stmt.setString(1, room.getType());
            stmt.setFloat(2, room.getPrix());
            stmt.setBoolean(3, room.getDisponible());
            stmt.setInt(4, room.getAdministrateur().getId());
            stmt.setString(5, room.getImage());
            stmt.setInt(6, room.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteRoom(int id) {
        String sql = "DELETE FROM chambre WHERE id = ?";
        try (PreparedStatement stmt = connexion.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Rooms extractRoomFromResultSet(ResultSet rs) throws SQLException {
        Rooms room = new Rooms();
        room.setId(rs.getInt("id"));
        room.setType(rs.getString("type"));
        room.setPrix(rs.getFloat("prix"));
        room.setDisponible(rs.getBoolean("disponible"));
        room.setImage(rs.getString("image"));

        Admin admin = new Admin();
        admin.setId(rs.getInt("admin_id"));
        admin.setEmail(rs.getString("email"));
        admin.setPassword(rs.getString("password"));
        admin.setCin(rs.getString("cin"));
        admin.setPrenom(rs.getString("prenom"));
        admin.setNom(rs.getString("nom"));

        room.setAdministrateur(admin);
        return room;
    }
}