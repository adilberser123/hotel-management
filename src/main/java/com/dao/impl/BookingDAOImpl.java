package com.dao.impl;

import com.dao.BookingDAO;
import com.db.DBConnexion;
import com.entities.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAOImpl implements BookingDAO {
    private Connection conn;

    public BookingDAOImpl() {
        conn = DBConnexion.getConnection();
    }

    @Override
    public Booking getLastBookingByUser(int userId) {
        Booking booking = null;
        String sql = "SELECT * FROM bookings WHERE user_id = ? ORDER BY id DESC LIMIT 1";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                booking = extractBookingFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return booking;
    }

    @Override
    public boolean addBooking(Booking booking) {
        String sql = "INSERT INTO bookings (user_id, room_id, date_booking, status, payment_status, check_in_date, check_out_date, total_price, paid) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            conn.setAutoCommit(false); // démarrer transaction

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, booking.getUserId());
                ps.setInt(2, booking.getRoomId());
                ps.setDate(3, Date.valueOf(booking.getDateBooking()));
                ps.setString(4, booking.getStatus());

                //  forcer valeur par defaut si null
                String paymentStatus = booking.getPaymentStatus();
                if (paymentStatus == null || paymentStatus.isEmpty()) {
                    paymentStatus = "en attente";
                }
                ps.setString(5, paymentStatus);

                if (booking.getCheckInDate() != null) {
                    ps.setDate(6, new Date(booking.getCheckInDate().getTime()));
                } else {
                    ps.setNull(6, Types.DATE);
                }

                if (booking.getCheckOutDate() != null) {
                    ps.setDate(7, new Date(booking.getCheckOutDate().getTime()));
                } else {
                    ps.setNull(7, Types.DATE);
                }

                if (booking.getTotalPrice() != null) {
                    ps.setDouble(8, booking.getTotalPrice());
                } else {
                    ps.setNull(8, Types.DOUBLE);
                }

                ps.setBoolean(9, booking.isPaid());

                int rowsInserted = ps.executeUpdate();
                if (rowsInserted == 0) {
                    conn.rollback();
                    return false;
                }
            }

            // Mettre la chambre comme occupée
            try (PreparedStatement ps2 = conn.prepareStatement("UPDATE chambre SET disponible = 0 WHERE id = ?")) {
                ps2.setInt(1, booking.getRoomId());
                ps2.executeUpdate();
            }

            // Mettre à jour la disponibilité si check-out déjà passé
            try (PreparedStatement ps3 = conn.prepareStatement(
                    "UPDATE chambre c JOIN bookings b ON c.id = b.room_id "
                            + "SET c.disponible = 1 WHERE b.room_id = ? AND b.check_out_date <= CURRENT_DATE()")) {
                ps3.setInt(1, booking.getRoomId());
                ps3.executeUpdate();
            }

            conn.commit();
            conn.setAutoCommit(true);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                conn.rollback();
                conn.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public boolean updateBooking(Booking booking) {
        String sql = "UPDATE bookings SET user_id = ?, room_id = ?, date_booking = ?, status = ?, "
                + "payment_status = ?, check_in_date = ?, check_out_date = ?, total_price = ?, paid = ? "
                + "WHERE id = ?";

        try {
            conn.setAutoCommit(false); // démarrer transaction

            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, booking.getUserId());
                ps.setInt(2, booking.getRoomId());
                ps.setDate(3, Date.valueOf(booking.getDateBooking()));
                ps.setString(4, booking.getStatus());

                // 🔹 Forcer une valeur par défaut pour payment_status
                String paymentStatus = booking.getPaymentStatus();
                if (paymentStatus == null || paymentStatus.isEmpty()) {
                    paymentStatus = "en attente";
                }
                ps.setString(5, paymentStatus);

                if (booking.getCheckInDate() != null) {
                    ps.setDate(6, new java.sql.Date(booking.getCheckInDate().getTime()));
                } else {
                    ps.setNull(6, Types.DATE);
                }

                if (booking.getCheckOutDate() != null) {
                    ps.setDate(7, new java.sql.Date(booking.getCheckOutDate().getTime()));
                } else {
                    ps.setNull(7, Types.DATE);
                }

                if (booking.getTotalPrice() != null) {
                    ps.setDouble(8, booking.getTotalPrice());
                } else {
                    ps.setNull(8, Types.DOUBLE);
                }

                ps.setBoolean(9, booking.isPaid());
                ps.setInt(10, booking.getId());

                int rowsUpdated = ps.executeUpdate();
                if (rowsUpdated == 0) {
                    conn.rollback();
                    return false;
                }
            }

            // Mettre la chambre comme occupée
            try (PreparedStatement ps2 = conn.prepareStatement("UPDATE chambre SET disponible = 0 WHERE id = ?")) {
                ps2.setInt(1, booking.getRoomId());
                ps2.executeUpdate();
            }

            // Mettre à jour la disponibilité si check-out déjà passé
            try (PreparedStatement ps3 = conn.prepareStatement(
                    "UPDATE chambre c JOIN bookings b ON c.id = b.room_id "
                            + "SET c.disponible = 1 WHERE b.room_id = ? AND b.check_out_date <= CURRENT_DATE()")) {
                ps3.setInt(1, booking.getRoomId());
                ps3.executeUpdate();
            }

            conn.commit();
            conn.setAutoCommit(true);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            try {
                conn.rollback();
                conn.setAutoCommit(true);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public boolean deleteBooking(int bookingId) {
        String sql = "DELETE FROM bookings WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean isRoomAvailableForModification(int bookingId, int roomId, java.util.Date checkIn, java.util.Date checkOut) {
        String sql = "SELECT COUNT(*) FROM bookings "
                + "WHERE room_id = ? AND id != ? AND status != 'annule' "
                + "AND NOT (check_out_date <= ? OR check_in_date >= ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setInt(2, bookingId);
            ps.setDate(3, new java.sql.Date(checkIn.getTime()));
            ps.setDate(4, new java.sql.Date(checkOut.getTime()));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Booking getBookingById(int bookingId) {
        String sql = "SELECT * FROM bookings WHERE id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractBookingFromResultSet(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }



    @Override
    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE user_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(extractBookingFromResultSet(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Méthode pour réduire la duplication
    private Booking extractBookingFromResultSet(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setRoomId(rs.getInt("room_id"));
        b.setDateBooking(rs.getDate("date_booking").toLocalDate());
        b.setStatus(rs.getString("status"));
        b.setPaymentStatus(rs.getString("payment_status"));
        b.setPaid(rs.getBoolean("paid"));

        Date checkIn = rs.getDate("check_in_date");
        if (checkIn != null) b.setCheckInDate(checkIn);

        Date checkOut = rs.getDate("check_out_date");
        if (checkOut != null) b.setCheckOutDate(checkOut);

        double totalPrice = rs.getDouble("total_price");
        if (!rs.wasNull()) b.setTotalPrice(totalPrice);

        return b;
    }

}
