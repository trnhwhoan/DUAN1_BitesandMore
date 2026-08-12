<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Sản phẩm yêu thích</title>
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
      padding: 20px 20px 60px 20px;
      box-sizing: border-box;
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

    /* Xóa các viền gạch dư thừa */
    .wire-page, .section, .wf-footer, .footer-bottom, .filter-block {
      border: none !important;
      background: transparent !important;
      box-shadow: none !important;
    }

    .product-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
    }
    @media (max-width: 992px) {
      .product-grid { grid-template-columns: repeat(2, 1fr); }
    }

    .product-card {
      position: relative;
      background: #fff;
      border: 1px solid #000;
    }
    .product-card .img-ph {
      height: 180px;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
      background: #f5f5f5;
    }
    .product-card .img-ph img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .fav-remove-btn {
      position: absolute;
      top: 10px;
      right: 10px;
      background: #fff;
      border-radius: 50%;
      width: 32px;
      height: 32px;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      box-shadow: 0 2px 6px rgba(0,0,0,0.15);
      transition: transform 0.2s ease;
      z-index: 5;
    }
    .fav-remove-btn:hover {
      transform: scale(1.1);
    }
    .fav-remove-btn svg {
      pointer-events: none;
    }

    .empty-state {
      display: none;
      text-align: center;
      padding: 60px 20px;
      background: #fff;
      border: 1px solid #000;
    }
    .empty-state svg { margin-bottom: 16px; color: #ccc; }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: (000) 123-4567</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
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
        <svg width="22" height="22" viewBox="0 0 24 24" fill="#000" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
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
    <span class="active">Sản phẩm yêu thích</span>
  </div>

  <!-- MAIN CONTENT -->
  <div class="main-content">
    <div id="fav-header" style="margin-bottom:24px;display:flex;justify-content:space-between;align-items:flex-end;">
      <div>
        <h2 style="font-size:22px;font-weight:bold;margin:0 0 6px 0;">Danh Sách Yêu Thích</h2>
        <div style="font-size:14px;color:#666;" class="fav-summary-text">Bạn đang có <strong style="color:#000;" id="count-num">0</strong> sản phẩm trong danh sách yêu thích</div>
      </div>
      <button id="clear-all-fav" type="button" class="btn" style="border:1px solid #000;background:#fff;padding:8px 16px;font-size:13px;font-weight:bold;cursor:pointer;">Xóa tất cả</button>
    </div>

    <!-- Grid Hiển Thị Sản Phẩm Động Từ LocalStorage -->
    <div class="product-grid" id="fav-grid"></div>

    <!-- Khối Hiển Thị Khi Trống -->
    <div class="empty-state" id="empty-state">
      <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="#ccc" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
        <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path>
      </svg>
      <div style="font-size:18px;font-weight:bold;margin-bottom:8px;">Danh sách yêu thích trống</div>
      <div style="font-size:14px;color:#666;margin-bottom:24px;">Hãy nhấn thả tim các món bánh bạn thích từ cửa hàng để xem lại tại đây nhé!</div>
      <a href="shop.jsp" class="btn btn-dark" style="display:inline-block;padding:12px 28px;text-decoration:none;color:#fff;background:#000;font-weight:bold;">Khám phá cửa hàng</a>
    </div>

  </div>

  <!-- FOOTER -->
  <div style="border-top:1px solid #000; padding:16px 0; text-align:center; font-size:13px; color:#000; background:#fff;">
    &copy; Bites &amp; More. since 2026
  </div>

</div>

<!-- SCRIPT ĐỌC VÀ HIỂN THỊ TỪ LOCALSTORAGE -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  var favGrid = document.getElementById("fav-grid");
  var emptyState = document.getElementById("empty-state");
  var favHeader = document.getElementById("fav-header");
  var countNum = document.getElementById("count-num");
  var clearAllBtn = document.getElementById("clear-all-fav");

  function getFavorites() {
    return JSON.parse(localStorage.getItem("bites_favorites") || "[]");
  }

  function saveFavorites(list) {
    localStorage.setItem("bites_favorites", JSON.stringify(list));
    renderFavorites();
    if (typeof updateGlobalBadges === "function") {
      updateGlobalBadges();
    }
  }

  function renderFavorites() {
    var favorites = getFavorites();
    var total = favorites.length;

    if (total === 0) {
      favGrid.style.display = "none";
      favHeader.style.display = "none";
      emptyState.style.display = "block";
    } else {
      emptyState.style.display = "none";
      favHeader.style.display = "flex";
      favGrid.style.display = "grid";
      if (countNum) countNum.innerText = total;

      var html = "";
      favorites.forEach(function (p, index) {
        html += '<div class="product-card" data-index="' + index + '">';
        html += '  <div class="img-ph"><img src="' + p.img + '" alt="' + p.name + '" onError="this.onerror=null;this.src=\'images/placeholder.jpg\';"></div>';
        html += '  <div class="fav-remove-btn" data-name="' + p.name + '" title="Bỏ yêu thích">';
        html += '    <svg width="16" height="16" viewBox="0 0 24 24" fill="#000" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>';
        html += '  </div>';
        html += '  <div class="pc-body" style="padding:16px;">';
        html += '    <div class="pc-name" style="font-weight:bold;font-size:15px;margin-bottom:6px;">' + p.name + '</div>';
        html += '    <div class="pc-price" style="font-size:14px;color:#444;margin-bottom:12px;">' + p.price + '</div>';
        html += '    <div class="pc-cart-btn" style="cursor:pointer;padding:8px;background:#000;color:#fff;text-align:center;font-size:12px;font-weight:bold;">THÊM VÀO GIỎ</div>';
        html += '  </div>';
        html += '</div>';
      });
      favGrid.innerHTML = html;
    }
  }

  // Xóa từng món khỏi danh sách yêu thích
  favGrid.addEventListener("click", function (e) {
    var btn = e.target.closest(".fav-remove-btn");
    if (btn) {
      var name = btn.getAttribute("data-name");
      var favorites = getFavorites().filter(function (item) { return item.name !== name; });
      saveFavorites(favorites);
      return;
    }

    // Bắt sự kiện Thêm vào giỏ hàng ngay tại trang Yêu thích
    var cartBtn = e.target.closest(".pc-cart-btn");
    if (cartBtn) {
      e.preventDefault();
      var card = cartBtn.closest(".product-card");
      var name = card.querySelector(".pc-name").innerText.trim();
      var price = card.querySelector(".pc-price").innerText.trim();
      var imgEl = card.querySelector("img");
      var img = imgEl ? imgEl.src : "images/placeholder.jpg";

      var cart = JSON.parse(localStorage.getItem("bites_cart") || "[]");
      var existingIndex = cart.findIndex(function (item) { return item.name === name; });

      if (existingIndex > -1) {
        cart[existingIndex].quantity = (cart[existingIndex].quantity || 1) + 1;
      } else {
        cart.push({ name: name, price: price, img: img, quantity: 1 });
      }

      localStorage.setItem("bites_cart", JSON.stringify(cart));
      if (typeof updateGlobalBadges === "function") {
        updateGlobalBadges();
      }

      var oldText = cartBtn.innerText;
      cartBtn.innerText = "ĐÃ THÊM ✓";
      setTimeout(function () {
        cartBtn.innerText = oldText;
      }, 1000);
    }
  });

  // Nút xóa tất cả
  if (clearAllBtn) {
    clearAllBtn.addEventListener("click", function () {
      if (confirm("Xóa tất cả sản phẩm khỏi danh sách yêu thích?")) {
        saveFavorites([]);
      }
    });
  }

  renderFavorites();
});
</script>

<!-- SCRIPT APP.JS ĐỒNG BỘ BADGE HEADER TOÀN HỆ THỐNG -->
<script src="js/app.js"></script>
</body>
</html>