package com.example.Servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.OrderDAO;
import com.example.DAO.PaymentDAO;
import com.example.DAO.ProductDAO;
import com.example.Model.CartDetail;
import com.example.Model.Order;
import com.example.Model.OrderDetail;
import com.example.Model.Payment;
import com.example.Model.Product;
import com.example.Model.User;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // 1. GET: Hiển thị trang Checkout (hoặc chuyển sang checkout.jsp)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<CartDetail> cart = (List<CartDetail>) session.getAttribute("cart");

        // Nếu giỏ hàng trống thì bắt quay lại trang Cart
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        User currentUser = (User) session.getAttribute("account");
        if (currentUser == null) {
            session.setAttribute("redirectAfterLogin", "checkout");
            response.sendRedirect("login.jsp?required=checkout");
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
        List<CartDetail> cart = (List<CartDetail>) session.getAttribute("cart");

        // Kiểm tra giỏ hàng
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        User currentUser = (User) session.getAttribute("account");
        if (currentUser == null) {
            session.setAttribute("redirectAfterLogin", "checkout");
            response.sendRedirect("login.jsp?required=checkout");
            return;
        }

        // Lấy thông tin khách hàng từ Form checkout.jsp
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        // Bites & More chỉ giao nội thành Đà Nẵng.
        String city = "Đà Nẵng";
        String state = request.getParameter("state");
        String zipCode = request.getParameter("zipCode");
        String paymentMethod = request.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.isEmpty()) {
            paymentMethod = "COD";
        }

        if (isBlank(firstName) || isBlank(lastName) || isBlank(phone) || isBlank(address) || isBlank(city)) {
            request.setAttribute("error", "Please complete all required shipping information.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        String recipientName = firstName.trim() + " " + lastName.trim();
        String shippingAddress = joinAddress(address, city, state, zipCode);
        String paymentName = "cod".equalsIgnoreCase(paymentMethod) ? "Tiền mặt" : "Chuyển khoản";
        Payment payment = new PaymentDAO().getByName(paymentName);
        if (payment == null) {
            request.setAttribute("error", "Payment methods have not been configured in the database.");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            return;
        }

        // Tính tổng tiền đơn hàng
        BigDecimal totalAmount = BigDecimal.ZERO;
        List<OrderDetail> orderDetails = new ArrayList<>();
        ProductDAO productDAO = new ProductDAO();

        for (CartDetail item : cart) {
            if (item.getQuantity() <= 0) {
                request.setAttribute("error", "Cart contains an invalid quantity.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }
            Product product = productDAO.getProductById(item.getProductId());
            if (product == null || !"Active".equalsIgnoreCase(product.getStatus())
                    || product.getPrice() == null || item.getQuantity() > product.getQuantity()) {
                request.setAttribute("error", "A product in your cart is no longer available.");
                request.getRequestDispatcher("checkout.jsp").forward(request, response);
                return;
            }
            BigDecimal itemTotal = product.getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
            totalAmount = totalAmount.add(itemTotal);

            OrderDetail detail = new OrderDetail();
            detail.setProductId(item.getProductId());
            detail.setQuantity(item.getQuantity());
            detail.setUnitPrice(product.getPrice());
            detail.setSubtotal(itemTotal);

            orderDetails.add(detail);
        }

        // Tạo đối tượng Order
        Order order = new Order();
        order.setUserId(currentUser.getUserId());
        order.setOrderDate(Timestamp.valueOf(LocalDateTime.now(ZoneId.of("Asia/Ho_Chi_Minh"))));
        order.setRecipientName(recipientName);
        order.setRecipientPhone(phone.trim());
        order.setRecipientEmail(currentUser.getEmail());
        order.setShippingAddress(shippingAddress);
        order.setTotalAmount(totalAmount);
        order.setDiscountAmount(BigDecimal.ZERO);
        BigDecimal shippingFee = totalAmount.compareTo(new BigDecimal("100000")) >= 0
                ? BigDecimal.ZERO : new BigDecimal("30000");
        order.setShippingFee(shippingFee);
        order.setFinalAmount(totalAmount.add(shippingFee));
        order.setPaymentId(payment.getPaymentId());
        order.setPaymentStatus("Pending");
        order.setStatus("Pending");

        // Lưu đơn hàng vào Database thông qua OrderDAO
        OrderDAO orderDAO = new OrderDAO();
        boolean isSuccess = orderDAO.createOrder(order, orderDetails);

        if (isSuccess) {
            // Đặt hàng thành công -> Xóa giỏ hàng khỏi session
            session.removeAttribute("cart");
            session.setAttribute("cartSize", 0);

            // Chuyển hướng tới trang thông báo thành công hoặc chi tiết đơn hàng
            session.setAttribute("lastOrder", order);
            session.setAttribute("lastPaymentName", payment.getPaymentName());
            response.sendRedirect("order-success");
        } else {
            // Thất bại -> Báo lỗi quay lại checkout.jsp
            request.setAttribute("error", "Failed to place order. Please try again!");
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private String joinAddress(String address, String city, String state, String zipCode) {
        StringBuilder result = new StringBuilder(address.trim()).append(", ").append(city.trim());
        if (!isBlank(state)) result.append(", ").append(state.trim());
        if (!isBlank(zipCode)) result.append(" ").append(zipCode.trim());
        return result.toString();
    }
}
