<%
    // Nếu trang shop.jsp được truy cập trực tiếp (chưa có productList từ Servlet)
    if (request.getAttribute("productList") == null) {
        response.sendRedirect("shop");
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Cửa Hàng</title>
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

    /* CARD SẢN PHẨM HỒNG KEM */
    .product-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
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
      height: 200px;
      background: var(--pink-subtle);
      overflow: hidden;
      position: relative;
    }

    .product-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
      transition: transform 0.4s ease;
    }

    .product-box:hover .product-img-wrap img {
      transform: scale(1.05);
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
    .fav-btn:hover, .fav-btn.active {
      background: var(--pink-primary);
      color: #fff;
      border-color: var(--pink-primary);
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

    /* BỘ LỌC SIDEBAR VỚI BO GÓC MỀM MẠI */
    .filter-sidebar {
      background: #fff;
      border: 1.5px solid var(--border-soft);
      padding: 24px;
      box-sizing: border-box;
      border-radius: var(--radius-md);
      box-shadow: var(--shadow-sm);
      height: fit-content;
    }

    .filter-title {
      font-size: 13px;
      font-weight: 800;
      color: var(--text-chocolate);
      border-bottom: 2px solid var(--pink-primary);
      padding-bottom: 8px;
      margin-bottom: 14px;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      display: flex;
      align-items: center;
      gap: 6px;
    }

    .btn-submit-filter {
      width: 100%;
      background: var(--pink-primary);
      color: #fff;
      border: none;
      padding: 12px;
      font-size: 12px;
      font-weight: 700;
      cursor: pointer;
      border-radius: 20px;
      transition: background 0.2s, transform 0.1s;
      box-shadow: var(--shadow-sm);
    }

    .btn-submit-filter:hover {
      background: var(--pink-dark);
      transform: translateY(-1px);
    }

    /* SLIDER 2 NÚT KÉO MÀU HỒNG */
    .dual-range-container {
      position: relative;
      width: 100%;
      height: 24px;
      margin-bottom: 8px;
    }
    .slider-track-bg {
      position: absolute;
      top: 10px;
      left: 0;
      width: 100%;
      height: 4px;
      background: var(--pink-light);
      border-radius: 2px;
    }
    .slider-track-active {
      position: absolute;
      top: 10px;
      height: 4px;
      background: var(--pink-primary);
      border-radius: 2px;
    }
    .dual-range-container input[type="range"] {
      position: absolute;
      top: 2px;
      left: 0;
      width: 100%;
      height: 20px;
      -webkit-appearance: none;
      appearance: none;
      background: transparent;
      pointer-events: none;
      margin: 0;
    }
    .dual-range-container input[type="range"]::-webkit-slider-thumb {
      -webkit-appearance: none;
      height: 18px;
      width: 18px;
      border-radius: 50%;
      background: var(--pink-primary);
      border: 2px solid #fff;
      box-shadow: 0 2px 6px rgba(232, 106, 133, 0.4);
      cursor: pointer;
      pointer-events: auto;
    }
    .dual-range-container input[type="range"]::-moz-range-thumb {
      height: 18px;
      width: 18px;
      border-radius: 50%;
      background: var(--pink-primary);
      border: 2px solid #fff;
      box-shadow: 0 2px 6px rgba(232, 106, 133, 0.4);
      cursor: pointer;
      pointer-events: auto;
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
      .product-grid { grid-template-columns: repeat(2, 1fr); }
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
    MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: 0766 766 999
  </div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
      BITES &amp; MORE
    </a>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop" class="active">Cửa hàng</a>
      <a href="categories.jsp">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact">Liên hệ</a>
    </nav>
    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm sản phẩm...">
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
    
    <!-- BREADCRUMB -->
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <a href="shop">Cửa hàng</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);">Tất cả sản phẩm</strong>
    </div>

    <div style="display:grid; grid-template-columns:280px 1fr; gap:32px; align-items:start;">
      
      <!-- Cột Trái: Bộ Lọc Sidebar -->
      <aside class="filter-sidebar">
        <form action="shop" method="GET" id="filter-form">
          
          <!-- 1. TÌM KIẾM -->
          <div style="margin-bottom:28px;">
            <div class="filter-title">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
              TÌM KIẾM BÁNH
            </div>
            <div style="position:relative; display:flex; align-items:center;">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2" style="position:absolute; left:12px;"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
              <input type="text" id="filter-keyword" name="keyword" value="${keyword}" placeholder="Nhập tên bánh..." style="width:100%; padding:10px 12px 10px 34px; border:1.5px solid var(--border-soft); border-radius:20px; font-size:12px; box-sizing:border-box; outline:none; background:#fff; color:var(--text-chocolate);">
            </div>
          </div>

          <!-- 2. DANH MỤC SẢN PHẨM -->
          <div style="margin-bottom:28px;">
            <div class="filter-title">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><path d="M8 12h8"/></svg>
              DANH MỤC
            </div>
            <ul style="list-style:none; padding:0; margin:0;">
              <li style="margin-bottom:12px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="1" style="accent-color:var(--pink-primary); width:16px; height:16px; cursor:pointer;"> 🥖 Bánh mì (Bread)
              </li>
              <li style="margin-bottom:12px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="2" style="accent-color:var(--pink-primary); width:16px; height:16px; cursor:pointer;"> 🍰 Bánh kem (Cakes)
              </li>
              <li style="margin-bottom:12px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="3" style="accent-color:var(--pink-primary); width:16px; height:16px; cursor:pointer;"> 🥐 Ngọt Bơ &amp; Ngàn Lớp
              </li>
              <li style="margin-bottom:12px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="4" style="accent-color:var(--pink-primary); width:16px; height:16px; cursor:pointer;"> 🍪 Bánh quy (Cookie)
              </li>
              <li style="margin-bottom:12px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="5" style="accent-color:var(--pink-primary); width:16px; height:16px; cursor:pointer;"> 🍩 Bánh Donuts
              </li>
              <li style="margin-bottom:12px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="6" style="accent-color:var(--pink-primary); width:16px; height:16px; cursor:pointer;"> 🧁 Bánh Cupcake
              </li>
            </ul>
          </div>

          <!-- 3. KHOẢNG GIÁ DUAL SLIDER -->
          <div>
            <div class="filter-title">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
              KHOẢNG GIÁ (NGHÌN VNĐ)
            </div>
            
            <div style="text-align:center; font-size:13px; margin-bottom:12px; color:var(--text-muted);">
              Giá chọn: <strong id="slider-val-display" style="color:var(--pink-primary); font-size:14px;">${not empty minPrice ? minPrice : 1}k - ${not empty maxPrice ? maxPrice : 1000}k</strong>
            </div>

            <div class="dual-range-container">
              <div class="slider-track-bg"></div>
              <div id="slider-track" class="slider-track-active"></div>

              <input type="range" id="price-slider-min" min="1" max="1000" step="1" value="${not empty minPrice ? minPrice : 1}">
              <input type="range" id="price-slider-max" min="1" max="1000" step="1" value="${not empty maxPrice ? maxPrice : 1000}">
            </div>

            <div style="display:flex; justify-content:space-between; font-size:11px; color:var(--text-muted); margin-bottom:14px;">
              <span>1.000 VNĐ</span>
              <span>1.000.000 VNĐ</span>
            </div>

            <div style="display:flex; gap:8px; margin-bottom:18px; align-items:center;">
              <input type="number" id="filter-min-price" name="minPrice" value="${not empty minPrice ? minPrice : 1}" min="1" max="1000" placeholder="Từ" style="width:100%; padding:8px 12px; border:1.5px solid var(--border-soft); border-radius:8px; font-size:12px; box-sizing:border-box; outline:none; background:#fff;">
              <span style="color:var(--text-muted);">-</span>
              <input type="number" id="filter-max-price" name="maxPrice" value="${not empty maxPrice ? maxPrice : 1000}" min="1" max="1000" placeholder="Đến" style="width:100%; padding:8px 12px; border:1.5px solid var(--border-soft); border-radius:8px; font-size:12px; box-sizing:border-box; outline:none; background:#fff;">
            </div>

            <button type="submit" id="btn-submit-filter" class="btn-submit-filter">
              ÁP DỤNG BỘ LỌC
            </button>
          </div>

        </form>
      </aside>

      <!-- Cột Phải: Lưới Sản Phẩm -->
      <section style="width:100%; min-width:0;">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:24px; border-bottom:1.5px solid var(--border-soft); padding-bottom:12px;">
          <div id="result-status-text" style="font-size:14px; color:var(--text-muted);">
            Hiển thị <strong>${not empty productList ? productList.size() : 0}</strong> sản phẩm từ Database
          </div>
          <div style="display:flex; align-items:center; gap:10px;">
            <span style="font-size:12px; font-weight:700; text-transform:uppercase; color:var(--text-chocolate);">Sắp xếp:</span>
            <div style="border:1.5px solid var(--border-soft); padding:6px 14px; border-radius:20px; font-size:12px; width:160px; display:flex; justify-content:space-between; align-items:center; background:#fff; cursor:pointer; color:var(--text-chocolate);">
              Phổ biến nhất 
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg>
            </div>
          </div>
        </div>

        <!-- LƯỚI SẢN PHẨM -->
        <div class="product-grid" style="width:100%;">
          <c:choose>
            <c:when test="${not empty productList}">
              <c:forEach items="${productList}" var="p">
                <div class="product-box" data-category="${p.categoryId}" style="width:100%;">
                  
                  <button type="button" class="fav-btn" data-id="${p.id != 0 ? p.id : p.productId}" title="Thêm vào yêu thích">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
                  </button>

                  <div class="product-img-wrap">
                    <a href="product-detail?id=${p.id != 0 ? p.id : p.productId}">
                      <img src="${p.image}" alt="${p.productName}" onError="this.onerror=null;this.src='images/placeholder.jpg';">
                    </a>
                  </div>

                  <div class="product-info" style="padding:16px;">
                    <div class="p-title" style="font-weight:700; font-size:14px; margin-bottom:8px; line-height:1.3; height:36px; overflow:hidden; color:var(--text-chocolate);">
                      ${p.productName}
                    </div>
                    
                    <div class="p-price" style="font-size:15px; font-weight:800; margin-bottom:14px; color:var(--pink-primary);">
                      <fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ
                    </div>

                    <button type="button" class="add-cart-btn btn-ajax-cart" data-id="${p.id != 0 ? p.id : p.productId}">
                      <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
                      THÊM VÀO GIỎ
                    </button>
                  </div>

                </div>
              </c:forEach>
            </c:when>

            <c:otherwise>
              <div style="grid-column: 1 / -1; text-align:center; padding:60px; background:#fff; border:1.5px solid var(--border-soft); border-radius:var(--radius-md); font-size:14px; color:var(--text-muted);">
                Không có sản phẩm nào phù hợp với bộ lọc.
              </div>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- PHÂN TRANG -->
        <div class="pagination" style="margin-top:40px; display:flex; justify-content:center; gap:8px;"></div>

      </section>
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

<!-- SCRIPT DUAL SLIDER & PHÂN TRANG -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  var sliderMin = document.getElementById('price-slider-min');
  var sliderMax = document.getElementById('price-slider-max');
  var inputMin = document.getElementById('filter-min-price');
  var inputMax = document.getElementById('filter-max-price');
  var track = document.getElementById('slider-track');
  var displayVal = document.getElementById('slider-val-display');

  var maxLimit = 1000;
  var minGap = 5;

  function updateMin() {
    var minVal = parseInt(sliderMin.value);
    var maxVal = parseInt(sliderMax.value);

    if (maxVal - minVal < minGap) {
      sliderMin.value = maxVal - minGap;
      minVal = parseInt(sliderMin.value);
    }
    renderUI(minVal, maxVal);
  }

  function updateMax() {
    var minVal = parseInt(sliderMin.value);
    var maxVal = parseInt(sliderMax.value);

    if (maxVal - minVal < minGap) {
      sliderMax.value = minVal + minGap;
      maxVal = parseInt(sliderMax.value);
    }
    renderUI(minVal, maxVal);
  }

  function renderUI(minVal, maxVal) {
    if (inputMin) inputMin.value = minVal;
    if (inputMax) inputMax.value = maxVal;

    var percentMin = (minVal / maxLimit) * 100;
    var percentMax = (maxVal / maxLimit) * 100;

    if (track) {
      track.style.left = percentMin + "%";
      track.style.width = (percentMax - percentMin) + "%";
    }

    if (displayVal) {
      displayVal.innerText = minVal + "k - " + maxVal + "k";
    }
  }

  if (sliderMin && sliderMax) {
    sliderMin.addEventListener('input', function() {
      sliderMin.style.zIndex = "5";
      sliderMax.style.zIndex = "4";
      updateMin();
    });

    sliderMax.addEventListener('input', function() {
      sliderMax.style.zIndex = "5";
      sliderMin.style.zIndex = "4";
      updateMax();
    });

    if (inputMin) {
      inputMin.addEventListener('input', function() {
        var val = parseInt(this.value) || 1;
        sliderMin.value = val;
        updateMin();
      });
    }

    if (inputMax) {
      inputMax.addEventListener('input', function() {
        var val = parseInt(this.value) || 1000;
        sliderMax.value = val;
        updateMax();
      });
    }

    updateMin();
    updateMax();
  }

  // PHẦN PHÂN TRANG
  var productCards = Array.from(document.querySelectorAll('.product-grid .product-box'));
  var paginationContainer = document.querySelector('.pagination');
  var resultStatusText = document.getElementById('result-status-text');

  var ITEMS_PER_PAGE = 12;
  var currentPage = 1;

  if (productCards.length === 0) return;

  function renderPage(page) {
    currentPage = page;
    var startIndex = (page - 1) * ITEMS_PER_PAGE;
    var endIndex = startIndex + ITEMS_PER_PAGE;

    productCards.forEach(function (card, index) {
      if (index >= startIndex && index < endIndex) {
        card.style.display = 'flex';
      } else {
        card.style.display = 'none';
      }
    });

    if (resultStatusText) {
      var startNum = startIndex + 1;
      var endNum = Math.min(endIndex, productCards.length);
      resultStatusText.innerHTML = "Hiển thị <strong>" + startNum + "-" + endNum + "</strong> trong tổng số <strong>" + productCards.length + "</strong> sản phẩm";
    }

    renderPaginationButtons();
  }

  function renderPaginationButtons() {
    if (!paginationContainer) return;
    var totalPages = Math.ceil(productCards.length / ITEMS_PER_PAGE);

    if (totalPages <= 1) {
      paginationContainer.style.display = 'none';
      return;
    }

    paginationContainer.style.display = 'flex';
    var html = '';

    var prevDisabled = (currentPage === 1) ? 'opacity:0.4;pointer-events:none;' : 'cursor:pointer;';
    html += '<div class="page-num" data-page="' + (currentPage - 1) + '" style="padding:8px 14px;border:1.5px solid var(--border-soft);border-radius:20px;background:#fff;margin:0 2px;font-weight:bold;color:var(--text-chocolate);' + prevDisabled + '">&lt;</div>';

    for (var i = 1; i <= totalPages; i++) {
      var activeStyle = (i === currentPage) ? 'background:var(--pink-primary);color:#fff;border-color:var(--pink-primary);' : 'background:#fff;color:var(--text-chocolate);border-color:var(--border-soft);';
      html += '<div class="page-num" data-page="' + i + '" style="cursor:pointer;padding:8px 14px;border:1.5px solid;border-radius:20px;margin:0 2px;font-weight:bold;' + activeStyle + '">' + i + '</div>';
    }

    var nextDisabled = (currentPage === totalPages) ? 'opacity:0.4;pointer-events:none;' : 'cursor:pointer;';
    html += '<div class="page-num" data-page="' + (currentPage + 1) + '" style="padding:8px 14px;border:1.5px solid var(--border-soft);border-radius:20px;background:#fff;margin:0 2px;font-weight:bold;color:var(--text-chocolate);' + nextDisabled + '">&gt;</div>';

    paginationContainer.innerHTML = html;

    paginationContainer.querySelectorAll('.page-num').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var page = parseInt(this.getAttribute('data-page'));
        if (page >= 1 && page <= totalPages) {
          renderPage(page);
          window.scrollTo({ top: 0, behavior: 'smooth' });
        }
      });
    });
  }

  renderPage(1);
});
</script>

