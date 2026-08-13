package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.ReviewDAO;
import com.example.Model.User;

@WebServlet("/admin-reviews")
public class AdminReviewsServlet extends HttpServlet {

    private boolean isAdmin(HttpSession session) {
        User user = session == null ? null : (User) session.getAttribute("account");
        return user != null && "admin".equalsIgnoreCase(user.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect("login");
            return;
        }

        request.setAttribute("reviewList", new ReviewDAO().getAllReviews());
        request.getRequestDispatcher("/admin-reviews.jsp").forward(request, response);
    }
}
