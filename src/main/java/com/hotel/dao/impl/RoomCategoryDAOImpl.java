package com.hotel.dao.impl;

import com.hotel.config.DBConnection;
import com.hotel.dao.RoomCategoryDAO;
import com.hotel.entity.RoomCategory;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomCategoryDAOImpl implements RoomCategoryDAO {

    @Override
    public List<RoomCategory> findAll() {
        List<RoomCategory> list = new ArrayList<>();
        String sql = "SELECT * FROM Room_Category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                RoomCategory category = new RoomCategory(
                    rs.getInt("CategoryID"),
                    rs.getNString("CategoryName"),
                    rs.getNString("Description"),
                    rs.getDouble("BasePrice"),
                    rs.getInt("MaxPeople"),
                    rs.getBoolean("Status"),
                    rs.getTimestamp("CreatedAt")
                );
                list.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public RoomCategory findById(int id) {
        String sql = "SELECT * FROM Room_Category WHERE CategoryID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new RoomCategory(
                        rs.getInt("CategoryID"),
                        rs.getNString("CategoryName"),
                        rs.getNString("Description"),
                        rs.getDouble("BasePrice"),
                        rs.getInt("MaxPeople"),
                        rs.getBoolean("Status"),
                        rs.getTimestamp("CreatedAt")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(RoomCategory category) {
        String sql = "INSERT INTO Room_Category(CategoryName, Description, BasePrice, MaxPeople, Status, CreatedAt) " +
                     "VALUES(?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setNString(1, category.getCategoryName());
            ps.setNString(2, category.getDescription());
            ps.setDouble(3, category.getBasePrice());
            ps.setInt(4, category.getMaxPeople());
            ps.setBoolean(5, category.isStatus());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(RoomCategory category) {
        String sql = "UPDATE Room_Category SET CategoryName = ?, Description = ?, BasePrice = ?, MaxPeople = ?, Status = ? " +
                     "WHERE CategoryID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setNString(1, category.getCategoryName());
            ps.setNString(2, category.getDescription());
            ps.setDouble(3, category.getBasePrice());
            ps.setInt(4, category.getMaxPeople());
            ps.setBoolean(5, category.isStatus());
            ps.setInt(6, category.getCategoryId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM Room_Category WHERE CategoryID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Cannot delete RoomCategory ID " + id + " due to dependencies: " + e.getMessage());
            return false;
        }
    }
}
