package com.hotel.service.impl;

import com.hotel.dao.RoleDAO;
import com.hotel.dao.impl.RoleDAOImpl;
import com.hotel.entity.Role;
import com.hotel.service.RoleService;

import java.util.List;

public class RoleServiceImpl implements RoleService {

    private final RoleDAO roleDAO = new RoleDAOImpl();

    @Override
    public List<Role> getAllRoles() {
        return roleDAO.findAll();
    }

    @Override
    public Role getRoleById(int id) {
        return roleDAO.findById(id);
    }

    @Override
    public boolean createRole(Role role) {
        // Validation check for empty name
        if (role.getRoleName() == null || role.getRoleName().trim().isEmpty()) {
            return false;
        }
        return roleDAO.insert(role);
    }

    @Override
    public boolean updateRole(Role role) {
        // Validation check for empty name
        if (role.getRoleName() == null || role.getRoleName().trim().isEmpty()) {
            return false;
        }
        return roleDAO.update(role);
    }

    @Override
    public boolean deleteRole(int id) {
        return roleDAO.delete(id);
    }
}
