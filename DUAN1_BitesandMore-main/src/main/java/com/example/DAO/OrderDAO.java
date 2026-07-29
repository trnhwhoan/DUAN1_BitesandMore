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

public class OrderDAO {

    private Connection conn;

    public OrderDAO() {
        this.conn = conn;
    }


    // 1. Tạo đơn hàng
    public int insert(Order order) throws SQLException {

        String sql = """
            INSERT INTO [Order]
            (
                user_id,
                recipient_name,
                recipient_phone,
                total_amount,
                status,
                payment_method,
                payment_status,
                shipping_fee
            )
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;


        PreparedStatement ps = conn.prepareStatement(
                sql,
                Statement.RETURN_GENERATED_KEYS
        );

        ps.setInt(1, order.getUserId());
        ps.setString(2, order.getCustomerName());
        ps.setString(3, order.getPhone());
        ps.setDouble(4, order.getTotalAmount());
        ps.setString(5, order.getStatus());
        ps.setString(6, order.getPaymentMethod());
        ps.setString(7, order.getPaymentStatus());
        ps.setDouble(8, order.getShippingFee());


        ps.executeUpdate();


        ResultSet rs = ps.getGeneratedKeys();

        if (rs.next()) {
            return rs.getInt(1);
        }

        return -1;
    }



    // 2. Lấy đơn hàng theo id
    public Order findById(int orderId) throws SQLException {

        String sql = """
            SELECT *
            FROM [Order]
            WHERE order_id = ?
        """;


        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, orderId);

        ResultSet rs = ps.executeQuery();


        if (rs.next()) {

            Order order = new Order();

            order.setId(rs.getInt("order_id"));
            order.setUserId(rs.getInt("user_id"));
            order.setCustomerName(rs.getString("recipient_name"));
            order.setPhone(rs.getString("recipient_phone"));
            order.setCreatedAt(rs.getTimestamp("order_date"));
            order.setTotalAmount(rs.getDouble("total_amount"));
            order.setStatus(rs.getString("status"));
            order.setPaymentMethod(rs.getString("payment_method"));
            order.setPaymentStatus(rs.getString("payment_status"));
            order.setShippingFee(
                    rs.getDouble("shipping_fee")
            );

            return order;
        }

        return null;
    }



    // 3. Lấy danh sách đơn hàng của user
    public List<Order> findByUserId(int userId) throws SQLException {

        List<Order> list = new ArrayList<>();


        String sql = """
            SELECT *
            FROM [Order]
            WHERE user_id = ?
            ORDER BY order_date DESC
        """;


        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);


        ResultSet rs = ps.executeQuery();


        while(rs.next()) {

            Order order = new Order();

            order.setId(rs.getInt("order_id"));
            order.setUserId(rs.getInt("user_id"));
            order.setCustomerName(
                    rs.getString("recipient_name")
            );
            order.setPhone(
                    rs.getString("recipient_phone")
            );
            order.setCreatedAt(
                    rs.getTimestamp("order_date")
            );
            order.setTotalAmount(
                    rs.getDouble("total_amount")
            );
            order.setStatus(
                    rs.getString("status")
            );
            order.setPaymentMethod(
                    rs.getString("payment_method")
            );
            order.setPaymentStatus(
                    rs.getString("payment_status")
            );
            order.setShippingFee(
                    rs.getDouble("shipping_fee")
            );
            list.add(order);
        }
        return list;
    }



    // 4. Cập nhật trạng thái đơn hàng
    public void updateStatus(int orderId, String status)
            throws SQLException {


        String sql = """
            UPDATE [Order]
            SET status = ?
            WHERE order_id = ?
        """;


        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, status);
        ps.setInt(2, orderId);

        ps.executeUpdate();
    }



    // 5. Cập nhật trạng thái thanh toán
    public void updatePaymentStatus(
            int orderId,
            String paymentStatus
    ) throws SQLException {


        String sql = """
            UPDATE [Order]
            SET payment_status = ?
            WHERE order_id = ?
        """;


        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, paymentStatus);
        ps.setInt(2, orderId);

        ps.executeUpdate();
    }



    // 6. Xóa đơn hàng
    public void delete(int orderId)
            throws SQLException {


        String sql = """
            DELETE FROM [Order]
            WHERE order_id = ?
        """;


        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);

        ps.executeUpdate();
    }


    public boolean createOrder(Order order, List<OrderDetail> orderDetails) {
        // TODO Auto-generated method stub
        throw new UnsupportedOperationException("Unimplemented method 'createOrder'");
    }
}