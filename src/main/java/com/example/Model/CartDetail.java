package com.example.Model;

import java.math.BigDecimal;

public class CartDetail {

    private int cartDetailId;
    private int cartId;
    private int productId;
    private int quantity;
    private BigDecimal unitPrice;
    private Product product;

    public CartDetail(Product product, int quantity2) {
        if (product == null) {
            throw new IllegalArgumentException("Product must not be null");
        }
        this.productId = product.getId();
        this.quantity = quantity2;
        this.unitPrice = product.getPrice();
        this.product = product;
    }

    public CartDetail(int cartDetailId, int cartId, int productId, int quantity) {
        this.cartDetailId = cartDetailId;
        this.cartId = cartId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() { return unitPrice; }

    public void setUnitPrice(BigDecimal unitPrice) { this.unitPrice = unitPrice; }
    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public int getCartDetailId() {
        return cartDetailId;
    }

    public void setCartDetailId(int cartDetailId) {
        this.cartDetailId = cartDetailId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
