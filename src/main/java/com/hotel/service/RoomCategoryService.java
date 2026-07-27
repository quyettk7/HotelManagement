package com.hotel.service;

import com.hotel.entity.RoomCategory;
import java.util.List;

public interface RoomCategoryService {
    List<RoomCategory> getAllCategories();
    RoomCategory getCategoryById(int id);
    boolean createCategory(RoomCategory category);
    boolean updateCategory(RoomCategory category);
    boolean deleteCategory(int id);
}
