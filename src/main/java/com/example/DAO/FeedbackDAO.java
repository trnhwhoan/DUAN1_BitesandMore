package com.example.DAO;

import com.example.Util.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class FeedbackDAO {
    private void ensureTable(Connection con) throws Exception {
        String sql = "IF OBJECT_ID('Customer_Feedback', 'U') IS NULL "
                + "CREATE TABLE Customer_Feedback (feedback_id INT IDENTITY PRIMARY KEY, "
                + "user_id INT NULL, customer_name NVARCHAR(100) NOT NULL, email VARCHAR(255) NOT NULL, "
                + "topic NVARCHAR(100) NOT NULL, rating NVARCHAR(30) NULL, content NVARCHAR(2000) NOT NULL, "
                + "created_at DATETIME2(3) NOT NULL DEFAULT CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00')))";
        try (PreparedStatement ps = con.prepareStatement(sql)) { ps.executeUpdate(); }
    }

    public boolean insert(Integer userId, String name, String email, String topic, String rating, String content) {
        try (Connection con = DBContext.getConnection()) {
            ensureTable(con);
            String sql = "INSERT INTO Customer_Feedback(user_id, customer_name, email, topic, rating, content) VALUES (?,?,?,?,?,?)";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                if (userId == null) ps.setNull(1, java.sql.Types.INTEGER); else ps.setInt(1, userId);
                ps.setString(2, name); ps.setString(3, email); ps.setString(4, topic); ps.setString(5, rating); ps.setString(6, content);
                return ps.executeUpdate() > 0;
            }
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public List<Map<String, Object>> findLatest(int limit) {
        List<Map<String, Object>> list = new ArrayList<>();
        try (Connection con = DBContext.getConnection()) {
            ensureTable(con);
            String sql = "SELECT TOP (?) feedback_id, user_id, customer_name, topic, rating, content, created_at "
                    + "FROM Customer_Feedback ORDER BY created_at DESC, feedback_id DESC";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, limit);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> item = new LinkedHashMap<>();
                        item.put("id", rs.getInt("feedback_id")); item.put("userId", (Integer) rs.getObject("user_id"));
                        item.put("name", rs.getString("customer_name")); item.put("topic", rs.getString("topic"));
                        item.put("rating", rs.getString("rating")); item.put("content", rs.getString("content"));
                        item.put("createdAt", rs.getTimestamp("created_at")); list.add(item);
                    }
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}
