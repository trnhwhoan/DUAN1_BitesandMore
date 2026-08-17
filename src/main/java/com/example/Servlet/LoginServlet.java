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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 1. GET: Hiển thị trang giao diện đăng nhập (login.jsp)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        // Nếu người dùng ĐÃ ĐĂNG NHẬP rồi mà cố tình truy cập lại /login -> Chuyển hướng sang profile luôn
        if (session.getAttribute("account") != null) {
            response.sendRedirect("profile");
            return;
        }

        // Chuyển hướng sang giao diện login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // 2. POST: Xử lý Xác thực Đăng Nhập
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate cơ bản input
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ Email và Mật khẩu!");
            request.setAttribute("email", email);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();
        User user = userDAO.login(email.trim().toLowerCase(), password);

if (user != null) {
    HttpSession session = request.getSession();
    request.changeSessionId();
    session.setAttribute("account", user);

    String userRole = user.getRole() != null ? user.getRole().trim().toLowerCase() : "";

    if ("admin".equals(userRole)) {
        response.sendRedirect("admin");
        return; // Dừng thực thi ngay sau khi chuyển hướng
    } else if ("shipper".equals(userRole)) {
        response.sendRedirect("shipper");
        return; // Dừng thực thi ngay sau khi chuyển hướng
    } else {
        String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
        if (redirectUrl != null) {
            session.removeAttribute("redirectAfterLogin");
            response.sendRedirect(redirectUrl);
            return;
        } else {
            response.sendRedirect("home");
            return;
        }
    } 
} else {
    request.setAttribute("error", "Email hoặc mật khẩu không chính xác!");
    request.setAttribute("email", email);
    request.getRequestDispatcher("login.jsp").forward(request, response);
    return;
}

}   
}
