package com.hotel.dao.impl;

import com.hotel.config.DBConnection;
import com.hotel.dao.RoleDAO;
import com.hotel.entity.Role;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoleDAOImpl implements RoleDAO {

    @Override
    public List<Role> findAll() {
        List<Role> list = new ArrayList<>();
        String sql = "SELECT * FROM Role";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Role role = new Role(
                    rs.getInt("RoleID"),
                    rs.getNString("RoleName"),
                    rs.getNString("Description"),
                    rs.getBoolean("Status")
                );
                list.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Role findById(int id) {
        String sql = "SELECT * FROM Role WHERE RoleID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Role(
                        rs.getInt("RoleID"),
                        rs.getNString("RoleName"),
                        rs.getNString("Description"),
                        rs.getBoolean("Status")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Role role) {
        String sql = "INSERT INTO Role(RoleName, Description, Status) VALUES(?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setNString(1, role.getRoleName());
            ps.setNString(2, role.getDescription());
            ps.setBoolean(3, role.isStatus());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(Role role) {
        String sql = "UPDATE Role SET RoleName = ?, Description = ?, Status = ? WHERE RoleID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setNString(1, role.getRoleName());
            ps.setNString(2, role.getDescription());
            ps.setBoolean(3, role.isStatus());
            ps.setInt(4, role.getRoleId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Role WHERE RoleID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Cannot delete Role ID " + id + " due to dependencies: " + e.getMessage());
            return false;
        }
    }
}
