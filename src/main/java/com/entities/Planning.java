package com.entities;

import java.util.Date;

public class Planning {
    private int id;
    private int chambre_id;
    private Date dateDebut;
    private Date dateFin;
    private String status;
    private int reservation_id;

    public int getReservationId() {
        return reservation_id;
    }

    public void setReservationId(int reservation_id) {
        this.reservation_id = reservation_id;
    }

    public int getChambre_id() {
        return chambre_id;
    }

    public void setChambre_id(int chambre_id) {
        this.chambre_id = chambre_id;
    }

    public Date getDateFin() {
        return dateFin;
    }

    public void setDateFin(Date dateFin) {
        this.dateFin = dateFin;
    }

    public Date getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(Date dateDebut) {
        this.dateDebut = dateDebut;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
