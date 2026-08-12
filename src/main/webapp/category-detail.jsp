<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    html, body { height: 100%; margin: 0; padding: 0; background-color: #f8f8f8; font-family: system-ui, -apple-system, sans-serif; color: #000; }
    .wire-page { display: flex; flex-direction: column; min-height: 100vh; width: 100%; }
    
    .main-content { flex: 1; width: 100%; padding: 32px 60px 80px 60px; box-sizing: border-box; }
    
    .wf-topbar { background: #000; color: #fff; font-size: 11px; font-weight: bold; text-align: center; padding: 8px 20px; letter-spacing: 0.5px; }
    .wf-header { width: 100%; box-sizing: border-box; padding: 16px 60px; display: flex; align-items: center; justify-content: space-between; background: #f8f8f8; border-bottom: 1px solid #000; position: sticky; top: 0; z-index: 100; }
    .brand-logo { color: #000; text-decoration: none; font-weight: bold; font-size: 20px; border: 1px solid #000; padding: 6px 16px; background: #fff; }
    .wf-nav { display: flex; gap: 32px; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }

    .header-actions { display: flex; align-items: center; gap: 20px; }
    .search-box { display: flex; align-items: center; gap: 8px; border: 1px solid #000; padding: 6px 12px; background: #fff; width: 260px; }
    .search-box input { border: none; outline: none; font-size: 13px; width: 100%; background: transparent; }

    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }

    .breadcrumb-bar { font-size: 13px; color: #666; display: flex; align-items: center; gap: 8px; margin-bottom: 32px; }
    .breadcrumb-bar a { color: #666; text-decoration: none; }

    /* HERO BANNER EDITORIAL MINIMALIST */
    .hero-collection-banner {
      position: relative;
      width: 100%;
      height: 320px;
      border: 1px solid #000;
      margin-bottom: 40px;
      overflow: hidden;
      background: url('https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1600') center/cover no-repeat;
      display: flex;
      align-items: center;
      justify-content: center;
      box-sizing: border-box;
    }

    .hero-overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0, 0, 0, 0.65);
      transition: background 0.4s ease;
    }

    .hero-collection-banner:hover .hero-overlay {
      background: rgba(0, 0, 0, 0.55);
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
      display: inline-block;
      font-size: 11px;
      font-weight: 700;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: #ddd;
      border: 1px solid rgba(255, 255, 255, 0.4);
      padding: 4px 14px;
      margin-bottom: 16px;
      background: rgba(0, 0, 0, 0.3);
    }

    .hero-title {
      font-size: 30px;
      font-weight: 800;
      letter-spacing: 2px;
      text-transform: uppercase;
      margin: 0;
      line-height: 1.2;
      text-shadow: 0 2px 4px rgba(0,0,0,0.3);
    }

    .hero-divider {
      width: 60px;
      height: 2px;
      background: #fff;
      margin: 16px auto;
    }

    .hero-subtitle {
      font-size: 14px;
      font-weight: 400;
      color: #e0e0e0;
      margin: 0;
      letter-spacing: 0.5px;
      line-height: 1.6;
    }

    /* DANH SÁCH SẢN PHẨM HIỂN THỊ CHI TIẾT */
    .product-detail-list { display: flex; flex-direction: column; gap: 24px; }
    
    .product-detail-card {
      border: 1px solid #000;
      background: #fff;
      padding: 28px;
      display: grid;
      grid-template-columns: 240px 1fr;
      gap: 32px;
      align-items: start;
    }

    .p-img-box {
      width: 100%;
      height: 220px;
      border: 1px solid #000;
      overflow: hidden;
      background: #fafafa;
    }
    .p-img-box img { width: 100%; height: 100%; object-fit: cover; display: block; }

    .p-info-box { display: flex; flex-direction: column; justify-content: space-between; height: 100%; }
    .p-title { font-size: 20px; font-weight: bold; text-transform: uppercase; margin-bottom: 8px; }
    .p-price { font-size: 18px; font-weight: bold; color: #000; margin-bottom: 14px; }
    .p-desc { font-size: 14px; color: #333; line-height: 1.7; margin-bottom: 16px; text-align: justify; }

    /* KHỐI MÔ TẢ NGUYÊN LIỆU & BẢO QUẢN */
    .p-spec-box {
      background: #fafafa;
      border: 1px solid #000;
      padding: 14px 18px;
      font-size: 13px;
      color: #444;
      line-height: 1.6;
      margin-bottom: 20px;
    }

    .btn-actions { display: flex; gap: 12px; }
    .btn-action-main { padding: 12px 24px; background: #000; color: #fff; border: 1px solid #000; text-decoration: none; font-weight: bold; font-size: 12px; cursor: pointer; }
    .btn-action-sub { padding: 12px 24px; background: #fff; color: #000; border: 1px solid #000; text-decoration: none; font-weight: bold; font-size: 12px; }

    .minimal-footer { border-top: 1px solid #000; background: #fff; padding: 24px 0; text-align: center; font-size: 13px; color: #000; }

    @media (max-width: 768px) {
      .hero-collection-banner { height: 260px; }
      .hero-title { font-size: 22px; }
      .hero-subtitle { font-size: 13px; }
      .product-detail-card { grid-template-columns: 1fr; }
      .main-content { padding: 20px; }
    }
  </style>
</head>
<body>
<div class="wire-page">

  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND | HOTLINE: 0766 766 999</div>

  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp" style="text-decoration:underline; font-weight:bold;">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>

      <div class="wf-icons">
        <a href="favorites.jsp" class="ic-btn">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          <span class="badge fav-count">0</span>
        </a>
        <a href="cart.jsp" class="ic-btn">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge cart-count">0</span>
        </a>
        <a href="login.jsp" class="ic-btn">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
        </a>
      </div>
    </div>
  </header>

  <main class="main-content">
    
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <a href="categories.jsp">Danh Mục</a> <span>&rsaquo;</span>
      <strong style="color:#000;">${categoryName}</strong>
    </div>

    <!-- HERO BANNER TỐI GIẢN & CHẤT LƯỢNG (OPTION 1) -->
    <div class="hero-collection-banner">
      <div class="hero-overlay"></div>
      <div class="hero-content">
        <span class="hero-tag">THE ART OF ARTISAN BAKERY</span>
        <h1 class="hero-title">THIÊN ĐƯỜNG BÁNH NGỌT BITES &amp; MORE</h1>
        <div class="hero-divider"></div>
        <p class="hero-subtitle">Nơi đánh thức vị giác bằng những mẻ bánh mì men tự nhiên thơm nức mỗi sáng và các tuyệt tác bánh kem thủ công thượng hạng.</p>
      </div>
    </div>

    <!-- TIÊU ĐỀ DANH MỤC -->
    <div style="border-bottom:2px solid #000; padding-bottom:12px; margin-bottom:32px; display:flex; justify-content:space-between; align-items:flex-end;">
      <div>
        <h1 style="font-size:24px; font-weight:bold; text-transform:uppercase; margin:0 0 6px 0;">${categoryName}</h1>
        <p style="font-size:14px; color:#666; margin:0;">Danh sách giới thiệu chi tiết các dòng bánh đặc sản thuộc danh mục này</p>
      </div>
      <div style="font-size:13px; font-weight:bold;">Hiển thị <strong>${not empty productList ? productList.size() : 0}</strong> sản phẩm</div>
    </div>

    <!-- KHỐI SẢN PHẨM HIỂN THỊ CHI TIẾT -->
    <div class="product-detail-list">
      <c:choose>
        <c:when test="${not empty productList}">
          <c:forEach items="${productList}" var="p">
            <div class="product-detail-card">
              
              <!-- Ảnh bánh -->
              <div class="p-img-box">
                <img src="${p.image}" alt="${p.productName}" onError="this.onerror=null;this.src='images/placeholder.jpg';">
              </div>

              <!-- Nội dung thông tin chi tiết -->
              <div class="p-info-box">
                <div>
                  <div class="p-title">${p.productName}</div>
                  <div class="p-price"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</div>
                  <div class="p-desc">${p.description}</div>

                  <!-- Thông số thành phần & bảo quản -->
                  <div class="p-spec-box">
                    <div><strong>• Thành phần nguyên liệu:</strong> ${not empty p.ingredient ? p.ingredient : 'Bột mỳ hữu cơ, bơ Pháp, men tươi tự nhiên.'}</div>
                    <div><strong>• Hạn sử dụng:</strong> ${p.expiryDate > 0 ? p.expiryDate : 3} ngày kể từ ngày sản xuất.</div>
                    <div><strong>• Hướng dẫn bảo quản:</strong> ${not empty p.usageInstructions ? p.usageInstructions : 'Nên thưởng thức ngay trong ngày hoặc bảo quản ngăn mát tủ lạnh.'}</div>
                  </div>
                </div>

                <div class="btn-actions">
                  <a href="product-detail?id=${p.id != 0 ? p.id : p.productId}" class="btn-action-sub">XEM CHI TIẾT SẢN PHẨM</a>
                  <button type="button" class="btn-action-main">THÊM VÀO GIỎ HÀNG</button>
                </div>
              </div>

            </div>
          </c:forEach>
        </c:when>

        <c:otherwise>
          <div style="text-align:center; padding:60px; border:1px solid #000; background:#fff; font-size:14px;">
            Chưa có sản phẩm nào thuộc danh mục này trong Database.
          </div>
        </c:otherwise>
      </c:choose>
    </div>

  </main>

  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

</div>

<script src="js/app.js"></script>
</body>
</html>