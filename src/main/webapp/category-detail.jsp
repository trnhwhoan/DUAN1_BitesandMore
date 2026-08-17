<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${categoryName} — Bites &amp; More</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* SYSTEM DESIGN VARIABLES */
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
      color: var(--text-chocolate);
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
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
    .brand-logo:hover {
      background: var(--pink-primary);
      color: #fff;
      transform: translateY(-1px);
    }

    .wf-nav {
      display: flex;
      gap: 28px;
      align-items: center;
    }
    .wf-nav a {
      color: var(--text-chocolate);
      text-decoration: none;
      font-size: 13px;
      font-weight: 600;
      transition: color 0.2s;
    }
    .wf-nav a:hover, .wf-nav a.active {
      color: var(--pink-primary);
    }

    .header-actions {
      display: flex;
      align-items: center;
      gap: 16px;
    }

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
    .search-box input {
      border: none;
      outline: none;
      font-size: 12px;
      width: 100%;
      background: transparent;
      color: var(--text-chocolate);
    }

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
    .ic-btn:hover {
      border-color: var(--pink-primary);
      color: var(--pink-primary);
      transform: translateY(-2px);
    }
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

    .breadcrumb-bar {
      font-size: 13px;
      color: var(--text-muted);
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 28px;
    }
    .breadcrumb-bar a {
      color: var(--text-muted);
      text-decoration: none;
      transition: color 0.2s;
    }
    .breadcrumb-bar a:hover {
      color: var(--pink-primary);
    }

    .hero-collection-banner {
      position: relative;
      width: 100%;
      height: 300px;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-lg);
      margin-bottom: 40px;
      overflow: hidden;
      background: url('https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1600') center/cover no-repeat;
      display: flex;
      align-items: center;
      justify-content: center;
      box-shadow: var(--shadow-sm);
    }

    .hero-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(45, 30, 30, 0.6);
      transition: background 0.4s ease;
    }

    .hero-collection-banner:hover .hero-overlay {
      background: rgba(45, 30, 30, 0.5);
    }

    .hero-content {
      position: relative;
      z-index: 2;
      text-align: center;
      color: #fff;
      padding: 0 20px;
      max-width: 900px;
    }

    .hero-tag {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: var(--pink-primary);
      background: rgba(255, 255, 255, 0.95);
      border-radius: 20px;
      padding: 4px 14px;
      margin-bottom: 16px;
    }

    .hero-title {
      font-size: 28px;
      font-weight: 800;
      letter-spacing: 1px;
      text-transform: uppercase;
      margin: 0;
      line-height: 1.25;
      color: #fff;
    }

    .hero-divider {
      width: 50px;
      height: 3px;
      background: var(--pink-primary);
      margin: 14px auto;
      border-radius: 2px;
    }

    .hero-subtitle {
      font-size: 14px;
      font-weight: 400;
      color: var(--pink-light);
      margin: 0;
      line-height: 1.6;
    }

    .product-detail-list { display: flex; flex-direction: column; gap: 24px; }
    
    .product-detail-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 28px;
      display: grid;
      grid-template-columns: 240px 1fr;
      gap: 32px;
      align-items: start;
      border-radius: var(--radius-md);
      transition: all 0.25s ease;
      box-shadow: var(--shadow-sm);
    }

    .product-detail-card:hover {
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-md);
    }

    .p-img-box {
      width: 100%;
      height: 220px;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      overflow: hidden;
      background: var(--pink-subtle);
    }
    .p-img-box img { 
      width: 100%; 
      height: 100%; 
      object-fit: cover; 
      display: block; 
      transition: transform 0.4s ease;
    }
    .product-detail-card:hover .p-img-box img {
      transform: scale(1.04);
    }

    .p-info-box { display: flex; flex-direction: column; justify-content: space-between; height: 100%; }
    .p-title { font-size: 18px; font-weight: 800; text-transform: uppercase; margin-bottom: 8px; color: var(--text-chocolate); }
    .p-price { font-size: 18px; font-weight: 800; color: var(--pink-primary); margin-bottom: 14px; }
    .p-desc { font-size: 14px; color: var(--text-muted); line-height: 1.7; margin-bottom: 16px; text-align: justify; }

    .p-spec-box {
      background: var(--pink-subtle);
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      padding: 14px 18px;
      font-size: 13px;
      color: var(--text-muted);
      line-height: 1.6;
      margin-bottom: 20px;
    }
    .p-spec-box strong {
      color: var(--text-chocolate);
    }

    .btn-actions { display: flex; gap: 12px; }
    
    .btn-action-main { 
      padding: 10px 22px; 
      background: var(--pink-primary); 
      color: #fff; 
      border: none; 
      border-radius: 20px;
      text-decoration: none; 
      font-weight: 700; 
      font-size: 12px; 
      cursor: pointer; 
      transition: all 0.2s;
      box-shadow: var(--shadow-sm);
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }
    .btn-action-main:hover {
      background: var(--pink-dark);
      transform: translateY(-1px);
    }

    .btn-action-sub { 
      padding: 10px 22px; 
      background: #fff; 
      color: var(--pink-primary); 
      border: 1.5px solid var(--pink-primary); 
      border-radius: 20px;
      text-decoration: none; 
      font-weight: 700; 
      font-size: 12px; 
      transition: all 0.2s;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }
    .btn-action-sub:hover {
      background: var(--pink-light);
    }

    .minimal-footer { 
      border-top: 1.5px solid var(--border-soft); 
      background: #fff; 
      padding: 20px 0; 
      text-align: center; 
      font-size: 13px; 
      color: var(--text-muted); 
    }

    @media (max-width: 768px) {
      .hero-collection-banner { height: 260px; }
      .hero-title { font-size: 22px; }
      .hero-subtitle { font-size: 13px; }
      .product-detail-card { grid-template-columns: 1fr; }
      .main-content { padding: 20px; }
      .btn-actions { flex-direction: column; }
    }
  </style>
