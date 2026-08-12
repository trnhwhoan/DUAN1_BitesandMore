package com.example.DAO;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.example.Model.Order;
import com.example.Model.OrderDetail;
import com.example.Util.DBContext;

public class OrderDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Lấy tất cả đơn hàng
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM [Order]";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Order(
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
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
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
                + "recipient_email, total_amount, discount_amount, shipping_fee, final_amount, "
                + "status, payment_id, payment_status, shipping_address, order_note) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String findOrderIdSql = "SELECT TOP 1 order_id FROM [Order] "
                + "WHERE order_note = ?";
        String detailSql = "INSERT INTO Order_Detail "
                + "(order_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBContext.getConnection()) {
            con.setAutoCommit(false);
            String orderToken = "order-token:" + UUID.randomUUID();
            try {
                try (PreparedStatement orderPs = con.prepareStatement(orderSql)) {
                orderPs.setInt(1, order.getUserId());
                orderPs.setString(2, order.getRecipientName());
                orderPs.setString(3, order.getRecipientPhone());
                orderPs.setString(4, order.getRecipientEmail());
                orderPs.setBigDecimal(5, order.getTotalAmount());
                orderPs.setBigDecimal(6, valueOrZero(order.getDiscountAmount()));
                orderPs.setBigDecimal(7, valueOrZero(order.getShippingFee()));
                orderPs.setBigDecimal(8, order.getFinalAmount());
                orderPs.setString(9, order.getStatus());
                orderPs.setInt(10, order.getPaymentId());
                orderPs.setString(11, order.getPaymentStatus());
                    orderPs.setString(12, order.getShippingAddress());
                    orderPs.setString(13, orderToken);
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

    private BigDecimal valueOrZero(BigDecimal value) {
        return value == null ? BigDecimal.ZERO : value;
    }
}