<!-- AJAX GIỎ HÀNG & YÊU THÍCH -->
<script>
document.addEventListener('DOMContentLoaded', function () {
  function setBadge(selector, value) {
    document.querySelectorAll(selector).forEach(function (el) { el.textContent = value; });
  }
  document.querySelectorAll('.btn-ajax-cart').forEach(function (button) {
    button.addEventListener('click', function () {
      if (button.disabled) return;
      button.disabled = true;
      var oldContent = button.innerHTML;
      var body = new URLSearchParams({action:'add', productId:button.dataset.id, quantity:'1', ajax:'true'});
      fetch('cart', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'}, body:body.toString()})
        .then(function (r) { return r.json().then(function (data) { if (!r.ok) throw new Error(data.message || 'Không thể thêm vào giỏ.'); return data; }); })
        .then(function (data) { setBadge('.cart-count', data.cartSize); button.innerHTML = 'ĐÃ THÊM ✓'; })
        .catch(function (e) { alert(e.message); })
        .finally(function () { setTimeout(function () { button.innerHTML = oldContent; button.disabled = false; }, 1200); });
    });
  });
  document.querySelectorAll('.fav-btn').forEach(function (button) {
    button.addEventListener('click', function () {
      var body = new URLSearchParams({productId:button.dataset.id, action:'toggle'});
      fetch('favorite', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded','X-Requested-With':'XMLHttpRequest'}, body:body.toString()})
        .then(function (r) {
          return r.text().then(function (text) {
            if (!r.ok) throw new Error(text || 'Request failed');
            try { return JSON.parse(text); } catch (e) { throw new Error('Invalid server response'); }
          });
        })
        .then(function (data) { setBadge('.fav-count', data.favoriteSize); button.classList.toggle('active', data.favorite); })
        .catch(function () { alert('Không thể cập nhật yêu thích.'); });
    });
  });
});
</script>

</body>
</html>
