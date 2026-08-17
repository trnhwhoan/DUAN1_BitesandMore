<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.account}">
    <c:redirect url="login.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Thanh toán</title>
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

    .checkout-grid {
      display: flex;
      gap: 32px;
      align-items: flex-start;
    }
    .checkout-col-left {
      flex: 1.3;
      display: flex;
      flex-direction: column;
      gap: 24px;
    }
    .checkout-col-right {
      flex: 1;
      position: sticky;
      top: 90px;
    }

    .form-box {
      border: 1.5px solid var(--border-soft) !important;
      border-radius: var(--radius-lg);
      padding: 28px;
      background: #fff;
      box-shadow: var(--shadow-sm);
    }

    .form-row {
      display: flex;
      gap: 16px;
      margin-bottom: 16px;
    }
    .form-row:last-child {
      margin-bottom: 0;
    }
    .form-group {
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    .form-group label {
      font-size: 12px;
      font-weight: 700;
      color: var(--text-chocolate);
      margin-bottom: 6px;
      text-transform: uppercase;
    }

    .field-input {
      width: 100%;
      height: 42px;
      padding: 0 14px;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      font-size: 13px;
      outline: none;
      box-sizing: border-box;
      background: #fff;
      color: var(--text-chocolate);
      transition: border-color 0.2s;
    }
    .field-input:focus {
      border-color: var(--pink-primary);
      background-color: #fff;
    }

    .payment-option {
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      padding: 14px 16px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 12px;
      background: #fff;
      transition: all 0.2s;
    }
    .payment-option:hover {
      border-color: var(--pink-primary);
      background: var(--pink-subtle);
    }

    /* STEP PROGRESS BAR */
    .step-item {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      font-weight: 700;
      color: var(--text-muted);
      transition: all 0.3s ease;
    }
    .step-number {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      border: 1.5px solid var(--border-soft);
      background: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      color: var(--text-muted);
      transition: all 0.3s ease;
    }
    .step-item.active {
      color: var(--pink-primary);
    }
    .step-item.active .step-number { 
      background: var(--pink-primary); 
      color: #fff; 
      border-color: var(--pink-primary);
    }
    .step-item.inactive { opacity: 0.4; }

    /* THÔNG BÁO BƯỚC 3 THÀNH CÔNG */
    #order-success-box {
      display: none;
      background: #fff;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-lg);
      padding: 48px 32px;
      text-align: center;
      max-width: 600px;
      margin: 0 auto;
      box-shadow: var(--shadow-md);
    }

    .btn-submit-order {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 14px;
      width: 100%;
      font-size: 13px;
      font-weight: 700;
      cursor: pointer;
      background: var(--pink-primary);
      color: #fff;
      border: none;
      border-radius: 20px;
      transition: all 0.2s;
      box-shadow: var(--shadow-sm);
    }
    .btn-submit-order:hover {
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
      .main-content, .wf-header { padding-left: 20px; padding-right: 20px; }
      .checkout-grid { flex-direction: column; }
      .checkout-col-right { position: static; width: 100%; }
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
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact">Liên hệ</a>
    </nav>
    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>
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
        <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
        </a>
        <c:choose>
          <c:when test="${not empty sessionScope.account}">
            <a href="profile.jsp" class="ic-btn" title="Tài khoản: ${sessionScope.account.fullName}">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8 7"/></svg>
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

  <!-- BREADCRUMB -->
  <main class="main-content">
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <a href="cart.jsp">Giỏ hàng</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);">Thanh toán</strong>
    </div>

    <!-- TIẾN TRÌNH STEP BAR -->
    <div style="display:flex;justify-content:center;align-items:center;gap:24px;margin-bottom:36px;">
      <div class="step-item active" id="step-1">
        <div class="step-number">1</div>
        <span>Giỏ hàng</span>
      </div>
      <div style="width:40px;height:2px;background:var(--pink-primary);" id="line-1"></div>
      <div class="step-item active" id="step-2">
        <div class="step-number">2</div>
        <span>Giao hàng &amp; Thanh toán</span>
      </div>
      <div style="width:40px;height:2px;background:var(--border-soft);" id="line-2"></div>
      <div class="step-item inactive" id="step-3">
        <div class="step-number">3</div>
        <span>Xác nhận đơn</span>
      </div>
    </div>

    <!-- KHỐI 1: FORM ĐẶT HÀNG -->
    <c:if test="${not empty error}">
      <p style="color:#d6526f; font-weight:bold; text-align:center; margin-bottom:16px;"><c:out value="${error}"/></p>
    </c:if>

    <form id="checkout-form" action="checkout" method="POST">
      <div class="checkout-grid">
        
        <!-- CỘT TRÁI: NHẬP THÔNG TIN -->
        <div class="checkout-col-left">
          
          <!-- THÔNG TIN GIAO HÀNG -->
          <!-- KHUNG THÔNG TIN GIAO HÀNG CÓ CHỌN NGÀY NHẬN BÁNH -->
