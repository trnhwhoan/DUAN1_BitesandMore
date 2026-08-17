package com.example.Servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.OrderDAO;
import com.example.Model.Order;
import com.example.Model.User;

@WebServlet("/shipper")
public class ShipperServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("account");

        if (currentUser == null || currentUser.getRole() == null || !"shipper".equalsIgnoreCase(currentUser.getRole().trim())) {
            response.sendRedirect("login.jsp");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        
        // 1. Tab Đơn mới cần nhận
        List<Order> availableOrders = orderDAO.getAvailableOrdersForShipper();
        request.setAttribute("availableOrders", availableOrders);

        // Lấy tất cả đơn của Shipper này để phân loại
        List<Order> allMyOrders = orderDAO.getMyShipperOrders(currentUser.getId());
        List<Order> activeOrders = new ArrayList<>();
        List<Order> completedOrders = new ArrayList<>();

        for (Order o : allMyOrders) {
            String st = o.getStatus();
            if ("Delivered".equalsIgnoreCase(st) || "Đã giao".equalsIgnoreCase(st) 
                || "Completed".equalsIgnoreCase(st) || "Hoàn thành".equalsIgnoreCase(st)) {
                completedOrders.add(o); // Đã giao xong
            } else {
                activeOrders.add(o); // Đang nhận / Đang đi giao
            }
        }

        // 2. Tab Đang giao
        request.setAttribute("activeOrders", activeOrders);
        // 3. Tab Đã hoàn tất
        request.setAttribute("completedOrders", completedOrders);

        request.getRequestDispatcher("shipper-orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        User currentUser = session == null ? null : (User) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String action = request.getParameter("action");
            OrderDAO orderDAO = new OrderDAO();

            switch (action) {
                case "take_order":
                    orderDAO.updateOrderStatusByShipper(orderId, "Processing", currentUser.getId());
                    session.setAttribute("shipperMsg", "Đã nhận đơn #BM" + orderId + " vào mục Đang giao!");
                    break;
                case "start_shipping":
                    orderDAO.updateOrderStatusByShipper(orderId, "Shipping", currentUser.getId());
                    session.setAttribute("shipperMsg", "Đơn #BM" + orderId + " đang được đi giao!");
                    break;
                case "finish_delivery":
                    orderDAO.updateOrderStatusByShipper(orderId, "Delivered", currentUser.getId());
                    session.setAttribute("shipperMsg", "Đã giao đơn #BM" + orderId + " thành công và chuyển vào mục Hoàn tất!");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("shipper");
    }
}