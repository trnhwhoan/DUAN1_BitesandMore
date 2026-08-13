package com.example.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.example.Model.Order;
import com.example.Model.OrderDetail;
import com.example.Util.DBContext;

public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    /** Returns this user's orders with the latest status recorded in
     * Order_Status_History.  The map keys intentionally match profile.jsp. */
    public List<Map<String, Object>> getOrdersByUserId(int userId) {
        List<Map<String, Object>> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.order_date, o.shipping_address, "
                + "COALESCE(o.final_amount, o.total_amount) AS total_price, "
                + "COALESCE(h.status, o.status) AS current_status "
                + "FROM [Order] o OUTER APPLY ("
                + " SELECT TOP 1 [status] FROM Order_Status_History "
                + " WHERE order_id = o.order_id "
                + " ORDER BY created_at DESC, history_id DESC"
                + ") h WHERE o.user_id = ? "
                + "ORDER BY o.order_date DESC, o.order_id DESC";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            try (ResultSet result = statement.executeQuery()) {
                while (result.next()) {
                    Map<String, Object> order = new HashMap<>();
                    order.put("id", result.getInt("order_id"));
                    order.put("createdAt", result.getTimestamp("order_date"));
                    order.put("address", result.getString("shipping_address"));
                    order.put("totalPrice", result.getBigDecimal("total_price"));
                    order.put("status", result.getString("current_status"));
                    orders.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orders;
    }

    /** A customer may review a product only after placing a non-cancelled order. */
    public boolean hasUserPurchasedProduct(int userId, int productId) {
        String sql = "SELECT 1 FROM [Order] o "
                + "INNER JOIN Order_Detail d ON d.order_id = o.order_id "
                + "WHERE o.user_id = ? AND d.product_id = ? "
                + "AND ISNULL(o.[status], N'Pending') <> N'Cancelled'";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, userId);
            statement.setInt(2, productId);
            try (ResultSet result = statement.executeQuery()) {
                return result.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT order_id, user_id, recipient_name, recipient_phone, order_date, "
                + "total_amount, COALESCE(final_amount, total_amount) AS final_amount, [status], payment_id, payment_status, shipping_address, shipping_fee "
                + "FROM [Order] ORDER BY order_date DESC";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("recipient_name"),
                        rs.getString("recipient_phone"),
                        rs.getTimestamp("order_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("status"),
                        rs.getInt("payment_id"),
                        rs.getString("payment_status"),
                        rs.getString("shipping_address"),
                        rs.getBigDecimal("shipping_fee")
                );
                order.setFinalAmount(rs.getBigDecimal("final_amount"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public BigDecimal getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(COALESCE(final_amount, total_amount)), 0) "
                + "FROM [Order] WHERE ISNULL([status], N'Pending') <> N'Cancelled'";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            return result.next() ? result.getBigDecimal(1) : BigDecimal.ZERO;
        } catch (Exception e) { e.printStackTrace(); return BigDecimal.ZERO; }
    }

    public int getTotalSoldQuantity() {
        String sql = "SELECT COALESCE(SUM(d.quantity), 0) FROM Order_Detail d "
                + "INNER JOIN [Order] o ON o.order_id=d.order_id "
                + "WHERE ISNULL(o.[status], N'Pending') <> N'Cancelled'";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            return result.next() ? result.getInt(1) : 0;
        } catch (Exception e) { e.printStackTrace(); return 0; }
    }

    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE [Order] SET [status] = ? WHERE order_id = ?";
        String historySql = "INSERT INTO Order_Status_History(order_id, [status], note) VALUES (?, ?, N'Cập nhật từ trang quản trị')";
        try (Connection connection = DBContext.getConnection()) {
            connection.setAutoCommit(false);
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, status); ps.setInt(2, orderId);
                if (ps.executeUpdate() != 1) { connection.rollback(); return false; }
            }
            try (PreparedStatement ps = connection.prepareStatement(historySql)) {
                ps.setInt(1, orderId); ps.setString(2, status); ps.executeUpdate();
            }
            connection.commit(); return true;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // Lấy đơn hàng theo ID
    public Order getOrderById(int id) {
        String sql = "SELECT * FROM [Order] WHERE order_id=?";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new Order(
                        rs.getInt("order_id"),
                        rs.getInt("user_id"),
                        rs.getString("recipient_name"),
                        rs.getString("recipient_phone"),
                        rs.getTimestamp("order_date"),
                        rs.getBigDecimal("total_amount"),
                        rs.getString("status"),
                        rs.getInt("payment_id"),
                        rs.getString("payment_status"),
                        rs.getString("shipping_address"),
                        rs.getBigDecimal("shipping_fee")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Thêm đơn hàng
    public void insertOrder(Order order) {
        String sql = "INSERT INTO [Order](user_id, recipient_name, recipient_phone, order_date, total_amount, status, payment_id, payment_status, shipping_address, shipping_fee) VALUES(?,?,?,?,?,?,?,?,?,?)";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getRecipientName());
            ps.setString(3, order.getRecipientPhone());
            ps.setTimestamp(4, order.getOrderDate());
            ps.setBigDecimal(5, order.getTotalAmount());
            ps.setString(6, order.getStatus());
            ps.setInt(7, order.getPaymentId());
            ps.setString(8, order.getPaymentStatus());
            ps.setString(9, order.getShippingAddress());
            ps.setBigDecimal(10, order.getShippingFee());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật đơn hàng
    public void updateOrder(Order order) {
        String sql = "UPDATE [Order] SET user_id=?, recipient_name=?, recipient_phone=?, order_date=?, total_amount=?, status=?, payment_id=?, payment_status=?, shipping_address=?, shipping_fee=? WHERE order_id=?";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setInt(1, order.getUserId());
            ps.setString(2, order.getRecipientName());
            ps.setString(3, order.getRecipientPhone());
            ps.setTimestamp(4, order.getOrderDate());
            ps.setBigDecimal(5, order.getTotalAmount());
            ps.setString(6, order.getStatus());
            ps.setInt(7, order.getPaymentId());
            ps.setString(8, order.getPaymentStatus());
            ps.setString(9, order.getShippingAddress());
            ps.setBigDecimal(10, order.getShippingFee());
            ps.setInt(11, order.getOrderId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa đơn hàng
    public void deleteOrder(int id) {
        String sql = "DELETE FROM [Order] WHERE order_id=?";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean createOrder(Order order, List<OrderDetail> orderDetails) {
        if (order == null || orderDetails == null || orderDetails.isEmpty()) {
            return false;
        }

        String orderSql = "INSERT INTO [Order] (user_id, recipient_name, recipient_phone, "
                + "recipient_email, order_date, total_amount, discount_amount, shipping_fee, final_amount, "
                + "status, payment_id, payment_status, shipping_address, order_note) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String findOrderIdSql = "SELECT TOP 1 order_id FROM [Order] "
                + "WHERE order_note = ?";
        String detailSql = "INSERT INTO Order_Detail "
                + "(order_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
        String reserveStockSql = "UPDATE Product SET quantity = quantity - ? "
                + "WHERE product_id = ? AND status = N'Active' AND quantity >= ?";

        try (Connection con = DBContext.getConnection()) {
            con.setAutoCommit(false);
            String orderToken = "order-token:" + UUID.randomUUID();
            try {
                try (PreparedStatement stockPs = con.prepareStatement(reserveStockSql)) {
                    for (OrderDetail detail : orderDetails) {
                        stockPs.setInt(1, detail.getQuantity());
                        stockPs.setInt(2, detail.getProductId());
                        stockPs.setInt(3, detail.getQuantity());
                        if (stockPs.executeUpdate() != 1) {
                            throw new SQLException("Product is unavailable or has insufficient stock.");
                        }
                    }
                }
                try (PreparedStatement orderPs = con.prepareStatement(orderSql)) {
                orderPs.setInt(1, order.getUserId());
                orderPs.setString(2, order.getRecipientName());
                orderPs.setString(3, order.getRecipientPhone());
                orderPs.setString(4, order.getRecipientEmail());
                if (order.getOrderDate() == null) {
                    throw new SQLException("Order time is missing.");
                }
                orderPs.setTimestamp(5, order.getOrderDate());
                orderPs.setBigDecimal(6, order.getTotalAmount());
                orderPs.setBigDecimal(7, valueOrZero(order.getDiscountAmount()));
                orderPs.setBigDecimal(8, valueOrZero(order.getShippingFee()));
                orderPs.setBigDecimal(9, order.getFinalAmount());
                orderPs.setString(10, order.getStatus());
                orderPs.setInt(11, order.getPaymentId());
                orderPs.setString(12, order.getPaymentStatus());
                    orderPs.setString(13, order.getShippingAddress());
                    orderPs.setString(14, orderToken);
                    orderPs.executeUpdate();
                }

            int orderId;
                try (PreparedStatement idPs = con.prepareStatement(findOrderIdSql)) {
                idPs.setString(1, orderToken);
                try (ResultSet idRs = idPs.executeQuery()) {
                    if (!idRs.next()) {
                        throw new SQLException("Unable to retrieve the created order ID.");
                    }
                    orderId = idRs.getInt("order_id");
                }
                }

                // Giữ lại ID thật để trang xác nhận không hiển thị #BM-0.
                order.setOrderId(orderId);

                try (PreparedStatement detailPs = con.prepareStatement(detailSql)) {
                for (OrderDetail detail : orderDetails) {
                    detailPs.setInt(1, orderId);
                    detailPs.setInt(2, detail.getProductId());
                    detailPs.setInt(3, detail.getQuantity());
                    detailPs.setBigDecimal(4, detail.getUnitPrice());
                    detailPs.setBigDecimal(5, detail.getSubtotal());
                    detailPs.addBatch();
                }
                detailPs.executeBatch();
                }

                con.commit();
                return true;
            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
public boolean createOrder(Order order) {
    // 1. Thêm cột created_at vào câu lệnh SQL
    String sql = "INSERT INTO Orders (user_id, total_price, status, address, phone, created_at) "
               + "VALUES (?, ?, ?, ?, ?, ?)";
               
    try (Connection conn = DBContext.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, order.getUserId());
        ps.setBigDecimal(2, order.getTotalPrice());
        ps.setString(3, "Pending");
        ps.setString(4, order.getAddress());
        ps.setString(5, order.getPhone());

        // 2. LẤY CHUẨN GIỜ VIỆT NAM (UTC+7) VÀ TRUYỀN VÀO SQL
        java.time.LocalDateTime nowVietnam = java.time.LocalDateTime.now(java.time.ZoneId.of("Asia/Ho_Chi_Minh"));
        ps.setTimestamp(6, java.sql.Timestamp.valueOf(nowVietnam));

        return ps.executeUpdate() > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    private BigDecimal valueOrZero(BigDecimal value) {
        return value != null ? value : BigDecimal.ZERO;
    }
}
