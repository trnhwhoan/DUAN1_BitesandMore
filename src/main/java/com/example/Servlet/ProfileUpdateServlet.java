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

@WebServlet("/update-profile")
public class ProfileUpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User account = session == null ? null : (User) session.getAttribute("account");
        if (account == null) {
            response.sendRedirect("login");
            return;
        }
        String fullName = request.getParameter("fullName");
        String phoneNumber = request.getParameter("phoneNumber");
        String city = request.getParameter("city");
        String ward = request.getParameter("ward");
        String streetAddress = request.getParameter("streetAddress");
        if (blank(fullName) || blank(phoneNumber)) {
            session.setAttribute("profileError", "Họ tên và số điện thoại là bắt buộc.");
            response.sendRedirect("profile");
            return;
        }
        account.setFullName(fullName.trim());
        account.setPhoneNumber(phoneNumber.trim());
        StringBuilder address = new StringBuilder();
        if (streetAddress != null && !streetAddress.trim().isEmpty()) address.append(streetAddress.trim());
        if (ward != null && !ward.trim().isEmpty()) address.append(address.length() == 0 ? "" : ", ").append(ward.trim());
        if (city != null && !city.trim().isEmpty()) address.append(address.length() == 0 ? "" : ", ").append(city.trim());
        account.setAddress(address.toString());
        if (new UserDAO().updateProfile(account)) {
            session.setAttribute("account", account);
            session.setAttribute("profileSuccess", "Đã cập nhật hồ sơ.");
        } else {
            session.setAttribute("profileError", "Không thể cập nhật hồ sơ.");
        }
        response.sendRedirect("profile");
    }
    private boolean blank(String value) { return value == null || value.trim().isEmpty(); }
}
