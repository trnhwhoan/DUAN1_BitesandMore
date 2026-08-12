<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Chi tiết sản phẩm</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* SYSTEM DESIGN VARIABLES (ĐỒNG BỘ HOÀN TOÀN VỚI HOME.JSP) */
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

    .form-box {
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-lg);
      padding: 32px;
      background: #fff;
      box-shadow: var(--shadow-sm);
    }

    /* CARD VÀ THUMBNAIL */
    .thumb-img {
      height: 85px;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      cursor: pointer;
      overflow: hidden;
      background: var(--pink-subtle);
      transition: all 0.2s;
    }
    .thumb-img.active, .thumb-img:hover {
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-sm);
    }
    .thumb-img img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .tab-btn {
      padding-bottom: 12px;
      font-weight: 700;
      font-size: 14px;
      cursor: pointer;
      color: var(--text-muted);
      border-bottom: 2px solid transparent;
      transition: all 0.2s;
    }
    .tab-btn.active, .tab-btn:hover {
      color: var(--pink-primary);
      border-bottom-color: var(--pink-primary);
    }

    /* CARD SẢN PHẨM CÙNG LOẠI */
    .product-card {
      position: relative;
      background: #fff;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-md);
      overflow: hidden;
      transition: all 0.25s ease;
    }
    .product-card:hover {
      transform: translateY(-4px);
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-md);
    }
    .product-card .img-ph {
      height: 180px;
      overflow: hidden;
      background: var(--pink-subtle);
    }
    .product-card .img-ph img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.4s ease;
    }
    .product-card:hover .img-ph img {
      transform: scale(1.05);
    }

    .fav-icon {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 32px;
      height: 32px;
      background: rgba(255, 255, 255, 0.9);
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      border: 1px solid var(--border-soft);
      color: var(--pink-primary);
      transition: all 0.2s;
      z-index: 10;
    }
    .fav-icon:hover {
      background: var(--pink-primary);
      color: #fff;
    }

    .pc-cart-btn {
      cursor: pointer;
      padding: 9px;
      background: #fff;
      color: var(--pink-primary);
      border: 1.5px solid var(--pink-primary);
      text-align: center;
      font-size: 12px;
      font-weight: 700;
      border-radius: var(--radius-sm);
      transition: all 0.2s;
    }
    .pc-cart-btn:hover {
      background: var(--pink-primary);
      color: #fff;
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

    @media (max-width: 868px) {
      .main-content { padding: 20px; }
      .form-box { padding: 20px; }
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
      <a href="contact.jsp">Liên hệ</a>
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
    </div>
  </header>

  <!-- MAIN PRODUCT DETAIL -->
  <main class="main-content">
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <a href="shop">Cửa hàng</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);"><c:out value="${product.productName}"/></strong>
    </div>

    <div class="form-box">
      <div style="display:grid; grid-template-columns:1fr 1fr; gap:36px; align-items:start;">
        
        <!-- Cột Trái: Hình Ảnh Sản Phẩm -->
        <div>
          <div style="height:380px; border:1.5px solid var(--border-soft); border-radius:var(--radius-md); margin-bottom:16px; background:var(--pink-subtle); overflow:hidden;">
            <img id="main-product-img" src="<c:out value='${product.image}'/>" alt="<c:out value='${product.productName}'/>" style="width:100%; height:100%; object-fit:cover;" onError="this.onerror=null;this.src='images/placeholder.jpg';">
          </div>
          <div style="display:grid; grid-template-columns:repeat(4, 1fr); gap:12px;">
            <div class="thumb-img active"><img src="images/91865ec3a35f437be843c7b5b3f0c4e0.jpg" alt="Thumb 1" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
            <div class="thumb-img"><img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=300" alt="Thumb 2" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
            <div class="thumb-img"><img src="https://images.unsplash.com/photo-1588195538326-c5b1e9f80a1b?q=80&w=300" alt="Thumb 3" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
            <div class="thumb-img"><img src="https://images.unsplash.com/photo-1535141192574-5d4897c13136?q=80&w=300" alt="Thumb 4" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
          </div>
        </div>

        <!-- Cột Phải: Thông Tin Sản Phẩm -->
        <div>
          <h1 id="product-title" style="font-size:24px; font-weight:800; margin:0 0 10px 0; color:var(--text-chocolate);"><c:out value="${product.productName}"/></h1>
          
          <!-- Rating Stars -->
          <div style="display:flex; align-items:center; gap:10px; margin-bottom:16px;">
            <span class="stars" style="display:flex; gap:2px; color:var(--pink-primary);">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            </span>
            <span style="font-size:13px; color:var(--text-muted);">(36 đánh giá)</span>
          </div>

          <div id="product-price" style="font-size:26px; font-weight:800; color:var(--pink-primary); margin-bottom:18px;"><fmt:formatNumber value="${product.price}" pattern="#,#00"/>đ</div>
          <div style="font-size:14px; color:var(--text-muted); line-height:1.8; margin-bottom:24px;">
            <c:out value="${product.description}"/>
          </div>
          
          <hr style="border:none; border-top:1.5px solid var(--border-soft); margin-bottom:24px;">

          <!-- Tăng giảm số lượng -->
          <div style="display:flex; align-items:center; gap:20px; margin-bottom:28px;">
            <span style="font-weight:700; font-size:13px; color:var(--text-chocolate);">Số lượng:</span>
            <div style="display:flex; border:1.5px solid var(--border-soft); border-radius:20px; align-items:center; width:120px; overflow:hidden; background:#fff;">
              <button type="button" id="btn-qty-minus" style="padding:8px 14px; border:none; border-right:1px solid var(--border-soft); background:#fff; cursor:pointer; color:var(--text-chocolate);">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"/></svg>
              </button>
              <div id="qty-val" style="padding:8px; font-weight:800; flex:1; text-align:center; color:var(--pink-primary);">1</div>
              <button type="button" id="btn-qty-plus" style="padding:8px 14px; border:none; border-left:1px solid var(--border-soft); background:#fff; cursor:pointer; color:var(--text-chocolate);">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
              </button>
            </div>
          </div>

          <!-- Các nút bấm mua hàng -->
          <div style="display:flex; gap:12px;">
            <button type="button" id="detail-add-cart" style="flex:1.2; display:inline-flex; align-items:center; justify-content:center; gap:8px; border:1.5px solid var(--pink-primary); background:#fff; color:var(--pink-primary); padding:12px; font-weight:700; font-size:13px; cursor:pointer; border-radius:20px; transition:all 0.2s;">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> 
              Thêm vào giỏ
            </button>
            <button type="button" id="detail-buy-now" style="flex:1; background:var(--pink-primary); color:#fff; border:none; padding:12px; font-weight:700; font-size:13px; cursor:pointer; border-radius:20px; transition:all 0.2s; box-shadow:var(--shadow-sm);">
              Mua ngay
            </button>
            <button type="button" id="detail-fav-btn" style="width:46px; height:46px; border:1.5px solid var(--border-soft); background:#fff; cursor:pointer; display:flex; align-items:center; justify-content:center; border-radius:50%; color:var(--pink-primary); transition:all 0.2s;">
              <svg id="detail-fav-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
            </button>
          </div>

        </div>
      </div>
    </div>

    <!-- TABS MÔ TẢ & ĐÁNH GIÁ -->
    <div class="form-box" style="margin-top:30px;">
      <div style="display:flex; gap:30px; border-bottom:1.5px solid var(--border-soft); margin-bottom:24px;">
        <div class="tab-btn active">Mô tả sản phẩm</div>
        <div class="tab-btn">Đánh giá (36)</div>
        <div class="tab-btn">Thông tin giao hàng</div>
      </div>

      <div style="font-size:14px; color:var(--text-muted); line-height:1.8; margin-bottom:40px;">
        Thành phần gồm có: Bột mì cao cấp, đường kính, bơ lạt, trứng gà tươi, bột cacao nguyên chất, màu thực phẩm tự nhiên và lớp kem phô mai Cream Cheese nhập khẩu. Bánh được nướng tươi mới trong ngày, bảo quản ở nhiệt độ mát từ 2-5°C và nên sử dụng tốt nhất trong vòng 48 giờ.
      </div>

      <!-- ĐÁNH GIÁ KHÁCH HÀNG -->
      <h5 style="font-size:15px; font-weight:800; margin-bottom:20px; border-bottom:2px solid var(--pink-primary); padding-bottom:10px; color:var(--text-chocolate);">ĐÁNH GIÁ TỪ KHÁCH HÀNG</h5>
      
      <div style="display:flex; gap:16px; padding:16px 0; border-bottom:1px dashed var(--border-soft);">
        <div style="width:48px; height:48px; border-radius:50%; flex-shrink:0; background:var(--pink-light); color:var(--pink-primary); display:flex; align-items:center; justify-content:center; font-weight:800; font-size:12px;">NH</div>
        <div>
          <div style="font-weight:700; font-size:14px; margin-bottom:4px; color:var(--text-chocolate);">Như Hoàn</div>
          <div style="margin-bottom:8px; display:flex; gap:2px; color:var(--pink-primary);">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </div>
          <div style="font-size:13px; color:var(--text-muted);">Bánh rất mềm, thơm ngọt vừa phải! Đóng gói đẹp và giao hàng cực nhanh.</div>
        </div>
      </div>

      <div style="display:flex; gap:16px; padding:16px 0;">
        <div style="width:48px; height:48px; border-radius:50%; flex-shrink:0; background:var(--pink-light); color:var(--pink-primary); display:flex; align-items:center; justify-content:center; font-weight:800; font-size:12px;">TT</div>
        <div>
          <div style="font-weight:700; font-size:14px; margin-bottom:4px; color:var(--text-chocolate);">Tuấn Tú</div>
          <div style="margin-bottom:8px; display:flex; gap:2px; color:var(--pink-primary);">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="currentColor"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </div>
          <div style="font-size:13px; color:var(--text-muted);">Bánh ngon, kem béo ngậy đúng vị Red Velvet chuẩn.</div>
        </div>
      </div>
    </div>

    <!-- SẢN PHẨM LIÊN QUAN -->
    <div style="margin-top:40px;">
      <h3 style="font-size:18px; font-weight:800; margin-bottom:20px; color:var(--text-chocolate);">Sản Phẩm Cùng Loại</h3>
      <div style="display:grid; grid-template-columns:repeat(4, 1fr); gap:20px;">
        
        <div class="product-card">
          <div class="fav-icon" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="img-ph"><img src="images/5d9fc32d56126074219b204adc604a58.jpg" alt="Sourdough" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
          <div style="padding:16px;">
            <div style="font-weight:700; font-size:14px; margin-bottom:6px; color:var(--text-chocolate);">Bánh mì Sourdough</div>
            <div style="font-size:14px; font-weight:800; color:var(--pink-primary); margin-bottom:12px;">78.000đ</div>
            <div class="pc-cart-btn">THÊM VÀO GIỎ</div>
          </div>
        </div>

        <div class="product-card">
          <div class="fav-icon" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="img-ph"><img src="images/47be84309ce929918fadebfd363e9619.webp" alt="Cupcake" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
          <div style="padding:16px;">
            <div style="font-weight:700; font-size:14px; margin-bottom:6px; color:var(--text-chocolate);">Cupcake Socola</div>
            <div style="font-size:14px; font-weight:800; color:var(--pink-primary); margin-bottom:12px;">30.500đ</div>
            <div class="pc-cart-btn">THÊM VÀO GIỎ</div>
          </div>
        </div>

        <div class="product-card">
          <div class="fav-icon" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="img-ph"><img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=300" alt="Croissant" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
          <div style="padding:16px;">
            <div style="font-weight:700; font-size:14px; margin-bottom:6px; color:var(--text-chocolate);">Bánh Croissant Bơ</div>
            <div style="font-size:14px; font-weight:800; color:var(--pink-primary); margin-bottom:12px;">45.000đ</div>
            <div class="pc-cart-btn">THÊM VÀO GIỎ</div>
          </div>
        </div>

        <div class="product-card">
          <div class="fav-icon" title="Thêm vào yêu thích">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </div>
          <div class="img-ph"><img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=300" alt="Bánh Tiramisu" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
          <div style="padding:16px;">
            <div style="font-weight:700; font-size:14px; margin-bottom:6px; color:var(--text-chocolate);">Bánh Tiramisu Ý</div>
            <div style="font-size:14px; font-weight:800; color:var(--pink-primary); margin-bottom:12px;">165.000đ</div>
            <div class="pc-cart-btn">THÊM VÀO GIỎ</div>
          </div>
        </div>

      </div>
    </div>

  </main>

  <!-- FOOTER -->
  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

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

<!-- SCRIPT TƯƠNG TÁC CHI TIẾT SẢN PHẨM -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  var mainImg = document.getElementById("main-product-img");
  var thumbImgs = document.querySelectorAll(".thumb-img");
  var btnMinus = document.getElementById("btn-qty-minus");
  var btnPlus = document.getElementById("btn-qty-plus");
  var qtyVal = document.getElementById("qty-val");
  var btnAddCart = document.getElementById("detail-add-cart");
  var btnBuyNow = document.getElementById("detail-buy-now");
  var btnFav = document.getElementById("detail-fav-btn");
  var iconFav = document.getElementById("detail-fav-icon");

  thumbImgs.forEach(function (thumb) {
    thumb.addEventListener("click", function () {
      thumbImgs.forEach(function (t) { t.classList.remove("active"); });
      this.classList.add("active");
      var imgEl = this.querySelector("img");
      if (imgEl && mainImg) {
        mainImg.src = imgEl.src;
      }
    });
  });

  var qty = 1;
  if (btnPlus) {
    btnPlus.addEventListener("click", function () {
      qty++;
      if (qtyVal) qtyVal.innerText = qty;
    });
  }
  if (btnMinus) {
    btnMinus.addEventListener("click", function () {
      if (qty > 1) {
        qty--;
        if (qtyVal) qtyVal.innerText = qty;
      }
    });
  }

  if (btnAddCart) {
    btnAddCart.addEventListener("click", function () {
      addToCart(false);

      var oldContent = btnAddCart.innerHTML;
      btnAddCart.innerHTML = "ĐÃ THÊM ✓";
      setTimeout(function () {
        btnAddCart.innerHTML = oldContent;
      }, 1200);
    });
  }

  if (btnBuyNow) {
    btnBuyNow.addEventListener("click", function () {
      addToCart(true);
    });
  }

  if (btnFav) {
    btnFav.addEventListener("click", function () {
      var body = new URLSearchParams({productId: '${product.id}', action:'toggle', ajax:'true'});
      fetch('favorite', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:body.toString()})
        .then(function (response) { return response.json().then(function (data) { if (!response.ok) throw new Error(data.message || 'Không thể cập nhật yêu thích.'); return data; }); })
        .then(function (data) { 
          if (iconFav) iconFav.setAttribute('fill', data.favorite ? '#e86a85' : 'none'); 
          document.querySelectorAll('.fav-count').forEach(function (el) { el.textContent = data.favoriteSize; }); 
        })
        .catch(function (error) { alert(error.message); });
    });
  }

  function addToCart(buyNow) {
    var body = new URLSearchParams({action:'add', productId:'${product.id}', quantity:String(qty)});
    fetch('cart', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:body.toString()})
      .then(function (response) { if (!response.ok) throw new Error('Không đủ hàng'); if (buyNow) window.location.href = 'checkout'; })
      .catch(function (error) { alert(error.message); });
  }
});
</script>

<script src="js/app.js"></script>
</body>
</html>