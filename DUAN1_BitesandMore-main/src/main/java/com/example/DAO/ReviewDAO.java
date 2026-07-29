package com.example.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Review;

public class ReviewDAO {

    private Connection conn;

    public ReviewDAO(Connection conn) {
        this.conn = conn;
    }

    // 1. Thêm review
    public void insert(Review review) throws SQLException {
        String sql = """
            INSERT INTO Review(user_id, product_id, rating, content)
            VALUES (?, ?, ?, ?)
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, review.getUserId());
        ps.setInt(2, review.getProductId());
        ps.setInt(3, review.getRating());
        ps.setString(4, review.getContent());

        ps.executeUpdate();
    }

    // 2. Lấy danh sách review theo product
    public List<Review> findByProductId(int productId) throws SQLException {
        List<Review> list = new ArrayList<>();

        String sql = """
            SELECT r.*, u.fullname
            FROM Review r
            JOIN Users u ON r.user_id = u.user_id
            WHERE r.product_id = ?
            ORDER BY r.review_date DESC
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, productId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Review r = new Review();
            r.setReviewId(rs.getInt("review_id"));
            r.setUserId(rs.getInt("user_id"));
            r.setProductId(rs.getInt("product_id"));
            r.setRating(rs.getInt("rating"));
            r.setContent(rs.getString("content"));
            r.setReviewDate(rs.getTimestamp("review_date"));

            // nếu m có field này trong entity
            // r.setUserName(rs.getString("fullname"));

            list.add(r);
        }

        return list;
    }

    // 3. Xóa review
    public void delete(int reviewId) throws SQLException {
        String sql = "DELETE FROM Review WHERE review_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, reviewId);
        ps.executeUpdate();
    }

    // 4. Cập nhật review
    public void update(Review review) throws SQLException {
        String sql = """
            UPDATE Review
            SET rating = ?, content = ?
            WHERE review_id = ?
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, review.getRating());
        ps.setString(2, review.getContent());
        ps.setInt(3, review.getReviewId());

        ps.executeUpdate();
    }

    // 5. Kiểm tra user đã review chưa (1 user 1 review / product)
    public boolean exists(int userId, int productId) throws SQLException {
        String sql = """
            SELECT 1 FROM Review
            WHERE user_id = ? AND product_id = ?
        """;

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        ps.setInt(2, productId);

        ResultSet rs = ps.executeQuery();
        return rs.next();
    }
}