</head>
<body>

<canvas id="sweet-falling-canvas"></canvas>

<div class="wire-page">

  <div class="wf-topbar">
    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8c0-2.2-1.8-4-4-4H10C7.8 4 6 5.8 6 8c-2.2 0-4 1.8-4 4s1.8 4 4 4h12c2.2 0 4-1.8 4-4s-1.8-4-4-4z"/><path d="M10 4v12"/><path d="M14 4v12"/></svg>
    MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND | HOTLINE: 0766 766 999
  </div>

  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
      BITES &amp; MORE
    </a>
    
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp" class="active">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>

      <!-- NÚT THÔNG BÁO KÈM MENU DROPDOWN -->
<div class="notification-wrapper" style="position: relative; display: inline-block;">
  <button type="button" class="ic-btn" id="btn-noti-toggle" title="Thông báo" onclick="toggleNotificationDropdown(event)" 
          style="cursor: pointer; background: #fff; border: 1.5px solid var(--border-soft, #f1cfd5); width: 40px; height: 40px; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; position: relative; padding: 0; outline: none; transition: transform 0.15s;">
    <!-- Icon Chuông SVG -->
    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#2b1b1b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
      <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
    </svg>
    
    <!-- Badge đỏ đếm số thông báo chưa đọc (Tự ẩn nếu = 0) -->
    <span class="noti-badge" id="notiCountBadge" 
          style="display: none; position: absolute; top: -4px; right: -4px; background: #e86a85; color: #fff; font-size: 10px; font-weight: 800; min-width: 18px; height: 18px; line-height: 18px; text-align: center; border-radius: 10px; border: 2px solid #fff; padding: 0 4px; box-sizing: border-box;">
      0
    </span>
  </button>

  <!-- MENU DANH SÁCH THÔNG BÁO XỔ XUỐNG -->
  <div id="notificationDropdown" class="notification-dropdown-box" 
       style="display: none; position: absolute; right: 0; top: 48px; width: 330px; background: #fff; border: 1.5px solid #f1cfd5; border-radius: 14px; box-shadow: 0 10px 25px rgba(232, 106, 133, 0.15); z-index: 9999; overflow: hidden;">
    
    <div style="padding: 12px 16px; background: #fff7f8; border-bottom: 1px solid #f1cfd5; display: flex; justify-content: space-between; align-items: center;">
      <strong style="font-size: 13px; color: #2b1b1b; text-transform: uppercase;">🔔 Thông báo đơn hàng</strong>
      <span style="font-size: 11px; color: #e86a85; cursor: pointer; font-weight: 700;" onclick="markAllNotificationsAsRead()">Đã đọc tất cả</span>
    </div>

    <!-- Nơi render dữ liệu từ database -->
    <div class="notification-list-body" id="notificationListBody" style="max-height: 300px; overflow-y: auto;">
      <div style="padding: 24px; text-align: center; color: #999; font-size: 12px;">Đang tải thông báo...</div>
    </div>

    <div style="padding: 10px; text-align: center; border-top: 1px solid #f1cfd5; background: #fafafa;">
      <a href="profile" style="font-size: 12px; font-weight: 700; color: #e86a85; text-decoration: none;">Xem lịch sử đơn hàng &rsaquo;</a>
    </div>
  </div>
