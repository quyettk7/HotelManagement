package com.hotel.dao;

import com.hotel.entity.RoomCategory;
import java.util.List;

public interface RoomCategoryDAO {
    List<RoomCategory> findAll();
    RoomCategory findById(int id);
    boolean insert(RoomCategory category);
    boolean update(RoomCategory category);
    boolean delete(int id);
}
