package com.dao;

import com.entities.Booking;

import java.util.Date;
import java.util.List;

public interface BookingDAO {

    boolean addBooking(Booking booking);
    boolean updateBooking(Booking booking);
    boolean deleteBooking(int bookingId);

    boolean isRoomAvailableForModification(int bookingId, int roomId, Date checkIn, Date checkOut);

    Booking getBookingById(int bookingId);
    List<Booking> getBookingsByUser(int userId);

    Booking getLastBookingByUser(int userId);

    }