<div class="content-box-card" style="background:#fff; border:1.5px solid var(--border-soft); border-radius:16px; padding:28px; margin-bottom:24px; box-shadow:0 4px 12px rgba(232,106,133,0.06);">
  <h2 style="font-size:14px; font-weight:800; text-transform:uppercase; color:var(--text-chocolate); border-bottom:2px solid var(--pink-primary); padding-bottom:10px; margin-top:0; margin-bottom:20px;">
    THÔNG TIN GIAO HÀNG
  </h2>

  <div style="display:grid; grid-template-columns:1fr 1fr; gap:16px;">
    <!-- HỌ & TÊN -->
    <div>
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">HỌ *</label>
      <input type="text" name="lastName" placeholder="Nguyễn" required
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none;">
    </div>
    <div>
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">TÊN *</label>
      <input type="text" name="firstName" placeholder="Văn A" value="${sessionScope.account != null ? sessionScope.account.fullName : ''}" required
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none;">
    </div>

    <!-- SỐ ĐIỆN THOẠI & EMAIL -->
    <div>
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">SỐ ĐIỆN THOẠI *</label>
      <input type="tel" name="phone" placeholder="0905 123 456" value="${sessionScope.account != null ? sessionScope.account.phoneNumber : ''}" required
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none;">
    </div>
    <div>
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">EMAIL NHẬN HÓA ĐƠN</label>
      <input type="email" name="email" placeholder="nguyenvana@gmail.com" value="${sessionScope.account != null ? sessionScope.account.email : ''}"
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none;">
    </div>

    <!-- ĐỊA CHỈ NHẬN HÀNG (FULL CHIỀU RỘNG) -->
    <div style="grid-column: span 2;">
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">ĐỊA CHỈ NHẬN HÀNG *</label>
      <input type="text" name="address" placeholder="Số nhà, tên đường, phường/xã..." value="${sessionScope.account != null ? sessionScope.account.address : ''}" required
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none;">
    </div>

    <!-- TỈNH/THÀNH PHỐ & NGÀY GIAO BÁNH -->
    <div>
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">TỈNH / THÀNH PHỐ *</label>
      <input type="text" name="city" value="Đà Nẵng" readonly
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none; background:var(--pink-subtle);">
    </div>
    <div>
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">NGÀY NHẬN BÁNH MONG MUỐN *</label>
      <input type="date" id="deliveryDate" name="deliveryDate" required
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none; font-family:inherit; background:#fff; color:var(--text-chocolate); cursor:pointer;">
    </div>

    <!-- GHI CHÚ GIAO HÀNG -->
    <div style="grid-column: span 2;">
      <label style="font-size:11px; font-weight:700; text-transform:uppercase; display:block; margin-bottom:6px;">GHI CHÚ GIAO HÀNG</label>
      <input type="text" name="note" placeholder="Giao giờ hành chính, viết chữ lên bánh kem..."
             style="width:100%; box-sizing:border-box; padding:10px 14px; border:1.5px solid var(--border-soft); border-radius:8px; outline:none;">
    </div>
  </div>
