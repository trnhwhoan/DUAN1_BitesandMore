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
import com.example.Model.CartItem;
import com.example.Model.Order;
import com.example.Model.OrderDetail;
import com.example.Model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // 1. GET: Hiển thị trang Checkout (hoặc chuyển sang checkout.jsp)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Nếu giỏ hàng trống thì bắt quay lại trang Cart
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        request.getRequestDispatcher("checkout.jsp").forward(request, response);
    }

    // 2. POST: Xử lý ĐẶT HÀNG (Tạo đơn hàng vào Database)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        // Kiểm tra giỏ hàng
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        // Lấy thông tin khách hàng từ Form checkout.jsp
        String customerName = request.getParameter("customerName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.isEmpty()) {
            paymentMethod = "COD";
        }

        // Lấy thông tin user nếu đã đăng nhập (nếu chưa đăng nhập thì userId = 0)
        User currentUser = (User) session.getAttribute("account");
        int userId = (currentUser != null) ? currentUser.getId() : 0;

        // Tính tổng tiền đơn hàng
        double totalAmount = 0;
        List<OrderDetail> orderDetails = new ArrayList<>();

        for (CartItem item : cart) {
            double itemTotal = item.getTotalPrice();
            totalAmount += itemTotal;

            OrderDetail detail = new OrderDetail();
            detail.setProductId(item.getProduct().getId());
            detail.setProductName(item.getProduct().getName());
            detail.setProductImage(item.getProduct().getImage());
            detail.setPrice(item.getProduct().getPrice());
            detail.setQuantity(item.getQuantity());

            orderDetails.add(detail);
        }

        // Tạo đối tượng Order
        Order order = new Order();
        order.setUserId(userId);
        order.setCustomerName(customerName);
        order.setPhone(phone);
        order.setAddress(address);
        order.setTotalAmount(totalAmount);
        order.setPaymentMethod(paymentMethod);
        order.setStatus("Pending");

        // Lưu đơn hàng vào Database thông qua OrderDAO
        OrderDAO orderDAO = new OrderDAO();
        boolean isSuccess = orderDAO.createOrder(order, orderDetails);

        if (isSuccess) {
            // Đặt hàng thành công -> Xóa giỏ hàng khỏi session
            session.removeAttribute("cart");
            session.setAttribute("cartSize", 0);

            // Chuyển hướng tới trang thông báo thành công hoặc chi tiết đơn hàng
            response.sendRedirect("order-success.jsp");
        } else {
            // Thất bại -> Báo lỗi quay lại checkout.jsp
            request.setAttribute("error", "Failed to place order. Please try again!");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }
}