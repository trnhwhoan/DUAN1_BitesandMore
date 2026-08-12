package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.OrderDAO;
import com.example.DAO.ProductDAO;
import com.example.Model.User;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");

        // Phân quyền: Chỉ cho phép tài khoản Admin truy cập
        if (currentUser == null || !"admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();

        // Load các dữ liệu thống kê lên trang Admin
        request.setAttribute("recentOrders", orderDAO.getAllOrders());
        request.setAttribute("totalProducts", productDAO.getAllProducts().size());

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
