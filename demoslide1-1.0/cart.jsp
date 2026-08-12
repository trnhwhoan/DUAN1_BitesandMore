<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Giỏ Hàng Của Bạn</title>
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

    .wf-nav { display: flex; gap: 32px; align-items: center; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }

    .header-actions { display: flex; align-items: center; gap: 20px; }
    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }

    .breadcrumb-bar { font-size: 13px; color: #666; display: flex; align-items: center; gap: 8px; margin-bottom: 32px; }
    .breadcrumb-bar a { color: #666; text-decoration: none; }

    .cart-card {
      border: 1px solid #000;
      background: #fff;
      padding: 32px;
      box-sizing: border-box;
    }

    .cart-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 24px;
    }

    .cart-table th, .cart-table td {
      padding: 16px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }

    .cart-table th {
      font-size: 11px;
      font-weight: bold;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 2px solid #000;
    }

    .cart-item-img {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border: 1px solid #000;
      background: #fafafa;
    }

    .btn-action {
      background: #000;
      color: #fff;
      border: 1px solid #000;
      padding: 12px 28px;
      font-size: 12px;
      font-weight: bold;
      letter-spacing: 1px;
      text-transform: uppercase;
      cursor: pointer;
      text-decoration: none;
      display: inline-block;
      transition: background 0.2s;
    }
    .btn-action:hover { background: #333; }

    .minimal-footer { 
      border-top: 1px solid #000; 
      background: #fff; 
      padding: 24px 0; 
      text-align: center; 
      font-size: 13px; 
      color: #000; 
      width: 100%; 
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
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <a href="feedback" class="ic-btn feedback-link" title="Góp ý">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
      </a>

      <a href="cart.jsp" class="ic-btn" title="Giỏ hàng" style="opacity:0.5;">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
      </a>

      <c:choose>
        <c:when test="${not empty sessionScope.account}">
          <a href="profile.jsp" class="ic-btn account-active" title="Tài khoản: ${sessionScope.account.fullName}">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5">
              <circle cx="12" cy="8" r="4"/>
              <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
            </svg>
          </a>
        </c:when>
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

  <main class="main-content">
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <strong style="color:#000;">Giỏ hàng</strong>
    </div>

    <div class="cart-card">
      <h1 style="font-size:16px; font-weight:bold; text-transform:uppercase; letter-spacing:1px; margin-top:0; margin-bottom:24px; border-bottom:2px solid #000; padding-bottom:12px;">GIỎ HÀNG CỦA BẠN</h1>

      <c:choose>
        <c:when test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
          <table class="cart-table">
            <thead>
              <tr>
                <th>Sản phẩm</th>
                <th>Giá bánh</th>
                <th>Số lượng</th>
                <th>Tạm tính</th>
              </tr>
            </thead>
            <tbody>
              <c:set var="totalPrice" value="0" />
              <c:forEach items="${sessionScope.cart}" var="item">
                <%-- Xử lý trường hợp đối tượng item là CartItem hoặc Product trực tiếp --%>
                <c:set var="prod" value="${not empty item.product ? item.product : item}" />
                <c:set var="qty" value="${not empty item.quantity ? item.quantity : 1}" />
                <c:set var="subTotal" value="${prod.price * qty}" />
                <c:set var="totalPrice" value="${totalPrice + subTotal}" />

                <tr>
                  <td>
                    <div style="display:flex; align-items:center; gap:16px;">
                      <img src="${prod.image}" alt="${prod.productName}" class="cart-item-img" onError="this.onerror=null;this.src='images/placeholder.jpg';">
                      <span style="font-weight:bold; font-size:13px; text-transform:uppercase;">${prod.productName}</span>
                    </div>
                  </td>
                  <td style="font-size:13px; font-weight:bold;">
                    <fmt:formatNumber value="${prod.price}" pattern="#,##0"/>đ
                  </td>
                  <td style="font-size:14px; font-weight:bold;">
                    ${qty}
                  </td>
                  <td style="font-size:14px; font-weight:bold; color:#000;">
                    <fmt:formatNumber value="${subTotal}" pattern="#,##0"/>đ
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <div style="display:flex; justify-content:space-between; align-items:center; border-top:2px solid #000; padding-top:24px;">
            <a href="shop" style="color:#000; text-decoration:underline; font-size:12px; font-weight:bold; text-transform:uppercase;">&larr; Tiếp tục chọn bánh</a>
            
            <div style="text-align:right;">
              <div style="font-size:16px; font-weight:bold; margin-bottom:16px;">
                TỔNG CỘNG: <span style="font-size:20px; color:#000;"><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/>đ</span>
              </div>
              <a href="checkout" class="btn-action">TIẾN HÀNH THANH TOÁN</a>
            </div>
          </div>
        </c:when>

        <c:otherwise>
          <div style="text-align:center; padding:60px 20px;">
            <p style="font-size:14px; color:#555; margin-bottom:24px; text-transform:uppercase; letter-spacing:0.5px;">Giỏ hàng của bạn đang trống.</p>
            <a href="shop" class="btn-action">KHÁM PHÁ CỬA HÀNG</a>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </main>

  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

</div>

</body>
</html>
