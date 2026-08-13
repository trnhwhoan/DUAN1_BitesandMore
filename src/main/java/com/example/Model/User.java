package com.example.Model;

import java.sql.Date;

public class User {

    private int userId;
    private String fullName;
    private String email;
    private String phoneNumber;
    private String password;
    private String gender;
    private Date dateOfBirth;
    private String address;
    private String role;
    private String status;

    // Constructor không tham số
    public User() {
    }

    // Constructor đầy đủ tham số
    public User(int userId, String fullName, String email, String phoneNumber,
                String password, String gender, Date dateOfBirth,
                String address, String role, String status) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.password = password;
        this.gender = gender;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.role = role;
        this.status = status;
    }

    // Getter và Setter
    public int getUserId() {
        return userId;
    }

    // Alias used by the administration JSP pages.
    public int getId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    // 1. Khai báo thuộc tính avatar (nếu chưa có)
private String avatar;

// 2. Thêm hàm Getter và Setter chuẩn JavaBean
public String getAvatar() {
    return avatar;
}

public void setAvatar(String avatar) {
    this.avatar = avatar;
}
}
