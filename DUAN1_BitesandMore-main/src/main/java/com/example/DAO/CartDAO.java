package com.example.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.CartDetail;

public class CartDAO {

    private Connection conn;

    public CartDAO(Connection conn) {
        this.conn = conn;
    }

    // 1. Lấy cart theo user
    public int getCartIdByUser(int userId) throws SQLException {
        String sql = "SELECT cart_id FROM Cart WHERE user_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            return rs.getInt("cart_id");
        }
        return -1;
    }

    // 2. Tạo cart mới
    public int createCart(int userId) throws SQLException {
        String sql = "INSERT INTO Cart(user_id) VALUES(?)";
        PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.setInt(1, userId);
        ps.executeUpdate();

        ResultSet rs = ps.getGeneratedKeys();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return -1;
    }

    // 3. Lấy hoặc tạo cart
    public int getOrCreateCart(int userId) throws SQLException {
        int cartId = getCartIdByUser(userId);
        if (cartId == -1) {
            cartId = createCart(userId);
        }
        return cartId;
    }

    // 4. Thêm vào giỏ (nếu có rồi thì tăng số lượng)
    public void addToCart(int userId, int productId, int quantity) throws SQLException {
        int cartId = getOrCreateCart(userId);

        String checkSql = "SELECT quantity FROM CartDetail WHERE cart_id = ? AND product_id = ?";
        PreparedStatement checkPs = conn.prepareStatement(checkSql);
        checkPs.setInt(1, cartId);
        checkPs.setInt(2, productId);
        ResultSet rs = checkPs.executeQuery();

        if (rs.next()) {
            int newQuantity = rs.getInt("quantity") + quantity;

            String updateSql = "UPDATE CartDetail SET quantity = ? WHERE cart_id = ? AND product_id = ?";
            PreparedStatement updatePs = conn.prepareStatement(updateSql);
            updatePs.setInt(1, newQuantity);
            updatePs.setInt(2, cartId);
            updatePs.setInt(3, productId);
            updatePs.executeUpdate();
        } else {
            String insertSql = "INSERT INTO CartDetail(cart_id, product_id, quantity) VALUES(?, ?, ?)";
            PreparedStatement insertPs = conn.prepareStatement(insertSql);
            insertPs.setInt(1, cartId);
            insertPs.setInt(2, productId);
            insertPs.setInt(3, quantity);
            insertPs.executeUpdate();
        }
    }

    // 5. Cập nhật số lượng
    public void updateQuantity(int cartId, int productId, int quantity) throws SQLException {
        String sql = "UPDATE CartDetail SET quantity = ? WHERE cart_id = ? AND product_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, quantity);
        ps.setInt(2, cartId);
        ps.setInt(3, productId);
        ps.executeUpdate();
    }

    // 6. Xóa 1 sản phẩm
    public void removeItem(int cartId, int productId) throws SQLException {
        String sql = "DELETE FROM CartDetail WHERE cart_id = ? AND product_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, cartId);
        ps.setInt(2, productId);
        ps.executeUpdate();
    }

    // 7. Xóa toàn bộ giỏ hàng
    public void clearCart(int userId) throws SQLException {
        int cartId = getCartIdByUser(userId);
        if (cartId != -1) {
            String sql = "DELETE FROM CartDetail WHERE cart_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, cartId);
            ps.executeUpdate();
        }
    }

    // 8. Lấy danh sách sản phẩm trong giỏ (JOIN Product)
    public List<CartDetail> getCartItems(int userId) throws SQLException {
        List<CartDetail> list = new ArrayList<>();
        int cartId = getCartIdByUser(userId);

        String sql = """
            SELECT cd.cart_id, cd.product_id, cd.quantity,
                   p.title, p.price, p.poster
            FROM CartDetail cd
            JOIN Video p ON cd.product_id = p.id
            WHERE cd.cart_id = ?
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, cartId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            CartDetail item = new CartDetail();
            item.setCartId(rs.getInt("cart_id"));
            item.setProductId(rs.getInt("product_id"));
            item.setQuantity(rs.getInt("quantity"));

            // thêm info product để hiển thị
            item.setProductName(rs.getString("title"));
            item.setPrice(rs.getDouble("price"));
            item.setImage(rs.getString("poster"));

            list.add(item);
        }
        return list;
    }
}