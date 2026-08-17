package com.example.Servlet;

import java.io.IOException;
import java.math.BigDecimal;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ProductDAO;
import com.example.Model.Product;

@WebServlet("/edit-product")
public class EditProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                ProductDAO dao = new ProductDAO();
                Product p = dao.getProductById(id);

                // Gán sản phẩm cũ vào request scope để JSP đọc được
                request.setAttribute("product", p);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Chuyển tiếp sang admin-edit-product.jsp
        request.getRequestDispatcher("admin-edit-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String status = request.getParameter("status");
            String imageUrl = request.getParameter("imageUrl");
            String description = request.getParameter("description");

            Product p = new Product();
            p.setProductId(productId);
            p.setProductName(productName);
            p.setCategoryId(categoryId);
            p.setPrice(price);
            p.setQuantity(quantity);
            p.setStatus(status);
            p.setImageUrl(imageUrl);
            p.setDescription(description);

            new ProductDAO().updateProduct(p);
            response.sendRedirect("admin-products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin-products");
        }
    }
}