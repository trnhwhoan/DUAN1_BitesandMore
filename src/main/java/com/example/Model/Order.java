package com.example.Model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Order {
    private int orderId;
    private int userId;
    private String recipientName;
    private String recipientPhone;
    private String recipientEmail;
    private Timestamp createdAt;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal shippingFee;
    private BigDecimal finalAmount;
    private String status;
    private int paymentId;
    private String paymentStatus;
    private String paymentMethod;
    private String shippingAddress;
    private String note;

    public Order() {}

    // Constructor 10 tham số
    public Order(int orderId, int userId, String recipientName, String recipientPhone,
                 String shippingAddress, String paymentMethod, String note,
                 BigDecimal totalAmount, String status, Timestamp createdAt) {
        this.orderId = orderId;
        this.userId = userId;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.shippingAddress = shippingAddress;
        this.paymentMethod = paymentMethod;
        this.note = note;
        this.totalAmount = totalAmount;
        this.status = status;
        this.createdAt = createdAt;
    }

    // Constructor 11 tham số
    public Order(int orderId, int userId, String recipientName, String recipientPhone,
                 Timestamp createdAt, BigDecimal totalAmount, String status,
                 int paymentId, String paymentStatus, String shippingAddress,
                 BigDecimal shippingFee) {
        this.orderId = orderId;
        this.userId = userId;
        this.recipientName = recipientName;
        this.recipientPhone = recipientPhone;
        this.createdAt = createdAt;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentId = paymentId;
        this.paymentStatus = paymentStatus;
        this.shippingAddress = shippingAddress;
        this.shippingFee = shippingFee;
    }

    // ID
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public int getId() { return orderId; }
    public void setId(int id) { this.orderId = id; }

    // User ID
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    // Tên người nhận
    public String getRecipientName() { return recipientName; }
    public void setRecipientName(String recipientName) { this.recipientName = recipientName; }
    public String getCustomerName() { return recipientName; }
    public void setCustomerName(String customerName) { this.recipientName = customerName; }

    // Số điện thoại (Hỗ trợ cả getRecipientPhone và getPhone)
    public String getRecipientPhone() { return recipientPhone; }
    public void setRecipientPhone(String recipientPhone) { this.recipientPhone = recipientPhone; }
    public String getPhoneNumber() { return recipientPhone; }
    public void setPhoneNumber(String phoneNumber) { this.recipientPhone = phoneNumber; }
    public String getPhone() { return recipientPhone; }
    public void setPhone(String phone) { this.recipientPhone = phone; }

    // Email người nhận
    public String getRecipientEmail() { return recipientEmail; }
    public void setRecipientEmail(String recipientEmail) { this.recipientEmail = recipientEmail; }
    public String getEmail() { return recipientEmail; }
    public void setEmail(String email) { this.recipientEmail = email; }

    // Ngày đặt (Hỗ trợ cả getCreatedAt và getOrderDate)
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public Timestamp getOrderDate() { return createdAt; }
    public void setOrderDate(Timestamp orderDate) { this.createdAt = orderDate; }

    // Tiền tổng & Tiền giảm giá & Phí ship
    public BigDecimal getTotalAmount() { return totalAmount; }
    public void setTotalAmount(BigDecimal totalAmount) { this.totalAmount = totalAmount; }
    public BigDecimal getTotalPrice() { return totalAmount; }
    public void setTotalPrice(BigDecimal totalPrice) { this.totalAmount = totalPrice; }

    public BigDecimal getDiscountAmount() { return discountAmount; }
    public void setDiscountAmount(BigDecimal discountAmount) { this.discountAmount = discountAmount; }

    public BigDecimal getShippingFee() { return shippingFee; }
    public void setShippingFee(BigDecimal shippingFee) { this.shippingFee = shippingFee; }

    public BigDecimal getFinalAmount() { return finalAmount != null ? finalAmount : totalAmount; }
    public void setFinalAmount(BigDecimal finalAmount) { this.finalAmount = finalAmount; }

    // Trạng thái đơn hàng
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // Thanh toán
    public int getPaymentId() { return paymentId; }
    public void setPaymentId(int paymentId) { this.paymentId = paymentId; }
    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }
    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    // Địa chỉ nhận hàng
    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }
    public String getAddress() { return shippingAddress; }
    public void setAddress(String address) { this.shippingAddress = address; }

    // Ghi chú
    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}