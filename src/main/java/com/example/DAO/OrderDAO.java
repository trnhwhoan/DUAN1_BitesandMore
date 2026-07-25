package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Order;
import com.example.Model.OrderDetail;
import com.example.Util.DBContext;

public class OrderDAO {
// 1. Hàm tạo đơn hàng mới (Lưu cả Order và danh sách OrderDetail vào Database)
    @SuppressWarnings("CallToPrintStackTrace")
    public boolean createOrder(Order order, List<OrderDetail> details) {
        String insertOrderSQL = "INSERT INTO orders (user_id, customer_name, phone, address, total_amount, payment_method, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertDetailSQL = "INSERT INTO order_details (order_id, product_id, price, quantity) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        try {
            conn = DBContext.getConnection(); // Thay DBContext bằng class kết nối DB của cưng
            conn.setAutoCommit(false); // Bật Transaction để đảm bảo an toàn dữ liệu

            // Thêm đơn hàng chính
            PreparedStatement psOrder = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS);
            psOrder.setInt(1, order.getUserId());
            psOrder.setString(2, order.getCustomerName());
            psOrder.setString(3, order.getPhone());
            psOrder.setString(4, order.getAddress());
            psOrder.setDouble(5, order.getTotalAmount());
            psOrder.setString(6, order.getPaymentMethod());
            psOrder.setString(7, "Pending");
            psOrder.executeUpdate();

            // Lấy ID tự tăng của đơn hàng vừa tạo
            ResultSet rs = psOrder.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Thêm danh sách các món trong đơn
            PreparedStatement psDetail = conn.prepareStatement(insertDetailSQL);
            for (OrderDetail item : details) {
                psDetail.setInt(1, orderId);
                psDetail.setInt(2, item.getProductId());
                psDetail.setDouble(3, item.getPrice());
                psDetail.setInt(4, item.getQuantity());
                psDetail.addBatch();
            }
            psDetail.executeBatch();

            conn.commit(); // Hoàn tất giao dịch
            return true;
        } catch (Exception e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            }
            e.printStackTrace();
            return false;
        }
    }

    // 2. Lấy danh sách lịch sử đơn hàng của một User
    @SuppressWarnings("CallToPrintStackTrace")
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setPhone(rs.getString("phone"));
                order.setAddress(rs.getString("address"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Object getAllOrders() {
        throw new UnsupportedOperationException("Unimplemented method 'getAllOrders'");
    }
}
