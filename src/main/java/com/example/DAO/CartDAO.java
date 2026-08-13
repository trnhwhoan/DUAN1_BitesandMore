package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Cart;
import com.example.Util.DBContext;

public class CartDAO {

    // Lấy tất cả giỏ hàng
    public List<Cart> getAll() {
        List<Cart> list = new ArrayList<>();

        String sql = "SELECT * FROM Cart";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));

                list.add(cart);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm giỏ hàng
    public boolean insert(Cart cart) {
        String sql = "INSERT INTO Cart(user_id) VALUES(?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cart.getUserId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Tìm giỏ hàng theo user_id
    public Cart getCartByUserId(int userId) {
        String sql = "SELECT * FROM Cart WHERE user_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));

                return cart;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Xóa giỏ hàng
    public boolean delete(int cartId) {
        String sql = "DELETE FROM Cart WHERE cart_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}