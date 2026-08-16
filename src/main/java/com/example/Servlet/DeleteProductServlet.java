package com.example.Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ProductDAO;

@WebServlet("/admin-delete-product") // Đổi khớp đúng với URI bị lỗi 404
public class DeleteProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam.trim());
                ProductDAO dao = new ProductDAO();
                dao.deleteProduct(productId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Xóa xong quay lại trang danh sách sản phẩm
        response.sendRedirect("admin-products");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}