package com.example.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Payment;

public class PaymentDAO {

    private Connection conn;

    public PaymentDAO(Connection conn) {
        this.conn = conn;
    }


    // 1. Lấy tất cả phương thức thanh toán
    public List<Payment> findAll() throws SQLException {
        List<Payment> list = new ArrayList<>();

        String sql = "SELECT * FROM Payment";

        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Payment payment = new Payment();

            payment.setPaymentId(rs.getInt("payment_id"));
            payment.setPaymentName(rs.getString("payment_name"));

            list.add(payment);
        }

        return list;
    }


    // 2. Lấy payment theo id
    public Payment findById(int paymentId) throws SQLException {

        String sql = """
            SELECT * FROM Payment
            WHERE payment_id = ?
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, paymentId);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Payment payment = new Payment();

            payment.setPaymentId(rs.getInt("payment_id"));
            payment.setPaymentName(rs.getString("payment_name"));

            return payment;
        }

        return null;
    }


    // 3. Thêm phương thức thanh toán
    public void insert(Payment payment) throws SQLException {

        String sql = """
            INSERT INTO Payment(payment_name)
            VALUES (?)
        """;

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, payment.getPaymentName());

        ps.executeUpdate();
    }


    // 4. Cập nhật phương thức thanh toán
    public void update(Payment payment) throws SQLException {

        String sql = """
            UPDATE Payment
            SET payment_name = ?
            WHERE payment_id = ?
        """;

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setString(1, payment.getPaymentName());
        ps.setInt(2, payment.getPaymentId());

        ps.executeUpdate();
    }


    // 5. Xóa phương thức thanh toán
    public void delete(int paymentId) throws SQLException {

        String sql = """
            DELETE FROM Payment
            WHERE payment_id = ?
        """;

        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, paymentId);

        ps.executeUpdate();
    }
}