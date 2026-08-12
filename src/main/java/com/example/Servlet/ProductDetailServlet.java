package com.example.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ProductDAO;
import com.example.Model.Product;

@WebServlet("/productdetail")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Cấu hình kiểu dữ liệu trả về cho Frontend là JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        List<Product> products;
        try {
            products = new ProductDAO().getAllProducts();
        } catch (RuntimeException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"message\":\"Không kết nối được SQL Server. Kiểm tra database BitesandMore và cấu hình DBContext.\"}");
            return;
        }

        // 3. Tự tạo chuỗi JSON đơn giản để gửi về cho Client
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < products.size(); i++) {
            Product p = products.get(i);
            json.append(String.format(
                "{\"id\":%d,\"name\":\"%s\",\"price\":%s,\"image\":\"%s\",\"categoryId\":%d}",
                p.getId(), escapeJson(p.getProductName()), p.getPrice().toPlainString(),
                escapeJson(p.getImage()), p.getCategoryId()
            ));
            if (i < products.size() - 1) json.append(",");
        }
        json.append("]");

        // 4. Bắn dữ liệu JSON về cho trình duyệt
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }

    private String escapeJson(String value) {
        if (value == null) return "";
        return value.replace("\\", "\\\\").replace("\"", "\\\"")
                .replace("\n", "\\n").replace("\r", "\\r");
    }
}