</div>

          <!-- PHƯƠNG THỨC THANH TOÁN -->
          <div class="form-box">
            <h5 style="border-bottom:2px solid var(--pink-primary);padding-bottom:10px;margin:0 0 20px 0;font-size:15px;font-weight:800;color:var(--text-chocolate);">PHƯƠNG THỨC THANH TOÁN</h5>
            
            <div style="display:flex;flex-direction:column;gap:12px;">
              <label class="payment-option">
                <input type="radio" name="paymentMethod" value="cod" style="accent-color:var(--pink-primary);width:18px;height:18px;cursor:pointer;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2"><rect x="2" y="6" width="20" height="12" rx="2"/><circle cx="12" cy="12" r="3"/></svg>
                <span style="font-size:13px;font-weight:700;color:var(--text-chocolate);">Thanh toán khi nhận hàng (COD)</span>
              </label>
              <label class="payment-option">
                <input type="radio" name="paymentMethod" value="transfer" checked style="accent-color:var(--pink-primary);width:18px;height:18px;cursor:pointer;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                <span style="font-size:13px;font-weight:700;color:var(--text-chocolate);">Chuyển khoản ngân hàng</span>
              </label>
            </div>

            <div id="transfer-info-box" style="display:none;gap:20px;align-items:stretch;background:var(--pink-subtle);padding:18px;border:1.5px solid var(--border-soft);border-radius:var(--radius-sm);margin-top:16px;">
              <div style="flex:1;line-height:1.9;font-size:13px;color:var(--text-chocolate);">
                <strong style="font-size:14px;">THÔNG TIN TÀI KHOẢN</strong><br>
                Ngân hàng: <strong>MB Bank</strong><br>
                Số tài khoản: <strong>0123456789</strong><br>
                Chủ tài khoản: <strong>BITES &amp; MORE</strong><br>
                Nội dung: <strong>Họ tên + Số điện thoại</strong>
              </div>
              <div style="flex:0 0 160px;text-align:center;">
                <strong style="font-size:12px;">QUÉT MÃ QR</strong>
                <img src="https://img.vietqr.io/image/MB-0123456789-compact2.png" alt="Mã QR chuyển khoản" style="display:block;width:140px;height:140px;margin:8px auto 0;object-fit:contain;background:#fff;">
              </div>
            </div>

          </div>

        </div>

        <!-- CỘT PHẢI: TÓM TẮT SẢN PHẨM -->
        <div class="checkout-col-right">
          <div class="form-box">
            <h5 style="border-bottom:2px solid var(--pink-primary);padding-bottom:10px;margin:0 0 16px 0;font-size:15px;font-weight:800;color:var(--text-chocolate);">SẢN PHẨM ĐẶT MUA</h5>
            
            <div id="checkout-item-list" style="max-height:300px;overflow-y:auto;margin-bottom:16px;padding-right:4px;">
              <!-- JS Render -->
            </div>

            <hr style="border:none;border-top:1.5px solid var(--border-soft);margin:14px 0;">

            <div style="display:flex;justify-content:space-between;font-size:13px;color:var(--text-muted);margin-bottom:10px;">
              <span>Tạm tính</span>
              <span id="checkout-subtotal" style="font-weight:700;color:var(--text-chocolate);">0đ</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:13px;color:var(--text-muted);margin-bottom:10px;">
              <span>Phí vận chuyển</span>
              <span id="checkout-shipping" style="color:var(--pink-primary);font-weight:700;">0đ</span>
            </div>

            <hr style="border:none;border-top:1.5px solid var(--border-soft);margin:14px 0;">

            <div style="display:flex;justify-content:space-between;font-size:16px;font-weight:800;margin-bottom:24px;color:var(--text-chocolate);">
              <span>TỔNG CỘNG</span>
              <span id="checkout-total" style="color:var(--pink-primary);">0đ</span>
            </div>
            
            <button type="submit" class="btn-submit-order">
              XÁC NHẬN ĐẶT HÀNG 
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><polyline points="20,6 9,17 4,12"/></svg>
            </button>
          </div>
        </div>

      </div>
    </form>

    <!-- KHỐI 2: XÁC NHẬN ĐƠN HÀNG THÀNH CÔNG (BƯỚC 3) -->
    <div id="order-success-box">
      <div style="width:60px;height:60px;background:var(--pink-primary);color:#fff;border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 20px auto;box-shadow:var(--shadow-sm);">
        <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5"><polyline points="20,6 9,17 4,12"/></svg>
      </div>
      
      <h3 style="font-size:20px;font-weight:800;margin-bottom:12px;color:var(--text-chocolate);">ĐẶT HÀNG THÀNH CÔNG!</h3>
      <p style="font-size:14px;color:var(--text-muted);margin-bottom:24px;line-height:1.6;">
        Cảm ơn bạn <strong id="success-user-name" style="color:var(--text-chocolate);"></strong> đã tin tưởng lựa chọn <strong>Bites &amp; More</strong>.<br>
        Mã đơn hàng của bạn là: <strong id="success-order-id" style="color:var(--pink-primary);text-decoration:underline;">#BM8892</strong>.
      </p>

      <div style="background:var(--pink-subtle);border:1.5px solid var(--border-soft);border-radius:var(--radius-md);padding:20px;text-align:left;font-size:13px;margin-bottom:28px;color:var(--text-muted);">
        <div style="margin-bottom:8px;"><strong>Người nhận:</strong> <span id="success-receiver" style="color:var(--text-chocolate);"></span></div>
        <div style="margin-bottom:8px;"><strong>Số điện thoại:</strong> <span id="success-phone" style="color:var(--text-chocolate);"></span></div>
        <div style="margin-bottom:8px;"><strong>Địa chỉ:</strong> <span id="success-address" style="color:var(--text-chocolate);"></span></div>
        <div><strong>Tổng thanh toán:</strong> <span id="success-total" style="font-weight:800;color:var(--pink-primary);"></span></div>
      </div>

      <div style="display:flex;justify-content:center;gap:12px;">
        <a href="shop.jsp" style="padding:12px 24px;text-decoration:none;color:#fff;font-weight:700;font-size:12px;display:inline-block;background:var(--pink-primary);border-radius:20px;box-shadow:var(--shadow-sm);">TIẾP TỤC MUA SẮM</a>
        <a href="home.jsp" style="padding:12px 24px;text-decoration:none;color:var(--pink-primary);border:1.5px solid var(--pink-primary);font-weight:700;font-size:12px;display:inline-block;border-radius:20px;">VỀ TRANG CHỦ</a>
      </div>
    </div>

  </main>

  <!-- FOOTER -->
  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

