<%
    // Nếu trang shop.jsp được truy cập trực tiếp (chưa có productList từ Servlet)
    if (request.getAttribute("productList") == null) {
        response.sendRedirect("shop");
        return;
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
      font-family: system-ui, -apple-system, sans-serif;
      color: #000;
    }
    
    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      width: 100%;
    }

    /* MỞ RỘNG KHUNG NỘI DUNG CHÍNH HOÀN TOÀN NHƯ ABOUT & CONTACT */
    .main-content {
      flex: 1;
      width: 100%;
      padding: 32px 60px 80px 60px;
      box-sizing: border-box;
    }

    .wf-topbar {
      background: #000;
      color: #fff;
      font-size: 11px;
      font-weight: bold;
      text-align: center;
      padding: 8px 20px;
      letter-spacing: 0.5px;
    }

    .wf-header {
      width: 100%;
      box-sizing: border-box;
      padding: 16px 60px;
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
    .brand-logo:hover { background: #000; color: #fff; }

    .wf-nav { display: flex; gap: 32px; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }

    .header-actions { display: flex; align-items: center; gap: 20px; }
    .search-box { display: flex; align-items: center; gap: 8px; border: 1px solid #000; padding: 6px 12px; background: #fff; width: 260px; }
    .search-box input { border: none; outline: none; font-size: 13px; width: 100%; background: transparent; }

    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }

    .breadcrumb-bar { font-size: 13px; color: #666; display: flex; align-items: center; gap: 8px; margin-bottom: 32px; }
    .breadcrumb-bar a { color: #666; text-decoration: none; }

    /* THIẾT KẾ CARD SẢN PHẨM SANG CHẢNH */
    .product-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 24px;
    }

    .product-box {
      border: 1px solid #000 !important;
      background: #fff !important;
      position: relative;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .product-box:hover {
      transform: translateY(-4px);
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.06);
    }

    .product-img-wrap {
      height: 200px !important;
      border-bottom: 1px solid #000 !important;
      overflow: hidden;
      background: #fafafa !important;
    }

    .product-img-wrap img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
      transition: transform 0.3s ease;
    }

    .product-box:hover .product-img-wrap img {
      transform: scale(1.04);
    }

    .add-cart-btn {
      width: 100%;
      border: 1px solid #000 !important;
      background: #fff !important;
      color: #000 !important;
      padding: 10px !important;
      font-size: 12px !important;
      font-weight: bold !important;
      cursor: pointer;
      box-sizing: border-box;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      transition: all 0.2s;
    }

    .add-cart-btn:hover {
      background: #000 !important;
      color: #fff !important;
    }

    /* BỘ LỌC SIDEBAR CHUẨN ĐỆP */
    .filter-sidebar {
      background: #fff !important;
      border: 1px solid #000 !important;
      padding: 24px !important;
      box-sizing: border-box;
      height: fit-content;
    }

    .btn-submit-filter {
      width: 100%;
      background: #000 !important;
      color: #fff !important;
      border: 1px solid #000 !important;
      padding: 12px !important;
      font-size: 12px !important;
      font-weight: bold !important;
      cursor: pointer;
      letter-spacing: 1px;
      text-transform: uppercase;
      transition: background 0.2s;
    }

    .btn-submit-filter:hover {
      background: #333 !important;
    }

    /* STYLES CHO SLIDER 2 NÚT KÉO */
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
      background: #e0e0e0;
      border-radius: 2px;
    }
    .slider-track-active {
      position: absolute;
      top: 10px;
      height: 4px;
      background: #000;
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
      background: #000;
      border: 2px solid #fff;
      box-shadow: 0 1px 4px rgba(0,0,0,0.4);
      cursor: pointer;
      pointer-events: auto;
    }
    .dual-range-container input[type="range"]::-moz-range-thumb {
      height: 18px;
      width: 18px;
      border-radius: 50%;
      background: #000;
      border: 2px solid #fff;
      box-shadow: 0 1px 4px rgba(0,0,0,0.4);
      cursor: pointer;
      pointer-events: auto;
    }

    .minimal-footer { 
      border-top: 1px solid #000; 
      background: #fff; 
      padding: 24px 0; 
      text-align: center; 
      font-size: 13px; 
      color: #000; 
      width: 100%; 
    }

    @media (max-width: 992px) {
      .main-content, .wf-header { padding-left: 20px; padding-right: 20px; }
      .product-grid { grid-template-columns: repeat(2, 1fr); }
    }
  </style>
</head>
<body>

<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: 0766 766 999</div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop" style="text-decoration:underline; font-weight:bold;">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" value="${keyword}" placeholder="Tìm kiếm sản phẩm...">
      </form>
      <div class="wf-icons">
        <a href="favorites.jsp" class="ic-btn" title="Yêu thích">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">0</span>
      </a>

      <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">0</span>
      </a
        <a href="login.jsp" class="ic-btn">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
        </a>
      </div>
    </div>
  </header>

  <main class="main-content">
    
    <!-- BREADCRUMB -->
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <a href="shop">Cửa hàng</a> <span>&rsaquo;</span>
      <strong style="color:#000;">Tất cả sản phẩm</strong>
    </div>

    <div style="display:grid; grid-template-columns:280px 1fr; gap:36px; align-items:start;">
      
      <!-- Cột Trái: Bộ Lọc Sidebar -->
      <aside class="filter-sidebar">
        <form action="shop" method="GET" id="filter-form">
          
          <!-- 1. TÌM KIẾM -->
          <div style="margin-bottom:28px;">
            <div style="font-size:13px; font-weight:bold; border-bottom:2px solid #000; padding-bottom:8px; margin-bottom:14px; letter-spacing:1px; text-transform:uppercase;">TÌM KIẾM BÁNH</div>
            <div style="position:relative; display:flex; align-items:center;">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2" style="position:absolute; left:10px;"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
              <input type="text" id="filter-keyword" name="keyword" value="${keyword}" placeholder="Nhập tên bánh..." style="width:100%; padding:10px 10px 10px 32px; border:1px solid #000; font-size:12px; box-sizing:border-box; outline:none; background:#fff; font-family:inherit;">
            </div>
          </div>

          <!-- 2. DANH MỤC SẢN PHẨM -->
          <div style="margin-bottom:28px;">
            <div style="font-size:13px; font-weight:bold; border-bottom:2px solid #000; padding-bottom:8px; margin-bottom:14px; letter-spacing:1px; text-transform:uppercase;">DANH MỤC</div>
            <ul style="list-style:none; padding:0; margin:0;">
              <li style="margin-bottom:10px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="1" style="width:15px; height:15px; cursor:pointer;"> 🥖 Bánh mì (Bread)
              </li>
              <li style="margin-bottom:10px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="2" style="width:15px; height:15px; cursor:pointer;"> 🍰 Bánh kem (Cakes)
              </li>
              <li style="margin-bottom:10px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="3" style="width:15px; height:15px; cursor:pointer;"> 🥐 Bánh Ngọt Bơ & Ngàn Lớp (Pastry)
              </li>
              <li style="margin-bottom:10px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="4" style="width:15px; height:15px; cursor:pointer;"> 🍪 Bánh quy (Cookie)
              </li>
              <li style="margin-bottom:10px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="5" style="width:15px; height:15px; cursor:pointer;"> 🍩 Bánh Donuts
              </li>
              <li style="margin-bottom:10px; font-size:13px; display:flex; align-items:center; gap:10px;">
                <input type="checkbox" name="category" value="6" style="width:15px; height:15px; cursor:pointer;"> 🧁 Bánh Cupcake
              </li>
            </ul>
          </div>

          <!-- 3. KHOẢNG GIÁ DUAL SLIDER (2 NÚT KÉO) -->
          <div>
            <div style="font-size:13px; font-weight:bold; border-bottom:2px solid #000; padding-bottom:8px; margin-bottom:14px; letter-spacing:1px; text-transform:uppercase;">KHOẢNG GIÁ (NGHÌN VNĐ)</div>
            
            <!-- Dòng hiển thị giá chọn -->
            <div style="text-align:center; font-size:13px; margin-bottom:12px;">
              Giá chọn: <strong id="slider-val-display" style="color:#000; font-size:14px;">${not empty minPrice ? minPrice : 1}k - ${not empty maxPrice ? maxPrice : 1000}k</strong>
            </div>

            <!-- Container chứa 2 nút trượt -->
            <div class="dual-range-container">
              <div class="slider-track-bg"></div>
              <div id="slider-track" class="slider-track-active"></div>

              <input type="range" id="price-slider-min" min="1" max="1000" step="1" value="${not empty minPrice ? minPrice : 1}">
              <input type="range" id="price-slider-max" min="1" max="1000" step="1" value="${not empty maxPrice ? maxPrice : 1000}">
            </div>

            <div style="display:flex; justify-content:space-between; font-size:11px; color:#666; margin-bottom:14px;">
              <span>1.000 VNĐ</span>
              <span>1.000.000 VNĐ</span>
            </div>

            <!-- Ô Nhập Số Trực Tiếp -->
            <div style="display:flex; gap:8px; margin-bottom:16px; align-items:center;">
              <input type="number" id="filter-min-price" name="minPrice" value="${not empty minPrice ? minPrice : 1}" min="1" max="1000" placeholder="Từ" style="width:100%; padding:8px; border:1px solid #000; font-size:12px; box-sizing:border-box; outline:none; background:#fff; font-family:inherit;">
              <span>-</span>
              <input type="number" id="filter-max-price" name="maxPrice" value="${not empty maxPrice ? maxPrice : 1000}" min="1" max="1000" placeholder="Đến" style="width:100%; padding:8px; border:1px solid #000; font-size:12px; box-sizing:border-box; outline:none; background:#fff; font-family:inherit;">
            </div>

            <button type="submit" id="btn-submit-filter" class="btn-submit-filter">
              ÁP DỤNG BỘ LỌC
            </button>
          </div>

        </form>
      </aside>

      <!-- Cột Phải: Hiển Thị Sản Phẩm Từ SQL Database -->
      <section style="width:100%; min-width:0;">
        <div style="display:flex; justify-content:space-between; align-items:center; margin-bottom:24px; border-bottom:2px solid #000; padding-bottom:12px;">
          <div id="result-status-text" style="font-size:14px; color:#444;">
            Hiển thị <strong>${not empty productList ? productList.size() : 0}</strong> sản phẩm từ Database
          </div>
          <div style="display:flex; align-items:center; gap:10px;">
            <span style="font-size:13px; font-weight:bold; text-transform:uppercase;">Sắp xếp:</span>
            <div style="border:1px solid #000; padding:8px 14px; font-size:12px; width:170px; display:flex; justify-content:space-between; align-items:center; background:#fff; cursor:pointer;">
              Phổ biến nhất 
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg>
            </div>
          </div>
        </div>

        <!-- LƯỚI SẢN PHẨM JSTL DÙNG DỮ LIỆU TỪ DATABASE -->
        <div class="product-grid" style="width:100%;">
          <c:choose>
            <c:when test="${not empty productList}">
              <c:forEach items="${productList}" var="p">
                <div class="product-box" data-category="${p.categoryId}" style="width:100%;">
                  
                  <div class="fav-btn" title="Thêm vào yêu thích" style="position:absolute; top:12px; right:12px; width:30px; height:30px; border-radius:50%; border:1px solid #000; background:#fff; display:flex; align-items:center; justify-content:center; cursor:pointer; z-index:5;">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
                  </div>

                  <div class="product-img-wrap img-ph">
                    <a href="product-detail?id=${p.id != 0 ? p.id : p.productId}">
                      <img src="${p.image}" alt="${p.productName}" onError="this.onerror=null;this.src='images/placeholder.jpg';">
                    </a>
                  </div>

                  <div class="product-info" style="padding:16px;">
                    <div class="p-title" style="font-weight:bold; font-size:14px; margin-bottom:8px; line-height:1.3; height:36px; overflow:hidden; text-transform:uppercase;">
                      ${p.productName}
                    </div>
                    
                    <div class="p-price" style="font-size:15px; font-weight:bold; margin-bottom:14px; color:#000;">
                      <fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ
                    </div>

                    <button type="button" class="add-cart-btn">
                      THÊM VÀO GIỎ
                    </button>
                  </div>

                </div>
              </c:forEach>
            </c:when>

            <c:otherwise>
              <div style="grid-column: 1 / -1; text-align:center; padding:60px; background:#fff; border:1px solid #000; font-size:14px;">
                Không có sản phẩm nào trong Database phù hợp với bộ lọc.
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

<!-- SCRIPT PHÂN TRANG VÀ DUAL SLIDER KÉO REALTIME -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  // 1. XỬ LÝ DUAL RANGE SLIDER (KÉO 2 NÚT THỜI GIAN THỰC)
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

  // 2. PHẦN PHÂN TRANG TRÊN DỮ LIỆU JSTL
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
    html += '<div class="page-num" data-page="' + (currentPage - 1) + '" style="padding:8px 14px;border:1px solid #000;margin:0 2px;font-weight:bold;' + prevDisabled + '">&lt;</div>';

    for (var i = 1; i <= totalPages; i++) {
      var activeStyle = (i === currentPage) ? 'background:#000;color:#fff;' : 'background:#fff;color:#000;';
      html += '<div class="page-num" data-page="' + i + '" style="cursor:pointer;padding:8px 14px;border:1px solid #000;margin:0 2px;font-weight:bold;' + activeStyle + '">' + i + '</div>';
    }

    var nextDisabled = (currentPage === totalPages) ? 'opacity:0.4;pointer-events:none;' : 'cursor:pointer;';
    html += '<div class="page-num" data-page="' + (currentPage + 1) + '" style="padding:8px 14px;border:1px solid #000;margin:0 2px;font-weight:bold;' + nextDisabled + '">&gt;</div>';

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

</body>
</html>