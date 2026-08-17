<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — ${not empty product ? product.productName : 'Chi tiết sản phẩm'}</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
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
      --radius-sm: 8px;
      --radius-md: 12px;
      --radius-lg: 16px;
    }

    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: var(--bg-cream);
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: var(--text-chocolate);
    }

    .wire-page { display: flex; flex-direction: column; min-height: 100vh; width: 100%; }

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
      background: rgba(250, 247, 245, 0.95);
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
      background: #fff;
      border-radius: var(--radius-sm);
    }

    .wf-nav { display: flex; gap: 28px; align-items: center; }
    .wf-nav a { color: var(--text-chocolate); text-decoration: none; font-size: 13px; font-weight: 600; }

    .header-actions { display: flex; align-items: center; gap: 16px; }
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
    }

    .breadcrumb-bar {
      font-size: 13px;
      color: var(--text-muted);
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 24px;
    }
    .breadcrumb-bar a { color: var(--text-muted); text-decoration: none; }

    /* CARD SẢN PHẨM CHÍNH */
    .product-detail-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      border-radius: var(--radius-lg);
      padding: 36px;
      box-sizing: border-box;
      box-shadow: var(--shadow-sm);
      display: grid;
      grid-template-columns: 480px 1fr;
      gap: 40px;
      margin-bottom: 32px;
    }

    /* KHU VỰC ẢNH & THUMBNAILS GALLERY */
    .gallery-box { display: flex; flex-direction: column; gap: 16px; }
    
    .main-img-wrap {
      width: 100%;
      height: 380px;
      border-radius: var(--radius-md);
      overflow: hidden;
      border: 1.5px solid var(--border-soft);
      background: var(--pink-subtle);
    }

    .main-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
      transition: transform 0.3s ease;
    }

    /* DÀN 4 THUMBNAIL */
    .thumbnail-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 12px;
    }

    .thumb-item {
      height: 80px;
      border-radius: var(--radius-sm);
      border: 1.5px solid var(--border-soft);
      overflow: hidden;
      cursor: pointer;
      background: var(--pink-subtle);
      transition: all 0.2s ease;
    }
    .thumb-item.active, .thumb-item:hover {
      border-color: var(--pink-primary);
      box-shadow: 0 0 0 2px var(--pink-light);
      transform: translateY(-2px);
    }
    .thumb-item img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
    }

    /* KHU VỰC THÔNG TIN BÊN PHẢI */
    .info-box { display: flex; flex-direction: column; }

    .p-title {
      font-size: 26px;
      font-weight: 800;
      color: var(--text-chocolate);
      margin: 0 0 12px 0;
      text-transform: capitalize;
    }

    .p-rating {
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 16px;
      font-size: 13px;
      color: var(--text-muted);
    }
    .stars { color: #ffb400; font-size: 15px; }

    .p-price {
      font-size: 28px;
      font-weight: 800;
      color: var(--pink-primary);
      margin-bottom: 16px;
    }

    .p-short-desc {
      font-size: 14px;
      color: var(--text-muted);
      line-height: 1.6;
      margin-bottom: 28px;
      padding-bottom: 20px;
      border-bottom: 1px dashed var(--border-soft);
    }

    /* BỘ CHỌN SỐ LƯỢNG */
    .qty-row {
      display: flex;
      align-items: center;
      gap: 16px;
      margin-bottom: 28px;
    }
    .qty-label { font-size: 13px; font-weight: 700; text-transform: uppercase; }

    .qty-control {
      display: inline-flex;
      align-items: center;
      border: 1.5px solid var(--border-soft);
      border-radius: 20px;
      overflow: hidden;
      background: #fff;
    }

    .qty-btn {
      width: 36px;
      height: 36px;
      border: none;
      background: transparent;
      font-size: 16px;
      font-weight: bold;
      cursor: pointer;
      color: var(--text-chocolate);
      transition: background 0.2s;
    }
    .qty-btn:hover { background: var(--pink-light); color: var(--pink-primary); }

    .qty-input {
      width: 44px;
      height: 36px;
      border: none;
      text-align: center;
      font-size: 14px;
      font-weight: bold;
      outline: none;
      font-family: inherit;
    }

    /* NÚT BẤM HÀNH ĐỘNG */
    .action-btn-group {
      display: flex;
      gap: 16px;
      align-items: center;
    }

    .btn-add-cart {
      flex: 1;
      height: 46px;
      background: #fff;
      color: var(--pink-primary);
      border: 2px solid var(--pink-primary);
      border-radius: 24px;
      font-size: 13px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      transition: all 0.2s;
    }
    .btn-add-cart:hover { background: var(--pink-subtle); transform: translateY(-1px); }

    .btn-buy-now {
      flex: 1;
      height: 46px;
      background: var(--pink-primary);
      color: #fff;
      border: 2px solid var(--pink-primary);
      border-radius: 24px;
      font-size: 13px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      cursor: pointer;
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.2s;
      box-shadow: var(--shadow-sm);
    }
    .btn-buy-now:hover { background: var(--pink-dark); border-color: var(--pink-dark); transform: translateY(-1px); }

    /* TAB NỘI DUNG MÔ TẢ & ĐÁNH GIÁ */
    .tab-section-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      border-radius: var(--radius-lg);
      padding: 32px 36px;
      box-shadow: var(--shadow-sm);
      margin-bottom: 40px;
    }

    .tab-header {
      display: flex;
      gap: 32px;
      border-bottom: 2px solid var(--border-soft);
      margin-bottom: 24px;
    }

    .tab-btn {
      padding-bottom: 12px;
      font-size: 14px;
      font-weight: 700;
      color: var(--text-muted);
      cursor: pointer;
      position: relative;
      transition: color 0.2s;
    }
    .tab-btn.active { color: var(--pink-primary); }
    .tab-btn.active::after {
      content: '';
      position: absolute;
      bottom: -2px;
      left: 0;
      width: 100%;
      height: 3px;
      background: var(--pink-primary);
      border-radius: 3px;
    }

    .tab-body { font-size: 14px; color: var(--text-chocolate); line-height: 1.7; }

    /* FORM ĐÁNH GIÁ */
    .review-form-box {
      background: var(--pink-subtle);
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-md);
      padding: 24px;
      margin-bottom: 28px;
    }

    .review-star-rating {
      display: flex;
      gap: 6px;
      font-size: 20px;
      color: #ccc;
      cursor: pointer;
      margin: 8px 0 16px 0;
    }
    .review-star-rating span.selected, .review-star-rating span:hover { color: #ffb400; }

    .review-textarea {
      width: 100%;
      height: 90px;
      padding: 12px;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      font-size: 13px;
      font-family: inherit;
      outline: none;
      box-sizing: border-box;
      background: #fff;
      margin-bottom: 12px;
      resize: none;
    }

    .btn-submit-review {
      background: var(--pink-primary);
      color: #fff;
      border: none;
      padding: 10px 24px;
      border-radius: 20px;
      font-size: 12px;
      font-weight: 700;
      text-transform: uppercase;
      cursor: pointer;
      transition: background 0.2s;
    }
    .btn-submit-review:hover { background: var(--pink-dark); }

    /* SẢN PHẨM TƯƠNG TỰ */
    .related-section-title {
      font-size: 18px;
      font-weight: 800;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: var(--text-chocolate);
      margin-bottom: 20px;
      border-bottom: 2px solid var(--pink-primary);
      padding-bottom: 8px;
      display: inline-block;
    }

    .related-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
    }

    .related-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      border-radius: var(--radius-md);
      overflow: hidden;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }
    .related-card:hover {
      transform: translateY(-4px);
      box-shadow: var(--shadow-sm);
    }

    .related-img-wrap {
      height: 180px;
      background: var(--pink-subtle);
      overflow: hidden;
      border-bottom: 1px solid var(--border-soft);
    }
    .related-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s;
    }
    .related-card:hover .related-img-wrap img { transform: scale(1.05); }

    .related-info { padding: 14px; }
    .related-title {
      font-size: 13px;
      font-weight: 700;
      text-transform: uppercase;
      margin-bottom: 6px;
      height: 36px;
      overflow: hidden;
      color: var(--text-chocolate);
    }
    .related-price {
      font-size: 14px;
      font-weight: 800;
      color: var(--pink-primary);
      margin-bottom: 10px;
    }

    .minimal-footer {
      border-top: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 20px 0;
      text-align: center;
      font-size: 13px;
      color: var(--text-muted);
      margin-top: 40px;
    }

    @media (max-width: 868px) {
      .product-detail-card { grid-template-columns: 1fr; padding: 24px; }
      .main-img-wrap { height: 280px; }
      .related-grid { grid-template-columns: repeat(2, 1fr); }
      .action-btn-group { flex-direction: column; }
      .main-content { padding: 20px; }
    }
  </style>
