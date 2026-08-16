package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.OrderDetail;
import com.example.Util.DBContext; 

public class OrderDetailDAO {

    public List<OrderDetail> getByOrderId(int orderId) {
        List<OrderDetail> list = new ArrayList<>();
        
        // Khớp chuẩn tên bảng Product và khóa product_id theo schema SQL
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
}