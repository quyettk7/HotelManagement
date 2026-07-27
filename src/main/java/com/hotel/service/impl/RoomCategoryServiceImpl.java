package com.hotel.service.impl;

import com.hotel.dao.RoomCategoryDAO;
import com.hotel.dao.impl.RoomCategoryDAOImpl;
import com.hotel.entity.RoomCategory;
import com.hotel.service.RoomCategoryService;

import java.util.List;

public class RoomCategoryServiceImpl implements RoomCategoryService {

    private final RoomCategoryDAO categoryDAO = new RoomCategoryDAOImpl();

    @Override
    public List<RoomCategory> getAllCategories() {
        return categoryDAO.findAll();
    }

    @Override
    public RoomCategory getCategoryById(int id) {
        return categoryDAO.findById(id);
    }

    @Override
    public boolean createCategory(RoomCategory category) {
        if (category.getCategoryName() == null || category.getCategoryName().trim().isEmpty() ||
            category.getBasePrice() < 0 || category.getMaxPeople() <= 0) {
            return false;
        }
        return categoryDAO.insert(category);
    }

    @Override
    public boolean updateCategory(RoomCategory category) {
        if (category.getCategoryName() == null || category.getCategoryName().trim().isEmpty() ||
            category.getBasePrice() < 0 || category.getMaxPeople() <= 0) {
            return false;
        }
        return categoryDAO.update(category);
    }

    @Override
    public boolean deleteCategory(int id) {
        return categoryDAO.delete(id);
    }
}
