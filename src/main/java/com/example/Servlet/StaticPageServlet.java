package com.example.Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/** Clean URL entry points for pages that only need a JSP view. */
@WebServlet({"/about", "/categories"})
public class StaticPageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String page = request.getServletPath();
        request.getRequestDispatcher("/" + ("/about".equals(page) ? "about.jsp" : "categories.jsp"))
                .forward(request, response);
    }
}
