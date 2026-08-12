package com.example.Servlet;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("feedback.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String name = clean(request.getParameter("name"));
        String email = clean(request.getParameter("email"));
        String topic = clean(request.getParameter("topic"));
        String rating = clean(request.getParameter("rating"));
        String content = clean(request.getParameter("content"));
        if (name.isEmpty() || email.isEmpty() || content.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập họ tên, email và nội dung góp ý.");
            request.getRequestDispatcher("feedback.jsp").forward(request, response);
            return;
        }
        Map<String, String> feedback = new LinkedHashMap<>();
        feedback.put("name", name);
        feedback.put("email", email);
        feedback.put("topic", topic.isEmpty() ? "Góp ý chung" : topic);
        feedback.put("rating", rating.isEmpty() ? "Chưa đánh giá" : rating);
        feedback.put("content", content);
        HttpSession session = request.getSession();
        session.setAttribute("lastFeedback", feedback);
        response.sendRedirect("contact.jsp?feedback=true&submitted=true");
    }

    private String clean(String value) { return value == null ? "" : value.trim(); }
}
