package com.hotel.entity;

public class RoomImage {
    private int imageId;
    private int roomId;
    private String imageUrl;
    private boolean isMain;
    private int sortOrder;

    public RoomImage() {
    }

    public RoomImage(int imageId, int roomId, String imageUrl, boolean isMain, int sortOrder) {
        this.imageId = imageId;
        this.roomId = roomId;
        this.imageUrl = imageUrl;
        this.isMain = isMain;
        this.sortOrder = sortOrder;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isIsMain() {
        return isMain;
    }

    public void setIsMain(boolean isMain) {
        this.isMain = isMain;
    }

    public int getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(int sortOrder) {
        this.sortOrder = sortOrder;
    }

    @Override
    public String toString() {
        return "RoomImage{" +
                "imageId=" + imageId +
                ", roomId=" + roomId +
                ", imageUrl='" + imageUrl + '\'' +
                ", isMain=" + isMain +
                '}';
    }
}
