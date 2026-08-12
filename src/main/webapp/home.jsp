<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Tiệm Bánh Thủ Công</title>
  <!-- Nhúng file CSS chung -->
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* CORE SYSTEM RESET & BASE STYLES */
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
      color: #000;
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    }
    
    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      width: 100%;
    }

    /* FULL WIDTH CONTAINER */
    .main-content {
      flex: 1;
      width: 100%;
      max-width: 100% !important;
      padding: 24px 40px 60px 40px;
      box-sizing: border-box;
    }

    /* HEADER & TOPBAR STYLING */
    .wf-topbar {
      background: #000;
      color: #fff;
      font-size: 11px;
      font-weight: bold;
      letter-spacing: 0.5px;
      text-align: center;
      padding: 8px 20px;
    }

    .wf-header {
      width: 100%;
      box-sizing: border-box;
      padding: 16px 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #f8f8f8;
      border-bottom: 1px solid #000;
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .brand-logo {
      color: #000;
      text-decoration: none;
      font-weight: bold;
      font-size: 20px;
      border: 1px solid #000;
      padding: 6px 16px;
      display: inline-block;
      background: #fff;
      transition: all 0.2s;
    }
    .brand-logo:hover {
      background: #000;
      color: #fff;
    }

    .wf-nav {
      display: flex;
      gap: 24px;
      align-items: center;
    }
    .wf-nav a {
      color: #000;
      text-decoration: none;
      font-size: 13px;
      font-weight: bold;
      transition: opacity 0.2s;
    }
    .wf-nav a:hover {
      opacity: 0.6;
    }

    .header-actions {
      display: flex;
      align-items: center;
      gap: 20px;
    }

    .search-box {
      display: flex;
      align-items: center;
      gap: 8px;
      border: 1px solid #000;
      padding: 6px 12px;
      background: #fff;
      width: 240px;
    }
    .search-box input {
      border: none;
      outline: none;
      font-size: 13px;
      width: 100%;
      background: transparent;
    }

    .ic-btn {
      position: relative;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      color: #000;
      text-decoration: none;
    }
    .ic-btn .badge {
      position: absolute;
      top: -6px;
      right: -8px;
      background: #000;
      color: #fff;
      font-size: 10px;
      font-weight: bold;
      padding: 2px 5px;
      border-radius: 50%;
    }

    /* 1. HERO SECTION SPLIT LAYOUT */
    .hero-split-box {
      display: grid;
      grid-template-columns: 1.2fr 1fr;
      border: 1px solid #000;
      background: #fff;
      margin-bottom: 40px;
    }
    .hero-img-side {
      height: 420px;
      border-right: 1px solid #000;
      overflow: hidden;
    }
    .hero-img-side img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.4s ease;
    }
    .hero-split-box:hover .hero-img-side img {
      transform: scale(1.03);
    }
    .hero-info-side {
      padding: 48px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: flex-start;
    }
    .hero-info-side h1 {
      font-size: 32px;
      font-weight: bold;
      margin: 0 0 16px 0;
      line-height: 1.2;
    }
    .hero-info-side p {
      font-size: 14px;
      color: #555;
      line-height: 1.6;
      margin: 0 0 28px 0;
    }

    /* 2. VALUE PROPOSITION (LÝ DO CHỌN TIỆM) */
    .features-row {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 40px;
    }
    .feature-card {
      border: 1px solid #000;
      background: #fff;
      padding: 24px 16px;
      text-align: center;
    }
    .feature-icon {
      width: 48px;
      height: 48px;
      border-radius: 50%;
      border: 1px solid #000;
      background: #f8f8f8;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 12px auto;
    }

    /* 3. PROMOTION BANNER GRID */
    .promo-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
      margin-bottom: 40px;
    }
    .promo-card-item {
      border: 1px solid #000;
      background: #fff;
      display: flex;
      align-items: center;
      overflow: hidden;
    }
    .promo-card-img {
      width: 45%;
      height: 240px;
      border-right: 1px solid #000;
      overflow: hidden;
      flex-shrink: 0;
    }
    .promo-card-img img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .promo-card-content {
      padding: 20px;
      flex: 1;
    }

    /* 4. CATEGORIES GRID */
    .categories-grid {
      display: grid;
      grid-template-columns: repeat(6, 1fr);
      gap: 16px;
      margin-bottom: 40px;
    }
    .cat-card {
      text-decoration: none;
      color: #000;
      text-align: center;
    }
    .cat-img-box {
      border: 1px solid #000;
      background: #fff;
      height: 160px;
      margin-bottom: 10px;
      overflow: hidden;
      transition: transform 0.2s;
    }
    .cat-card:hover .cat-img-box {
      transform: translateY(-4px);
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
      margin-bottom: 40px;
    }
    .product-box {
      border: 1px solid #000;
      background: #fff;
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: transform 0.2s;
    }
    .product-box:hover {
      transform: translateY(-3px);
    }
    .product-img-wrap {
      height: 220px;
      border-bottom: 1px solid #000;
      background: #f5f5f5;
      overflow: hidden;
    }
    .product-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
    .fav-btn {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 32px;
      height: 32px;
      border-radius: 50%;
      border: 1px solid #000;
      background: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      z-index: 5;
    }
    .product-info {
      padding: 16px;
    }
    .p-title {
      font-weight: bold;
      font-size: 14px;
      margin-bottom: 6px;
    }
    .p-price {
      font-size: 14px;
      font-weight: bold;
      margin-bottom: 14px;
    }
    .add-cart-btn {
      border: 1px solid #000;
      background: #fff;
      color: #000;
      text-align: center;
      padding: 8px;
      font-size: 12px;
      font-weight: bold;
      cursor: pointer;
      width: 100%;
      box-sizing: border-box;
      transition: all 0.2s;
    }
    .add-cart-btn:hover {
      background: #000;
      color: #fff;
    }

    /* 6. REVIEWS & NEWSLETTER SECTION */
    .reviews-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 20px;
      margin-bottom: 40px;
    }
    .review-card {
      border: 1px solid #000;
      background: #fff;
      padding: 20px;
    }

    .newsletter-box {
      border: 1px solid #000;
      background: #fff;
      padding: 36px 20px;
      text-align: center;
      margin-bottom: 40px;
    }

    .btn-action {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 10px 24px;
      background: #000;
      color: #fff;
      text-decoration: none;
      font-size: 12px;
      font-weight: bold;
      border: none;
      cursor: pointer;
    }

    /* FOOTER TỐI GIẢN TOÀN MÀN HÌNH */
    .minimal-footer {
      border-top: 1px solid #000;
      background: #fff;
      padding: 20px 0;
      text-align: center;
      font-size: 13px;
      color: #000;
      width: 100%;
    }

    /* RESPONSIVE TRÊN MỌI THIẾT BỊ */
    @media (max-width: 992px) {
      .hero-split-box, .promo-grid { grid-template-columns: 1fr; }
      .hero-img-side { border-right: none; border-bottom: 1px solid #000; height: 280px; }
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
      .promo-card-img { width: 100%; height: 200px; border-right: none; border-bottom: 1px solid #000; }
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">
    MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: 0766 766 999
  </div>
  
  <!-- HEADER TRÀN VIỀN -->
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    
    <nav class="wf-nav">
      <a href="home.jsp" style="text-decoration: underline;">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <div class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" placeholder="Tìm kiếm sản phẩm...">
      </div>

      <a href="favorites.jsp" class="ic-btn" title="Yêu thích">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">0</span>
      </a>

      <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">0</span>
      </a>

      <!-- DUY NHẤT 1 ICON TÀI KHOẢN -->
      <c:choose>
        <%-- Nếu ĐÃ ĐĂNG NHẬP -> Bấm vào icon mở trang profile.jsp --%>
        <c:when test="${not empty sessionScope.account}">
          <a href="profile.jsp" class="ic-btn" title="Tài khoản: ${sessionScope.account.fullName}">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5">
              <circle cx="12" cy="8" r="4"/>
              <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
            </svg>
          </a>
        </c:when>

        <%-- Nếu CHƯA ĐĂNG NHẬP -> Bấm vào icon mở trang login.jsp --%>
        <c:otherwise>
          <a href="login.jsp" class="ic-btn" title="Đăng nhập">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5">
              <circle cx="12" cy="8" r="4"/>
              <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
            </svg>
          </a>
        </c:otherwise>
      </c:choose>
    </div>
  </header>

  <!-- NỘI DUNG CHÍNH (DÀN TRÀN NỀN MÁY TÍNH) -->
  <main class="main-content">
    
    <!-- 1. HERO EDITORIAL BOX -->
    <div class="hero-split-box">
      <div class="hero-img-side">
        <img src="https://i.pinimg.com/1200x/63/4e/8c/634e8cccc1feac660625b2e2a3d657c8.jpg" alt="Bánh mì Sourdough">
      </div>
      <div class="hero-info-side">
        <span style="font-size:11px;font-weight:bold;letter-spacing:1px;color:#666;border:1px solid #000;padding:2px 8px;margin-bottom:12px;">MỚI NƯỚNG MỖI SÁNG</span>
        <h1>BÁNH NGON, BÁNH TƯƠI MỖI NGÀY</h1>
        <p>Thưởng thức hương vị bánh mì men tự nhiên hảo hạng, được chế biến thủ công tỉ mỉ từ những nguyên liệu hữu cơ thuần khiết nhất.</p>
        <a href="shop" class="btn-action">
          MUA NGAY HÔM NAY
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
        </a>
      </div>
    </div>

    <!-- 2. VALUE PROPOSITION (LÝ DO CHỌN TIỆM) -->
    <div class="features-row">
      <div class="feature-card">
        <div class="feature-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
        </div>
        <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">100% Hữu Cơ</div>
        <div style="font-size:12px;color:#666;">Nguyên liệu sạch chuẩn chất lượng</div>
      </div>

      <div class="feature-card">
        <div class="feature-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Tươi Mới Mỗi Ngày</div>
        <div style="font-size:12px;color:#666;">Nướng mới mỗi sáng sớm</div>
      </div>

      <div class="feature-card">
        <div class="feature-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="1" y="3" width="15" height="13"/><polygon points="16 8 20 8 23 11 23 16 16 16 16 8"/><circle cx="5.5" cy="18.5" r="2.5"/><circle cx="18.5" cy="18.5" r="2.5"/></svg>
        </div>
        <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Giao Hàng Nhanh</div>
        <div style="font-size:12px;color:#666;">Miễn phí đơn từ 100k</div>
      </div>

      <div class="feature-card">
        <div class="feature-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
        </div>
        <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Làm Bằng Yêu Thương</div>
        <div style="font-size:12px;color:#666;">Tâm huyết trong từng mẻ bánh</div>
      </div>
    </div>

    <!-- 3. PROMOTION BANNER GRID -->
    <div class="promo-grid">
      <div class="promo-card-item">
        <div class="promo-card-img">
          <img src="https://i.pinimg.com/736x/68/32/f4/6832f494796bd602418e07a6ac36c04c.jpg" alt="Cake Strawberry">
        </div>
        <div class="promo-card-content">
          <span style="font-size:10px;font-weight:bold;border:1px solid #000;padding:2px 6px;">HOT DEAL</span>
          <h3 style="font-size:16px;font-weight:bold;margin:10px 0 6px 0;">Giảm 20% Bánh Dâu MewMew</h3>
          <p style="font-size:12px;color:#555;margin-bottom:14px;">Bánh dâu tươi kem béo ngậy vừa ra mắt hôm nay.</p>
          <a href="shop" class="btn-action" style="padding:6px 14px;font-size:11px;">MUA NGAY</a>
        </div>
      </div>

      <div class="promo-card-item">
        <div class="promo-card-img">
          <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=400" alt="Croissant Combo">
        </div>
        <div class="promo-card-content">
          <span style="font-size:10px;font-weight:bold;border:1px solid #000;padding:2px 6px;">COMBO SÁNG</span>
          <h3 style="font-size:16px;font-weight:bold;margin:10px 0 6px 0;">Combo Croissant &amp; Cà Phê</h3>
          <p style="font-size:12px;color:#555;margin-bottom:14px;">Năng lượng ngày mới trọn vẹn chỉ với 59.000đ.</p>
          <a href="shop" class="btn-action" style="padding:6px 14px;font-size:11px;">MUA NGAY</a>
        </div>
      </div>
    </div>

    <!-- 4. CATEGORIES (DANH MỤC KHUNG VUÔNG) -->
    <div style="margin-bottom:40px;">
      <h3 style="font-size:18px;font-weight:bold;text-align:center;margin:0 0 6px 0;">CÁC LOẠI BÁNH</h3>
      <div style="font-size:13px;color:#666;text-align:center;margin-bottom:24px;">Cùng khám phá các danh mục bánh ngon nhất!</div>

      <div class="categories-grid">
        <a href="shop?category=1" class="cat-card">
          <div class="cat-img-box"><img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=400" alt="Bánh mì"></div>
          <div style="font-size:13px;font-weight:bold;">Bánh mì</div>
        </a>

        <a href="shop?category=2" class="cat-card">
          <div class="cat-img-box"><img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=400" alt="Bánh kem"></div>
          <div style="font-size:13px;font-weight:bold;">Bánh kem</div>
        </a>

        <a href="shop?category=3" class="cat-card">
          <div class="cat-img-box"><img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=400" alt="Bánh ngàn lớp"></div>
          <div style="font-size:13px;font-weight:bold;">Bánh Ngọt Bơ &amp; Ngàn Lớp</div>
        </a>

        <a href="shop?category=4" class="cat-card">
          <div class="cat-img-box"><img src="https://images.unsplash.com/photo-1499636136210-6f4ee915583e?q=80&w=400" alt="Bánh quy"></div>
          <div style="font-size:13px;font-weight:bold;">Bánh quy</div>
        </a>

        <a href="shop?category=5" class="cat-card">
          <div class="cat-img-box"><img src="https://images.unsplash.com/photo-1527515637462-cff94eecc1ac?q=80&w=400" alt="Bánh Donut"></div>
          <div style="font-size:13px;font-weight:bold;">Bánh Donuts</div>
        </a>

        <a href="shop?category=6" class="cat-card">
          <div class="cat-img-box"><img src="https://images.unsplash.com/photo-1519869325930-281384150729?q=80&w=400" alt="Bánh Cupcake"></div>
          <div style="font-size:13px;font-weight:bold;">Bánh Cupcake</div>
        </a>
      </div>
    </div>

    <!-- 5. FEATURED PRODUCTS -->
    <div style="margin-bottom:40px;">
      <h3 style="font-size:18px;font-weight:bold;text-align:center;margin:0 0 6px 0;">SẢN PHẨM NỔI BẬT</h3>
      <div style="font-size:13px;color:#666;text-align:center;margin-bottom:24px;">Những món bánh được yêu thích nhất từ tiệm chúng tôi</div>

      <div class="products-grid">
        
        <!-- Card 1 -->
        <div class="product-box">
          <div class="fav-btn" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="product-img-wrap">
            <img src="images/5d9fc32d56126074219b204adc604a58.jpg" alt="Bánh mì Baguette" onError="this.onerror=null;this.src='images/placeholder.jpg';">
          </div>
          <div class="product-info">
            <div class="p-title">Bánh mì Baguette</div>
            <div class="p-price">28.000đ</div>
            <button type="button" class="add-cart-btn">THÊM VÀO GIỎ</button>
          </div>
        </div>

        <!-- Card 2 -->
        <div class="product-box">
          <div class="fav-btn" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="product-img-wrap">
            <img src="images/47be84309ce929918fadebfd363e9619.webp" alt="Bánh mì hoa cúc" onError="this.onerror=null;this.src='images/placeholder.jpg';">
          </div>
          <div class="product-info">
            <div class="p-title">Bánh mì hoa cúc</div>
            <div class="p-price">65.000đ</div>
            <button type="button" class="add-cart-btn">THÊM VÀO GIỎ</button>
          </div>
        </div>

        <!-- Card 3 -->
        <div class="product-box">
          <div class="fav-btn" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="product-img-wrap">
            <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=400" alt="Bánh mì sữa Hokkaido" onError="this.onerror=null;this.src='images/placeholder.jpg';">
          </div>
          <div class="product-info">
            <div class="p-title">Bánh mì sữa Hokkaido</div>
            <div class="p-price">55.000đ</div>
            <button type="button" class="add-cart-btn">THÊM VÀO GIỎ</button>
          </div>
        </div>

        <!-- Card 4 -->
        <div class="product-box">
          <div class="fav-btn" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="product-img-wrap">
            <img src="images/91865ec3a35f437be843c7b5b3f0c4e0.jpg" alt="Bánh mì bơ tỏi" onError="this.onerror=null;this.src='images/placeholder.jpg';">
          </div>
          <div class="product-info">
            <div class="p-title">Bánh mì bơ tỏi</div>
            <div class="p-price">42.000đ</div>
            <button type="button" class="add-cart-btn">THÊM VÀO GIỎ</button>
          </div>
        </div>

      </div>
    </div>

    <!-- 6. ĐÁNH GIÁ CỦA KHÁCH HÀNG -->
    <div style="margin-bottom:40px;">
      <h3 style="font-size:18px;font-weight:bold;text-align:center;margin:0 0 6px 0;">CẢM NHẬN TỪ KHÁCH HÀNG</h3>
      <div style="font-size:13px;color:#666;text-align:center;margin-bottom:24px;">Niềm vui của bạn là động lực mỗi ngày của chúng tôi</div>

      <div class="reviews-grid">
        <div class="review-card">
          <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Như Hoàn</div>
          <div style="margin-bottom:8px;display:flex;gap:2px;">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </div>
          <div style="font-size:12px;color:#555;line-height:1.5;">"Bánh mì Baguette ở đây giòn rụm bên ngoài, đặc ruột thơm phức bên trong. Giao hàng cực nhanh!"</div>
        </div>

        <div class="review-card">
          <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Tuấn Tú</div>
          <div style="margin-bottom:8px;display:flex;gap:2px;">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </div>
          <div style="font-size:12px;color:#555;line-height:1.5;">"Cả nhà mình rất mê Bánh mì bơ tỏi. Vị phô mai béo ngậy tỏi thơm lừng, đặt lại lần thứ 3 rồi."</div>
        </div>

        <div class="review-card">
          <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Thế Đan</div>
          <div style="margin-bottom:8px;display:flex;gap:2px;">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </div>
          <div style="font-size:12px;color:#555;line-height:1.5;">"Đóng gói vô cùng chỉn chu, tiệm bánh phục vụ tận tình chu đáo. Sẽ tiếp tục ủng hộ!"</div>
        </div>
      </div>
    </div>

    <!-- 7. NEWSLETTER (ĐĂNG KÝ NHẬN TIN KHUNG KHUNG) -->
    <div class="newsletter-box">
      <h3 style="font-size:18px;font-weight:bold;margin:0 0 8px 0;">ĐĂNG KÝ NHẬN TIN ƯU ĐÃI</h3>
      <p style="font-size:13px;color:#666;margin:0 0 20px 0;">Nhập email của bạn để không bỏ lỡ các mã giảm giá và mẻ bánh mới nướng mỗi ngày.</p>
      
      <div style="display:flex;justify-content:center;gap:8px;max-width:420px;margin:0 auto;">
        <input type="email" placeholder="Địa chỉ email của bạn..." style="flex:1;padding:8px 12px;border:1px solid #000;outline:none;font-size:13px;">
        <button type="button" class="btn-action">ĐĂNG KÝ</button>
      </div>
    </div>

  </main>

  <!-- FOOTER TỐI GIẢN TOÀN MÀN HÌNH -->
  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>

<!-- SCRIPT APP.JS ĐỒNG BỘ NÚT BADGE HEADER -->
<script src="js/app.js"></script>
</body>
</html>