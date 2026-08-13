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

/** JSON endpoint used by the legacy shop JavaScript. */
@WebServlet("/product")
public class ProductApiServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            List<Product> products = new ProductDAO().getAllProducts();
            StringBuilder json = new StringBuilder("[");
            for (int i = 0; i < products.size(); i++) {
                Product p = products.get(i);
                if (i > 0) json.append(',');
                json.append("{\"id\":").append(p.getId())
                    .append(",\"name\":\"").append(escape(p.getProductName()))
                    .append("\",\"price\":").append(p.getPrice())
                    .append(",\"image\":\"").append(escape(p.getImage()))
                    .append("\",\"categoryId\":").append(p.getCategoryId()).append('}');
            }
            response.getWriter().print(json.append(']'));
        } catch (RuntimeException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"message\":\"Unable to load products\"}");
        }
    }

    private String escape(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r");
    }
}
