package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Product;
import com.example.Util.DBContext;

public class ProductDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    // Lấy tất cả sản phẩm
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getString("ingredient"),
                        rs.getInt("expiry_date"),
                        rs.getString("status"),
                        rs.getInt("quantity"),
                        rs.getString("usage_instructions"),
                        rs.getInt("category_id"),
                        0f
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Lấy sản phẩm theo ID
    public Product getProductById(int id) {
        String sql = "SELECT * FROM Product WHERE product_id=?";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new Product(
                        rs.getInt("product_id"),
                        rs.getString("product_name"),
                        rs.getString("description"),
                        rs.getBigDecimal("price"),
                        rs.getString("image"),
                        rs.getString("ingredient"),
                        rs.getInt("expiry_date"),
                        rs.getString("status"),
                        rs.getInt("quantity"),
                        rs.getString("usage_instructions"),
                        rs.getInt("category_id"),
                        0f
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Thêm sản phẩm
    public void insertProduct(Product product) {
        String sql = "INSERT INTO Product(product_name,description,price,image,ingredient,expiry_date,status,quantity,usage_instructions,category_id) VALUES(?,?,?,?,?,?,?,?,?,?)";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getImage());
            ps.setString(5, product.getIngredient());
            ps.setInt(6, product.getExpiryDate());
            ps.setString(7, product.getStatus());
            ps.setInt(8, product.getQuantity());
            ps.setString(9, product.getUsageInstructions());
            ps.setInt(10, product.getCategoryId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật sản phẩm
    public void updateProduct(Product product) {
        String sql = "UPDATE Product SET product_name=?, description=?, price=?, image=?, ingredient=?, expiry_date=?, status=?, quantity=?, usage_instructions=?, category_id=? WHERE product_id=?";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPrice());
            ps.setString(4, product.getImage());
            ps.setString(5, product.getIngredient());
            ps.setInt(6, product.getExpiryDate());
            ps.setString(7, product.getStatus());
            ps.setInt(8, product.getQuantity());
            ps.setString(9, product.getUsageInstructions());
            ps.setInt(10, product.getCategoryId());
            ps.setInt(11, product.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Xóa sản phẩm
    public void deleteProduct(int id) {
        String sql = "DELETE FROM Product WHERE product_id=?";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}