package com.hotel.entity;
public class BookingDetail {
    private int bookingDetailId;
    private int bookingId;
    private int roomId;
    private double price;
    private int quantity;
    private double total;
    // Transient fields (from JOIN)
    private String roomNumber;
    private String roomName;
    private String categoryName;
    public BookingDetail() {
    }
    public BookingDetail(int bookingDetailId, int bookingId, int roomId,
                         double price, int quantity, double total) {
        this.bookingDetailId = bookingDetailId;
        this.bookingId = bookingId;
        this.roomId = roomId;
        this.price = price;
        this.quantity = quantity;
        this.total = total;
    }
    // ===== Getters & Setters =====
    public int getBookingDetailId() { return bookingDetailId; }
    public void setBookingDetailId(int bookingDetailId) { this.bookingDetailId = bookingDetailId; }
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }
    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    // Transient getters/setters
    public String getRoomNumber() { return roomNumber; }
    public void setRoomNumber(String roomNumber) { this.roomNumber = roomNumber; }
    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    @Override
    public String toString() {
        return "BookingDetail{" +
                "bookingDetailId=" + bookingDetailId +
                ", roomId=" + roomId +
                ", price=" + price +
                ", quantity=" + quantity +
                ", total=" + total +
                '}';
    }
}
