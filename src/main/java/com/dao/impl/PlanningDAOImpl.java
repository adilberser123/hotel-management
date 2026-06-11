package com.dao.impl;

import com.dao.PlanningDAO;
import com.db.DBConnexion;
import com.entities.Planning;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;


public class PlanningDAOImpl implements PlanningDAO {

    private Connection connection() throws SQLException {
        return DBConnexion.getConnection();
    }

    public PlanningDAOImpl() {
    }

    @Override
    public boolean isRoomAvailable(int chambreId, Date dateDebut, Date dateFin) {
        boolean available = true;
        String sql = "SELECT * FROM planning WHERE chambre_id = ? AND status = 'occupée' " +
                "AND NOT (date_fin <= ? OR date_debut >= ?)";

        try (Connection conn = connection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            java.sql.Date sqlDateDebut = new java.sql.Date(dateDebut.getTime());
            java.sql.Date sqlDateFin = new java.sql.Date(dateFin.getTime());

            stmt.setInt(1, chambreId);
            stmt.setDate(2, sqlDateDebut); // dateFin <= dateDebut
            stmt.setDate(3, sqlDateFin);   // dateDebut >= dateFin

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                available = false; // chambre déjà réservée à cette période
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return available;
    }


    @Override
    public void addPlanning(Planning planning) {
        String sql = "INSERT INTO planning (chambre_id, reservation_id, date_debut, date_fin, status) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = connection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, planning.getChambre_id());
            stmt.setInt(2, planning.getReservationId());
            stmt.setDate(3, new java.sql.Date(planning.getDateDebut().getTime()));
            stmt.setDate(4, new java.sql.Date(planning.getDateFin().getTime()));
            stmt.setString(5, planning.getStatus());

            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }



}
