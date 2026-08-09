package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.UserDAO;
import com.example.Model.User;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {

    // 1. GET: Chuyển hướng tới trang login.jsp
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // 2. POST: Xử lý Đăng nhập
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();
        // Gọi hàm kiểm tra đăng nhập từ UserDAO
        User user = userDAO.login(email, password);

        if (user != null) {
            // Đăng nhập thành công -> Lưu user vào Session
            HttpSession session = request.getSession();
            session.setAttribute("account", user);

            // Kiểm tra Vai trò (Role) để chuyển hướng đúng trang
            if ("admin".equalsIgnoreCase(user.getRole())) {
                // Nếu là Admin -> Chuyển sang Trang quản trị
                response.sendRedirect("admin");
            } else {
                // Nếu là Khách hàng -> Chuyển về Trang chủ
                response.sendRedirect("home");
            }
        } else {
            // Đăng nhập thất bại -> Báo lỗi quay lại login.jsp
            request.setAttribute("error", "Invalid email or password!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
