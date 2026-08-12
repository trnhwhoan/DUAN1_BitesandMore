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
            throw new RuntimeException("Không thể lấy danh sách sản phẩm từ SQL Server", e);
        } finally {
            closeResources();
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
        } finally {
            closeResources();
        }

        return null;
    }

    // Lấy danh sách sản phẩm theo Category ID
    public List<Product> getProductsByCategoryId(int categoryId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM Product WHERE category_id = ?";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
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
        } finally {
            closeResources();
        }

        return list;
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
        } finally {
            closeResources();
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
        } finally {
            closeResources();
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
        } finally {
            closeResources();
        }
    }

    // Tìm kiếm và lọc sản phẩm linh hoạt trong SQL Server
    public List<Product> searchProducts(String keyword, String minPriceStr, String maxPriceStr, String[] categories) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Product WHERE 1=1 ");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND product_name LIKE ? ");
        }

        if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
            sql.append(" AND price >= ? ");
        }

        if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
            sql.append(" AND price <= ? ");
        }

        if (categories != null && categories.length > 0) {
            sql.append(" AND category_id IN (");
            for (int i = 0; i < categories.length; i++) {
                sql.append("?");
                if (i < categories.length - 1) {
                    sql.append(",");
                }
            }
            sql.append(") ");
        }

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql.toString());

            int paramIndex = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setNString(paramIndex++, "%" + keyword.trim() + "%");
            }

            if (minPriceStr != null && !minPriceStr.trim().isEmpty()) {
                double minVal = Double.parseDouble(minPriceStr.trim()) * 1000;
                ps.setBigDecimal(paramIndex++, java.math.BigDecimal.valueOf(minVal));
            }

            if (maxPriceStr != null && !maxPriceStr.trim().isEmpty()) {
                double maxVal = Double.parseDouble(maxPriceStr.trim()) * 1000;
                ps.setBigDecimal(paramIndex++, java.math.BigDecimal.valueOf(maxVal));
            }

            if (categories != null && categories.length > 0) {
                for (String catId : categories) {
                    ps.setInt(paramIndex++, Integer.parseInt(catId));
                }
            }

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
            System.out.println("LỖI SEARCH PRODUCTS: " + e.getMessage());
            e.printStackTrace();
        } finally {
            closeResources();
        }

        return list;
    }

    // Hàm hỗ trợ tự động đóng kết nối SQL
    private void closeResources() {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (ps != null) ps.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
}