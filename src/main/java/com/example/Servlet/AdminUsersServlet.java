package com.example.Servlet;

import com.example.DAO.UserDAO;
import com.example.Model.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/admin-users")
public class AdminUsersServlet extends HttpServlet {

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

        request.setAttribute("userList", new UserDAO().getAllUsers());
        request.getRequestDispatcher("/admin-users.jsp").forward(request, response);
    }
}
