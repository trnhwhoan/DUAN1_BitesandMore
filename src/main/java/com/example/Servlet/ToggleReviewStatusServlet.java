package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ReviewDAO;

@WebServlet("/toggle-review-status")
public class ToggleReviewStatusServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status"); // "Active" hoặc "Hidden"
            
            if (status != null && (status.equals("Active") || status.equals("Hidden"))) {
                new ReviewDAO().updateReviewStatus(id, status);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("admin-reviews");
    }
}