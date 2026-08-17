package com.example.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.Model.User;
import com.example.Util.DBContext;

@WebServlet("/api/notifications")
public class NotificationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("account");

        if (currentUser == null) {
            response.getWriter().write("[]");
            return;
        }

        StringBuilder json = new StringBuilder("[");
        String sql = "SELECT TOP 10 notification_id, order_id, title, message, icon, is_read, created_at "
                   + "FROM [Notification] WHERE user_id = ? ORDER BY notification_id DESC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, currentUser.getId());
            try (ResultSet rs = ps.executeQuery()) {
                boolean first = true;
                while (rs.next()) {
                    if (!first) json.append(",");
                    json.append("{")
                        .append("\"id\":").append(rs.getInt("notification_id")).append(",")
                        .append("\"orderId\":").append(rs.getInt("order_id")).append(",")
                        .append("\"title\":\"").append(escapeJson(rs.getString("title"))).append("\",")
                        .append("\"message\":\"").append(escapeJson(rs.getString("message"))).append("\",")
                        .append("\"icon\":\"").append(rs.getString("icon")).append("\",")
                        .append("\"isRead\":").append(rs.getBoolean("is_read"))
                        .append("}");
                    first = false;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        json.append("]");
        try (PrintWriter out = response.getWriter()) {
            out.print(json.toString());
            out.flush();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("account");
        if (currentUser != null) {
            String sql = "UPDATE [Notification] SET is_read = 1 WHERE user_id = ?";
            try (Connection conn = DBContext.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, currentUser.getId());
                ps.executeUpdate();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private String escapeJson(String input) {
        if (input == null) return "";
        return input.replace("\"", "\\\"").replace("\n", " ").replace("\r", " ");
    }
}