</head>
<body>

<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">
    MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: 0766 766 999
  </div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home" class="brand-logo">BITES &amp; MORE</a>
    
    <nav class="wf-nav">
      <a href="home">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="categories">Danh mục</a>
      <a href="about">Giới thiệu</a>
      <a href="contact">Liên hệ</a>
    </nav>

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

        <a href="cart" class="ic-btn" title="Giỏ hàng">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
      </a>

      <a href="profile" class="ic-btn" title="Tài khoản">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a>
    </div>
  </header>

  <main class="main-content">
    
    <!-- BREADCRUMB -->
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <a href="shop">Cửa hàng</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);">${not empty product ? product.productName : 'Sản phẩm'}</strong>
    </div>

    <!-- KHỐI SẢN PHẨM CHÍNH -->
    <div class="product-detail-card">
      
      <!-- CỘT ẢNH & DÀN 4 THUMBNAIL -->
      <div class="gallery-box">
        <div class="main-img-wrap">
          <img id="main-product-img" src="${product.image}" alt="${product.productName}" onError="this.onerror=null;this.src='images/placeholder.jpg';">
        </div>

      <!-- CỘT THÔNG TIN CHÍNH -->
      <div class="info-box">
        <h1 class="p-title">${product.productName}</h1>

        <div class="p-rating">
          <span class="stars">★★★★★</span>
          <span>(36 đánh giá từ khách hàng)</span>
        </div>

        <div class="p-price">
          <fmt:formatNumber value="${product.price}" pattern="#,##0"/>đ
        </div>

        <div class="p-short-desc">
          ${not empty product.description ? product.description : 'Bánh được nướng tươi mỗi ngày từ nguyên liệu cao cấp, đảm bảo hương vị thơm ngon tròn vị.'}
        </div>

        <!-- SỐ LƯỢNG MUA -->
        <div class="qty-row">
          <span class="qty-label">Số lượng:</span>
          <div class="qty-control">
            <button type="button" class="qty-btn" id="btn-minus">-</button>
            <input type="number" id="p-qty" class="qty-input" value="1" min="1" max="99" readonly>
            <button type="button" class="qty-btn" id="btn-plus">+</button>
          </div>
        </div>

        <!-- CỤM NÚT BẤM -->
        <div class="action-btn-group">
          <button type="button" class="btn-add-cart" id="btn-add-cart" data-id="${product.id != 0 ? product.id : product.productId}">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
            THÊM VÀO GIỎ
          </button>

          <button type="button" class="btn-buy-now" id="btn-buy-now" data-id="${product.id != 0 ? product.id : product.productId}">
            MUA NGAY
          </button>
        </div>

        <div style="margin-top:24px; font-size:12px; color:var(--text-muted); display:flex; gap:20px;">
          <span>✓ Bánh nướng tươi mỗi ngày</span>
          <span>✓ Giao nhanh tận nơi</span>
        </div>

      </div>

    </div>

    <!-- KHỐI TABS MÔ TẢ VÀ ĐÁNH GIÁ (ĐÃ XÓA TAB THÔNG TIN GIAO HÀNG) -->
    <div class="tab-section-card">
      <div class="tab-header">
        <div class="tab-btn active" onclick="switchDetailTab('tab-desc', this)">Mô tả sản phẩm</div>
        <div class="tab-btn" onclick="switchDetailTab('tab-reviews', this)">Đánh giá từ khách hàng (36)</div>
      </div>

      <!-- TAB 1: MÔ TẢ SẢN PHẨM -->
      <div id="tab-desc" class="tab-body">
        <p style="margin-top:0;">${not empty product.description ? product.description : 'Sản phẩm bánh tươi được làm trong ngày từ thương hiệu Bites & More.'}</p>
        <p><strong>Bảo quản:</strong> Nơi khô ráo thoáng mát, nên dùng ngay trong ngày để giữ trọn vị thơm ngon.</p>
      </div>

      <!-- TAB 2: ĐÁNH GIÁ VÀ VIẾT ĐÁNH GIÁ -->
      <div id="tab-reviews" class="tab-body" style="display:none;">
        
        <!-- FORM VIẾT ĐÁNH GIÁ MỚI -->
        <c:choose>
          <c:when test="${not empty sessionScope.account}">
            <c:choose>
              <c:when test="${canReview}">
            <div class="review-form-box">
              <div style="font-weight:700; font-size:14px; text-transform:uppercase;">Viết đánh giá của bạn</div>
              <div class="review-star-rating" id="rating-stars">
                <span data-star="1" class="selected">★</span>
                <span data-star="2" class="selected">★</span>
                <span data-star="3" class="selected">★</span>
                <span data-star="4" class="selected">★</span>
                <span data-star="5" class="selected">★</span>
              </div>
              <textarea id="review-content" class="review-textarea" placeholder="Chia sẻ cảm nhận của bạn về món bánh này..."></textarea>
              <button type="button" id="btn-submit-review" class="btn-submit-review">GỬI ĐÁNH GIÁ</button>
            </div>
              </c:when>
              <c:otherwise>
                <div class="review-form-box" style="text-align:center; padding:24px;">
                  <div style="font-weight:700; font-size:14px; margin-bottom:8px;">Bạn cần đặt món này trước khi đánh giá nhé</div>
                  <div style="color:var(--text-muted); font-size:13px; margin-bottom:16px;">Hãy đặt sản phẩm trong giỏ hàng, sau đó quay lại chia sẻ cảm nhận của bạn.</div>
                  <a href="cart" id="btn-add-review-product-to-cart"
                     data-product-id="${product.id != 0 ? product.id : product.productId}"
                     class="btn-submit-review" style="display:inline-block; text-decoration:none;">ĐI ĐẾN GIỎ HÀNG</a>
                </div>
              </c:otherwise>
            </c:choose>
          </c:when>
          <c:otherwise>
            <div class="review-form-box" style="text-align:center; padding:24px;">
              <div style="font-weight:700; font-size:14px; margin-bottom:8px;">Bạn cần đăng nhập để đánh giá sản phẩm</div>
              <div style="color:var(--text-muted); font-size:13px; margin-bottom:16px;">Hãy đăng nhập hoặc đăng ký tài khoản để chia sẻ cảm nhận của bạn.</div>
              <a href="login.jsp?redirect=${pageContext.request.requestURI}" class="btn-submit-review" style="display:inline-block; text-decoration:none; margin-right:8px;">ĐĂNG NHẬP</a>
              <a href="register.jsp" class="btn-submit-review" style="display:inline-block; text-decoration:none; background:#fff; color:var(--pink-primary); border:1px solid var(--pink-primary);">ĐĂNG KÝ</a>
            </div>
          </c:otherwise>
        </c:choose>

        <!-- DANH SÁCH BÌNH LUẬN CỦA KHÁCH -->
        <div id="review-list">
          <div style="margin-bottom:18px; padding-bottom:14px; border-bottom:1px dashed var(--border-soft);">
            <div style="display:flex; justify-content:space-between; align-items:center;">
              <strong>Như Hoàn</strong>
              <span style="color:#ffb400; font-size:13px;">★★★★★</span>
            </div>
            <p style="margin:4px 0 0 0; color:var(--text-muted); font-size:13px;">Bánh thơm phức, giòn ngon nướng tươi đúng giờ!</p>
          </div>

          <div style="margin-bottom:18px; padding-bottom:14px; border-bottom:1px dashed var(--border-soft);">
            <div style="display:flex; justify-content:space-between; align-items:center;">
              <strong>Minh Triết</strong>
              <span style="color:#ffb400; font-size:13px;">★★★★★</span>
            </div>
            <p style="margin:4px 0 0 0; color:var(--text-muted); font-size:13px;">Đóng gói đẹp, bánh ăn vừa vị không bị ngọt gắt.</p>
          </div>
        </div>

      </div>
    </div>

    <!-- KHỐI SẢN PHẨM TƯƠNG TỰ TỪ DATABASE -->
    <div style="margin-top:40px;">
      <div class="related-section-title">SẢN PHẨM TƯƠNG TỰ</div>

      <div class="related-grid">
        <c:set var="relatedList" value="${not empty relatedProducts ? relatedProducts : productList}" />
        <c:choose>
          <c:when test="${not empty relatedList}">
            <c:forEach items="${relatedList}" var="rp" begin="0" end="3">
              <div class="related-card">
                <div class="related-img-wrap">
                  <a href="product-detail?id=${rp.id != 0 ? rp.id : rp.productId}">
                    <img src="${rp.image}" alt="${rp.productName}" onError="this.onerror=null;this.src='images/placeholder.jpg';">
                  </a>
                </div>

                <div class="related-info">
                  <div class="related-title">${rp.productName}</div>
                  <div class="related-price">
                    <fmt:formatNumber value="${rp.price}" pattern="#,##0"/>đ
                  </div>

                  <a href="product-detail?id=${rp.id != 0 ? rp.id : rp.productId}" style="display:block; text-align:center; background:var(--pink-subtle); color:var(--pink-primary); border:1px solid var(--border-soft); padding:8px; font-size:11px; font-weight:bold; border-radius:16px; text-decoration:none; text-transform:uppercase;">
                    XEM CHI TIẾT
                  </a>
                </div>
              </div>
            </c:forEach>
          </c:when>

          <c:otherwise>
            <div style="grid-column: 1 / -1; color:var(--text-muted); font-size:13px;">
              Chưa có sản phẩm tương tự.
            </div>
          </c:otherwise>
        </c:choose>
      </div>
    </div>

  </main>

  <!-- FOOTER -->
  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>

