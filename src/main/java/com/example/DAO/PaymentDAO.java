package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Payment;
import com.example.Util.DBContext;

public class PaymentDAO {

    // Lấy tất cả phương thức thanh toán
    public List<Payment> getAll() {
        List<Payment> list = new ArrayList<>();

        String sql = "SELECT * FROM Payment";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setPaymentName(rs.getString("payment_name"));

                list.add(payment);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy phương thức thanh toán theo ID
    public Payment getById(int paymentId) {

        String sql = "SELECT * FROM Payment WHERE payment_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, paymentId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Payment payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setPaymentName(rs.getString("payment_name"));

                return payment;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public Payment getByName(String paymentName) {
        String sql = "SELECT * FROM Payment WHERE payment_name = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, paymentName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Payment payment = new Payment();
                    payment.setPaymentId(rs.getInt("payment_id"));
                    payment.setPaymentName(rs.getString("payment_name"));
                    return payment;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thêm phương thức thanh toán
    public boolean insert(Payment payment) {

        String sql = "INSERT INTO Payment(payment_name) VALUES(?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, payment.getPaymentName());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật phương thức thanh toán
    public boolean update(Payment payment) {

        String sql = "UPDATE Payment SET payment_name = ? WHERE payment_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, payment.getPaymentName());
            ps.setInt(2, payment.getPaymentId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Xóa phương thức thanh toán
    public boolean delete(int paymentId) {

        String sql = "DELETE FROM Payment WHERE payment_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, paymentId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}
