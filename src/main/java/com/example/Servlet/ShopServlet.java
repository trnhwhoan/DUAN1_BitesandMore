package com.example.Servlet; 

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.ProductDAO;
import com.example.Model.Product;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy tham số từ URL / Form
        String keyword = request.getParameter("keyword");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        String[] categories = request.getParameterValues("category");

        // In log ra Terminal để kiểm tra
        System.out.println("=== CHECK PARAMETERS ===");
        System.out.println("Keyword: " + keyword);
        System.out.println("MinPrice: " + minPrice);
        System.out.println("MaxPrice: " + maxPrice);
        System.out.println("Categories: " + (categories != null ? Arrays.toString(categories) : "null"));

        ProductDAO dao = new ProductDAO();
        
        // Gọi hàm searchProducts xử lý lọc dữ liệu SQL
        List<Product> list = dao.searchProducts(keyword, minPrice, maxPrice, categories);

        System.out.println("===> SO LUONG TSP TIM THAY: " + (list != null ? list.size() : 0));

        // Đẩy danh sách sản phẩm tìm được ra trang shop.jsp
        request.setAttribute("productList", list);
        
        // GIỮ LẠI GIÁ TRỊ VÀ DẤU TICK TRÊN FORM SHOP.JSP
        request.setAttribute("keyword", keyword);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        
        // Chuyển mảng String[] thành List<String> để JSTL c:forEach / c:if so sánh chuẩn 100%
        if (categories != null) {
            request.setAttribute("selectedCategories", Arrays.asList(categories));
        }

        request.getRequestDispatcher("shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}