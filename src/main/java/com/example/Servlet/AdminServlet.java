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
import com.example.DAO.UserDAO;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session) {
        User user = session == null ? null : (User) session.getAttribute("account");
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();

        // Phân quyền: Chỉ cho phép tài khoản Admin truy cập
        if (!isAdmin(session)) {
            response.sendRedirect("login");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        ProductDAO productDAO = new ProductDAO();

        // Load các dữ liệu thống kê lên trang Admin
        request.setAttribute("recentOrders", orderDAO.getAllOrders());
        request.setAttribute("totalProducts", productDAO.getAllProducts().size());
        request.setAttribute("bestSellingProducts", productDAO.getBestSellingProducts(3));
        request.setAttribute("totalRevenue", orderDAO.getTotalRevenue());
        request.setAttribute("totalOrders", orderDAO.getAllOrders().size());
        request.setAttribute("totalCustomers", new UserDAO().getAllUsers().size());
        request.setAttribute("totalSold", orderDAO.getTotalSoldQuantity());

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (!isAdmin(session)) { response.sendRedirect("login"); return; }
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            if (status != null && status.matches("Pending|Confirmed|Processing|Shipping|Delivered|Completed|Cancelled")) {
                new OrderDAO().updateStatus(orderId, status);
            }
        } catch (NumberFormatException ignored) { }
        response.sendRedirect("admin");
    }
}
