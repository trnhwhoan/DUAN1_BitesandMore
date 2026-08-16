package com.example.Model;

import java.math.BigDecimal;

public class Product {

    private int productId;
    private String productName;
    private String description;
    private BigDecimal price;
    private String image;
    private String ingredient;
    private int expiryDate;
    private String status;
    private int quantity;
    private String usageInstructions;
    private int categoryId;
    private float rating;
    private int soldQuantity;

    // Constructor rỗng
    public Product() {
    }

    // Constructor đầy đủ
    public Product(int productId, String productName, String description,
                   BigDecimal price, String image, String ingredient,
                   int expiryDate, String status, int quantity,
                   String usageInstructions, int categoryId, float rating) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.price = price;
        this.image = image;
        this.ingredient = ingredient;
        this.expiryDate = expiryDate;
        this.status = status;
        this.quantity = quantity;
        this.usageInstructions = usageInstructions;
        this.categoryId = categoryId;
        this.rating = rating;
    }

    public int getId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getIngredient() {
        return ingredient;
    }

    public void setIngredient(String ingredient) {
        this.ingredient = ingredient;
    }

    public int getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(int expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getUsageInstructions() {
        return usageInstructions;
    }

    public void setUsageInstructions(String usageInstructions) {
        this.usageInstructions = usageInstructions;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public float getRating() {
        return rating;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public void setImageUrl(String imageUrl) {
    this.image = imageUrl; // hoặc this.imageUrl = imageUrl (tùy tên biến bạn đặt)
}

public String getImageUrl() {
    return this.image != null ? this.image : this.image;
}
}
