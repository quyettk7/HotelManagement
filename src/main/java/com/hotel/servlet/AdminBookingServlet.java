package com.hotel.servlet;
import com.hotel.entity.Booking;
import com.hotel.entity.BookingDetail;
import com.hotel.entity.User;
import com.hotel.service.BookingService;
import com.hotel.service.impl.BookingServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
@WebServlet("/admin/bookings")
public class AdminBookingServlet extends HttpServlet {
    private final BookingService bookingService = new BookingServiceImpl();
    // Valid booking statuses
    private static final String[] VALID_STATUSES = {
        "Chờ xác nhận", "Đã xác nhận", "Đang ở", "Đã trả phòng", "Đã hủy"
    };
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";
        switch (action) {
            case "detail":
                showDetail(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteBooking(request, response);
                break;
            case "list":
            default:
                listBookings(request, response);
                break;
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String subAction = request.getParameter("subAction");
        // Quick status update from list page
        if ("updateStatus".equals(subAction)) {
            updateStatus(request, response);
            return;
        }
        // Full booking update (edit form)
        updateBooking(request, response);
    }
    // ======================== PRIVATE HANDLERS ========================
    private void listBookings(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Booking> list = bookingService.getAllBookings();
        request.setAttribute("bookingList", list);
        request.setAttribute("validStatuses", VALID_STATUSES);
        // Flash messages from session
        passFlashMessages(request);
        request.getRequestDispatcher("/admin/booking-list.jsp").forward(request, response);
    }
    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }
        int id = Integer.parseInt(idStr);
        Booking booking = bookingService.getBookingById(id);
        if (booking == null) {
            request.getSession().setAttribute("error", "Không tìm thấy đặt phòng với mã này.");
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }
        List<BookingDetail> details = bookingService.getDetailsByBookingId(id);
        request.setAttribute("booking", booking);
        request.setAttribute("details", details);
        request.setAttribute("validStatuses", VALID_STATUSES);
        passFlashMessages(request);
        request.getRequestDispatcher("/admin/booking-detail.jsp").forward(request, response);
    }
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }
        int id = Integer.parseInt(idStr);
        Booking booking = bookingService.getBookingById(id);
        if (booking == null) {
            request.getSession().setAttribute("error", "Không tìm thấy đặt phòng.");
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }
        List<BookingDetail> details = bookingService.getDetailsByBookingId(id);
        request.setAttribute("booking", booking);
        request.setAttribute("details", details);
        request.setAttribute("validStatuses", VALID_STATUSES);
        request.getRequestDispatcher("/admin/booking-detail.jsp").forward(request, response);
    }
    private void updateStatus(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("bookingId");
        String status = request.getParameter("status");
        if (idStr != null && !idStr.isEmpty() && status != null && !status.trim().isEmpty()) {
            int bookingId = Integer.parseInt(idStr);
            boolean success = bookingService.updateStatus(bookingId, status.trim());
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật trạng thái đặt phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Cập nhật trạng thái thất bại.");
            }
        }
        // Redirect back to detail or list
        String redirect = request.getParameter("redirect");
        if ("detail".equals(redirect) && idStr != null) {
            response.sendRedirect(request.getContextPath() + "/admin/bookings?action=detail&id=" + idStr);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        }
    }
    private void updateBooking(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        String userIdStr    = request.getParameter("userId");
        String checkInStr   = request.getParameter("checkIn");
        String checkOutStr  = request.getParameter("checkOut");
        String adultStr     = request.getParameter("adult");
        String childrenStr  = request.getParameter("children");
        String totalStr     = request.getParameter("totalAmount");
        String status       = request.getParameter("status");
        String note         = request.getParameter("note");
        // Trim
        if (status != null) status = status.trim();
        if (note != null) note = note.trim();
        // Validate required fields
        if (bookingIdStr == null || checkInStr == null || checkInStr.isEmpty() ||
            checkOutStr == null || checkOutStr.isEmpty() ||
            adultStr == null || adultStr.isEmpty()) {
            request.getSession().setAttribute("error", "Vui lòng nhập đầy đủ thông tin bắt buộc.");
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }
        try {
            int bookingId  = Integer.parseInt(bookingIdStr);
            int userId     = Integer.parseInt(userIdStr);
            Date checkIn   = Date.valueOf(checkInStr);
            Date checkOut  = Date.valueOf(checkOutStr);
            int adult      = Integer.parseInt(adultStr);
            int children   = (childrenStr != null && !childrenStr.isEmpty()) ? Integer.parseInt(childrenStr) : 0;
            double total   = (totalStr != null && !totalStr.isEmpty()) ? Double.parseDouble(totalStr) : 0;
            if (!checkOut.after(checkIn)) {
                request.getSession().setAttribute("error", "Ngày trả phòng phải sau ngày nhận phòng.");
                response.sendRedirect(request.getContextPath() + "/admin/bookings?action=detail&id=" + bookingId);
                return;
            }
            Booking existing = bookingService.getBookingById(bookingId);
            if (existing == null) {
                request.getSession().setAttribute("error", "Không tìm thấy đặt phòng.");
                response.sendRedirect(request.getContextPath() + "/admin/bookings");
                return;
            }
            existing.setUserId(userId);
            existing.setCheckIn(checkIn);
            existing.setCheckOut(checkOut);
            existing.setAdult(adult);
            existing.setChildren(children);
            existing.setTotalAmount(total);
            existing.setStatus(status);
            existing.setNote(note);
            boolean success = bookingService.updateBooking(existing);
            if (success) {
                request.getSession().setAttribute("message", "Cập nhật đặt phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Cập nhật đặt phòng thất bại.");
            }
            response.sendRedirect(request.getContextPath() + "/admin/bookings?action=detail&id=" + bookingId);
        } catch (IllegalArgumentException e) {
            request.getSession().setAttribute("error", "Dữ liệu ngày tháng không hợp lệ.");
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
        }
    }
    private void deleteBooking(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            boolean success = bookingService.deleteBooking(id);
            if (success) {
                request.getSession().setAttribute("message", "Đã xóa đặt phòng thành công.");
            } else {
                request.getSession().setAttribute("error", "Không thể xóa đặt phòng này (có thể có hóa đơn/thanh toán liên kết).");
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/bookings");
    }
    /** Transfer flash messages from session scope to request scope and clear them. */
    private void passFlashMessages(HttpServletRequest request) {
        if (request.getSession().getAttribute("message") != null) {
            request.setAttribute("message", request.getSession().getAttribute("message"));
            request.getSession().removeAttribute("message");
        }
        if (request.getSession().getAttribute("error") != null) {
            request.setAttribute("error", request.getSession().getAttribute("error"));
            request.getSession().removeAttribute("error");
        }
    }
}
