package com.example.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.example.Model.Order;
import com.example.Model.OrderDetail;
import com.example.Util.DBContext;

public class OrderDAO {

    /** Returns this user's orders with the latest status recorded in
     * Order_Status_History. The map keys match profile.jsp. */
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

    // Lấy tất cả đơn hàng cho Admin
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT order_id, user_id, recipient_name, recipient_phone, order_date, "
                + "total_amount, COALESCE(final_amount, total_amount) AS final_amount, [status], payment_id, payment_status, shipping_address, shipping_fee "
                + "FROM [Order] ORDER BY order_date DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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
        } catch (Exception e) {
            e.printStackTrace();
            return BigDecimal.ZERO;
        }
    }

    public int getTotalSoldQuantity() {
        String sql = "SELECT COALESCE(SUM(d.quantity), 0) FROM Order_Detail d "
                + "INNER JOIN [Order] o ON o.order_id=d.order_id "
                + "WHERE ISNULL(o.[status], N'Pending') <> N'Cancelled'";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet result = statement.executeQuery()) {
            return result.next() ? result.getInt(1) : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public boolean updateStatus(int orderId, String status) {
        String sql = "UPDATE [Order] SET [status] = ? WHERE order_id = ?";
        String historySql = "INSERT INTO Order_Status_History(order_id, [status], note) VALUES (?, ?, N'Cập nhật từ trang quản trị')";
        try (Connection connection = DBContext.getConnection()) {
            connection.setAutoCommit(false);
            try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setString(1, status);
                ps.setInt(2, orderId);
                if (ps.executeUpdate() != 1) {
                    connection.rollback();
                    return false;
                }
            }
            try (PreparedStatement ps = connection.prepareStatement(historySql)) {
                ps.setInt(1, orderId);
                ps.setString(2, status);
                ps.executeUpdate();
            }
            connection.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Lấy chi tiết đơn hàng theo order_id
    public List<OrderDetail> getByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        String sql = "SELECT od.order_detail_id, od.order_id, od.product_id, od.quantity, od.unit_price, od.subtotal, "
                   + "COALESCE(p.product_name, 'Bánh tươi') AS display_product_name "
                   + "FROM Order_Detail od "
                   + "LEFT JOIN Product p ON od.product_id = p.product_id "
                   + "WHERE od.order_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail detail = new OrderDetail();
                    detail.setId(rs.getInt("order_detail_id"));
                    detail.setOrderId(rs.getInt("order_id"));
                    detail.setProductId(rs.getInt("product_id"));
                    detail.setQuantity(rs.getInt("quantity"));
                    detail.setUnitPrice(rs.getBigDecimal("unit_price"));
                    detail.setSubtotal(rs.getBigDecimal("subtotal"));
                    detail.setProductName(rs.getString("display_product_name"));

                    list.add(detail);
                }
            }
        } catch (Exception e) {
            System.err.println("===> [LỖI SQL] getByOrderId: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // Thêm đơn hàng và các món chi tiết từ CheckoutServlet
    public boolean createOrder(Order order, List<OrderDetail> orderDetails) {
        String orderSql = "INSERT INTO [Order] (user_id, recipient_name, recipient_phone, recipient_email, "
                        + "shipping_address, total_amount, discount_amount, shipping_fee, final_amount, "
                        + "payment_id, payment_status, status, order_date) "
                        + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        String detailSql = "INSERT INTO Order_Detail (order_id, product_id, quantity, unit_price, subtotal) "
                         + "VALUES (?, ?, ?, ?, ?)";

        Connection con = null;
        try {
            con = DBContext.getConnection();
            con.setAutoCommit(false);

            // 1. Thêm vào bảng [Order]
            int orderId = 0;
            try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                ps.setInt(1, order.getUserId());
                ps.setString(2, order.getRecipientName());
                ps.setString(3, order.getRecipientPhone());
                ps.setString(4, order.getRecipientEmail());
                ps.setString(5, order.getShippingAddress());
                ps.setBigDecimal(6, valueOrZero(order.getTotalAmount()));
                ps.setBigDecimal(7, valueOrZero(order.getDiscountAmount()));
                ps.setBigDecimal(8, valueOrZero(order.getShippingFee()));
                ps.setBigDecimal(9, valueOrZero(order.getFinalAmount()));
                ps.setInt(10, order.getPaymentId());
                ps.setString(11, order.getPaymentStatus());
                ps.setString(12, order.getStatus());
                ps.setTimestamp(13, order.getOrderDate());

                int affectedRows = ps.executeUpdate();
                if (affectedRows > 0) {
                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) {
                            orderId = rs.getInt(1);
                        }
                    }
                }
            }

            if (orderId == 0) {
                con.rollback();
                return false;
            }

            // 2. Thêm vào bảng Order_Detail
            try (PreparedStatement detailPs = con.prepareStatement(detailSql)) {
                for (OrderDetail detail : orderDetails) {
                    detailPs.setInt(1, orderId);
                    detailPs.setInt(2, detail.getProductId());
                    detailPs.setInt(3, detail.getQuantity());

                    BigDecimal price = detail.getUnitPrice() != null ? detail.getUnitPrice() : BigDecimal.valueOf(detail.getPrice());
                    BigDecimal subtotal = detail.getSubtotal() != null ? detail.getSubtotal() : price.multiply(BigDecimal.valueOf(detail.getQuantity()));

                    detailPs.setBigDecimal(4, price);
                    detailPs.setBigDecimal(5, subtotal);
                    detailPs.addBatch();
                }
                detailPs.executeBatch();
            }

            con.commit();
            return true;

        } catch (Exception e) {
            if (con != null) {
                try { con.rollback(); } catch (Exception ignored) {}
            }
            System.err.println("===> [LỖI createOrder]: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            if (con != null) {
                try {
                    con.setAutoCommit(true);
                    con.close();
                } catch (Exception ignored) {}
            }
        }
    }

    // Cập nhật đơn hàng
    public void updateOrder(Order order) {
        String sql = "UPDATE [Order] SET user_id=?, recipient_name=?, recipient_phone=?, order_date=?, total_amount=?, status=?, payment_id=?, payment_status=?, shipping_address=?, shipping_fee=? WHERE order_id=?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

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

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private BigDecimal valueOrZero(BigDecimal value) {
        return value != null ? value : BigDecimal.ZERO;
    }
}