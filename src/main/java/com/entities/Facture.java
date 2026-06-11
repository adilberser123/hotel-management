package com.entities;
import java.sql.Timestamp;


public class Facture {
    private int id;
    private int clientId;
    private int bookingId;
    private double montant;
    private Timestamp dateFacture;
    private String statut;
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getClientId() {
        return clientId;
    }

    public void setClientId(int clientId) {
        this.clientId = clientId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public double getMontant() {
        return montant;
    }

    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Timestamp getDateFacture() {
        return dateFacture;
    }

    public void setDateFacture(Timestamp dateFacture) {
        this.dateFacture = dateFacture;
    }

    public String getStatut() {
        return statut;
    }

    public void setStatut(String statut) {
        this.statut = statut;
    }
}

