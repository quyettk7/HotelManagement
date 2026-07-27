package com.hotel.entity;

import java.sql.Timestamp;

public class Room {
    private int roomId;
    private int categoryId;
    private String roomNumber;
    private String roomName;
    private double price;
    private double acreage;
    private int bed;
    private String area;
    private String description;
    private boolean status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Transient fields
    private String categoryName;

    public Room() {
    }

    public Room(int roomId, int categoryId, String roomNumber, String roomName, double price,
                double acreage, int bed, String area, String description, boolean status,
                Timestamp createdAt, Timestamp updatedAt) {
        this.roomId = roomId;
        this.categoryId = categoryId;
        this.roomNumber = roomNumber;
        this.roomName = roomName;
        this.price = price;
        this.acreage = acreage;
        this.bed = bed;
        this.area = area;
        this.description = description;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getRoomName() {
        return roomName;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getAcreage() {
        return acreage;
    }

    public void setAcreage(double acreage) {
        this.acreage = acreage;
    }

    public int getBed() {
        return bed;
    }

    public void setBed(int bed) {
        this.bed = bed;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "Room{" +
                "roomId=" + roomId +
                ", categoryId=" + categoryId +
                ", roomNumber='" + roomNumber + '\'' +
                ", roomName='" + roomName + '\'' +
                ", price=" + price +
                ", status=" + status +
                '}';
    }
}
