package com.hotel.dao.impl;

import com.hotel.config.DBConnection;
import com.hotel.dao.RoomDAO;
import com.hotel.entity.Room;
import com.hotel.entity.RoomImage;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAOImpl implements RoomDAO {

    @Override
    public List<Room> findAll() {
        List<Room> list = new ArrayList<>();
        String sql = "SELECT r.*, rc.CategoryName FROM Room r " +
                     "JOIN Room_Category rc ON r.CategoryID = rc.CategoryID";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Room room = new Room(
                    rs.getInt("RoomID"),
                    rs.getInt("CategoryID"),
                    rs.getString("RoomNumber"),
                    rs.getNString("RoomName"),
                    rs.getDouble("Price"),
                    rs.getDouble("Acreage"),
                    rs.getInt("Bed"),
                    rs.getNString("Area"),
                    rs.getNString("Description"),
                    rs.getBoolean("Status"),
                    rs.getTimestamp("CreatedAt"),
                    rs.getTimestamp("UpdatedAt")
                );
                room.setCategoryName(rs.getNString("CategoryName"));
                list.add(room);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Room findById(int id) {
        String sql = "SELECT r.*, rc.CategoryName FROM Room r " +
                     "JOIN Room_Category rc ON r.CategoryID = rc.CategoryID " +
                     "WHERE r.RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Room room = new Room(
                        rs.getInt("RoomID"),
                        rs.getInt("CategoryID"),
                        rs.getString("RoomNumber"),
                        rs.getNString("RoomName"),
                        rs.getDouble("Price"),
                        rs.getDouble("Acreage"),
                        rs.getInt("Bed"),
                        rs.getNString("Area"),
                        rs.getNString("Description"),
                        rs.getBoolean("Status"),
                        rs.getTimestamp("CreatedAt"),
                        rs.getTimestamp("UpdatedAt")
                    );
                    room.setCategoryName(rs.getNString("CategoryName"));
                    return room;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean insert(Room room) {
        String sql = "INSERT INTO Room(CategoryID, RoomNumber, RoomName, Price, Acreage, Bed, Area, Description, Status, CreatedAt) " +
                     "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, room.getCategoryId());
            ps.setString(2, room.getRoomNumber());
            ps.setNString(3, room.getRoomName());
            ps.setDouble(4, room.getPrice());
            ps.setDouble(5, room.getAcreage());
            ps.setInt(6, room.getBed());
            ps.setNString(7, room.getArea());
            ps.setNString(8, room.getDescription());
            ps.setBoolean(9, room.isStatus());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean update(Room room) {
        String sql = "UPDATE Room SET CategoryID = ?, RoomNumber = ?, RoomName = ?, Price = ?, Acreage = ?, Bed = ?, Area = ?, Description = ?, Status = ?, UpdatedAt = GETDATE() " +
                     "WHERE RoomID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, room.getCategoryId());
            ps.setString(2, room.getRoomNumber());
            ps.setNString(3, room.getRoomName());
            ps.setDouble(4, room.getPrice());
            ps.setDouble(5, room.getAcreage());
            ps.setInt(6, room.getBed());
            ps.setNString(7, room.getArea());
            ps.setNString(8, room.getDescription());
            ps.setBoolean(9, room.isStatus());
            ps.setInt(10, room.getRoomId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        // First delete all images associated with the room to maintain referential integrity
        String sqlDeleteImages = "DELETE FROM Room_Image WHERE RoomID = ?";
        String sqlDeleteRoom = "DELETE FROM Room WHERE RoomID = ?";
        
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn != null) {
                conn.setAutoCommit(false);
                
                try (PreparedStatement psImg = conn.prepareStatement(sqlDeleteImages)) {
                    psImg.setInt(1, id);
                    psImg.executeUpdate();
                }
                
                try (PreparedStatement psRoom = conn.prepareStatement(sqlDeleteRoom)) {
                    psRoom.setInt(1, id);
                    int res = psRoom.executeUpdate();
                    if (res > 0) {
                        conn.commit();
                        return true;
                    }
                }
                
                conn.rollback();
            }
        } catch (SQLException e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return false;
    }

    @Override
    public List<RoomImage> findImagesByRoomId(int roomId) {
        List<RoomImage> list = new ArrayList<>();
        String sql = "SELECT * FROM Room_Image WHERE RoomID = ? ORDER BY SortOrder";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    RoomImage image = new RoomImage(
                        rs.getInt("ImageID"),
                        rs.getInt("RoomID"),
                        rs.getNString("ImageURL"),
                        rs.getBoolean("IsMain"),
                        rs.getInt("SortOrder")
                    );
                    list.add(image);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean insertImage(RoomImage image) {
        String sql = "INSERT INTO Room_Image(RoomID, ImageURL, IsMain, SortOrder) VALUES(?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, image.getRoomId());
            ps.setNString(2, image.getImageUrl());
            ps.setBoolean(3, image.isIsMain());
            ps.setInt(4, image.getSortOrder());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteImage(int imageId) {
        String sql = "DELETE FROM Room_Image WHERE ImageID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, imageId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
