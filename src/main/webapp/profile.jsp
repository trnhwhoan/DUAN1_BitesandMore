<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- Chưa đăng nhập thì chuyển về trang login.jsp --%>
<c:if test="${empty sessionScope.account}">
  <c:redirect url="login.jsp"/>
</c:if>
<c:if test="${empty requestScope.profileLoaded}">
  <c:redirect url="profile"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Tài Khoản Của Tôi</title>
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
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: var(--text-chocolate);
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

    .wf-nav { display: flex; gap: 28px; align-items: center; }
    .wf-nav a { color: var(--text-chocolate); text-decoration: none; font-size: 13px; font-weight: 600; transition: color 0.2s; }
    .wf-nav a:hover, .wf-nav a.active { color: var(--pink-primary); }

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
      transition: all 0.2s;
    }
    .ic-btn:hover {
      border-color: var(--pink-primary);
      color: var(--pink-primary);
      transform: translateY(-2px);
    }
    /* Badge số lượng dùng chung với các trang cửa hàng/giỏ hàng */
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
      box-sizing: border-box;
    }

    .breadcrumb-bar {
      font-size: 13px;
      color: var(--text-muted);
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 28px;
    }
    .breadcrumb-bar a { color: var(--text-muted); text-decoration: none; transition: color 0.2s; }
    .breadcrumb-bar a:hover { color: var(--pink-primary); }

    .profile-grid {
      display: grid;
      grid-template-columns: 300px 1fr;
      gap: 32px;
      align-items: start;
    }

    /* SIDEBAR CỘT TRÁI */
    .user-sidebar {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 32px 24px;
      text-align: center;
      box-sizing: border-box;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    .avatar-upload-box {
      position: relative;
      width: 100px;
      height: 100px;
      margin: 0 auto 16px;
    }

    .avatar-preview {
      width: 100%;
      height: 100%;
      border-radius: 50%;
      border: 2px solid var(--pink-primary);
      object-fit: cover;
      background: var(--pink-subtle);
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
      color: var(--pink-primary);
    }

    .avatar-edit-label {
      position: absolute;
      bottom: 0;
      right: 0;
      width: 30px;
      height: 30px;
      background: var(--pink-primary);
      color: #fff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      border: 2px solid #fff;
      transition: transform 0.2s;
    }
    .avatar-edit-label:hover { transform: scale(1.1); }

    .role-badge {
      display: inline-block;
      font-size: 10px;
      font-weight: 700;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      padding: 4px 12px;
      border-radius: 12px;
      background: var(--pink-light);
      color: var(--pink-primary);
      margin-top: 8px;
    }

    .side-nav {
      margin-top: 28px;
      border-top: 1.5px solid var(--border-soft);
      padding-top: 20px;
      text-align: left;
    }

    .side-link {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 16px;
      font-size: 13px;
      font-weight: 600;
      color: var(--text-chocolate);
      text-decoration: none;
      border: 1.5px solid transparent;
      border-radius: var(--radius-sm);
      margin-bottom: 6px;
      cursor: pointer;
      transition: all 0.2s;
    }

    .side-link.active, .side-link:hover {
      border-color: var(--border-soft);
      background: var(--pink-subtle);
      color: var(--pink-primary);
    }

    .side-link.logout {
      color: #d32f2f;
      margin-top: 16px;
      border-top: 1.5px solid var(--border-soft);
      padding-top: 16px;
    }
    .side-link.logout:hover {
      background: #fff5f5;
      border-color: #f4c2c2;
    }

    /* CARD CỘT PHẢI */
    .profile-content {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 36px 40px;
      box-sizing: border-box;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    .content-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 2px solid var(--pink-primary);
      padding-bottom: 14px;
      margin-bottom: 28px;
    }

    .content-title {
      font-size: 18px;
      font-weight: 800;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin: 0;
      color: var(--text-chocolate);
    }

    .btn-edit-toggle {
      border: 1.5px solid var(--pink-primary);
      background: #fff;
      color: var(--pink-primary);
      padding: 8px 18px;
      font-size: 12px;
      font-weight: 700;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      border-radius: 20px;
      transition: all 0.2s;
    }
    .btn-edit-toggle:hover { 
      background: var(--pink-primary); 
      color: #fff; 
    }

    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .form-group.full-width { grid-column: span 2; }

    .form-label {
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: var(--text-chocolate);
    }

    .form-input, .form-select {
      padding: 10px 14px;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      font-size: 13px;
      font-family: inherit;
      outline: none;
      background: #fff;
      color: var(--text-chocolate);
      transition: border-color 0.2s;
      width: 100%;
      box-sizing: border-box;
    }

    .form-input:read-only, .form-select:disabled {
      background: var(--pink-subtle);
      color: var(--text-muted);
      border-color: var(--border-soft);
      cursor: not-allowed;
    }

    .form-input:focus:not(:read-only), .form-select:focus:not(:disabled) {
      border-color: var(--pink-primary);
      background: #fff;
    }

    .address-select-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
    }

    .action-row {
      margin-top: 32px;
      display: flex;
      justify-content: flex-end;
      gap: 12px;
    }

    .btn-save {
      background: var(--pink-primary);
      color: #fff;
      border: none;
      padding: 10px 24px;
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 0.5px;
      border-radius: 20px;
      cursor: pointer;
      display: none;
      transition: background 0.2s;
      box-shadow: var(--shadow-sm);
    }
    .btn-save:hover { background: var(--pink-dark); }

    .btn-cancel {
      background: #fff;
      color: var(--pink-primary);
      border: 1.5px solid var(--pink-primary);
      padding: 10px 20px;
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 0.5px;
      border-radius: 20px;
      cursor: pointer;
      display: none;
      transition: background 0.2s;
    }
    .btn-cancel:hover { background: var(--pink-light); }

    /* CSS BẢNG ĐƠN HÀNG */
    .order-table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      margin-top: 10px;
    }
    .order-table th {
      background: var(--pink-subtle);
      color: var(--text-chocolate);
      font-size: 12px;
      font-weight: 800;
      text-transform: uppercase;
      padding: 14px 12px;
      border-bottom: 2px solid var(--border-soft);
      text-align: left;
    }
    .order-table td {
      padding: 14px 12px;
      font-size: 13px;
      border-bottom: 1px solid var(--border-soft);
      color: var(--text-chocolate);
    }
    .status-badge {
      display: inline-block;
      padding: 4px 10px;
      border-radius: 12px;
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
    }
    .status-badge.pending { background: #fff3cd; color: #856404; }
    .status-badge.completed { background: #d4edda; color: #155724; }
    .status-badge.cancelled { background: #f8d7da; color: #721c24; }

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
      .profile-grid { grid-template-columns: 1fr; }
      .form-grid { grid-template-columns: 1fr; }
      .form-group.full-width { grid-column: span 1; }
      .address-select-grid { grid-template-columns: 1fr; }
      .main-content { padding: 20px; }
      .profile-content { padding: 24px; }
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
     <a href="feedback" class="ic-btn feedback-link" title="Góp ý">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
        </a>

        <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
        </a>

      <a href="profile.jsp" class="ic-btn" title="Tài khoản cá nhân" style="border-color:var(--pink-primary); color:var(--pink-primary);">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="8" r="4"/>
          <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
        </svg>
      </a>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <main class="main-content">
    
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);">Tài khoản của tôi</strong>
    </div>

    <c:if test="${not empty sessionScope.profileError}">
      <p style="color:#d6526f; font-weight:bold; margin-bottom:16px;"><c:out value="${sessionScope.profileError}"/></p>
      <c:remove var="profileError" scope="session"/>
    </c:if>

    <c:if test="${not empty sessionScope.profileSuccess}">
      <p style="color:var(--pink-primary); font-weight:bold; margin-bottom:16px;"><c:out value="${sessionScope.profileSuccess}"/></p>
      <c:remove var="profileSuccess" scope="session"/>
    </c:if>

    <form action="update-profile" method="POST" id="profile-form">
      
      <div class="profile-grid">
        
        <!-- CỘT TRÁI: AVATAR & NAVIGATION MENU -->
        <aside class="user-sidebar">
          
          <div class="avatar-upload-box">
            <div class="avatar-preview">
              <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                  <img id="avatar-img-preview" src="${sessionScope.account.avatar}" alt="Avatar" style="width:100%; height:100%; object-fit:cover;">
                </c:when>
                <c:otherwise>
                  <svg id="avatar-icon-placeholder" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
                    <circle cx="12" cy="8" r="4"/>
                    <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
                  </svg>
                  <img id="avatar-img-preview" src="" alt="Avatar" style="width:100%; height:100%; object-fit:cover; display:none;">
                </c:otherwise>
              </c:choose>
            </div>

            <!-- Icon tải ảnh đại diện -->
            <label for="avatar-input" class="avatar-edit-label" title="Đổi ảnh đại diện">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>
            </label>
            <input type="file" id="avatar-input" name="avatarFile" accept="image/*" style="display:none;" disabled>
          </div>

          <div style="font-size:16px; font-weight:800; margin-bottom:2px; text-transform:capitalize; color:var(--text-chocolate);">
            ${sessionScope.account.fullName}
          </div>
          <div style="font-size:12px; color:var(--text-muted); margin-bottom:8px;">
            ${sessionScope.account.email}
          </div>

          <span class="role-badge">
            THÀNH VIÊN ${sessionScope.account.role}
          </span>

          <div class="side-nav">
            <div class="side-link active" onclick="switchProfileTab('tab-profile-info', this)">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
              Thông tin tài khoản
            </div>

            <div class="side-link" onclick="switchProfileTab('tab-order-history', this)">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
              Đơn hàng của tôi
            </div>

            <a href="logout" class="side-link logout">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#d32f2f" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
              Đăng xuất
            </a>
          </div>
        </aside>

        <!-- CỘT PHẢI: CONTAINER CHỨA 2 TAB -->
        <section class="profile-content">

          <!-- TAB 1: CHI TIẾT HỒ SƠ -->
          <div id="tab-profile-info" class="tab-profile-pane">
            <div class="content-header">
              <h1 class="content-title">HỒ SƠ CÁ NHÂN</h1>
              <button type="button" class="btn-edit-toggle" id="btn-toggle-edit">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
                Chỉnh sửa
              </button>
            </div>

            <div class="form-grid">
              
              <div class="form-group">
                <label class="form-label">Họ và tên</label>
                <input type="text" name="fullName" class="form-input editable-field" value="${sessionScope.account.fullName}" readonly required>
              </div>

              <div class="form-group">
                <label class="form-label">Địa chỉ Email (Cố định)</label>
                <input type="email" name="email" class="form-input" value="${sessionScope.account.email}" readonly>
              </div>

              <div class="form-group">
                <label class="form-label">Số điện thoại</label>
                <input type="text" name="phoneNumber" class="form-input editable-field" value="${not empty sessionScope.account.phoneNumber ? sessionScope.account.phoneNumber : ''}" placeholder="Chưa cập nhật" readonly>
              </div>

              <div class="form-group">
                <label class="form-label">Vai trò tài khoản</label>
                <input type="text" class="form-input" value="${sessionScope.account.role}" readonly style="text-transform:uppercase;">
              </div>

              <!-- BỘ CHỌN ĐỊA CHỈ HÀNH CHÍNH -->
              <div class="form-group full-width">
                <label class="form-label">Tỉnh / Thành phố — Xã / Phường / Thị trấn</label>
                <div class="address-select-grid">
                  <select id="city" name="city" class="form-select editable-select" disabled>
                    <option value="Đà Nẵng" selected>Đà Nẵng</option>
                  </select>

                  <select id="ward" name="ward" class="form-select editable-select" disabled>
                    <option value="" selected>Chọn Xã / Phường / Thị trấn</option>
                  </select>
                </div>
              </div>

              <div class="form-group full-width">
                <label class="form-label">Địa chỉ chi tiết (Số nhà, tên đường, thôn/xóm)</label>
                <input type="text" name="streetAddress" class="form-input editable-field" value="${not empty sessionScope.account.address ? sessionScope.account.address : ''}" placeholder="Ví dụ: Số 123 Nguyễn Lương Bằng..." readonly>
              </div>

            </div>

            <!-- NÚT LƯU VÀ HỦY -->
            <div class="action-row">
              <button type="button" class="btn-cancel" id="btn-cancel-edit">HỦY BỎ</button>
              <button type="submit" class="btn-save" id="btn-save-profile">LƯU THAY ĐỔI</button>
            </div>
          </div>

          <!-- TAB 2: LỊCH SỬ ĐƠN HÀNG -->
          <div id="tab-order-history" class="tab-profile-pane" style="display: none;">
            <div class="content-header">
              <h1 class="content-title">ĐƠN HÀNG CỦA TÔI</h1>
            </div>

            <c:choose>
              <c:when test="${not empty myOrders}">
                <div style="overflow-x:auto;">
                  <table class="order-table">
                    <thead>
                      <tr>
                        <th>Mã Đơn</th>
                        <th>Ngày Đặt</th>
                        <th>Địa Chỉ Giao Bánh</th>
                        <th>Tổng Tiền</th>
                        <th>Trạng Thái</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach items="${myOrders}" var="o">
                        <tr>
                          <td><strong>#BM${o.id}</strong></td>
                          <td><fmt:formatDate value="${o.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>
                          <td>${o.address}</td>
                          <td><strong><fmt:formatNumber value="${o.totalPrice}" pattern="#,##0"/>đ</strong></td>
                          <td>
                            <c:choose>
                              <c:when test="${o.status == 'Pending' || o.status == 'Chờ xử lý'}">
                                <span class="status-badge pending">Chờ xử lý</span>
                              </c:when>
                              <c:when test="${o.status == 'Completed' || o.status == 'Hoàn thành'}">
                                <span class="status-badge completed">Hoàn thành</span>
                              </c:when>
                              <c:when test="${o.status == 'Cancelled' || o.status == 'Đã hủy'}">
                                <span class="status-badge cancelled">Đã hủy</span>
                              </c:when>
                              <c:otherwise>
                                <span class="status-badge pending">${o.status}</span>
                              </c:otherwise>
                            </c:choose>
                          </td>
                        </tr>
                      </c:forEach>
                    </tbody>
                  </table>
                </div>
              </c:when>

              <c:otherwise>
                <div style="text-align:center; padding:50px 20px; color:var(--text-muted);">
                  <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="margin-bottom:12px; opacity:0.6;"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
                  <div style="font-size:14px; font-weight:600; margin-bottom:12px;">Bạn chưa có đơn hàng nào.</div>
                  <a href="shop" style="display:inline-block; background:var(--pink-primary); color:#fff; padding:8px 20px; border-radius:20px; text-decoration:none; font-size:12px; font-weight:700;">KHÁM PHÁ CỬA HÀNG</a>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

        </section>

      </div>

    </form>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
// HÀM CHUYỂN TAB MƯỢT MÀ
function switchProfileTab(tabId, element) {
  document.querySelectorAll('.tab-profile-pane').forEach(function(pane) {
    pane.style.display = 'none';
  });
  document.querySelectorAll('.side-link').forEach(function(link) {
    link.classList.remove('active');
  });

  var targetPane = document.getElementById(tabId);
  if (targetPane) {
    targetPane.style.display = 'block';
  }
  element.classList.add('active');
}

document.addEventListener("DOMContentLoaded", function () {
  var btnToggle = document.getElementById('btn-toggle-edit');
  var btnCancel = document.getElementById('btn-cancel-edit');
  var btnSave = document.getElementById('btn-save-profile');
  var editableInputs = document.querySelectorAll('.editable-field');
  var editableSelects = document.querySelectorAll('.editable-select');
  var avatarInput = document.getElementById('avatar-input');
  
  var avatarPreview = document.getElementById('avatar-img-preview');
  var avatarPlaceholder = document.getElementById('avatar-icon-placeholder');

  var citis = document.getElementById("city");
  var wards = document.getElementById("ward");

  var isEditing = false;

  if (btnToggle) {
    btnToggle.addEventListener('click', function () {
      isEditing = true;
      updateFormMode();
    });
  }

  if (btnCancel) {
    btnCancel.addEventListener('click', function () {
      isEditing = false;
      updateFormMode();
    });
  }

  function updateFormMode() {
    editableInputs.forEach(function (input) {
      if (isEditing) {
        input.removeAttribute('readonly');
      } else {
        input.setAttribute('readonly', 'readonly');
      }
    });

    editableSelects.forEach(function (select) {
      if (isEditing) {
        select.removeAttribute('disabled');
      } else {
        select.setAttribute('disabled', 'disabled');
      }
    });

    if (avatarInput) {
      if (isEditing) avatarInput.removeAttribute('disabled');
      else avatarInput.setAttribute('disabled', 'disabled');
    }

    if (btnSave) btnSave.style.display = isEditing ? 'inline-block' : 'none';
    if (btnCancel) btnCancel.style.display = isEditing ? 'inline-block' : 'none';
    if (btnToggle) btnToggle.style.display = isEditing ? 'none' : 'inline-flex';
  }

  if (avatarInput) {
    avatarInput.addEventListener('change', function (e) {
      var file = e.target.files[0];
      if (file) {
        var reader = new FileReader();
        reader.onload = function (event) {
          if (avatarPreview) {
            avatarPreview.src = event.target.result;
            avatarPreview.style.display = 'block';
          }
          if (avatarPlaceholder) avatarPlaceholder.style.display = 'none';
        };
        reader.readAsDataURL(file);
      }
    });
  }

  if (citis && wards) {
    // Chỉ phục vụ nội thành Đà Nẵng (mã tỉnh/thành của API là 48).
    function loadDaNangWards() {
      wards.length = 1;
      axios.get('https://esgoo.net/api-tinhthanh/2/48.htm')
          .then(function (resQuan) {
            if (resQuan.data.error === 0) {
              var listQuan = resQuan.data.data;
              listQuan.forEach(function (quan) {
                axios.get('https://esgoo.net/api-tinhthanh/3/' + quan.id + '.htm')
                  .then(function (resXa) {
                    if (resXa.data.error === 0) {
                      resXa.data.data.forEach(function (xa) {
                        wards.options[wards.options.length] = new Option(xa.full_name + " (" + quan.full_name + ")", xa.full_name);
                      });
                    }
                  });
              });
            }
          });
    }
    loadDaNangWards();
  }
});
</script>

</body>
</html>
