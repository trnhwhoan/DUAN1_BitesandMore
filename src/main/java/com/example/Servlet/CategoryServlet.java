package com.example.Servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ProductDAO;
import com.example.Model.Product;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idRaw = request.getParameter("id");

        if (idRaw != null && !idRaw.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(idRaw.trim());
                ProductDAO dao = new ProductDAO();
                List<Product> list = dao.getProductsByCategoryId(categoryId);

                // Tên danh mục tương ứng
                String categoryName = "Danh mục sản phẩm";
                switch (categoryId) {
                    case 1: categoryName = "Bánh Mì (Bread)"; break;
                    case 2: categoryName = "Bánh Kem (Cakes)"; break;
                    case 3: categoryName = "Bánh Ngàn Lớp (Pastry)"; break;
                    case 4: categoryName = "Bánh Quy (Cookie)"; break;
                    case 5: categoryName = "Bánh Donuts"; break;
                    case 6: categoryName = "Bánh Cupcake"; break;
                }

                request.setAttribute("productList", list);
                request.setAttribute("categoryName", categoryName);
                request.getRequestDispatcher("category-detail.jsp").forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Nếu không truyền ID thì quay về trang danh mục chính
        response.sendRedirect("categories.jsp");
    }
}