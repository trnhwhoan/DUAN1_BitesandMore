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

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String productId = request.getParameter("productId");
        
        if (productId != null && !productId.isEmpty()) {
            HttpSession session = request.getSession();
            
            // Lấy danh sách yêu thích từ session (nếu chưa có thì tạo mới)
            @SuppressWarnings("unchecked")
            List<String> favoriteList = (List<String>) session.getAttribute("favoriteList");
            if (favoriteList == null) {
                favoriteList = new ArrayList<>();
            }
            
            // Nếu chưa có thì thêm vào danh sách
            if (!favoriteList.contains(productId)) {
                favoriteList.add(productId);
            }
            
            session.setAttribute("favoriteList", favoriteList);
        }
        
        // Quay lại trang shop vừa đứng
        response.sendRedirect("shop");
    }
}