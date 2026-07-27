package com.hotel.dao;

import com.hotel.entity.User;

public interface UserDAO {
    /**
     * Tìm kiếm người dùng bằng email.
     *
     * @param email Email của người dùng
     * @return Đối tượng User nếu tìm thấy, ngược lại trả về null
     */
    User findByEmail(String email);
    
    java.util.List<User> findAll();
    User findById(int id);
    boolean insert(User user);
    boolean update(User user);
    boolean delete(int id);
}