</div>
        <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
        </a>
        <c:choose>
          <c:when test="${not empty sessionScope.account}">
            <a href="profile.jsp" class="ic-btn" title="Tài khoản: ${sessionScope.account.fullName}">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
            </a>
          </c:when>
          <c:otherwise>
            <a href="login.jsp" class="ic-btn" title="Đăng nhập">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8 7"/></svg>
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>

  <main class="main-content">
    
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <a href="categories.jsp">Danh Mục</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);">${categoryName}</strong>
    </div>

    <div class="hero-collection-banner">
      <div class="hero-overlay"></div>
      <div class="hero-content">
        <span class="hero-tag">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
          THE ART OF ARTISAN BAKERY
        </span>
        <h1 class="hero-title">THIÊN ĐƯỜNG BÁNH NGỌT BITES &amp; MORE</h1>
        <div class="hero-divider"></div>
        <p class="hero-subtitle">Nơi đánh thức vị giác bằng những mẻ bánh mì men tự nhiên thơm nức mỗi sáng và các tuyệt tác bánh kem thủ công thượng hạng.</p>
      </div>
    </div>

    <div style="border-bottom:1.5px solid var(--border-soft); padding-bottom:12px; margin-bottom:32px; display:flex; justify-content:space-between; align-items:flex-end;">
      <div>
        <h1 style="font-size:22px; font-weight:800; text-transform:uppercase; margin:0 0 4px 0; color:var(--text-chocolate);">${categoryName}</h1>
        <p style="font-size:13px; color:var(--text-muted); margin:0;">Danh sách giới thiệu chi tiết các dòng bánh đặc sản thuộc danh mục này</p>
      </div>
      <div style="font-size:13px; color:var(--text-muted);">Hiển thị <strong style="color:var(--pink-primary);">${not empty productList ? productList.size() : 0}</strong> sản phẩm</div>
    </div>

    <div class="product-detail-list">
      <c:choose>
        <c:when test="${not empty productList}">
          <c:forEach items="${productList}" var="p">
            <div class="product-detail-card">
              
              <div class="p-img-box">
                <img src="${p.image}" alt="${p.productName}" onError="this.onerror=null;this.src='images/placeholder.jpg';">
              </div>

              <div class="p-info-box">
                <div>
                  <div class="p-title">${p.productName}</div>
                  <div class="p-price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</div>
                  <div class="p-desc">${p.description}</div>

                  <div class="p-spec-box">
                    <div><strong>• Thành phần nguyên liệu:</strong> ${not empty p.ingredient ? p.ingredient : 'Bột mỳ hữu cơ, bơ Pháp, men tươi tự nhiên.'}</div>
                    <div><strong>• Hạn sử dụng:</strong> ${p.expiryDate > 0 ? p.expiryDate : 3} ngày kể từ ngày sản xuất.</div>
                    <div><strong>• Hướng dẫn bảo quản:</strong> ${not empty p.usageInstructions ? p.usageInstructions : 'Nên thưởng thức ngay trong ngày hoặc bảo quản ngăn mát tủ lạnh.'}</div>
                  </div>
                </div>

                <div class="btn-actions">
                  <a href="product-detail?id=${p.id != 0 ? p.id : p.productId}" class="btn-action-sub">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
                    XEM CHI TIẾT
                  </a>
                  <button type="button" class="btn-action-main btn-ajax-cart" data-id="${p.id != 0 ? p.id : p.productId}">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
                    THÊM VÀO GIỎ HÀNG
                  </button>
                </div>
              </div>

            </div>
          </c:forEach>
        </c:when>

        <c:otherwise>
          <div style="text-align:center; padding:60px; border:1.5px solid var(--border-soft); border-radius:var(--radius-md); background:#fff; font-size:14px; color:var(--text-muted);">
            Chưa có sản phẩm nào thuộc danh mục này trong Database.
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </main>

  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

