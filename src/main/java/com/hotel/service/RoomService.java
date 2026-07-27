package com.hotel.service;

import com.hotel.entity.Room;
import com.hotel.entity.RoomImage;
import java.util.List;

public interface RoomService {
    List<Room> getAllRooms();
    Room getRoomById(int id);
    boolean createRoom(Room room);
    boolean updateRoom(Room room);
    boolean deleteRoom(int id);
    
    // Room Image methods
    List<RoomImage> getImagesByRoomId(int roomId);
    boolean addRoomImage(RoomImage image);
    boolean removeRoomImage(int imageId);
}
