package com.example.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.CartDetail;

public class CartDetailDAO {

    private Connection conn;

    public CartDetailDAO(Connection conn) {
        this.conn = conn;
    }

    // 1. Thêm sản phẩm
    public void insert(CartDetail item) throws SQLException {
        String sql = "INSERT INTO CartDetail(cart_id, product_id, quantity) VALUES (?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, item.getCartId());
        ps.setInt(2, item.getProductId());
        ps.setInt(3, item.getQuantity());
        ps.executeUpdate();
    }

    // 2. Update số lượng
    public void updateQuantity(int cartId, int productId, int quantity) throws SQLException {
        String sql = "UPDATE CartDetail SET quantity = ? WHERE cart_id = ? AND product_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, quantity);
        ps.setInt(2, cartId);
        ps.setInt(3, productId);
        ps.executeUpdate();
    }

    // 3. Xóa 1 item
    public void delete(int cartId, int productId) throws SQLException {
        String sql = "DELETE FROM CartDetail WHERE cart_id = ? AND product_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, cartId);
        ps.setInt(2, productId);
        ps.executeUpdate();
    }

    // 4. Lấy danh sách theo cart
    public List<CartDetail> findByCartId(int cartId) throws SQLException {
        List<CartDetail> list = new ArrayList<>();

        String sql = """
            SELECT cd.*, p.title, p.price, p.poster
            FROM CartDetail cd
            JOIN Video p ON cd.product_id = p.id
            WHERE cd.cart_id = ?
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, cartId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            CartDetail item = new CartDetail();
            item.setCartDetailId(rs.getInt("cart_detail_id"));
            item.setCartId(rs.getInt("cart_id"));
            item.setProductId(rs.getInt("product_id"));
            item.setQuantity(rs.getInt("quantity"));

            item.setProductName(rs.getString("title"));
            item.setPrice(rs.getDouble("price"));
            item.setImage(rs.getString("poster"));

            list.add(item);
        }

        return list;
    }
}