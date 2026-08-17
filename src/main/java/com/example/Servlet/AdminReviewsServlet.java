package com.example.Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ReviewDAO;
import com.example.Model.Review;

@WebServlet("/admin-reviews")
public class AdminReviewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        ReviewDAO dao = new ReviewDAO();
        List<Review> list = dao.getAllReviews(); // Lấy tất cả từ database
        request.setAttribute("reviewList", list);
        request.getRequestDispatcher("admin-reviews.jsp").forward(request, response);
    }
}