package com.hotel.service;
import com.hotel.entity.Booking;
import com.hotel.entity.BookingDetail;
import java.util.List;
public interface BookingService {
    // === Booking ===
    List<Booking> getAllBookings();
    Booking getBookingById(int id);
    List<Booking> getBookingsByUserId(int userId);
    boolean createBooking(Booking booking, List<BookingDetail> details);
    boolean updateBooking(Booking booking);
    boolean updateStatus(int bookingId, String status);
    boolean deleteBooking(int id);
    // === Booking Detail ===
    List<BookingDetail> getDetailsByBookingId(int bookingId);
}
