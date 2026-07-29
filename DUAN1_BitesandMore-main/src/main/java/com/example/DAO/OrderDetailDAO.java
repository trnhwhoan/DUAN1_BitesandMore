package com.example.DAO;

import com.example.Model.OrderDetail;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;


public class OrderDetailDAO {

    private Connection conn;


    public OrderDetailDAO(Connection conn) {
        this.conn = conn;
    }


    // 1. Thêm chi tiết đơn hàng
    public void insert(OrderDetail detail) throws SQLException {

        String sql = """
            INSERT INTO OrderDetail
            (
                order_id,
                product_id,
                quantity,
                unit_price
            )
            VALUES (?, ?, ?, ?)
        """;


        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, detail.getOrderId());
        ps.setInt(2, detail.getProductId());
        ps.setInt(3, detail.getQuantity());
        ps.setDouble(4, detail.getPrice());


        ps.executeUpdate();
    }



    // 2. Lấy danh sách sản phẩm trong đơn hàng
    public List<OrderDetail> findByOrderId(int orderId)
            throws SQLException {


        List<OrderDetail> list = new ArrayList<>();


        String sql = """
            SELECT *
            FROM OrderDetail
            WHERE order_id = ?
        """;


        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);


        ResultSet rs = ps.executeQuery();


        while(rs.next()) {

            OrderDetail detail = new OrderDetail();

            detail.setId(
                    rs.getInt("order_detail_id")
            );

            detail.setOrderId(
                    rs.getInt("order_id")
            );

            detail.setProductId(
                    rs.getInt("product_id")
            );

            detail.setQuantity(
                    rs.getInt("quantity")
            );

            detail.setPrice(
                    rs.getDouble("unit_price")
            );


            list.add(detail);
        }


        return list;
    }



    // 3. Xóa chi tiết đơn hàng
    public void deleteByOrderId(int orderId)
            throws SQLException {


        String sql = """
            DELETE FROM OrderDetail
            WHERE order_id = ?
        """;


        PreparedStatement ps = conn.prepareStatement(sql);

        ps.setInt(1, orderId);

        ps.executeUpdate();
    }

}