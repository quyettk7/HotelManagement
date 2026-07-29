package com.hotel.dao.impl;
import com.hotel.config.DBConnection;
import com.hotel.dao.BookingDAO;
import com.hotel.entity.Booking;
import com.hotel.entity.BookingDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class BookingDAOImpl implements BookingDAO {
    /**
     * Map ResultSet row → Booking object.
     * Query MUST include u.FullName AS UserFullName, u.Email AS UserEmail,
     * u.Phone AS UserPhone, v.VoucherCode AS VoucherCode.
     */
    private Booking mapRow(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setBookingId(rs.getInt("BookingID"));
        b.setUserId(rs.getInt("UserID"));
        int voucherId = rs.getInt("VoucherID");
        b.setVoucherId(rs.wasNull() ? null : voucherId);
        b.setBookingCode(rs.getString("BookingCode"));
        b.setBookingDate(rs.getTimestamp("BookingDate"));
        b.setCheckIn(rs.getDate("CheckIn"));
        b.setCheckOut(rs.getDate("CheckOut"));
        b.setAdult(rs.getInt("Adult"));
        b.setChildren(rs.getInt("Children"));
        b.setTotalAmount(rs.getDouble("TotalAmount"));
        b.setStatus(rs.getNString("Status"));
        b.setNote(rs.getNString("Note"));
        // Transient fields from JOIN
        b.setUserFullName(rs.getNString("UserFullName"));
        b.setUserEmail(rs.getString("UserEmail"));
        b.setUserPhone(rs.getString("UserPhone"));
        try {
            b.setVoucherCode(rs.getString("VoucherCode"));
        } catch (SQLException e) {
            // VoucherCode may be null when no voucher
            b.setVoucherCode(null);
        }
        return b;
    }
    @Override
    public List<Booking> findAll() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, " +
                     "u.FullName AS UserFullName, u.Email AS UserEmail, u.Phone AS UserPhone, " +
                     "v.VoucherCode AS VoucherCode " +
                     "FROM Booking b " +
                     "JOIN [User] u ON b.UserID = u.UserID " +
                     "LEFT JOIN Voucher v ON b.VoucherID = v.VoucherID " +
                     "ORDER BY b.BookingDate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    @Override
    public Booking findById(int id) {
        String sql = "SELECT b.*, " +
                     "u.FullName AS UserFullName, u.Email AS UserEmail, u.Phone AS UserPhone, " +
                     "v.VoucherCode AS VoucherCode " +
                     "FROM Booking b " +
                     "JOIN [User] u ON b.UserID = u.UserID " +
                     "LEFT JOIN Voucher v ON b.VoucherID = v.VoucherID " +
                     "WHERE b.BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    @Override
    public List<Booking> findByUserId(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, " +
                     "u.FullName AS UserFullName, u.Email AS UserEmail, u.Phone AS UserPhone, " +
                     "v.VoucherCode AS VoucherCode " +
                     "FROM Booking b " +
                     "JOIN [User] u ON b.UserID = u.UserID " +
                     "LEFT JOIN Voucher v ON b.VoucherID = v.VoucherID " +
                     "WHERE b.UserID = ? " +
                     "ORDER BY b.BookingDate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    @Override
    public boolean insert(Booking booking) {
        String sql = "INSERT INTO Booking (UserID, VoucherID, BookingCode, BookingDate, CheckIn, CheckOut, " +
                     "Adult, Children, TotalAmount, Status, Note) " +
                     "VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getUserId());
            if (booking.getVoucherId() == null) {
                ps.setNull(2, Types.INTEGER);
            } else {
                ps.setInt(2, booking.getVoucherId());
            }
            ps.setString(3, booking.getBookingCode());
            ps.setDate(4, booking.getCheckIn());
            ps.setDate(5, booking.getCheckOut());
            ps.setInt(6, booking.getAdult());
            ps.setInt(7, booking.getChildren());
            ps.setDouble(8, booking.getTotalAmount());
            ps.setNString(9, booking.getStatus());
            ps.setNString(10, booking.getNote());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean update(Booking booking) {
        String sql = "UPDATE Booking SET UserID = ?, VoucherID = ?, CheckIn = ?, CheckOut = ?, " +
                     "Adult = ?, Children = ?, TotalAmount = ?, Status = ?, Note = ? " +
                     "WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, booking.getUserId());
            if (booking.getVoucherId() == null) {
                ps.setNull(2, Types.INTEGER);
            } else {
                ps.setInt(2, booking.getVoucherId());
            }
            ps.setDate(3, booking.getCheckIn());
            ps.setDate(4, booking.getCheckOut());
            ps.setInt(5, booking.getAdult());
            ps.setInt(6, booking.getChildren());
            ps.setDouble(7, booking.getTotalAmount());
            ps.setNString(8, booking.getStatus());
            ps.setNString(9, booking.getNote());
            ps.setInt(10, booking.getBookingId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean updateStatus(int bookingId, String status) {
        String sql = "UPDATE Booking SET Status = ? WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setNString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean delete(int id) {
        // Delete details first due to FK constraint
        String sqlDetails = "DELETE FROM Booking_Detail WHERE BookingID = ?";
        String sqlBooking = "DELETE FROM Booking WHERE BookingID = ?";
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn != null) {
                conn.setAutoCommit(false);
                try (PreparedStatement ps1 = conn.prepareStatement(sqlDetails)) {
                    ps1.setInt(1, id);
                    ps1.executeUpdate();
                }
                try (PreparedStatement ps2 = conn.prepareStatement(sqlBooking)) {
                    ps2.setInt(1, id);
                    int rows = ps2.executeUpdate();
                    if (rows > 0) {
                        conn.commit();
                        return true;
                    }
                }
                conn.rollback();
            }
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
        return false;
    }
    // ===== Booking Detail =====
    @Override
    public List<BookingDetail> findDetailsByBookingId(int bookingId) {
        List<BookingDetail> list = new ArrayList<>();
        String sql = "SELECT bd.*, r.RoomNumber, r.RoomName, rc.CategoryName " +
                     "FROM Booking_Detail bd " +
                     "JOIN Room r ON bd.RoomID = r.RoomID " +
                     "JOIN Room_Category rc ON r.CategoryID = rc.CategoryID " +
                     "WHERE bd.BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    BookingDetail detail = new BookingDetail(
                        rs.getInt("BookingDetailID"),
                        rs.getInt("BookingID"),
                        rs.getInt("RoomID"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"),
                        rs.getDouble("Total")
                    );
                    detail.setRoomNumber(rs.getString("RoomNumber"));
                    detail.setRoomName(rs.getNString("RoomName"));
                    detail.setCategoryName(rs.getNString("CategoryName"));
                    list.add(detail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    @Override
    public boolean insertDetail(BookingDetail detail) {
        String sql = "INSERT INTO Booking_Detail (BookingID, RoomID, Price, Quantity, Total) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detail.getBookingId());
            ps.setInt(2, detail.getRoomId());
            ps.setDouble(3, detail.getPrice());
            ps.setInt(4, detail.getQuantity());
            ps.setDouble(5, detail.getTotal());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean deleteDetail(int detailId) {
        String sql = "DELETE FROM Booking_Detail WHERE BookingDetailID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, detailId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    @Override
    public boolean deleteDetailsByBookingId(int bookingId) {
        String sql = "DELETE FROM Booking_Detail WHERE BookingID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
