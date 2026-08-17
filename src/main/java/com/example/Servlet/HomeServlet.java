package com.example.Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.CategoryDAO;
import com.example.DAO.ProductDAO;
import com.example.Model.Category;
import com.example.Model.Product;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. LẤY SESSION VÀ KIỂM TRA ĐĂNG NHẬP
        HttpSession session = request.getSession();
        Object account = session.getAttribute("account"); // Kiểm tra tài khoản đã lưu trong session chưa

        // Nếu người dùng chưa đăng nhập -> Chuyển hướng ngay sang trang Login
        if (account == null) {
            response.sendRedirect("login.jsp");
            return; // Dừng xử lý các đoạn code bên dưới
        }

        // 2. NẾU ĐÃ ĐĂNG NHẬP THÌ CHO PHÉP TẢI DỮ LIỆU VÀO TRANG HOME
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Lấy dữ liệu từ Database
        List<Product> featuredProducts = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();

        // Đẩy dữ liệu sang JSP
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}