package com.example.Servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.example.DAO.UserDAO;
import com.example.DAO.OrderDAO;
import com.example.Model.User;

@WebServlet({"/profile", "/profile-update"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // 1. HIỂN THỊ TRANG PROFILE
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");

        // Nếu chưa đăng nhập thì đẩy về login.jsp
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("myOrders", new OrderDAO().getOrdersByUserId(currentUser.getUserId()));
        request.setAttribute("profileLoaded", Boolean.TRUE);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    // 2. XỬ LÝ CẬP NHẬT THÔNG TIN VÀ UPLOAD AVATAR
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("account");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy thông tin từ Form
            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String city = request.getParameter("city");
            String ward = request.getParameter("ward");
            String streetAddress = request.getParameter("streetAddress");

            // Ghép nối địa chỉ đầy đủ (Số nhà + Xã/Phường + Tỉnh/Thành)
            StringBuilder fullAddress = new StringBuilder();
            if (streetAddress != null && !streetAddress.trim().isEmpty()) {
                fullAddress.append(streetAddress.trim());
            }
            if (ward != null && !ward.trim().isEmpty()) {
                if (fullAddress.length() > 0) fullAddress.append(", ");
                fullAddress.append(ward.trim());
            }
            if (city != null && !city.trim().isEmpty()) {
                if (fullAddress.length() > 0) fullAddress.append(", ");
                fullAddress.append(city.trim());
            }

            // Xử lý Upload ảnh Avatar (nếu người dùng có chọn file mới)
            Part filePart = request.getPart("avatarFile");
            String avatarPath = currentUser.getAvatar(); // Mặc định giữ đường dẫn ảnh cũ

            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null) {
                String fileName = new File(filePart.getSubmittedFileName()).getName();
                
                // Đổi tên file để tránh trùng lặp: avatar_userID_timestamp.jpg
                String newFileName = "avatar_" + currentUser.getUserId() + "_" + System.currentTimeMillis() + getFileExtension(fileName);

                // Đường dẫn thư mục lưu ảnh upload trên server
                String uploadFolder = getServletContext().getRealPath("/uploads");
                File uploadDir = new File(uploadFolder);
                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                // Lưu file vào thư mục uploads
                String filePath = uploadFolder + File.separator + newFileName;
                filePart.write(filePath);

                // Đường dẫn lưu vào Database để hiển thị trên JSP
                avatarPath = "uploads/" + newFileName;
            }

            // Cập nhật thông tin đối tượng User trong memory
            if (fullName != null && !fullName.trim().isEmpty()) {
                currentUser.setFullName(fullName.trim());
            }
            if (phoneNumber != null) {
                currentUser.setPhoneNumber(phoneNumber.trim());
            }
            if (fullAddress.length() > 0) {
                currentUser.setAddress(fullAddress.toString());
            }
            if (avatarPath != null) {
                currentUser.setAvatar(avatarPath);
            }

            // Gọi DAO để lưu thay đổi xuống SQL Database
            UserDAO userDAO = new UserDAO();
            boolean isUpdated = userDAO.updateUserProfile(currentUser);

            if (isUpdated) {
                // Cập nhật lại Session tài khoản mới nhất
                session.setAttribute("account", currentUser);
                request.setAttribute("message", "Cập nhật hồ sơ thành công!");
            } else {
                request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi trong quá trình xử lý: " + e.getMessage());
        }

        request.setAttribute("myOrders", new OrderDAO().getOrdersByUserId(currentUser.getUserId()));
        request.setAttribute("profileLoaded", Boolean.TRUE);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    // Hàm phụ trợ lấy đuôi file (.jpg, .png, ...)
    private String getFileExtension(String fileName) {
        int lastIndexOf = fileName.lastIndexOf(".");
        if (lastIndexOf == -1) {
            return ".jpg"; // Mặc định
        }
        return fileName.substring(lastIndexOf);
    }
}
