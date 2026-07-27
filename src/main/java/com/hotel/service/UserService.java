package com.hotel.service;

import com.hotel.entity.User;

public interface UserService {
    /**
     * Thực hiện kiểm tra thông tin đăng nhập của người dùng.
     *
     * @param email Email đăng nhập
     * @param password Mật khẩu
     * @return Đối tượng User nếu đăng nhập thành công và tài khoản hoạt động, ngược lại trả về null
     */
    User login(String email, String password);

    java.util.List<User> getAllUsers();
    User getUserById(int id);
    boolean createUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(int id);
}
