package com.hotel.service.impl;
import com.hotel.dao.BookingDAO;
import com.hotel.dao.impl.BookingDAOImpl;
import com.hotel.entity.Booking;
import com.hotel.entity.BookingDetail;
import com.hotel.service.BookingService;
import java.util.List;
public class BookingServiceImpl implements BookingService {
    private final BookingDAO bookingDAO = new BookingDAOImpl();
    @Override
    public List<Booking> getAllBookings() {
        return bookingDAO.findAll();
    }
    @Override
    public Booking getBookingById(int id) {
        return bookingDAO.findById(id);
    }
    @Override
    public List<Booking> getBookingsByUserId(int userId) {
        return bookingDAO.findByUserId(userId);
    }
    @Override
    public boolean createBooking(Booking booking, List<BookingDetail> details) {
        // Business validation
        if (booking.getBookingCode() == null || booking.getBookingCode().trim().isEmpty()) {
            return false;
        }
        if (booking.getCheckIn() == null || booking.getCheckOut() == null) {
            return false;
        }
        if (!booking.getCheckOut().after(booking.getCheckIn())) {
            return false;
        }
        if (booking.getAdult() <= 0) {
            return false;
        }
        boolean inserted = bookingDAO.insert(booking);
        if (!inserted) return false;
        // Insert details if provided
        if (details != null && !details.isEmpty()) {
            // Retrieve the just-inserted booking by code to get its generated ID
            // The servlet should set the bookingId on each detail before calling this
            for (BookingDetail detail : details) {
                bookingDAO.insertDetail(detail);
            }
        }
        return true;
    }
    @Override
    public boolean updateBooking(Booking booking) {
        if (booking.getCheckIn() == null || booking.getCheckOut() == null) {
            return false;
        }
        if (!booking.getCheckOut().after(booking.getCheckIn())) {
            return false;
        }
        return bookingDAO.update(booking);
    }
    @Override
    public boolean updateStatus(int bookingId, String status) {
        if (status == null || status.trim().isEmpty()) {
            return false;
        }
        return bookingDAO.updateStatus(bookingId, status);
    }
    @Override
    public boolean deleteBooking(int id) {
        return bookingDAO.delete(id);
    }
    @Override
    public List<BookingDetail> getDetailsByBookingId(int bookingId) {
        return bookingDAO.findDetailsByBookingId(bookingId);
    }
}
