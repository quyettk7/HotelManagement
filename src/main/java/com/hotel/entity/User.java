package com.hotel.entity;

import java.sql.Date;
import java.sql.Timestamp;

public class User {
    private int userId;
    private int roleId;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private Boolean gender; // true: Nam, false: Nữ, null: Khác
    private Date dateOfBirth;
    private String cccd;
    private String address;
    private String nationality;
    private boolean status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Transient fields (không lưu trong bảng User trực tiếp, lấy từ JOIN)
    private String roleName;

    public User() {
    }

    public User(int userId, int roleId, String fullName, String email, String phone, String password,
                Boolean gender, Date dateOfBirth, String cccd, String address, String nationality,
                boolean status, Timestamp createdAt, Timestamp updatedAt) {
        this.userId = userId;
        this.roleId = roleId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.cccd = cccd;
        this.address = address;
        this.nationality = nationality;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Boolean getGender() {
        return gender;
    }

    public void setGender(Boolean gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getCccd() {
        return cccd;
    }

    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    @Override
    public String toString() {
        return "User{" +
                "userId=" + userId +
                ", roleId=" + roleId +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", gender=" + gender +
                ", dateOfBirth=" + dateOfBirth +
                ", cccd='" + cccd + '\'' +
                ", address='" + address + '\'' +
                ", nationality='" + nationality + '\'' +
                ", status=" + status +
                ", createdAt=" + createdAt +
                ", updatedAt=" + updatedAt +
                ", roleName='" + roleName + '\'' +
                '}';
    }
}
