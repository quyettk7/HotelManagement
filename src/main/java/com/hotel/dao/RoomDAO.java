package com.hotel.dao;

import com.hotel.entity.Room;
import com.hotel.entity.RoomImage;
import java.util.List;

public interface RoomDAO {
    List<Room> findAll();
    Room findById(int id);
    boolean insert(Room room);
    boolean update(Room room);
    boolean delete(int id);
    
    // Room Image methods
    List<RoomImage> findImagesByRoomId(int roomId);
    boolean insertImage(RoomImage image);
    boolean deleteImage(int imageId);
}
