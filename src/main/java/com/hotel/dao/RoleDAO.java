package com.hotel.dao;

import com.hotel.entity.Role;
import java.util.List;

public interface RoleDAO {
    List<Role> findAll();
    Role findById(int id);
    boolean insert(Role role);
    boolean update(Role role);
    boolean delete(int id);
}