</div>

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
<script>
document.querySelectorAll('.btn-ajax-cart').forEach(function (button) {
  button.addEventListener('click', function () {
    var params = new URLSearchParams({action:'add', productId:this.dataset.id, quantity:'1'});
    fetch('cart', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:params.toString()})
      .then(function (r) { if (!r.ok) throw new Error('Không thể thêm sản phẩm vào giỏ.'); return r; })
      .then(function () { button.textContent = 'ĐÃ THÊM ✓'; })
      .catch(function (e) { alert(e.message); });
  });
});
</script>
<script>
  // 1. Tự động lấy thông báo thật từ Servlet khi vừa tải trang
  document.addEventListener("DOMContentLoaded", function () {
    fetchRealNotifications();
    // Tự động kiểm tra thông báo mới mỗi 15 giây (Polling)
    setInterval(fetchRealNotifications, 15000);
  });

  // 2. Bật / Tắt menu khi bấm vào chuông
  function toggleNotificationDropdown(event) {
    event.stopPropagation();
    var dropdown = document.getElementById("notificationDropdown");
    if (dropdown.style.display === "none" || dropdown.style.display === "") {
      dropdown.style.display = "block";
      fetchRealNotifications();
    } else {
      dropdown.style.display = "none";
    }
  }

  // 3. Tải danh sách thông báo từ API Servlet (/api/notifications)
  function fetchRealNotifications() {
    fetch('api/notifications')
      .then(res => res.json())
      .then(data => {
        var badge = document.getElementById("notiCountBadge");
        var listBody = document.getElementById("notificationListBody");
        if (!listBody) return;

        if (!data || data.length === 0) {
          listBody.innerHTML = '<div style="padding: 24px; text-align: center; color: #8c7373; font-size: 12px;">Chưa có thông báo nào</div>';
          if (badge) badge.style.display = "none";
          return;
        }

        // Đếm số thông báo chưa đọc
        var unreadCount = data.filter(item => !item.isRead).length;
        if (badge) {
          if (unreadCount > 0) {
            badge.innerText = unreadCount;
            badge.style.display = "block";
          } else {
            badge.style.display = "none";
          }
        }

        // Tạo danh sách HTML các item thông báo
        var html = "";
        data.forEach(item => {
          var bg = item.isRead ? "#ffffff" : "#fff8f9";
          html += `
            <a href="profile" style="display: block; padding: 12px 16px; border-bottom: 1px solid #f8e8ec; text-decoration: none; color: inherit; background: \${bg}; transition: background 0.15s;"
               onmouseover="this.style.background='#fff0f3'" onmouseout="this.style.background='\${bg}'">
              <div style="display: flex; gap: 12px; align-items: flex-start;">
                <span style="font-size: 20px; line-height: 1;">\${item.icon || '📦'}</span>
                <div style="flex: 1;">
                  <div style="font-size: 12.5px; font-weight: 700; color: #2b1b1b;">\${item.title}</div>
                  <div style="font-size: 11.5px; color: #666; margin-top: 3px; line-height: 1.4;">\${item.message}</div>
                </div>
              </div>
            </a>
          `;
        });
        listBody.innerHTML = html;
      })
      .catch(err => console.log("Lỗi tải thông báo:", err));
  }

  // 4. Đánh dấu đã đọc tất cả
  function markAllNotificationsAsRead() {
    fetch('api/notifications', { method: 'POST' })
      .then(() => {
        var badge = document.getElementById("notiCountBadge");
        if (badge) badge.style.display = "none";
        fetchRealNotifications();
      });
  }

  // 5. Tự động đóng menu khi bấm chuột ra ngoài màn hình
  document.addEventListener("click", function(event) {
    var wrapper = document.querySelector(".notification-wrapper");
    var dropdown = document.getElementById("notificationDropdown");
    if (wrapper && dropdown && !wrapper.contains(event.target)) {
      dropdown.style.display = "none";
    }
  });
</script>
</body>
</html>
