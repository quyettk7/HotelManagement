package com.hotel.service;

import com.hotel.entity.Role;
import java.util.List;

public interface RoleService {
    List<Role> getAllRoles();
    Role getRoleById(int id);
    boolean createRole(Role role);
    boolean updateRole(Role role);
    boolean deleteRole(int id);
}