</div>

<!-- Dữ liệu giỏ server được dùng làm nguồn chính tại bước thanh toán. -->
<div id="server-cart-data" hidden>
  <c:forEach items="${sessionScope.cart}" var="cartItem">
    <span class="server-cart-item"
      data-id="${cartItem.productId}"
      data-name="<c:out value='${cartItem.product.productName}'/>"
      data-price="${cartItem.product.price}" 
      data-image="<c:out value='${cartItem.product.image}'/>"
      data-quantity="${cartItem.quantity}"></span>
  </c:forEach>
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

<!-- SCRIPT CHUYỂN BƯỚC VÀ XÁC NHẬN ĐƠN HÀNG -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  var itemListContainer = document.getElementById("checkout-item-list");
  var subtotalEl = document.getElementById("checkout-subtotal");
  var shippingEl = document.getElementById("checkout-shipping");
  var totalEl = document.getElementById("checkout-total");
  var paymentRadios = document.querySelectorAll('input[name="paymentMethod"]');
  var transferInfoBox = document.getElementById("transfer-info-box");

  function getCart() {
    var serverItems = Array.from(document.querySelectorAll('.server-cart-item')).map(function (el) {
      return {
        id: el.dataset.id,
        name: el.dataset.name || 'Sản phẩm',
        price: el.dataset.price || '0',
        img: el.dataset.image || 'images/placeholder.jpg',
        quantity: parseInt(el.dataset.quantity, 10) || 1
      };
    });
    if (serverItems.length > 0) return serverItems;
    return JSON.parse(localStorage.getItem("bites_cart") || "[]");
  }

  function formatMoney(amount) {
    return amount.toLocaleString('vi-VN') + 'đ';
  }

  function parsePrice(priceInput) {
    if (typeof priceInput === 'number') return priceInput;
    if (!priceInput) return 0;
    
    var str = String(priceInput).trim();
    str = str.split('/')[0];

    if (/^\d+\.\d{1,2}$/.test(str)) {
      return parseFloat(str);
    }
    if (str.includes('.')) {
      if (str.includes(',')) {
        str = str.split(',')[0].replace(/\./g, '');
      } else {
        str = str.replace(/\./g, '');
      }
    } else if (str.includes(',')) {
      str = str.split(',')[0];
    }

    var cleaned = str.replace(/[^0-9]/g, '');
    return parseInt(cleaned, 10) || 0;
  }

  function renderCheckoutSummary() {
    var cart = getCart();

    if (cart.length === 0) {
      if (itemListContainer) {
        itemListContainer.innerHTML = '<div style="font-size:13px;color:var(--text-muted);text-align:center;padding:20px;">Giỏ hàng trống. <a href="shop" style="color:var(--pink-primary);text-decoration:underline;">Quay lại cửa hàng</a></div>';
      }
      return;
    }

    var html = "";
    var grandTotal = 0;

    cart.forEach(function (item) {
      var priceNum = parsePrice(item.price);
      var qty = item.quantity || 1;
      var subtotal = priceNum * qty;
      grandTotal += subtotal;

      html += '<div style="display:flex;justify-content:space-between;align-items:center;font-size:13px;margin-bottom:12px;padding-bottom:10px;border-bottom:1px dashed var(--border-soft);gap:12px;">';
      html += '  <div style="display:flex;align-items:center;gap:10px;flex:1;min-width:0;">';
      html += '    <img src="' + item.img + '" style="width:44px;height:44px;object-fit:cover;background:var(--pink-subtle);border-radius:4px;flex-shrink:0;" onError="this.onerror=null;this.src=\'images/placeholder.jpg\';">';
      html += '    <div style="overflow:hidden;">';
      html += '      <div style="font-weight:700;color:var(--text-chocolate);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">' + item.name + '</div>';
      html += '      <div style="font-size:12px;color:var(--text-muted);">Số lượng: ' + qty + '</div>';
      html += '    </div>';
      html += '  </div>';
      html += '  <span style="font-weight:700;color:var(--pink-primary);flex-shrink:0;margin-left:8px;">' + formatMoney(subtotal) + '</span>';
      html += '</div>';
    });

    if (itemListContainer) itemListContainer.innerHTML = html;

    var shipping = grandTotal >= 100000 ? 0 : 30000;
    if (subtotalEl) subtotalEl.innerText = formatMoney(grandTotal);
    if (shippingEl) shippingEl.innerText = shipping === 0 ? "MIỄN PHÍ" : formatMoney(shipping);
    if (totalEl) totalEl.innerText = formatMoney(grandTotal + shipping);
  }

  paymentRadios.forEach(function (radio) {
    radio.addEventListener("change", function () {
      if (transferInfoBox) transferInfoBox.style.display = this.value === "transfer" ? "flex" : "none";
    });
  });

  var selectedPayment = document.querySelector('input[name="paymentMethod"]:checked');
  if (selectedPayment && transferInfoBox && selectedPayment.value === "transfer") transferInfoBox.style.display = "flex";

  renderCheckoutSummary();
});
</script>

<script src="js/app.js"></script>
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
