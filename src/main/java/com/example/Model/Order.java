package com.example.Model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {

    private int orderId;
    private int userId;
    private String recipientName;
    private String recipientPhone;
    private Timestamp orderDate;
    private BigDecimal totalAmount;
    private String status;
    private int paymentId;
    private String paymentStatus;
    private String shippingAddress;
    private BigDecimal shippingFee;
    private String recipientEmail;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;

    // Constructor rỗng
    public Order() {
    }

    // Constructor đầy đủ
    public Order(int orderId, int userId, String recipientName,
                 String recipientPhone, Timestamp orderDate,
                 BigDecimal totalAmount, String status,
                 int paymentId, String paymentStatus,
                 String shippingAddress, BigDecimal shippingFee) {
        this.orderId = orderId;
        this.userId = userId;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentId = paymentId;
        this.paymentStatus = paymentStatus;
        this.shippingAddress = shippingAddress;
        this.shippingFee = shippingFee;
    }

    public int getOrderId() {
        return orderId;
    }

    // Aliases used by the administration JSP pages.
    public int getId() {
        return orderId;
    }

    public String getCustomerName() {
        return recipientName;
    }

    public Timestamp getCreatedAt() {
        return orderDate;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getRecipientPhone() {
        return recipientPhone;
    }

    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public BigDecimal getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(BigDecimal shippingFee) {
        this.shippingFee = shippingFee;
    }

    public String getRecipientEmail() { return recipientEmail; }
    public void setRecipientEmail(String recipientEmail) { this.recipientEmail = recipientEmail; }
    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }
    public BigDecimal getFinalAmount() { return finalAmount; }
    public void setFinalAmount(BigDecimal finalAmount) { this.finalAmount = finalAmount; }

    public BigDecimal getTotalPrice() {
        return finalAmount != null ? finalAmount : totalAmount;
    }

    public String getAddress() {
        return shippingAddress;
    }

    public String getPhone() {
        return recipientPhone;
    }

}
