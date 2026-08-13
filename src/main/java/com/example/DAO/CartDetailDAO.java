package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.CartDetail;
import com.example.Util.DBContext;

public class CartDetailDAO {

    // Lấy tất cả sản phẩm trong giỏ hàng theo cart_id
    public List<CartDetail> getByCartId(int cartId) {
        List<CartDetail> list = new ArrayList<>();

        String sql = "SELECT * FROM Cart_Detail WHERE cart_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartDetail detail = new CartDetail(rs.getInt("cart_detail_id"), cartId,
                        rs.getInt("product_id"), rs.getInt("quantity"));
                detail.setCartDetailId(rs.getInt("cart_detail_id"));
                detail.setCartId(rs.getInt("cart_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setUnitPrice(rs.getBigDecimal("unit_price"));

                list.add(detail);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm sản phẩm vào giỏ hàng
    public boolean insert(CartDetail detail) {

        String sql = "INSERT INTO Cart_Detail(cart_id, product_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, detail.getCartId());
            ps.setInt(2, detail.getProductId());
            ps.setInt(3, detail.getQuantity());
            ps.setBigDecimal(4, detail.getUnitPrice());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật số lượng
    public boolean updateQuantity(int cartDetailId, int quantity) {

        String sql = "UPDATE Cart_Detail SET quantity = ? WHERE cart_detail_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartDetailId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Xóa sản phẩm khỏi giỏ hàng
    public boolean delete(int cartDetailId) {

        String sql = "DELETE FROM Cart_Detail WHERE cart_detail_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartDetailId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
    public CartDetail getByCartAndProduct(int cartId, int productId) {

        String sql = "SELECT * FROM Cart_Detail WHERE cart_id = ? AND product_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, productId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                CartDetail detail = new CartDetail(rs.getInt("cart_detail_id"), cartId,
                        productId, rs.getInt("quantity"));
                detail.setCartDetailId(rs.getInt("cart_detail_id"));
                detail.setCartId(rs.getInt("cart_id"));
                detail.setProductId(rs.getInt("product_id"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setUnitPrice(rs.getBigDecimal("unit_price"));

                return detail;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