<!-- SCRIPT XỬ LÝ ĐỔI ẢNH THUMBNAIL, TABS, ĐÁNH GIÁ & AJAX -->
<script>
// 1. CHUYỂN ẢNH KHI BẤM THUMBNAIL
function changeMainImage(imgUrl, thumbEl) {
  var mainImg = document.getElementById('main-product-img');
  if (mainImg && imgUrl) {
    mainImg.src = imgUrl;
  }
  document.querySelectorAll('.thumb-item').forEach(el => el.classList.remove('active'));
  if (thumbEl) thumbEl.classList.add('active');
}

// 2. CHUYỂN TAB MÔ TẢ & ĐÁNH GIÁ
function switchDetailTab(tabId, element) {
  document.querySelectorAll('.tab-body').forEach(el => el.style.display = 'none');
  document.querySelectorAll('.tab-btn').forEach(el => el.classList.remove('active'));

  document.getElementById(tabId).style.display = 'block';
  element.classList.add('active');
}

document.addEventListener("DOMContentLoaded", function () {
  // 3. TĂNG GIẢM SỐ LƯỢNG
  var btnMinus = document.getElementById('btn-minus');
  var btnPlus = document.getElementById('btn-plus');
  var qtyInput = document.getElementById('p-qty');

  if (btnMinus && qtyInput) {
    btnMinus.addEventListener('click', function () {
      var val = parseInt(qtyInput.value) || 1;
      if (val > 1) qtyInput.value = val - 1;
    });
  }

  if (btnPlus && qtyInput) {
    btnPlus.addEventListener('click', function () {
      var val = parseInt(qtyInput.value) || 1;
      if (val < 99) qtyInput.value = val + 1;
    });
  }

  // 4. CHỌN SAO ĐÁNH GIÁ
  var stars = document.querySelectorAll('#rating-stars span');
  var selectedStarVal = 5;

  stars.forEach(function(star) {
    star.addEventListener('click', function() {
      selectedStarVal = parseInt(this.getAttribute('data-star'));
      stars.forEach(function(s, idx) {
        if (idx < selectedStarVal) s.classList.add('selected');
        else s.classList.remove('selected');
      });
    });
  });

  // 5. SUBMIT ĐÁNH GIÁ MỚI
  var btnSubmitReview = document.getElementById('btn-submit-review');
  var reviewContent = document.getElementById('review-content');
  var reviewList = document.getElementById('review-list');

  if (btnSubmitReview) {
    btnSubmitReview.addEventListener('click', function() {
      var text = reviewContent ? reviewContent.value.trim() : "";
      if (!text) {
        alert("Vui lòng nhập nội dung đánh giá trước khi gửi nhé!");
        return;
      }

      var starStr = "★".repeat(selectedStarVal);
      var newHtml = '<div style="margin-bottom:18px; padding-bottom:14px; border-bottom:1px dashed var(--border-soft);">' +
                      '<div style="display:flex; justify-content:space-between; align-items:center;">' +
                        '<strong>Khách hàng</strong>' +
                        '<span style="color:#ffb400; font-size:13px;">' + starStr + '</span>' +
                      '</div>' +
                      '<p style="margin:4px 0 0 0; color:var(--text-muted); font-size:13px;">' + text + '</p>' +
                    '</div>';

      if (reviewList) {
        reviewList.insertAdjacentHTML('afterbegin', newHtml);
      }
      reviewContent.value = "";
      alert("Cảm ơn bạn đã gửi đánh giá cho Bites & More!");
    });
  }

  // Khách chưa mua sản phẩm: thêm sản phẩm đang xem vào giỏ rồi chuyển sang giỏ hàng.
  var addReviewProductButton = document.getElementById('btn-add-review-product-to-cart');
  if (addReviewProductButton) {
    addReviewProductButton.addEventListener('click', function (event) {
      event.preventDefault();
      var productId = this.getAttribute('data-product-id');
      if (!productId) {
        window.location.href = 'cart.jsp';
        return;
      }
      var body = new URLSearchParams();
      body.append('action', 'add');
      body.append('productId', productId);
      body.append('quantity', '1');
      body.append('ajax', 'true');
      fetch('cart', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: body.toString()
      }).then(function (response) {
        if (!response.ok) throw new Error('Không thể thêm sản phẩm vào giỏ hàng');
        window.location.href = 'cart.jsp';
      }).catch(function () {
        // Vẫn giữ đường dẫn dự phòng nếu máy chủ không phản hồi AJAX.
        window.location.href = 'cart.jsp';
      });
    });
  }

  // 6. AJAX THÊM GIỎ HÀNG
  var btnAddCart = document.getElementById('btn-add-cart');
  if (btnAddCart) {
    btnAddCart.addEventListener('click', function () {
      var pId = this.getAttribute('data-id');
      var qty = qtyInput ? qtyInput.value : 1;
      var self = this;

      var params = new URLSearchParams();
      params.append('action', 'add');
      params.append('productId', pId);
      params.append('quantity', qty);

      fetch('cart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        body: params.toString()
      }).then(function (res) {
        if (res.ok) {
          self.innerText = "ĐÃ THÊM VÀO GIỎ ✓";
          setTimeout(() => { self.innerText = "THÊM VÀO GIỎ"; }, 1500);
        }
      });
    });
  }

  // 7. MUA NGAY -> CHUYỂN SANG GIỎ HÀNG
  var btnBuyNow = document.getElementById('btn-buy-now');
  if (btnBuyNow) {
    btnBuyNow.addEventListener('click', function () {
      var pId = this.getAttribute('data-id');
      var qty = qtyInput ? qtyInput.value : 1;

      var params = new URLSearchParams();
      params.append('action', 'add');
      params.append('productId', pId);
      params.append('quantity', qty);

      fetch('cart', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
        body: params.toString()
      }).then(function (res) {
        window.location.href = "cart.jsp";
      });
    });
  }
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
