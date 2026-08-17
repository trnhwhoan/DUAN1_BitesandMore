package com.example.Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.OrderDAO;
import com.example.Model.Order;
import com.example.Model.User;

@WebServlet("/cancel-order")
public class CancelOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.getOrderById(orderId);

            // Kiểm tra chỉ cho phép hủy nếu đơn thuộc về đúng user và đang ở trạng thái Pending hoặc Confirmed
            if (order != null && order.getUserId() == currentUser.getId()) {
                String st = order.getStatus();
                if ("Pending".equalsIgnoreCase(st) || "Chờ xử lý".equalsIgnoreCase(st) 
                    || "Confirmed".equalsIgnoreCase(st) || "Đã xác nhận".equalsIgnoreCase(st)) {
                    
                    orderDAO.updateStatus(orderId, "Cancelled");
                    session.setAttribute("profileSuccess", "Đã hủy đơn hàng #BM" + orderId + " thành công!");
                } else {
                    session.setAttribute("profileError", "Đơn hàng đang được thực hiện, không thể hủy!");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("profileError", "Lỗi khi thực hiện hủy đơn hàng!");
        }

        response.sendRedirect("profile");
    }
}