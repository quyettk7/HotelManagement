package com.hotel.entity;

import java.sql.Timestamp;

public class RoomCategory {
    private int categoryId;
    private String categoryName;
    private String description;
    private double basePrice;
    private int maxPeople;
    private boolean status;
    private Timestamp createdAt;

    public RoomCategory() {
    }

    public RoomCategory(int categoryId, String categoryName, String description, double basePrice,
                        int maxPeople, boolean status, Timestamp createdAt) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.description = description;
        this.basePrice = basePrice;
        this.maxPeople = maxPeople;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public int getMaxPeople() {
        return maxPeople;
    }

    public void setMaxPeople(int maxPeople) {
        this.maxPeople = maxPeople;
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

    @Override
    public String toString() {
        return "RoomCategory{" +
                "categoryId=" + categoryId +
                ", categoryName='" + categoryName + '\'' +
                ", basePrice=" + basePrice +
                ", maxPeople=" + maxPeople +
                ", status=" + status +
                '}';
    }
}
