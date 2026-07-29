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

import com.example.DAO.ProductDAO;
import com.example.Model.CartDetail;
import com.example.Model.Product;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    // 1. GET: Hiển thị trang giỏ hàng
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "remove" -> removeItem(request, response);
            case "clear" -> clearCart(request, response);
            default -> request.getRequestDispatcher("cart.jsp").forward(request, response);
        }
    }

    // 2. POST: Thêm sản phẩm hoặc Cập nhật số lượng trong giỏ hàng
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        if (action == null) action = "add";

        if ("add".equalsIgnoreCase(action)) {
            addToCart(request, response);
        } else if ("update".equalsIgnoreCase(action)) {
            updateCart(request, response);
        }
    }

    // --- HÀM 1: THÊM BÁNH VÀO GIỎ ---
    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = 1;
        
        if (request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }

        HttpSession session = request.getSession();
        List<CartDetail> cart = (List<CartDetail>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        ProductDAO productDAO = new ProductDAO();
        Product product = productDAO.getProductById(productId);

        if (product != null) {
            boolean isExist = false;
            for (CartDetail item : cart) {
                if (item.getProduct().getId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    isExist = true;
                    break;
                }
            }

            if (!isExist) {
                cart.add(new CartDetail(product, quantity));
            }
        }

        session.setAttribute("cart", cart);
        
        // Tính tổng số lượng item để cập nhật cái Badge đỏ trên Header
        session.setAttribute("cartSize", getCartTotalQuantity(cart));

        // Chuyển hướng lại trang cart.jsp
        response.sendRedirect("cart");
    }

    // --- HÀM 2: CẬP NHẬT SỐ LƯỢNG MÓN ---
    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        HttpSession session = request.getSession();
        List<CartDetail> cart = (List<CartDetail>) session.getAttribute("cart");

        if (cart != null) {
            for (CartDetail item : cart) {
                if (item.getProduct().getId() == productId) {
                    if (quantity > 0) {
                        item.setQuantity(quantity);
                    } else {
                        cart.remove(item);
                    }
                    break;
                }
            }
            session.setAttribute("cart", cart);
            session.setAttribute("cartSize", getCartTotalQuantity(cart));
        }

        response.sendRedirect("cart");
    }

    // --- HÀM 3: XÓA 1 MÓN KHỎI GIỎ ---
    private void removeItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));

        HttpSession session = request.getSession();
        List<CartDetail> cart = (List<CartDetail>) session.getAttribute("cart");

        if (cart != null) {
            cart.removeIf(item -> item.getProduct().getId() == productId);
            session.setAttribute("cart", cart);
            session.setAttribute("cartSize", getCartTotalQuantity(cart));
        }

        response.sendRedirect("cart");
    }

    // --- HÀM 4: XÓA SẠCH GIỎ HÀNG ---
    private void clearCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("cart");
        session.setAttribute("cartSize", 0);
        response.sendRedirect("cart");
    }

    // Hàm phụ tính tổng số lượng bánh đang nằm trong giỏ
    private int getCartTotalQuantity(List<CartDetail> cart) {
        int total = 0;
        if (cart != null) {
            for (CartDetail item : cart) {
                total += item.getQuantity();
            }
        }
        return total;
    }
}