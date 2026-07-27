package com.hotel.service.impl;

import com.hotel.dao.UserDAO;
import com.hotel.dao.impl.UserDAOImpl;
import com.hotel.entity.User;
import com.hotel.service.UserService;

public class UserServiceImpl implements UserService {

    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    public User login(String email, String password) {
        // 1. Tìm kiếm người dùng bằng email
        User user = userDAO.findByEmail(email);
        
        // 2. So sánh mật khẩu (Plain Text)
        if (user != null && user.getPassword().equals(password)) {
            return user; // Trả về user nếu mật khẩu trùng khớp (Servlet sẽ kiểm tra status hoạt động)
        }
        
        return null;
    }

    @Override
    public java.util.List<User> getAllUsers() {
        return userDAO.findAll();
    }

    @Override
    public User getUserById(int id) {
        return userDAO.findById(id);
    }

    @Override
    public boolean createUser(User user) {
        // Validation check
        if (user.getEmail() == null || user.getEmail().trim().isEmpty() ||
            user.getFullName() == null || user.getFullName().trim().isEmpty() ||
            user.getPassword() == null || user.getPassword().trim().isEmpty()) {
            return false;
        }
        return userDAO.insert(user);
    }

    @Override
    public boolean updateUser(User user) {
        // Validation check
        if (user.getEmail() == null || user.getEmail().trim().isEmpty() ||
            user.getFullName() == null || user.getFullName().trim().isEmpty()) {
            return false;
        }
        return userDAO.update(user);
    }

    @Override
    public boolean deleteUser(int id) {
        return userDAO.delete(id);
    }
}
