package com.entities;

import java.time.LocalDate;
import java.util.Date;

public class Booking {
    private int id;
    private int userId;
    private int roomId;
    private LocalDate dateBooking;
    private String status;
    private Rooms room;
    private Double totalPrice;
    private String paymentStatus; // Ajouter ce champ
    private boolean paid;
    private Client client;

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public boolean isPaid() {
        return paid;
    }

    public void setPaid(boolean paid) {
        this.paid = paid;
    }

    // Getter
    public String getPaymentStatus() {
        return paymentStatus;
    }

    // Setter
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(Double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Rooms getRoom() {
        return room;
    }

    public void setRoom(Rooms room) {
        this.room = room;
    }
    private Date checkInDate;
    private Date checkOutDate;

    public Date getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(Date checkInDate) {
        this.checkInDate = checkInDate;
    }

    public Date getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(Date checkOutDate) {
        this.checkOutDate = checkOutDate;
    }


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public LocalDate getDateBooking() { return dateBooking; }
    public void setDateBooking(LocalDate dateBooking) { this.dateBooking = dateBooking; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
