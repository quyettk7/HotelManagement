package com.hotel.entity;
import java.sql.Date;
import java.sql.Timestamp;
public class Booking {
    private int bookingId;
    private int userId;
    private Integer voucherId; // nullable
    private String bookingCode;
    private Timestamp bookingDate;
    private Date checkIn;
    private Date checkOut;
    private int adult;
    private int children;
    private double totalAmount;
    private String status;
    private String note;
    // Transient fields (from JOIN)
    private String userFullName;
    private String userEmail;
    private String userPhone;
    private String voucherCode;
    public Booking() {
    }
    public Booking(int bookingId, int userId, Integer voucherId, String bookingCode,
                   Timestamp bookingDate, Date checkIn, Date checkOut,
                   int adult, int children, double totalAmount, String status, String note) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.voucherId = voucherId;
        this.bookingCode = bookingCode;
        this.bookingDate = bookingDate;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.adult = adult;
        this.children = children;
        this.totalAmount = totalAmount;
        this.status = status;
        this.note = note;
    }
    // ===== Getters & Setters =====
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public Integer getVoucherId() { return voucherId; }
    public void setVoucherId(Integer voucherId) { this.voucherId = voucherId; }
    public String getBookingCode() { return bookingCode; }
    public void setBookingCode(String bookingCode) { this.bookingCode = bookingCode; }
    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }
    public Date getCheckIn() { return checkIn; }
    public void setCheckIn(Date checkIn) { this.checkIn = checkIn; }
    public Date getCheckOut() { return checkOut; }
    public void setCheckOut(Date checkOut) { this.checkOut = checkOut; }
    public int getAdult() { return adult; }
    public void setAdult(int adult) { this.adult = adult; }
    public int getChildren() { return children; }
    public void setChildren(int children) { this.children = children; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
    // Transient getters/setters
    public String getUserFullName() { return userFullName; }
    public void setUserFullName(String userFullName) { this.userFullName = userFullName; }
    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    public String getUserPhone() { return userPhone; }
    public void setUserPhone(String userPhone) { this.userPhone = userPhone; }
    public String getVoucherCode() { return voucherCode; }
    public void setVoucherCode(String voucherCode) { this.voucherCode = voucherCode; }
    @Override
    public String toString() {
        return "Booking{" +
                "bookingId=" + bookingId +
                ", bookingCode='" + bookingCode + '\'' +
                ", checkIn=" + checkIn +
                ", checkOut=" + checkOut +
                ", status='" + status + '\'' +
                ", totalAmount=" + totalAmount +
                '}';
    }
}