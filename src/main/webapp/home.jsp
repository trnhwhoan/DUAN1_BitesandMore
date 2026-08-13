<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Tiệm Bánh Thủ Công</title>
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

    /* CANVAS HIỆU ỨNG BÁNH RƠI */
    #sweet-falling-canvas {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      pointer-events: none; /* Không cản trở người dùng click mua hàng */
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
      max-width: 100% !important;
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

    /* SECTION TITLES */
    .section-header {
      text-align: center;
      margin-bottom: 28px;
    }
    .section-title {
      font-size: 20px;
      font-weight: 800;
      color: var(--text-chocolate);
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      margin: 0 0 6px 0;
    }
    .section-subtitle {
      font-size: 13px;
      color: var(--text-muted);
      margin: 0;
    }

    /* 1. HERO SECTION */
    .hero-split-box {
      display: grid;
      grid-template-columns: 1.2fr 1fr;
      border: 1.5px solid var(--border-soft);
      background: var(--pink-subtle);
      margin-bottom: 40px;
      border-radius: var(--radius-lg);
      overflow: hidden;
      box-shadow: var(--shadow-sm);
    }
    .hero-img-side {
      height: 420px;
      overflow: hidden;
    }
    .hero-img-side img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.5s ease;
    }
    .hero-split-box:hover .hero-img-side img {
      transform: scale(1.04);
    }
    .hero-info-side {
      padding: 48px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: flex-start;
    }
    .hero-tag {
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 0.5px;
      color: var(--pink-primary);
      background: #fff;
      border: 1px solid var(--border-soft);
      padding: 4px 12px;
      border-radius: 20px;
      margin-bottom: 14px;
      display: inline-flex;
      align-items: center;
      gap: 6px;
    }
    .hero-info-side h1 {
      font-size: 32px;
      font-weight: 800;
      margin: 0 0 16px 0;
      line-height: 1.25;
      color: var(--text-chocolate);
    }
    .hero-info-side p {
      font-size: 14px;
      color: var(--text-muted);
      line-height: 1.6;
      margin: 0 0 28px 0;
    }

    /* 2. VALUE PROPOSITION */
    .features-row {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 48px;
    }
    .feature-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 24px 16px;
      text-align: center;
      border-radius: var(--radius-md);
      transition: all 0.25s ease;
    }
    .feature-card:hover {
      border-color: var(--pink-primary);
      transform: translateY(-4px);
      box-shadow: var(--shadow-sm);
    }
    .feature-icon {
      width: 52px;
      height: 52px;
      border-radius: 50%;
      background: var(--pink-light);
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 12px auto;
      color: var(--pink-primary);
    }

    /* 3. PROMOTION BANNER GRID */
    .promo-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
      margin-bottom: 48px;
    }
    .promo-card-item {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      display: flex;
      align-items: center;
      overflow: hidden;
      border-radius: var(--radius-md);
      transition: all 0.25s ease;
    }
    .promo-card-item:hover {
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-sm);
    }
    .promo-card-img {
      width: 45%;
      height: 240px;
      overflow: hidden;
      flex-shrink: 0;
    }
    .promo-card-img img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .promo-card-content {
      padding: 24px;
      flex: 1;
    }

    /* 4. CATEGORIES GRID */
    .categories-grid {
      display: grid;
      grid-template-columns: repeat(6, 1fr);
      gap: 16px;
      margin-bottom: 48px;
    }
    .cat-card {
      text-decoration: none;
      color: var(--text-chocolate);
      text-align: center;
    }
    .cat-img-box {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      height: 150px;
      margin-bottom: 10px;
      overflow: hidden;
      border-radius: var(--radius-md);
      transition: all 0.25s ease;
    }
    .cat-card:hover .cat-img-box {
      transform: translateY(-4px);
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-sm);
    }
    .cat-img-box img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    /* 5. PRODUCTS GRID */
    .products-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 48px;
    }
    .product-box {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: all 0.25s ease;
      border-radius: var(--radius-md);
      overflow: hidden;
    }
    .product-box:hover {
      transform: translateY(-4px);
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-md);
    }
    .product-img-wrap {
      height: 220px;
      background: var(--pink-subtle);
      overflow: hidden;
      position: relative;
    }
    .product-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .p-tag {
      position: absolute;
      top: 10px;
      left: 10px;
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(4px);
      color: var(--pink-primary);
      font-size: 10px;
      font-weight: 700;
      padding: 3px 8px;
      border-radius: 12px;
      border: 1px solid var(--border-soft);
    }
    .fav-btn {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 32px;
      height: 32px;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.9);
      border: 1px solid var(--border-soft);
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      z-index: 5;
      color: var(--pink-primary);
      transition: all 0.2s;
    }
    .fav-btn:hover {
      background: var(--pink-primary);
      color: #fff;
    }
    .product-info {
      padding: 16px;
    }
    .p-title {
      font-weight: 700;
      font-size: 14px;
      margin-bottom: 6px;
      color: var(--text-chocolate);
    }
    .p-price {
      font-size: 15px;
      font-weight: 800;
      margin-bottom: 14px;
      color: var(--pink-primary);
    }
    .add-cart-btn {
      border: 1.5px solid var(--pink-primary);
      background: #fff;
      color: var(--pink-primary);
      text-align: center;
      padding: 9px;
      font-size: 12px;
      font-weight: 700;
      cursor: pointer;
      width: 100%;
      border-radius: var(--radius-sm);
      transition: all 0.2s;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 6px;
    }
    .add-cart-btn:hover {
      background: var(--pink-primary);
      color: #fff;
    }

    /* 6. REVIEWS & NEWSLETTER */
    .reviews-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
      margin-bottom: 48px;
    }
    .review-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 20px;
      border-radius: var(--radius-md);
      box-shadow: var(--shadow-sm);
    }

    .newsletter-box {
      border: 1.5px solid var(--border-soft);
      background: linear-gradient(135deg, var(--pink-subtle), #fff);
      padding: 40px 20px;
      text-align: center;
      margin-bottom: 40px;
      border-radius: var(--radius-lg);
    }

    .btn-action {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 22px;
      background: var(--pink-primary);
      color: #fff;
      text-decoration: none;
      font-size: 12px;
      font-weight: 700;
      border: none;
      cursor: pointer;
      border-radius: 20px;
      transition: all 0.2s;
      box-shadow: var(--shadow-sm);
    }
    .btn-action:hover {
      background: var(--pink-dark);
      transform: translateY(-1px);
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
      .hero-split-box, .promo-grid { grid-template-columns: 1fr; }
      .hero-img-side { height: 280px; }
      .features-row { grid-template-columns: repeat(2, 1fr); }
      .categories-grid { grid-template-columns: repeat(3, 1fr); }
      .products-grid { grid-template-columns: repeat(2, 1fr); }
      .reviews-grid { grid-template-columns: 1fr; }
    }

    @media (max-width: 600px) {
      .main-content { padding: 16px; }
      .wf-header { flex-direction: column; gap: 12px; padding: 16px; }
      .wf-nav { flex-wrap: wrap; justify-content: center; gap: 12px; }
      .header-actions { width: 100%; justify-content: space-between; }
      .search-box { flex: 1; }
      .categories-grid { grid-template-columns: repeat(2, 1fr); }
      .products-grid { grid-template-columns: 1fr; }
      .promo-card-item { flex-direction: column; }
      .promo-card-img { width: 100%; height: 200px; }
    }
  </style>
</head>
<body>

  <!-- CANVAS CANVAS BÁNH RƠI LẢ TẢ -->
  <canvas id="sweet-falling-canvas"></canvas>

  <div class="wire-page">

    <!-- TOPBAR VỚI ICON BÁNH MÌ -->
    <div class="wf-topbar">
      <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8c0-2.2-1.8-4-4-4H10C7.8 4 6 5.8 6 8c-2.2 0-4 1.8-4 4s1.8 4 4 4h12c2.2 0 4-1.8 4-4s-1.8-4-4-4z"/><path d="M10 4v12"/><path d="M14 4v12"/></svg>
      MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: 0766 766 999
    </div>
    
    <!-- HEADER TRÀN VIỀN -->
    <header class="wf-header">
      <a href="home.jsp" class="brand-logo">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
        BITES &amp; MORE
      </a>
      
      <nav class="wf-nav">
        <a href="home.jsp" class="active">Trang chủ</a>
        <a href="shop">Cửa hàng</a>
        <a href="categories.jsp">Danh mục</a>
        <a href="about.jsp">Giới thiệu</a>
      <a href="contact">Liên hệ</a>
      </nav>

      <div class="header-actions">
        <div class="search-box">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          <input type="text" placeholder="Tìm bánh mì, bánh kem...">
        </div>

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
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
            </a>
          </c:when>
          <c:otherwise>
            <a href="login.jsp" class="ic-btn" title="Đăng nhập">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </header>

    <!-- NỘI DUNG CHÍNH -->
    <main class="main-content">
      
      <!-- 1. HERO EDITORIAL BOX -->
      <div class="hero-split-box">
        <div class="hero-img-side">
          <img src="https://i.pinimg.com/1200x/63/4e/8c/634e8cccc1feac660625b2e2a3d657c8.jpg" alt="Bánh mì Sourdough">
        </div>
        <div class="hero-info-side">
          <span class="hero-tag">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 13.8a4.5 4.5 0 1 1 2.61-8.22 5.5 5.5 0 0 1 10.78 2.22A4.5 4.5 0 1 1 18 13.8M6 13.8V20h12v-6.2"/></svg>
            MỚI NƯỚNG MỖI SÁNG
          </span>
          <h1>BÁNH NGON, BÁNH TƯƠI MỖI NGÀY</h1>
          <p>Thưởng thức hương vị bánh mì men tự nhiên hảo hạng, được chế biến thủ công tỉ mỉ từ những nguyên liệu hữu cơ thuần khiết nhất.</p>
          <a href="shop" class="btn-action">
            MUA NGAY HÔM NAY
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
          </a>
        </div>
      </div>

      <!-- 2. VALUE PROPOSITION -->
      <div class="features-row">
        <div class="feature-card">
          <div class="feature-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 20A7 7 0 0 1 9.8 6.1C15.5 5 17 4.4 19 2c1 2 2 4.1 2 8a9 9 0 0 1-10 10z"/><path d="M2 21c0-3 1.85-5.36 5.08-6C9.5 14.52 12 13 13 12"/></svg>
          </div>
          <div style="font-weight:700;font-size:14px;margin-bottom:4px;color:var(--text-chocolate);">100% Hữu Cơ</div>
          <div style="font-size:12px;color:var(--text-muted);">Nguyên liệu sạch chuẩn chất lượng</div>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          </div>
          <div style="font-weight:700;font-size:14px;margin-bottom:4px;color:var(--text-chocolate);">Tươi Mới Mỗi Ngày</div>
          <div style="font-size:12px;color:var(--text-muted);">Nướng mới mỗi sáng sớm</div>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="3" width="15" height="13"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
          </div>
          <div style="font-weight:700;font-size:14px;margin-bottom:4px;color:var(--text-chocolate);">Giao Hàng Nhanh</div>
          <div style="font-size:12px;color:var(--text-muted);">Miễn phí đơn từ 100k</div>
        </div>

        <div class="feature-card">
          <div class="feature-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
          </div>
          <div style="font-weight:700;font-size:14px;margin-bottom:4px;color:var(--text-chocolate);">Làm Bằng Yêu Thương</div>
          <div style="font-size:12px;color:var(--text-muted);">Tâm huyết trong từng mẻ bánh</div>
        </div>
      </div>

      <!-- 3. PROMOTION BANNER GRID -->
      <div class="promo-grid">
        <div class="promo-card-item">
          <div class="promo-card-img">
            <img src="https://i.pinimg.com/736x/68/32/f4/6832f494796bd602418e07a6ac36c04c.jpg" alt="Cake Strawberry">
          </div>
          <div class="promo-card-content">
            <span style="font-size:10px;font-weight:800;background:var(--pink-primary);color:#fff;padding:4px 10px;border-radius:12px;display:inline-block;">🔥 HOT DEAL</span>
            <h3 style="font-size:16px;font-weight:800;margin:10px 0 6px 0;color:var(--text-chocolate);">Giảm 20% Bánh Dâu MewMew</h3>
            <p style="font-size:12px;color:var(--text-muted);margin-bottom:14px;">Bánh dâu tươi kem béo ngậy vừa ra mắt hôm nay.</p>
            <a href="shop" class="btn-action" style="padding:7px 16px;font-size:11px;">MUA NGAY</a>
          </div>
        </div>

        <div class="promo-card-item">
          <div class="promo-card-img">
            <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=400" alt="Croissant Combo">
          </div>
          <div class="promo-card-content">
            <span style="font-size:10px;font-weight:800;background:var(--pink-primary);color:#fff;padding:4px 10px;border-radius:12px;display:inline-block;">☕ COMBO SÁNG</span>
            <h3 style="font-size:16px;font-weight:800;margin:10px 0 6px 0;color:var(--text-chocolate);">Combo Croissant &amp; Cà Phê</h3>
            <p style="font-size:12px;color:var(--text-muted);margin-bottom:14px;">Năng lượng ngày mới trọn vẹn chỉ với 59.000đ.</p>
            <a href="shop" class="btn-action" style="padding:7px 16px;font-size:11px;">MUA NGAY</a>
          </div>
        </div>
      </div>

      <!-- 4. CATEGORIES -->
      <div style="margin-bottom:48px;">
        <div class="section-header">
          <h3 class="section-title">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><path d="M8 12h8"/></svg>
            CÁC LOẠI BÁNH
          </h3>
          <div class="section-subtitle">Cùng khám phá các danh mục bánh thơm ngon nhất!</div>
        </div>

        <div class="categories-grid">
          <a href="shop?category=1" class="cat-card">
            <div class="cat-img-box"><img src="https://i.pinimg.com/736x/4e/e9/3e/4ee93e77f189f2f8ea14a456ed3660ac.jpg" alt="Bánh mì"></div>
            <div style="font-size:13px;font-weight:700;">Bánh mì</div>
          </a>

          <a href="shop?category=2" class="cat-card">
            <div class="cat-img-box"><img src="https://i.pinimg.com/736x/5c/3f/5d/5c3f5dd987b02e24d467f5d7b21d477a.jpg" alt="Bánh kem"></div>
            <div style="font-size:13px;font-weight:700;">Bánh kem</div>
          </a>

          <a href="shop?category=3" class="cat-card">
            <div class="cat-img-box"><img src="https://i.pinimg.com/1200x/96/10/90/96109054b68f5068042c7ed6b54f8cfc.jpg" alt="Bánh ngàn lớp"></div>
            <div style="font-size:13px;font-weight:700;">Ngọt &amp; Ngàn Lớp</div>
          </a>

          <a href="shop?category=4" class="cat-card">
            <div class="cat-img-box"><img src="https://i.pinimg.com/736x/d6/fb/a8/d6fba8968dea3e3855f0a972e52a9992.jpg" alt="Bánh quy"></div>
            <div style="font-size:13px;font-weight:700;">Bánh quy</div>
          </a>

          <a href="shop?category=5" class="cat-card">
            <div class="cat-img-box"><img src="https://i.pinimg.com/1200x/49/82/1d/49821dca984d2ebd70a0c52b17904f2f.jpg" alt="Bánh Donut"></div>
            <div style="font-size:13px;font-weight:700;">Bánh Donuts</div>
          </a>

          <a href="shop?category=6" class="cat-card">
            <div class="cat-img-box"><img src="https://i.pinimg.com/1200x/dd/1b/1e/dd1b1e8b11aca672ca558434b77be18d.jpg" alt="Bánh Cupcake"></div>
            <div style="font-size:13px;font-weight:700;">Bánh Cupcake</div>
          </a>
        </div>
      </div>

      <!-- 5. FEATURED PRODUCTS -->
      <div style="margin-bottom:48px;">
        <div class="section-header">
          <h3 class="section-title">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"/></svg>
            SẢN PHẨM NỔI BẬT
          </h3>
          <div class="section-subtitle">Những món bánh được chọn mua nhiều nhất mỗi ngày</div>
        </div>

        <div class="products-grid">
          
          <!-- Card 1 -->
          <div class="product-box">
            <div class="product-img-wrap">
              <span class="p-tag">⭐ Best Seller</span>
              <div class="fav-btn" title="Thêm vào yêu thích">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
              </div>
              <img src="https://i.pinimg.com/736x/34/a4/97/34a497fc88313f66649e0569c8e795ec.jpg" alt="Bánh mì Baguette" onError="this.onerror=null;this.src='images/placeholder.jpg';">
            </div>
            <div class="product-info">
              <div class="p-title">Bánh mì Baguette Pháp</div>
              <div class="p-price">28.000đ</div>
              <button type="button" class="add-cart-btn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
                THÊM VÀO GIỎ
              </button>
            </div>
          </div>

          <!-- Card 2 -->
          <div class="product-box">
            <div class="product-img-wrap">
              <span class="p-tag">🥐 Thơm bơ</span>
              <div class="fav-btn" title="Thêm vào yêu thích">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
              </div>
              <img src="https://i.pinimg.com/1200x/12/b5/8e/12b58ecc51dc513790c8dbf4a00a8ba4.jpg" alt="Bánh mì hoa cúc" onError="this.onerror=null;this.src='images/placeholder.jpg';">
            </div>
            <div class="product-info">
              <div class="p-title">Bánh mì hoa cúc bơ Pháp</div>
              <div class="p-price">65.000đ</div>
              <button type="button" class="add-cart-btn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
                THÊM VÀO GIỎ
              </button>
            </div>
          </div>

          <!-- Card 3 -->
          <div class="product-box">
            <div class="product-img-wrap">
              <span class="p-tag">🥛 Sữa tươi</span>
              <div class="fav-btn" title="Thêm vào yêu thích">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
              </div>
              <img src="https://i.pinimg.com/736x/92/67/87/926787bdc56844c3a9e486841f04c695.jpg" alt="Bánh mì sữa Hokkaido" onError="this.onerror=null;this.src='images/placeholder.jpg';">
            </div>
            <div class="product-info">
              <div class="p-title">Bánh mì sữa Hokkaido</div>
              <div class="p-price">55.000đ</div>
              <button type="button" class="add-cart-btn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
                THÊM VÀO GIỎ
              </button>
            </div>
          </div>

          <!-- Card 4 -->
          <div class="product-box">
            <div class="product-img-wrap">
              <span class="p-tag">🧄 Phô mai</span>
              <div class="fav-btn" title="Thêm vào yêu thích">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
              </div>
              <img src="https://i.pinimg.com/736x/45/ea/ca/45eaca05a7b549d801ab35e8b3cc7356.jpg" alt="Bánh mì bơ tỏi" onError="this.onerror=null;this.src='images/placeholder.jpg';">
            </div>
            <div class="product-info">
              <div class="p-title">Bánh mì bơ tỏi Hàn Quốc</div>
              <div class="p-price">42.000đ</div>
              <button type="button" class="add-cart-btn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
                THÊM VÀO GIỎ
              </button>
            </div>
          </div>

        </div>
      </div>

      <!-- 6. ĐÁNH GIÁ CỦA KHÁCH HÀNG -->
      <div style="margin-bottom:48px;">
        <div class="section-header">
          <h3 class="section-title">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/></svg>
            CẢM NHẬN TỪ KHÁCH HÀNG
          </h3>
          <div class="section-subtitle">Niềm vui của bạn là động lực mỗi ngày của tiệm</div>
        </div>

        <div class="reviews-grid">
          <div class="review-card">
            <div style="font-weight:700;font-size:14px;margin-bottom:4px;color:var(--text-chocolate);">Mỹ Tiên</div>
            <div style="margin-bottom:8px;display:flex;gap:2px;color:var(--pink-primary);">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            </div>
            <div style="font-size:12px;color:var(--text-muted);line-height:1.5;">"Bánh mì Baguette ở đây giòn rụm bên ngoài, đặc ruột thơm phức bên trong. Giao hàng cực nhanh!"</div>
          </div>

          <div class="review-card">
            <div style="font-weight:700;font-size:14px;margin-bottom:4px;color:var(--text-chocolate);">Gia Bảo Nguyễn</div>
            <div style="margin-bottom:8px;display:flex;gap:2px;color:var(--pink-primary);">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            </div>
            <div style="font-size:12px;color:var(--text-muted);line-height:1.5;">"Cả nhà mình rất mê Bánh mì bơ tỏi. Vị phô mai béo ngậy tỏi thơm lừng, đặt lại lần thứ 3 rồi."</div>
          </div>

          <div class="review-card">
            <div style="font-weight:700;font-size:14px;margin-bottom:4px;color:var(--text-chocolate);">Julia Trần</div>
            <div style="margin-bottom:8px;display:flex;gap:2px;color:var(--pink-primary);">
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            </div>
            <div style="font-size:12px;color:var(--text-muted);line-height:1.5;">"Đóng gói vô cùng chỉn chu, tiệm bánh phục vụ tận tình chu đáo. Sẽ tiếp tục ủng hộ!"</div>
          </div>
        </div>
      </div>

      <!-- 7. NEWSLETTER -->
      <div class="newsletter-box">
        <h3 style="font-size:18px;font-weight:800;margin:0 0 8px 0;color:var(--text-chocolate);display:flex;align-items:center;justify-content:center;gap:8px;">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/><polyline points="22,6 12,13 2,6"/></svg>
          ĐĂNG KÝ NHẬN TIN ƯU ĐÃI
        </h3>
        <p style="font-size:13px;color:var(--text-muted);margin:0 0 20px 0;">Nhập email của bạn để không bỏ lỡ các mã giảm giá và mẻ bánh mới nướng mỗi ngày.</p>
        
        <div style="display:flex;justify-content:center;gap:8px;max-width:420px;margin:0 auto;">
          <input type="email" placeholder="Địa chỉ email của bạn..." style="flex:1;padding:10px 16px;border:1.5px solid var(--border-soft);border-radius:20px;outline:none;font-size:12px;background:#fff;">
          <button type="button" class="btn-action">ĐĂNG KÝ</button>
        </div>
      </div>

    </main>

    <footer class="minimal-footer">
      &copy; Bites &amp; More. since 2026
    </footer>

  </div>

  <!-- SCRIPT HIỆU ỨNG BÁNH & TRÁI CÂY RƠI -->
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
      const particleCount = 24; 
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
