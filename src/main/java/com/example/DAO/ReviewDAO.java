package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.Model.Review;
import com.example.Util.DBContext;

public class ReviewDAO {

    // 1. LẤY TẤT CẢ ĐÁNH GIÁ/GÓP Ý CHO TRANG ADMIN
    public List<Review> getAllReviews() {
        List<Review> list = new ArrayList<>();
        // Truy vấn bảng Feedback hoặc Review
        String sql = "SELECT * FROM Feedback ORDER BY feedback_id DESC";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Review r = new Review();
                r.setReviewId(rs.getInt("feedback_id"));
                r.setUserName(rs.getString("customer_name")); // Tên khách hàng (Như Hoàn, Nh...)
                r.setProductName(rs.getString("topic"));       // Chủ đề (Chất lượng sản phẩm, Góp ý chung...)
                r.setContent(rs.getString("message"));        // Nội dung "oki la ngon bổ rẻ"
                r.setReviewDate(rs.getTimestamp("created_at"));
                
                try {
                    String st = rs.getString("status");
                    r.setStatus(st != null ? st : "Active");
                } catch (Exception e) {
                    r.setStatus("Active");
                }

                list.add(r);
            }
        } catch (Exception e) {
            System.err.println("===> [LỖI getAllReviews]: " + e.getMessage());
            e.printStackTrace();
        }
        return list;
    }

    // 2. LẤY DANH SÁCH HIỂN THỊ RA TRANG CHỦ / FEEDBACK (CHỈ LẤY ACTIVE)
    public List<Review> getActiveFeedbacks() {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE status = 'Active' OR status IS NULL ORDER BY feedback_id DESC";

        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Review r = new Review();
                r.setReviewId(rs.getInt("feedback_id"));
                r.setUserName(rs.getString("customer_name"));
                r.setProductName(rs.getString("topic"));
                r.setContent(rs.getString("message"));
                r.setReviewDate(rs.getTimestamp("created_at"));
                list.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. CẬP NHẬT TRẠNG THÁI ẨN / HIỆN
    public boolean updateReviewStatus(int reviewId, String status) {
        String sql = "UPDATE Feedback SET status = ? WHERE feedback_id = ?";
        try (Connection con = DBContext.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, reviewId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}