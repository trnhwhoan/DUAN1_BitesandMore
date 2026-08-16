package com.example.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.Util.DBContext;

@WebServlet("/send-feedback")
public class FeedbackServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String customerName = request.getParameter("customerName");
        String topic = request.getParameter("topic");
        String message = request.getParameter("message");

        String sql = "INSERT INTO Feedback (customer_name, topic, message, status, created_at) "
                   + "VALUES (?, ?, ?, 'Active', CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00')))";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customerName);
            ps.setString(2, topic);
            ps.setString(3, message);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("feedback"); // hoặc reload lại trang feedback
    }
}