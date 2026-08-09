package com.example.Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.CategoryDAO;
import com.example.DAO.ProductDAO;
import com.example.Model.Category;
import com.example.Model.Product;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Lấy dữ liệu từ Database
        List<Product> featuredProducts = productDAO.getAllProducts(); // Hoặc hàm lấy top/featured products
        List<Category> categories = categoryDAO.getAllCategories();

        // Đẩy dữ liệu sang JSP
        request.setAttribute("featuredProducts", featuredProducts);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
