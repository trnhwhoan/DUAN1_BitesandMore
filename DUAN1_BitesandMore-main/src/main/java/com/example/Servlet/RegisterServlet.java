package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.UserDAO;
import com.example.Model.User;
import com.example.Util.PasswordUtil;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phoneNumber = request.getParameter("phoneNumber");
        // Keep compatibility with forms that still use the old field name.
        if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
            phoneNumber = request.getParameter("phone");
        }

        UserDAO userDAO = new UserDAO();

        if (isBlank(fullName) || isBlank(email) || isBlank(password) || isBlank(phoneNumber)) {
            request.setAttribute("error", "Please complete all required fields.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (confirmPassword != null && !password.equals(confirmPassword)) {
            request.setAttribute("error", "Password confirmation does not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại chưa
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email already exists!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPassword(PasswordUtil.hash(password));
        user.setPhoneNumber(phoneNumber.trim());
        user.setRole("Customer");
        user.setStatus("Active");

        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect("login.jsp?registered=true");
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
