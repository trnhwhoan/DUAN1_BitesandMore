package com.example.Model;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int userId;
    private int productId;
    private int rating;
    private String content;
    private String status = "Active";
    private Timestamp reviewDate;
    private String userName;
    private String productName;

    public Review() {}

    public Review(int reviewId, int userId, int productId, int rating, String content, Timestamp reviewDate) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.content = content;
        this.reviewDate = reviewDate;
        this.status = "Active";
    }

    // Getter & Setter Review ID (hỗ trợ cả getReviewId và getId)
    public int getReviewId() { return reviewId; }
    public void setReviewId(int reviewId) { this.reviewId = reviewId; }
    public int getId() { return reviewId; }
    public void setId(int id) { this.reviewId = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // Getter & Setter Ngày (hỗ trợ cả reviewDate và createdAt)
    public Timestamp getReviewDate() { return reviewDate; }
    public void setReviewDate(Timestamp reviewDate) { this.reviewDate = reviewDate; }
    public Timestamp getCreatedAt() { return reviewDate; }
    public void setCreatedAt(Timestamp createdAt) { this.reviewDate = createdAt; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
}