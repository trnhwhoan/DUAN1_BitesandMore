package com.example.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.Model.Product;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Cấu hình kiểu dữ liệu trả về cho Frontend là JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 2. TẠO DỮ LIỆU MẪU (Thực tế đoạn này sẽ dùng DAO/Repository để query từ Database)
        List<Product> products = new ArrayList<>();
        products.add(new Product(1, "Sourdough Bread", 6.00, 5));
        products.add(new Product(2, "Chocolate Cupcake", 3.50, 4));
        products.add(new Product(3, "Strawberry Tart", 5.20, 4));
        products.add(new Product(4, "Butter Croissant", 4.00, 3));
        products.add(new Product(5, "Red Velvet Cake", 18.00, 5));

        // 3. Tự tạo chuỗi JSON đơn giản để gửi về cho Client
        StringBuilder json = new StringBuilder();
        json.append("[");
        for (int i = 0; i < products.size(); i++) {
            Product p = products.get(i);
            json.append(String.format(
                "{\"id\":%d, \"name\":\"%s\", \"price\":%.2f, \"rating\":%d}",
                p.getId(), p.getName(), p.getPrice(), p.getRating()
            ));
            if (i < products.size() - 1) json.append(",");
        }
        json.append("]");

        // 4. Bắn dữ liệu JSON về cho trình duyệt
        PrintWriter out = response.getWriter();
        out.print(json.toString());
        out.flush();
    }
}
