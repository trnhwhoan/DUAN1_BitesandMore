package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.OrderDAO;

@WebServlet("/update-order-status")
public class UpdateOrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String orderIdStr = request.getParameter("orderId");
        String status = request.getParameter("status");

        if (orderIdStr != null && !orderIdStr.trim().isEmpty() && status != null) {
            try {
                int orderId = Integer.parseInt(orderIdStr.trim());
                OrderDAO orderDAO = new OrderDAO();
                orderDAO.updateStatus(orderId, status);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Quay lại trang quản lý đơn hàng
        response.sendRedirect("admin-orders");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("admin-orders");
    }
}