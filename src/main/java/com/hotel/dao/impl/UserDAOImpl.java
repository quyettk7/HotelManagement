package com.hotel.dao.impl;

import com.hotel.config.DBConnection;
import com.hotel.dao.UserDAO;
import com.hotel.entity.User;

import java.sql.*;

public class UserDAOImpl implements UserDAO {

    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setRoleId(rs.getInt("RoleID"));
        user.setFullName(rs.getNString("FullName"));
        user.setEmail(rs.getString("Email"));
        user.setPhone(rs.getString("Phone"));
        user.setPassword(rs.getNString("Password"));
        
        // Handle nullable BIT (Boolean)
        boolean genderVal = rs.getBoolean("Gender");
        if (rs.wasNull()) {
            user.setGender(null);
        } else {
            user.setGender(genderVal);
        }
        
        user.setDateOfBirth(rs.getDate("DateOfBirth"));
        user.setCccd(rs.getString("CCCD"));
        user.setAddress(rs.getNString("Address"));
        user.setNationality(rs.getNString("Nationality"));
        user.setStatus(rs.getBoolean("Status"));
        user.setCreatedAt(rs.getTimestamp("CreatedAt"));
        user.setUpdatedAt(rs.getTimestamp("UpdatedAt"));
        
        // Set transient field
        user.setRoleName(rs.getNString("RoleName"));
        return user;
    }

    @Override
    public User findByEmail(String email) {
        String sql = "SELECT u.*, r.RoleName FROM [User] u " +
                     "JOIN Role r ON u.RoleID = r.RoleID " +
                     "WHERE u.Email = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public java.util.List<User> findAll() {
        java.util.List<User> list = new java.util.ArrayList<>();
        String sql = "SELECT u.*, r.RoleName FROM [User] u " +
                     "JOIN Role r ON u.RoleID = r.RoleID";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToUser(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public User findById(int id) {
        String sql = "SELECT u.*, r.RoleName FROM [User] u " +
                     "JOIN Role r ON u.RoleID = r.RoleID " +
                     "WHERE u.UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(User user) {
        String sql = "INSERT INTO [User] (RoleID, FullName, Email, Phone, Password, Gender, DateOfBirth, CCCD, Address, Nationality, Status, CreatedAt) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getRoleId());
            ps.setNString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setNString(5, user.getPassword());
            if (user.getGender() == null) {
                ps.setNull(6, Types.BIT);
            } else {
                ps.setBoolean(6, user.getGender());
            }
            ps.setDate(7, user.getDateOfBirth());
            ps.setString(8, user.getCccd());
            ps.setNString(9, user.getAddress());
            ps.setNString(10, user.getNationality());
            ps.setBoolean(11, user.isStatus());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(User user) {
        String sql = "UPDATE [User] SET RoleID = ?, FullName = ?, Email = ?, Phone = ?, Password = ?, Gender = ?, DateOfBirth = ?, CCCD = ?, Address = ?, Nationality = ?, Status = ?, UpdatedAt = GETDATE() " +
                     "WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, user.getRoleId());
            ps.setNString(2, user.getFullName());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getPhone());
            ps.setNString(5, user.getPassword());
            if (user.getGender() == null) {
                ps.setNull(6, Types.BIT);
            } else {
                ps.setBoolean(6, user.getGender());
            }
            ps.setDate(7, user.getDateOfBirth());
            ps.setString(8, user.getCccd());
            ps.setNString(9, user.getAddress());
            ps.setNString(10, user.getNationality());
            ps.setBoolean(11, user.isStatus());
            ps.setInt(12, user.getUserId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM [User] WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Cannot delete User ID " + id + " due to dependencies: " + e.getMessage());
            return false;
        }
    }
}
