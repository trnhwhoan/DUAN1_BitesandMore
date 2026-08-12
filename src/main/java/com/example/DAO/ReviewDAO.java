package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Review;
import com.example.Util.DBContext;

public class ReviewDAO {

    // Lấy tất cả đánh giá của một sản phẩm
    public List<Review> getByProductId(int productId) {
        List<Review> list = new ArrayList<>();

        String sql = "SELECT * FROM Review WHERE product_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setUserId(rs.getInt("user_id"));
                review.setProductId(rs.getInt("product_id"));
                review.setRating(rs.getInt("rating"));
                review.setContent(rs.getString("content"));
                review.setReviewDate(rs.getTimestamp("review_date"));

                list.add(review);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm đánh giá
    public boolean insert(Review review) {

        String sql = "INSERT INTO Review(user_id, product_id, rating, content) VALUES (?, ?, ?, ?)";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, review.getUserId());
            ps.setInt(2, review.getProductId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getContent());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Cập nhật đánh giá
    public boolean update(Review review) {

        String sql = "UPDATE Review SET rating = ?, content = ? WHERE review_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, review.getRating());
            ps.setString(2, review.getContent());
            ps.setInt(3, review.getReviewId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Xóa đánh giá
    public boolean delete(int reviewId) {

        String sql = "DELETE FROM Review WHERE review_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reviewId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Lấy đánh giá theo ID
    public Review getById(int reviewId) {

        String sql = "SELECT * FROM Review WHERE review_id = ?";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, reviewId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setUserId(rs.getInt("user_id"));
                review.setProductId(rs.getInt("product_id"));
                review.setRating(rs.getInt("rating"));
                review.setContent(rs.getString("content"));
                review.setReviewDate(rs.getTimestamp("review_date"));

                return review;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}