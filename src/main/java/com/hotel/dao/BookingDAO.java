package com.hotel.dao;
import com.hotel.entity.Booking;
import com.hotel.entity.BookingDetail;
import java.util.List;
public interface BookingDAO {
    // === Booking CRUD ===
    List<Booking> findAll();
    Booking findById(int id);
    List<Booking> findByUserId(int userId);
    boolean insert(Booking booking);
    boolean update(Booking booking);
    boolean updateStatus(int bookingId, String status);
    boolean delete(int id);
    // === Booking Detail ===
    List<BookingDetail> findDetailsByBookingId(int bookingId);
    boolean insertDetail(BookingDetail detail);
    boolean deleteDetail(int detailId);
    boolean deleteDetailsByBookingId(int bookingId);
}