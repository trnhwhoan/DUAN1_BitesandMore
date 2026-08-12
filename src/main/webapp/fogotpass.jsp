<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Quên Mật Khẩu</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="css/style.css">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
    }
    
    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* Đặt khối nội dung chính căn giữa màn hình */
    .main-content {
      flex: 1;
      width: 100%;
      max-width: 1140px;
      margin: 0 auto;
      padding: 40px 20px 60px 20px;
      box-sizing: border-box;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* BREADCRUMB TINH GỌN */
    .breadcrumb {
      max-width: 1140px;
      margin: 0 auto;
      padding: 20px 20px 10px !important;
      border: none !important;
      background: transparent !important;
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      color: #666;
    }
    .breadcrumb a {
      color: #666;
      text-decoration: none;
      transition: color 0.2s;
    }
    .breadcrumb a:hover {
      color: #000;
      text-decoration: underline;
    }
    .breadcrumb span.active {
      color: #000;
      font-weight: 600;
    }

    /* Xóa viền gạch dư thừa */
    .wire-page, .section, .wf-footer, .footer-bottom, .filter-block {
      border: none !important;
      background: transparent !important;
      box-shadow: none !important;
    }

    .form-box {
      width: 100%;
      max-width: 440px;
      border: 1px solid #000 !important;
      padding: 32px;
      background: #fff;
    }

    .field-input {
      width: 100%;
      height: 42px;
      padding: 0 12px;
      border: 1px solid #000;
      font-size: 14px;
      outline: none;
      box-sizing: border-box;
      background: #fff;
    }
    .field-input:focus {
      background-color: #fafafa;
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: (000) 123-4567</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <a href="home.jsp" class="wf-logo" style="color:#000;text-decoration:none;">BITES &amp; MORE</a>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="wf-searchbar">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <span>Tìm kiếm sản phẩm...</span>
    </div>
    <div class="wf-icons">
      <a href="favorites.jsp" class="ic-btn" style="position:relative;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">0</span>
      </a>
      <a href="cart.jsp" class="ic-btn" style="position:relative;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">0</span>
      </a>
      <a href="login.jsp" class="ic-btn">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a>
    </div>
  </div>

  <!-- BREADCRUMB -->
  <div class="breadcrumb">
    <a href="home.jsp">Trang chủ</a>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <a href="login.jsp">Đăng nhập</a>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span class="active">Quên mật khẩu</span>
  </div>

  <!-- MAIN FORGOT PASSWORD FORM -->
  <div class="main-content">
    <div class="form-box">
      
      <!-- Icon Khóa SVG -->
      <div style="height:64px;width:64px;border-radius:50%;margin:0 auto 20px;background:#f5f5f5;display:flex;align-items:center;justify-content:center;border:1px solid #000;">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
        </svg>
      </div>

      <h2 style="font-size:22px;font-weight:bold;text-align:center;margin:0 0 8px 0;">Khôi Phục Mật Khẩu</h2>
      <div style="font-size:13px;color:#555;text-align:center;margin-bottom:28px;line-height:1.5;">
        Nhập địa chỉ email đã đăng ký của bạn. Chúng tôi sẽ gửi đường dẫn đặt lại mật khẩu qua email.
      </div>

      <!-- Form gửi email sang ForgotPasswordServlet bằng POST -->
      <form action="forgot-password" method="POST">
        
        <div class="field">
          <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Địa chỉ Email *</label>
          <input type="email" name="email" class="field-input" placeholder="example@gmail.com" required>
        </div>

        <button type="submit" class="btn btn-dark" style="margin-top:20px;width:100%;padding:12px;background:#000;color:#fff;border:none;font-weight:bold;font-size:13px;cursor:pointer;">
          GỬI YÊU CẦU KHÔI PHỤC
        </button>
      
      </form>

      <div style="text-align:center;margin-top:24px;font-size:13px;display:flex;align-items:center;justify-content:center;gap:6px;">
        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="15,6 9,12 15,18"/></svg>
        <a href="login.jsp" style="text-decoration:underline;color:#000;font-weight:bold;">Quay lại Đăng nhập</a>
      </div>

    </div>
  </div>

  <!-- FOOTER -->
  <div style="border-top:1px solid #000; padding:16px 0; text-align:center; font-size:13px; color:#000; background:#fff;">
    &copy; Bites &amp; More. since 2026
  </div>

</div>

<!-- SCRIPT APP.JS ĐỒNG BỘ BADGE HEADER -->
<script src="js/app.js"></script>
</body>
</html>