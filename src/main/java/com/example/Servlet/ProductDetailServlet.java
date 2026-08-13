package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ProductDAO;
import com.example.DAO.OrderDAO;
import com.example.Model.Product;
import com.example.Model.User;
import javax.servlet.http.HttpSession;

@WebServlet({"/product-detail", "/productdetail"})
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            String rawId = request.getParameter("id");
            if (rawId == null || rawId.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/shop");
                return;
            }
            int id = Integer.parseInt(rawId.trim());
            Product product = new ProductDAO().getProductById(id);
            if (product == null || !"Active".equalsIgnoreCase(product.getStatus())) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found.");
                return;
            }
            request.setAttribute("product", product);
            HttpSession session = request.getSession(false);
            User account = session == null ? null : (User) session.getAttribute("account");
            boolean canReview = account != null
                    && new OrderDAO().hasUserPurchasedProduct(account.getUserId(), id);
            request.setAttribute("canReview", canReview);
            request.getRequestDispatcher("productdetail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product id.");
        } catch (RuntimeException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to load product.");
        }
    }
}
