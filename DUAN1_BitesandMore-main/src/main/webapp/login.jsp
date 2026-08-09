<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Đăng nhập</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="CSS/style.css">
  <style>
    /* Ép toàn bộ trang chiếm full chiều cao màn hình */
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
    }
    
    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* Đẩy phần nội dung chính giãn ra để ép footer xuống đáy */
    .main-content {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px 20px;
    }

    /* Xóa màu nền trắng và các viền gạch dư thừa từ CSS gốc */
    .wire-page, .section, .wf-footer, .footer-bottom, .filter-block {
      border: none !important;
      border-bottom: none !important;
      border-top: none !important;
      background: transparent !important;
      padding-bottom: 0 !important;
      box-shadow: none !important;
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TỪ 199.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: 0766 766 999</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="wf-searchbar">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <span>Tìm kiếm sản phẩm...</span>
    </div>
  </div>

  <!-- MAIN LOGIN FORM -->
  <div class="main-content">
    <div style="width:100%;max-width:480px;">
      
      <!-- Icon Lock SVG -->
      <div class="img-ph login-icon" style="height:60px;width:60px;border-radius:50%;margin:0 auto 20px;display:flex;align-items:center;justify-content:center;">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2"/>
          <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
        </svg>
      </div>

      <div style="font-size:26px;font-weight:bold;text-align:center;margin-bottom:8px;">Chào Mừng Trở Lại</div>
      <div style="font-size:14px;color:#555;text-align:center;margin-bottom:28px;">Đăng nhập vào tài khoản Bites &amp; More của bạn</div>

      <div class="filter-block" style="border:none;padding:0;background:transparent;">
        <!-- Form gửi dữ liệu sang LoginServlet bằng phương thức POST -->
        <form action="login" method="POST">
          
          <div class="field">
            <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Địa chỉ Email</label>
            <input type="email" name="email" class="input" placeholder="vidu@domain.com" required>
          </div>

          <div class="field" style="margin-top:16px;">
            <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Mật khẩu</label>
            <input type="password" name="password" class="input" placeholder="Nhập mật khẩu" required>
          </div>

          <div style="display:flex;justify-content:space-between;align-items:center;margin:20px 0;font-size:13px;">
            <label style="display:flex;align-items:center;gap:8px;cursor:pointer;font-weight:normal;">
              <input type="checkbox" name="remember" style="width:16px;height:16px;"> Ghi nhớ đăng nhập
            </label>
            <a href="forgot-password.jsp" style="text-decoration:underline;color:#000;">Quên mật khẩu?</a>
          </div>

          <button type="submit" class="btn btn-dark btn-block">ĐĂNG NHẬP</button>
        
        </form>

        <div style="text-align:center;margin-top:24px;font-size:13px;">
          Chưa có tài khoản? <a href="register.jsp" style="text-decoration:underline;font-weight:bold;color:#000;">Đăng ký ngay</a>
        </div>
      </div>

    </div>
  </div>

  <!-- FOOTER -->
  <div style="border-top:1px solid #000; padding:16px 0; text-align:center; font-size:13px; color:#000;">
    &copy; Bites &amp; More. since 2026
  </div>

</div>
</body>
</html>