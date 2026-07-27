package com.hotel.service.impl;

import com.hotel.dao.RoomDAO;
import com.hotel.dao.impl.RoomDAOImpl;
import com.hotel.entity.Room;
import com.hotel.entity.RoomImage;
import com.hotel.service.RoomService;

import java.util.List;

public class RoomServiceImpl implements RoomService {

    private final RoomDAO roomDAO = new RoomDAOImpl();

    @Override
    public List<Room> getAllRooms() {
        return roomDAO.findAll();
    }

    @Override
    public Room getRoomById(int id) {
        return roomDAO.findById(id);
    }

    @Override
    public boolean createRoom(Room room) {
        if (room.getRoomNumber() == null || room.getRoomNumber().trim().isEmpty() ||
            room.getCategoryId() <= 0 || room.getPrice() < 0) {
            return false;
        }
        return roomDAO.insert(room);
    }

    @Override
    public boolean updateRoom(Room room) {
        if (room.getRoomNumber() == null || room.getRoomNumber().trim().isEmpty() ||
            room.getCategoryId() <= 0 || room.getPrice() < 0) {
            return false;
        }
        return roomDAO.update(room);
    }

    @Override
    public boolean deleteRoom(int id) {
        return roomDAO.delete(id);
    }

    @Override
    public List<RoomImage> getImagesByRoomId(int roomId) {
        return roomDAO.findImagesByRoomId(roomId);
    }

    @Override
    public boolean addRoomImage(RoomImage image) {
        if (image.getImageUrl() == null || image.getImageUrl().trim().isEmpty() || image.getRoomId() <= 0) {
            return false;
        }
        return roomDAO.insertImage(image);
    }

    @Override
    public boolean removeRoomImage(int imageId) {
        return roomDAO.deleteImage(imageId);
    }
}
