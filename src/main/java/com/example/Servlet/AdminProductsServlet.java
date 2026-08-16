package com.example.Servlet;

import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.DAO.ProductDAO;
import com.example.Model.Product;
import com.example.Model.User;

@WebServlet("/admin-products")
public class AdminProductsServlet extends HttpServlet {

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

        request.setAttribute("productList", new ProductDAO().getAllProducts());
        request.getRequestDispatcher("/admin-products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        if (!isAdmin(request.getSession(false))) {
            response.sendRedirect("login");
            return;
        }

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            try {
                String productName = request.getParameter("productName");
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                BigDecimal price = new BigDecimal(request.getParameter("price"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String status = request.getParameter("status");
                String imageUrl = request.getParameter("imageUrl");
                String description = request.getParameter("description");

                Product product = new Product();
                product.setProductName(productName);
                product.setCategoryId(categoryId);
                product.setPrice(price);
                product.setQuantity(quantity);
                product.setStatus(status != null ? status : "Active");
                product.setImageUrl(imageUrl);
                product.setDescription(description);

                ProductDAO productDAO = new ProductDAO();
                // Gọi hàm thêm sản phẩm (nếu hàm trong DAO tên khác như addProduct/createProduct thì đổi lại)
                productDAO.insertProduct(product); 

                response.sendRedirect("admin-products");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi dữ liệu: " + e.getMessage());
                request.getRequestDispatcher("admin-add-product.jsp").forward(request, response);
                return;
            }
        }

        response.sendRedirect("admin-products");
    }
}