<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Liên Hệ</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* SYSTEM DESIGN VARIABLES (ĐỒNG BỘ VỚI HOME.JSP) */
    :root {
      --pink-primary: #e86a85;
      --pink-dark: #d6526f;
      --pink-light: #fde8ed;
      --pink-subtle: #fff5f7;
      --bg-cream: #faf7f5;
      --text-chocolate: #2d1e1e;
      --text-muted: #7a6363;
      --border-soft: #f4c2c2;
      --shadow-sm: 0 4px 12px rgba(232, 106, 133, 0.08);
      --shadow-md: 0 8px 24px rgba(232, 106, 133, 0.12);
      --radius-sm: 8px;
      --radius-md: 12px;
      --radius-lg: 16px;
    }

    /* CANVAS BÁNH RƠI LẢ TẢ */
    #sweet-falling-canvas {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      pointer-events: none;
      z-index: 9999;
      opacity: 0.8;
    }

    html, body { 
      height: 100%; 
      margin: 0; 
      padding: 0; 
      background-color: var(--bg-cream); 
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; 
      color: var(--text-chocolate); 
    }
    
    .wire-page { 
      display: flex; 
      flex-direction: column; 
      min-height: 100vh; 
      width: 100%; 
    }

    .main-content { 
      flex: 1; 
      width: 100%; 
      padding: 24px 40px 60px 40px; 
      box-sizing: border-box; 
    }

    /* TOPBAR & HEADER */
    .wf-topbar { 
      background: linear-gradient(135deg, var(--pink-primary), var(--pink-dark)); 
      color: #fff; 
      font-size: 11px; 
      font-weight: 600; 
      letter-spacing: 0.5px; 
      text-align: center; 
      padding: 8px 20px; 
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .wf-header { 
      width: 100%; 
      box-sizing: border-box; 
      padding: 16px 40px; 
      display: flex; 
      align-items: center; 
      justify-content: space-between; 
      background: rgba(250, 247, 245, 0.95); 
      backdrop-filter: blur(8px);
      border-bottom: 1px solid var(--border-soft); 
      position: sticky; 
      top: 0; 
      z-index: 100; 
    }

    .brand-logo { 
      color: var(--pink-primary); 
      text-decoration: none; 
      font-weight: 800; 
      font-size: 20px; 
      border: 2px solid var(--pink-primary); 
      padding: 6px 16px; 
      display: inline-flex; 
      align-items: center;
      gap: 8px;
      background: #fff; 
      border-radius: var(--radius-sm);
      transition: all 0.25s ease; 
      box-shadow: var(--shadow-sm);
    }
    .brand-logo:hover { background: var(--pink-primary); color: #fff; transform: translateY(-1px); }

    .wf-nav { display: flex; gap: 28px; align-items: center; }
    .wf-nav a { color: var(--text-chocolate); text-decoration: none; font-size: 13px; font-weight: 600; transition: color 0.2s; }
    .wf-nav a:hover, .wf-nav a.active { color: var(--pink-primary); }
    
    .header-actions { display: flex; align-items: center; gap: 16px; }
    .search-box { 
      display: flex; 
      align-items: center; 
      gap: 8px; 
      border: 1.5px solid var(--border-soft); 
      padding: 8px 14px; 
      background: #fff; 
      width: 220px; 
      border-radius: 20px;
      transition: all 0.2s;
    }
    .search-box:focus-within {
      border-color: var(--pink-primary);
      box-shadow: 0 0 0 3px rgba(232, 106, 133, 0.15);
    }
    .search-box input { border: none; outline: none; font-size: 12px; width: 100%; background: transparent; color: var(--text-chocolate); }

    .ic-btn { 
      position: relative; 
      display: inline-flex; 
      align-items: center; 
      justify-content: center;
      width: 38px;
      height: 38px;
      border-radius: 50%;
      background: #fff;
      border: 1px solid var(--border-soft);
      color: var(--text-chocolate); 
      text-decoration: none; 
      transition: all 0.2s;
    }
    .ic-btn:hover { border-color: var(--pink-primary); color: var(--pink-primary); transform: translateY(-2px); }
    .ic-btn .badge { 
      position: absolute; 
      top: -4px; 
      right: -4px; 
      background: var(--pink-primary); 
      color: #fff; 
      font-size: 10px; 
      font-weight: bold; 
      width: 18px;
      height: 18px;
      border-radius: 50%; 
      display: flex;
      align-items: center;
      justify-content: center;
      border: 2px solid #fff;
    }

    .breadcrumb-bar { font-size: 13px; color: var(--text-muted); display: flex; align-items: center; gap: 8px; margin-bottom: 28px; }
    .breadcrumb-bar a { color: var(--text-muted); text-decoration: none; transition: color 0.2s; }
    .breadcrumb-bar a:hover { color: var(--pink-primary); }

    /* MAP CONTAINER */
    .map-box {
      margin-bottom: 40px; 
      border: 1.5px solid var(--border-soft); 
      background: #fff; 
      overflow: hidden; 
      height: 320px;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    /* 4 CỘT THÔNG TIN VỚI GIỜ MỞ CỬA */
    .contact-info-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 48px;
    }

    .info-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 28px 16px;
      text-align: center;
      border-radius: var(--radius-md);
      transition: all 0.25s ease;
    }

    .info-card:hover {
      border-color: var(--pink-primary);
      transform: translateY(-4px);
      box-shadow: var(--shadow-sm);
    }

    .info-card .icon-ph {
      height: 52px;
      width: 52px;
      border-radius: 50%;
      margin: 0 auto 14px;
      background: var(--pink-light);
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--pink-primary);
    }

    /* KHỐI DỊCH VỤ ĐẶT TIỆC CHUYÊN NGHIỆP */
    .service-banner {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 36px;
      margin-bottom: 48px;
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 28px;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    .service-item h3 {
      font-size: 15px;
      font-weight: 800;
      color: var(--text-chocolate);
      margin: 0 0 8px 0;
      border-bottom: 2px solid var(--pink-primary);
      padding-bottom: 6px;
    }

    .service-item p {
      font-size: 13px;
      color: var(--text-muted);
      line-height: 1.6;
      margin: 0;
    }

    /* FORM VÀ HÌNH ẢNH */
    .contact-form-layout {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 32px;
      align-items: stretch;
      margin-bottom: 48px;
    }

    .form-box {
      border: 1.5px solid var(--border-soft);
      padding: 36px;
      background: #fff;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    .field-group-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
      margin-bottom: 16px;
    }

    .field-input {
      width: 100%;
      padding: 10px 14px;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      font-size: 13px;
      outline: none;
      box-sizing: border-box;
      background: #fff;
      font-family: inherit;
      color: var(--text-chocolate);
      transition: border-color 0.2s;
    }

    .field-input:focus {
      border-color: var(--pink-primary);
    }

    .btn-submit {
      margin-top: 16px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      cursor: pointer;
      background: var(--pink-primary);
      color: #fff;
      padding: 12px 28px;
      border: none;
      border-radius: 20px;
      font-weight: 700;
      font-size: 13px;
      letter-spacing: 0.5px;
      width: 100%;
      transition: all 0.2s;
      box-shadow: var(--shadow-sm);
    }

    .btn-submit:hover {
      background: var(--pink-dark);
      transform: translateY(-1px);
    }

    /* KHỐI FAQ CÂU HỎI THƯỜNG GẶP */
    .faq-section {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 36px;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    .faq-title {
      font-size: 18px;
      font-weight: 800;
      color: var(--text-chocolate);
      border-bottom: 2px solid var(--pink-primary);
      padding-bottom: 10px;
      margin-bottom: 24px;
      letter-spacing: 0.5px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .faq-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
    }

    .faq-item h4 {
      font-size: 14px;
      font-weight: 700;
      color: var(--text-chocolate);
      margin: 0 0 6px 0;
    }

    .faq-item p {
      font-size: 13px;
      color: var(--text-muted);
      line-height: 1.6;
      margin: 0;
    }

    .minimal-footer { 
      border-top: 1.5px solid var(--border-soft); 
      background: #fff; 
      padding: 20px 0; 
      text-align: center; 
      font-size: 13px; 
      color: var(--text-muted); 
      width: 100%; 
    }

    @media (max-width: 992px) {
      .main-content, .wf-header { padding-left: 20px; padding-right: 20px; }
      .contact-info-grid { grid-template-columns: repeat(2, 1fr); }
      .service-banner, .faq-grid, .contact-form-layout { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>

<!-- CANVAS BÁNH RƠI LẢ TẢ -->
<canvas id="sweet-falling-canvas"></canvas>

<div class="wire-page">

  <!-- TOPBAR VỚI ICON BÁNH MÌ -->
  <div class="wf-topbar">
    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8c0-2.2-1.8-4-4-4H10C7.8 4 6 5.8 6 8c-2.2 0-4 1.8-4 4s1.8 4 4 4h12c2.2 0 4-1.8 4-4s-1.8-4-4-4z"/><path d="M10 4v12"/><path d="M14 4v12"/></svg>
    MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND | HOTLINE: 0766 766 999
  </div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
      BITES &amp; MORE
    </a>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp" class="active">Liên hệ</a>
    </nav>
    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>
      <div style="display:flex; gap:12px;">
        <a href="feedback" class="ic-btn feedback-link" title="Góp ý">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
        </a>
        <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
        </a>
        <c:choose>
          <c:when test="${not empty sessionScope.account}">
            <a href="profile.jsp" class="ic-btn" title="Tài khoản: ${sessionScope.account.fullName}">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8 7"/></svg>
            </a>
          </c:when>
          <c:otherwise>
            <a href="login.jsp" class="ic-btn" title="Đăng nhập">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <main class="main-content">
    
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span> <strong style="color:var(--text-chocolate);">Liên Hệ</strong>
    </div>

    <!-- MAP BANNER -->
    <div class="map-box">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3833.837262078693!2d108.21980837583091!3d16.073926539970908!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142183120155555%3A0x28974a9582103d36!2zRMOgIE7huqVuZw!5e0!3m2!1svi!2s!4v1700000000000!5m2!1svi!2s" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
    </div>

    <div style="text-align:center; margin-bottom:36px;">
      <h1 style="font-size:22px; font-weight:800; text-transform:uppercase; letter-spacing:0.5px; margin:0 0 8px 0; color:var(--text-chocolate);">
        <c:choose>
          <c:when test="${param.feedback eq 'true'}">GÓP Ý &amp; PHẢN HỒI</c:when>
          <c:otherwise>HỖ TRỢ &amp; DỊCH VỤ KHÁCH HÀNG</c:otherwise>
        </c:choose>
      </h1>
      <p style="font-size:13px; color:var(--text-muted); margin:0;">Bites &amp; More luôn sẵn sàng phục vụ những mẻ bánh tươi ngon nhất mỗi ngày</p>
    </div>

    <!-- 4 BLOCK THÔNG TIN CHUYÊN NGHIỆP -->
    <div class="contact-info-grid">
      <div class="info-card">
        <div class="icon-ph">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
        </div>
        <div style="font-weight:700; margin-bottom:6px; font-size:14px; text-transform:uppercase; color:var(--text-chocolate);">Cửa Hàng</div>
        <div style="font-size:12px; color:var(--text-muted); line-height:1.5;">123 Phố Bánh Ngọt, Q. Hải Châu, TP. Đà Nẵng</div>
      </div>

      <div class="info-card">
        <div class="icon-ph">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div style="font-weight:700; margin-bottom:6px; font-size:14px; text-transform:uppercase; color:var(--text-chocolate);">Giờ Mở Cửa</div>
        <div style="font-size:12px; color:var(--text-muted); line-height:1.5;">Thứ 2 - Chủ Nhật<br><strong style="color:var(--pink-primary);">06:00 - 22:00</strong></div>
      </div>

      <div class="info-card">
        <div class="icon-ph">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1.9.3 1.8.6 2.7a2 2 0 0 1-.4 2.1L8 9.9a16 16 0 0 0 6 6l1.4-1.4a2 2 0 0 1 2.1-.4c.9.3 1.8.5 2.7.6a2 2 0 0 1 1.8 2.1z"/></svg>
        </div>
        <div style="font-weight:700; margin-bottom:6px; font-size:14px; text-transform:uppercase; color:var(--text-chocolate);">Hotline Đặt Hàng</div>
        <div style="font-size:12px; color:var(--text-muted); line-height:1.5;">0766 766 999<br><em>(Hỗ trợ 24/7)</em></div>
      </div>

      <div class="info-card">
        <div class="icon-ph">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,6 12,13 22,6"/></svg>
        </div>
        <div style="font-weight:700; margin-bottom:6px; font-size:14px; text-transform:uppercase; color:var(--text-chocolate);">Email Khách Hàng</div>
        <div style="font-size:12px; color:var(--text-muted); line-height:1.5;">hello@bitesandmore.com<br>order@bitesandmore.com</div>
      </div>
    </div>

    <!-- KHỐI DỊCH VỤ ĐẶT TIỆC / EVENT -->
    <div class="service-banner">
      <div class="service-item">
        <h3>Đặt Bánh Sinh Nhật Theo Yêu Cầu</h3>
        <p>Tự do lựa chọn hương vị, nhân bánh và thiết kế mẫu bánh theo cá tính riêng. Vui lòng liên hệ trước 24 giờ.</p>
      </div>
      <div class="service-item">
        <h3>Dịch Vụ Tiệc Teabreak Công Ty</h3>
        <p>Cung cấp các set bánh mỳ, pastry ngọt &amp; mặn nhỏ gọn dành cho sự kiện, hội thảo và tiệc sinh nhật công ty.</p>
      </div>
      <div class="service-item">
        <h3>Giao Bánh Tươi Tận Nơi</h3>
        <p>Giao hàng siêu tốc trong vòng 60 phút nội thành Đà Nẵng. Bảo đảm bánh nguyên vẹn, giữ trọn độ nóng giòn.</p>
      </div>
    </div>

    <!-- FORM VÀ HÌNH ẢNH -->
    <div class="contact-form-layout">
      <c:if test="${param.submitted eq 'true' and not empty sessionScope.lastFeedback}">
        <div style="grid-column:1/-1; border:1.5px solid var(--border-soft); background:var(--pink-light); color:var(--text-chocolate); padding:18px; margin-bottom:20px; font-size:13px; border-radius:var(--radius-md);">
          <strong style="color:var(--pink-primary);">Đã nhận feedback của bạn!</strong><br>
          Chủ đề: <c:out value="${sessionScope.lastFeedback.topic}"/> · Đánh giá: <c:out value="${sessionScope.lastFeedback.rating}"/><br>
          Nội dung: <c:out value="${sessionScope.lastFeedback.content}"/>
        </div>
      </c:if>

      <div style="border:1.5px solid var(--border-soft); border-radius:var(--radius-lg); overflow:hidden; box-shadow:var(--shadow-sm);">
        <img src="https://images.unsplash.com/photo-1517433670267-08bbd4be890f?q=80&w=800" alt="Không gian tiệm bánh Bites & More" style="width:100%; height:100%; min-height:440px; object-fit:cover; display:block;">
      </div>

      <div class="form-box">
        <h2 style="border-bottom:2px solid var(--pink-primary); padding-bottom:12px; margin:0 0 20px 0; font-size:15px; font-weight:800; text-transform:uppercase; color:var(--text-chocolate);">
          <c:choose>
            <c:when test="${param.feedback eq 'true'}">GỬI PHẢN HỒI CHO BITES &amp; MORE</c:when>
            <c:otherwise>GỬI TIN NHẮN TƯ VẤN</c:otherwise>
          </c:choose>
        </h2>
        
        <form action="contact" method="POST">
          <div class="field-group-row">
            <div>
              <label style="display:block; margin-bottom:6px; font-size:11px; font-weight:700; text-transform:uppercase; color:var(--text-chocolate);">Họ và Tên *</label>
              <input type="text" name="name" class="field-input" placeholder="Nhập tên của bạn" required>
            </div>
            <div>
              <label style="display:block; margin-bottom:6px; font-size:11px; font-weight:700; text-transform:uppercase; color:var(--text-chocolate);">Email *</label>
              <input type="email" name="email" class="field-input" placeholder="example@gmail.com" required>
            </div>
          </div>
          
          <div style="margin-bottom:16px;">
            <label style="display:block; margin-bottom:6px; font-size:11px; font-weight:700; text-transform:uppercase; color:var(--text-chocolate);">Nhu Cầu *</label>
            <select name="subject" class="field-input" style="height:41px;" required>
              <option value="Đặt bánh lẻ">Đặt bánh mì / bánh ngọt lẻ</option>
              <option value="Đặt bánh sinh nhật">Đặt bánh kem sinh nhật theo thiết kế</option>
              <option value="Đặt tiệc Teabreak">Tư vấn tiệc Teabreak công ty</option>
              <option value="Góp ý dịch vụ">Góp ý chất lượng dịch vụ</option>
            </select>
          </div>

          <div style="margin-bottom:16px;">
            <label style="display:block; margin-bottom:6px; font-size:11px; font-weight:700; text-transform:uppercase; color:var(--text-chocolate);">Nội Dung *</label>
            <textarea name="message" class="field-input" rows="4" placeholder="Nhập chi tiết yêu cầu bánh hoặc thắc mắc của bạn..." required style="height:auto; resize:vertical; padding-top:10px;"></textarea>
          </div>

          <button type="submit" class="btn-submit">
            GỬI YÊU CẦU TƯ VẤN
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
          </button>
        </form>
      </div>
    </div>

    <!-- KHỐI FAQ CÂU HỎI THƯỜNG GẶP -->
    <div class="faq-section">
      <div class="faq-title">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><path d="M9.09 9a3 3 0 0 1 5.83 1c0 2-3 3-3 3"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg>
        CÂU HỎI THƯỜNG GẶP (FAQ)
      </div>
      <div class="faq-grid">
        <div class="faq-item">
          <h4>Q: Tôi muốn đặt bánh sinh nhật mẫu riêng thì cần báo trước bao lâu?</h4>
          <p>A: Bạn nên gửi yêu cầu trước ít nhất 24 giờ để đội ngũ thợ bánh chuẩn bị nguyên liệu tươi và tạo hình tỉ mỉ nhất.</p>
        </div>
        <div class="faq-item">
          <h4>Q: Bánh mì tươi có thể bảo quản được trong bao lâu?</h4>
          <p>A: Bánh mì men tự nhiên thưởng thức ngon nhất trong ngày. Bạn có thể bọc kín bảo quản ngăn mát 2-3 ngày và nướng lại trước khi ăn.</p>
        </div>
        <div class="faq-item">
          <h4>Q: Tiệm có hỗ trợ giao hàng tận nơi không?</h4>
          <p>A: Bites &amp; More có đội ngũ shipper riêng hỗ trợ đóng gói và giao hàng cẩn thận toàn thành phố Đà Nẵng.</p>
        </div>
        <div class="faq-item">
          <h4>Q: Tiệm có xuất hóa đơn GTGT (VAT) cho đơn hàng công ty không?</h4>
          <p>A: Có, chúng tôi hỗ trợ xuất hóa đơn VAT đầy đủ cho các đơn hàng đặt tiệc Teabreak hoặc quà tặng doanh nghiệp.</p>
        </div>
      </div>
    </div>

  </main>

  <!-- FOOTER -->
  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

</div>

<!-- SCRIPT BÁNH RƠI -->
<script>
  (function() {
    const canvas = document.getElementById('sweet-falling-canvas');
    const ctx = canvas.getContext('2d');

    let width = canvas.width = window.innerWidth;
    let height = canvas.height = window.innerHeight;

    window.addEventListener('resize', () => {
      width = canvas.width = window.innerWidth;
      height = canvas.height = window.innerHeight;
    });

    const items = ['🥐', '🍰', '🍓', '🧁', '🍩', '🍪', '✨', '🍒'];
    const particleCount = 20; 
    const particles = [];

    class Particle {
      constructor() {
        this.reset();
      }

      reset() {
        this.x = Math.random() * width;
        this.y = Math.random() * -height;
        this.size = Math.random() * 14 + 14; 
        this.text = items[Math.floor(Math.random() * items.length)];
        this.speedY = Math.random() * 0.8 + 0.5; 
        this.speedX = Math.random() * 0.4 - 0.2; 
        this.rotation = Math.random() * 360;
        this.spin = Math.random() * 0.02 - 0.01; 
        this.opacity = Math.random() * 0.5 + 0.4;
      }

      update() {
        this.y += this.speedY;
        this.x += Math.sin(this.y * 0.01) * 0.5 + this.speedX;
        this.rotation += this.spin;

        if (this.y > height + 20) {
          this.reset();
          this.y = -20;
        }
      }

      draw() {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.rotation);
        ctx.globalAlpha = this.opacity;
        ctx.font = this.size + 'px serif';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(this.text, 0, 0);
        ctx.restore();
      }
    }

    for (let i = 0; i < particleCount; i++) {
      particles.push(new Particle());
    }

    function animate() {
      ctx.clearRect(0, 0, width, height);
      particles.forEach(p => {
        p.update();
        p.draw();
      });
      requestAnimationFrame(animate);
    }

    animate();
  })();
</script>

<script src="js/app.js"></script>
</body>
</html>