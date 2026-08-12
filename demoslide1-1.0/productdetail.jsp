<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Chi tiết sản phẩm</title>
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

    .form-box {
      border: 1px solid #000 !important;
      padding: 32px;
      background: #fff;
    }

    .product-card {
      position: relative;
      background: #fff;
      border: 1px solid #000;
      overflow: hidden;
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

    .fav-icon {
      position: absolute;
      top: 10px;
      right: 10px;
      width: 32px;
      height: 32px;
      background: #ffffff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
      transition: transform 0.2s ease;
      z-index: 10;
    }
    .fav-icon:hover { transform: scale(1.1); }
    .fav-icon svg { pointer-events: none; }

    .thumb-img {
      height: 90px;
      border: 1px solid #ddd;
      cursor: pointer;
      overflow: hidden;
      background: #fff;
    }
    .thumb-img.active {
      border-color: #000;
    }
    .thumb-img img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    .tab-btn {
      padding-bottom: 12px;
      font-weight: bold;
      font-size: 14px;
      cursor: pointer;
      color: #666;
      border-bottom: 2px solid transparent;
    }
    .tab-btn.active {
      color: #000;
      border-bottom-color: #000;
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: (000) 123-4567</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <a href="home.jsp" class="wf-logo" style="color:#000;text-decoration:none;">BITES &amp; MORE</a>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp" style="text-decoration:underline;font-weight:bold;">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="wf-searchbar">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <span>Tìm kiếm sản phẩm...</span>
    </div>
    <div class="wf-icons">
      <a href="feedback" class="ic-btn feedback-link" title="Góp ý" style="position:relative;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
      </a>
      <a href="cart.jsp" class="ic-btn" style="position:relative;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
      </a>
<c:choose><c:when test="${not empty sessionScope.account}"><a href="profile.jsp" class="ic-btn account-active" title="Tài khoản: ${sessionScope.account.fullName}">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a></c:when><c:otherwise><a href="login.jsp" class="ic-btn" title="Đăng nhập">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4 7 8 7"/></svg>
      </a></c:otherwise></c:choose>
    </div>
  </div>

  <!-- BREADCRUMB -->
  <div class="breadcrumb">
    <a href="home.jsp">Trang chủ</a>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <a href="shop.jsp">Cửa hàng</a>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <a href="shop.jsp?category=cake">Bánh kem</a>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span class="active">Bánh Red Velvet</span>
  </div>

  <!-- MAIN PRODUCT DETAIL -->
  <div class="main-content">
    <div class="form-box">
      <div class="row">
        
        <!-- Cột Trái: Hình Ảnh Sản Phẩm -->
        <div class="col-6">
          <div style="height:380px;border:1px solid #000;margin-bottom:16px;background:#f5f5f5;overflow:hidden;">
            <img id="main-product-img" src="<c:out value='${product.image}'/>" alt="<c:out value='${product.productName}'/>" style="width:100%;height:100%;object-fit:cover;" onError="this.onerror=null;this.src='images/placeholder.jpg';">
          </div>
          <div class="row">
            <div class="col-3"><div class="thumb-img active"><img src="images/91865ec3a35f437be843c7b5b3f0c4e0.jpg" alt="Thumb 1" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div></div>
            <div class="col-3"><div class="thumb-img"><img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=300" alt="Thumb 2" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div></div>
            <div class="col-3"><div class="thumb-img"><img src="https://images.unsplash.com/photo-1588195538326-c5b1e9f80a1b?q=80&w=300" alt="Thumb 3" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div></div>
            <div class="col-3"><div class="thumb-img"><img src="https://images.unsplash.com/photo-1535141192574-5d4897c13136?q=80&w=300" alt="Thumb 4" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div></div>
          </div>
        </div>

        <!-- Cột Phải: Thông Tin Sản Phẩm -->
        <div class="col-6" style="padding-left:30px;">
          <h1 id="product-title" style="font-size:26px;font-weight:bold;margin:0 0 10px 0;"><c:out value="${product.productName}"/></h1>
          
          <!-- Rating Stars -->
          <div style="display:flex;align-items:center;gap:10px;margin-bottom:16px;">
            <span class="stars" style="display:flex;gap:2px;">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            </span>
            <span style="font-size:13px;color:#555;">(36 đánh giá)</span>
          </div>

          <div id="product-price" style="font-size:26px;font-weight:bold;margin-bottom:18px;"><fmt:formatNumber value="${product.price}" pattern="#,#00"/>đ</div>
          <div style="font-size:14px;color:#444;line-height:1.8;margin-bottom:24px;">
            <c:out value="${product.description}"/>
          </div>
          
          <hr style="border:none;border-top:1px solid #000;margin-bottom:24px;">

          <!-- Tăng giảm số lượng -->
          <div style="display:flex;align-items:center;gap:20px;margin-bottom:28px;">
            <span style="font-weight:bold;font-size:13px;">Số lượng:</span>
            <div style="display:flex;border:1px solid #000;align-items:center;width:120px;">
              <button type="button" id="btn-qty-minus" style="padding:8px 14px;border:none;border-right:1px solid #000;background:#fff;cursor:pointer;">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><line x1="5" y1="12" x2="19" y2="12"/></svg>
              </button>
              <div id="qty-val" style="padding:8px;font-weight:bold;flex:1;text-align:center;">1</div>
              <button type="button" id="btn-qty-plus" style="padding:8px 14px;border:none;border-left:1px solid #000;background:#fff;cursor:pointer;">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
              </button>
            </div>
          </div>

          <!-- Các nút bấm mua hàng -->
          <div style="display:flex;gap:12px;">
            <button type="button" id="detail-add-cart" class="btn" style="flex:1.2;display:inline-flex;align-items:center;justify-content:center;gap:8px;border:1px solid #000;background:#fff;padding:12px;font-weight:bold;font-size:13px;cursor:pointer;">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> 
              Thêm vào giỏ
            </button>
            <button type="button" id="detail-buy-now" class="btn btn-dark" style="flex:1;background:#000;color:#fff;border:none;padding:12px;font-weight:bold;font-size:13px;cursor:pointer;">
              Mua ngay
            </button>
            <button type="button" id="detail-fav-btn" class="btn" style="width:48px;padding:12px;border:1px solid #000;background:#fff;cursor:pointer;display:flex;align-items:center;justify-content:center;">
              <svg id="detail-fav-icon" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
            </button>
          </div>

        </div>
      </div>
    </div>

    <!-- TABS MÔ TẢ & ĐÁNH GIÁ -->
    <div class="form-box" style="margin-top:30px;">
      <div style="display:flex;gap:30px;border-bottom:1px solid #000;margin-bottom:24px;">
        <div class="tab-btn active">Mô tả sản phẩm</div>
        <div class="tab-btn">Đánh giá (36)</div>
        <div class="tab-btn">Thông tin giao hàng</div>
      </div>

      <div style="font-size:14px;color:#444;line-height:1.8;margin-bottom:40px;">
        Thành phần gồm có: Bột mì cao cấp, đường kính, bơ lạt, trứng gà tươi, bột cacao nguyên chất, màu thực phẩm tự nhiên và lớp kem phô mai Cream Cheese nhập khẩu. Bánh được nướng tươi mới trong ngày, bảo quản ở nhiệt độ mát từ 2-5°C và nên sử dụng tốt nhất trong vòng 48 giờ.
      </div>

      <!-- ĐÁNH GIÁ KHÁCH HÀNG -->
      <h5 style="font-size:16px;font-weight:bold;margin-bottom:20px;border-bottom:1px solid #000;padding-bottom:10px;">ĐÁNH GIÁ TỪ KHÁCH HÀNG</h5>
      
      <div style="display:flex;gap:16px;padding:16px 0;border-bottom:1px dashed #ddd;">
        <div class="img-ph" style="width:48px;height:48px;border-radius:50%;flex-shrink:0;background:#000;color:#fff;display:flex;align-items:center;justify-content:center;font-weight:bold;font-size:12px;">NH</div>
        <div>
          <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Như Hoàn</div>
          <div style="margin-bottom:8px;display:flex;gap:2px;">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </div>
          <div style="font-size:13px;color:#444;">Bánh rất mềm, thơm ngọt vừa phải! Đóng gói đẹp và giao hàng cực nhanh.</div>
        </div>
      </div>

      <div style="display:flex;gap:16px;padding:16px 0;">
        <div class="img-ph" style="width:48px;height:48px;border-radius:50%;flex-shrink:0;background:#000;color:#fff;display:flex;align-items:center;justify-content:center;font-weight:bold;font-size:12px;">TT</div>
        <div>
          <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Tuấn Tú</div>
          <div style="margin-bottom:8px;display:flex;gap:2px;">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </div>
          <div style="font-size:13px;color:#444;">Bánh ngon, kem béo ngậy đúng vị Red Velvet chuẩn.</div>
        </div>
      </div>
    </div>

    <!-- SẢN PHẨM LIÊN QUAN -->
    <div style="margin-top:40px;">
      <h3 style="font-size:20px;font-weight:bold;margin-bottom:20px;">Sản Phẩm Cùng Loại</h3>
      <div class="row">
        
        <div class="col-3">
          <div class="product-card">
            <div class="fav-icon" title="Thêm vào yêu thích">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
            </div>
            <div class="img-ph"><img src="images/5d9fc32d56126074219b204adc604a58.jpg" alt="Sourdough" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
            <div class="pc-body" style="padding:16px;">
              <div class="pc-name" style="font-weight:bold;font-size:14px;margin-bottom:6px;">Bánh mì Sourdough</div>
              <div class="pc-price" style="font-size:13px;color:#444;margin-bottom:12px;">78.000đ</div>
              <div class="pc-cart-btn" style="cursor:pointer;padding:8px;background:#000;color:#fff;text-align:center;font-size:12px;font-weight:bold;">THÊM VÀO GIỎ</div>
            </div>
          </div>
        </div>

        <div class="col-3">
          <div class="product-card">
            <div class="fav-icon" title="Thêm vào yêu thích">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
            </div>
            <div class="img-ph"><img src="images/47be84309ce929918fadebfd363e9619.webp" alt="Cupcake" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
            <div class="pc-body" style="padding:16px;">
              <div class="pc-name" style="font-weight:bold;font-size:14px;margin-bottom:6px;">Cupcake Socola</div>
              <div class="pc-price" style="font-size:13px;color:#444;margin-bottom:12px;">30.500đ</div>
              <div class="pc-cart-btn" style="cursor:pointer;padding:8px;background:#000;color:#fff;text-align:center;font-size:12px;font-weight:bold;">THÊM VÀO GIỎ</div>
            </div>
          </div>
        </div>

        <div class="col-3">
          <div class="product-card">
            <div class="fav-icon" title="Thêm vào yêu thích">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
            </div>
            <div class="img-ph"><img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=300" alt="Croissant" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
            <div class="pc-body" style="padding:16px;">
              <div class="pc-name" style="font-weight:bold;font-size:14px;margin-bottom:6px;">Bánh Croissant Bơ</div>
              <div class="pc-price" style="font-size:13px;color:#444;margin-bottom:12px;">45.000đ</div>
              <div class="pc-cart-btn" style="cursor:pointer;padding:8px;background:#000;color:#fff;text-align:center;font-size:12px;font-weight:bold;">THÊM VÀO GIỎ</div>
            </div>
          </div>
        </div>

        <div class="col-3">
          <div class="product-card">
            <div class="fav-icon" title="Thêm vào yêu thích">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
            </div>
            <div class="img-ph"><img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=300" alt="Bánh Tiramisu" onError="this.onerror=null;this.src='images/placeholder.jpg';"></div>
            <div class="pc-body" style="padding:16px;">
              <div class="pc-name" style="font-weight:bold;font-size:14px;margin-bottom:6px;">Bánh Tiramisu Ý</div>
              <div class="pc-price" style="font-size:13px;color:#444;margin-bottom:12px;">165.000đ</div>
              <div class="pc-cart-btn" style="cursor:pointer;padding:8px;background:#000;color:#fff;text-align:center;font-size:12px;font-weight:bold;">THÊM VÀO GIỎ</div>
            </div>
          </div>
        </div>

      </div>
    </div>

  </div>

  <!-- FOOTER -->
  <div style="border-top:1px solid #000; padding:16px 0; text-align:center; font-size:13px; color:#000; background:#fff;">
    &copy; Bites &amp; More. since 2026
  </div>

</div>

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

  // Switch Thumbnail Image
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

  // Quantity Change
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

  // Thêm vào giỏ
  if (btnAddCart) {
    btnAddCart.addEventListener("click", function () {
      addToCart(false);

      var oldText = btnAddCart.innerText;
      btnAddCart.innerText = "ĐÃ THÊM ✓";
      setTimeout(function () {
        btnAddCart.innerHTML = '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Thêm vào giỏ';
      }, 1000);
    });
  }

  // Mua ngay
  if (btnBuyNow) {
    btnBuyNow.addEventListener("click", function () {
      addToCart(true);
    });
  }

  // Yêu thích
  function checkFavState() {
      return;
  }

  if (btnFav) {
    btnFav.addEventListener("click", function () {
      var body = new URLSearchParams({productId: '${product.id}', action:'toggle', ajax:'true'});
      fetch('favorite', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:body.toString()})
        .then(function (response) { return response.json().then(function (data) { if (!response.ok) throw new Error(data.message || 'Không thể cập nhật yêu thích.'); return data; }); })
        .then(function (data) { if (iconFav) iconFav.setAttribute('fill', data.favorite ? '#000' : 'none'); document.querySelectorAll('.fav-count').forEach(function (el) { el.textContent = data.favoriteSize; }); })
        .catch(function (error) { alert(error.message); });
    });
  }

  function addToCart(buyNow) {
    var body = new URLSearchParams({action:'add', productId:'${product.id}', quantity:String(qty)});
    fetch('cart', {method:'POST', headers:{'Content-Type':'application/x-www-form-urlencoded'}, body:body.toString()})
      .then(function (response) { if (!response.ok) throw new Error('Không đủ hàng'); if (buyNow) window.location.href = 'checkout'; })
      .catch(function (error) { alert(error.message); });
  }
  checkFavState();
});
</script>

<!-- SCRIPT APP.JS ĐỒNG BỘ BADGE HEADER -->
<script src="js/app.js"></script>
</body>
</html>
