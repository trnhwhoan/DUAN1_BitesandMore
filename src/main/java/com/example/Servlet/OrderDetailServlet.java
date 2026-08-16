package com.example.Servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.OrderDetailDAO;
import com.example.Model.OrderDetail;

@WebServlet("/order-detail")
public class OrderDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null || orderIdParam.trim().isEmpty()) {
            out.print("[]");
            out.flush();
            return;
        }

        try {
            int orderId = Integer.parseInt(orderIdParam.trim());
            OrderDetailDAO dao = new OrderDetailDAO();
            List<OrderDetail> items = dao.getByOrderId(orderId);

            StringBuilder json = new StringBuilder("[");
            if (items != null && !items.isEmpty()) {
                for (int i = 0; i < items.size(); i++) {
                    OrderDetail item = items.get(i);
                    String name = item.getProductName() != null ? item.getProductName() : "Bánh tươi";
                    String safeName = name.replace("\\", "\\\\").replace("\"", "\\\"");

                    double price = item.getUnitPrice() != null ? item.getUnitPrice().doubleValue() : item.getPrice();

                    json.append("{")
                        .append("\"productName\":\"").append(safeName).append("\",")
                        .append("\"quantity\":").append(item.getQuantity()).append(",")
                        .append("\"price\":").append(price)
                        .append("}");

                    if (i < items.size() - 1) {
                        json.append(",");
                    }
                }
            }
            json.append("]");

            out.print(json.toString());
        } catch (Exception e) {
            e.printStackTrace();
            out.print("[]");
        } finally {
            out.flush();
        }
    }
}