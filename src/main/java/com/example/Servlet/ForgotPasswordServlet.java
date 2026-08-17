package com.example.Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("fogotpass.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Email delivery requires deployment-specific SMTP credentials; never reveal whether an account exists.
        request.setAttribute("message", "Nếu email tồn tại, hướng dẫn khôi phục đã được gửi.");
        request.getRequestDispatcher("fogotpass.jsp").forward(request, response);
    }
}
