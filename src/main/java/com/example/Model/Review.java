package com.example.Model;

import java.util.Date;

public class Review {

    private int reviewId;
    private int userId;
    private int productId;
    private int rating;
    private String content;
    private Date reviewDate;
    private String userName;
    private String productName;

    public Review() {
    }

    public Review(int reviewId, int userId, int productId, int rating, String content, Date reviewDate) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.productId = productId;
        this.rating = rating;
        this.content = content;
        this.reviewDate = reviewDate;
    }

    public int getReviewId() {
        return reviewId;
    }

    // Aliases and display fields used by admin-reviews.jsp.
    public int getId() {
        return reviewId;
    }

    public Date getCreatedAt() {
        return reviewDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }
}
