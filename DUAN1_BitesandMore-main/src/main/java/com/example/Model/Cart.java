package com.example.Model;

public class Cart {
    private int cartId;
    private int userId;

    public Cart() {
    }

    public Cart(int cartId, int userId, java.util.Date createdAt) {
        this.cartId = cartId;
        this.userId = userId;
    }

    // Getter & Setter
    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

}