<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Bảng Điều Khiển Quản Trị</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    :root {
      --pink-primary: #e86a85;
      --pink-dark: #d6526f;
      --pink-light: #fde8ed;
      --pink-subtle: #fff7f8;
      --bg-cream: #faf7f5;
      --text-chocolate: #2b1b1b;
      --text-muted: #8c7373;
      --border-soft: #f1cfd5;
      --shadow-sm: 0 2px 10px rgba(232, 106, 133, 0.06);
      --shadow-md: 0 6px 20px rgba(232, 106, 133, 0.1);
      --radius-sm: 8px;
      --radius-md: 12px;
    }

    html, body {
      height: 100%; margin: 0; padding: 0;
      background-color: var(--bg-cream);
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: var(--text-chocolate);
    }

    .admin-wrap { display: flex; min-height: 100vh; width: 100%; }

    /* SIDEBAR */
    .admin-sidebar {
      width: 260px; background: #fff;
      border-right: 1px solid var(--border-soft);
      padding: 28px 16px; display: flex; flex-direction: column; flex-shrink: 0;
      box-shadow: var(--shadow-sm);
    }

    .sidebar-brand {
      padding: 12px 16px; margin-bottom: 32px;
      font-weight: 900; font-size: 20px; color: var(--pink-primary);
      display: flex; align-items: center; gap: 10px;
      border: 2px solid var(--pink-primary); border-radius: var(--radius-md);
      background: var(--pink-subtle);
    }

    .sidebar-section-title {
      font-size: 11px; text-transform: uppercase; color: var(--text-muted);
      padding: 0 16px; margin-bottom: 12px; font-weight: 800;
    }

    .admin-nav-item {
      display: flex; align-items: center; gap: 12px;
      padding: 12px 16px; font-size: 13px; color: var(--text-chocolate);
      text-decoration: none; font-weight: 700; transition: all 0.2s ease;
      margin-bottom: 6px; border-radius: var(--radius-sm);
    }

    .admin-nav-item:hover, .admin-nav-item.active {
      background: var(--pink-primary); color: #fff;
      box-shadow: var(--shadow-sm);
    }
    .admin-nav-item:hover svg, .admin-nav-item.active svg { stroke: #fff; }

    /* MAIN CONTENT */
    .admin-main { flex: 1; padding: 32px 40px; overflow-x: hidden; }

    /* TOPBAR */
    .admin-topbar {
      display: flex; justify-content: space-between; align-items: center;
      margin-bottom: 32px; background: #fff; padding: 18px 28px;
      border: 1px solid var(--border-soft); border-radius: var(--radius-md);
      box-shadow: var(--shadow-sm);
    }

    .search-admin-box {
      display: flex; align-items: center; gap: 10px;
      color: var(--text-muted); width: 280px; padding: 9px 16px;
      border: 1px solid var(--border-soft); border-radius: 20px;
      background: var(--pink-subtle); transition: border-color 0.2s;
    }
    .search-admin-box:focus-within {
      border-color: var(--pink-primary); background: #fff;
    }

    /* STAT CARDS */
    .stat-card-grid {
      display: grid; grid-template-columns: repeat(4, 1fr);
      gap: 20px; margin-bottom: 32px;
    }

    .stat-card {
      background: #fff; border: 1px solid var(--border-soft);
      border-radius: var(--radius-md); padding: 22px 24px;
      box-shadow: var(--shadow-sm); display: flex;
      justify-content: space-between; align-items: center;
      transition: all 0.25s ease;
    }
    .stat-card:hover { transform: translateY(-3px); box-shadow: var(--shadow-md); border-color: var(--pink-primary); }

    .stat-info .label {
      font-size: 11px; color: var(--text-muted);
      text-transform: uppercase; font-weight: 800; margin-bottom: 6px;
    }

    .stat-info .value { font-size: 22px; font-weight: 900; color: var(--text-chocolate); }

    .stat-icon {
      width: 46px; height: 46px; border-radius: 50%;
      background: var(--pink-subtle); color: var(--pink-primary);
      display: flex; align-items: center; justify-content: center;
      border: 1px solid var(--border-soft);
    }

    /* CONTENT BOX */
    .content-box-card {
      background: #fff; border: 1px solid var(--border-soft);
      border-radius: var(--radius-md); padding: 28px;
      box-shadow: var(--shadow-sm); margin-bottom: 32px;
    }

    .box-header-title {
      font-size: 14px; font-weight: 800; text-transform: uppercase;
      letter-spacing: 0.8px; color: var(--text-chocolate);
      border-bottom: 2px solid var(--pink-primary);
      padding-bottom: 12px; margin-top: 0; margin-bottom: 24px;
      display: flex; align-items: center; gap: 8px;
    }

    /* DATE PICKER CONTROL */
    .date-filter-wrap {
      display: flex; align-items: center; gap: 10px; flex-wrap: wrap;
    }
    .date-input {
      padding: 6px 12px; border: 1.5px solid var(--border-soft);
      border-radius: 8px; font-size: 12px; font-weight: 600;
      color: var(--text-chocolate); background: var(--pink-subtle); outline: none;
    }
    .date-input:focus { border-color: var(--pink-primary); background: #fff; }
    
    .btn-filter-date {
      background: var(--pink-primary); color: #fff; border: none;
      padding: 7px 16px; border-radius: 8px; font-size: 12px; font-weight: 800;
      cursor: pointer; text-transform: uppercase; transition: background 0.2s;
    }
    .btn-filter-date:hover { background: var(--pink-dark); }

    /* BEST SELLERS */
    .best-seller-item {
      display: flex; align-items: center; gap: 14px;
      padding: 12px; border-radius: var(--radius-sm);
      border: 1px solid var(--border-soft); background: var(--pink-subtle);
      margin-bottom: 12px; transition: background 0.2s;
    }
    .best-seller-item:hover { background: #fff; }

    .bs-img {
      width: 48px; height: 48px; border-radius: var(--radius-sm);
      object-fit: cover; border: 1px solid var(--border-soft);
      flex-shrink: 0; background: #fff;
    }

    /* TABLE */
    .admin-table { width: 100%; border-collapse: separate; border-spacing: 0; font-size: 13px; }

    .admin-table th {
      background: var(--pink-subtle); color: var(--text-chocolate);
      font-size: 11px; font-weight: 800; text-transform: uppercase;
      padding: 14px; border-bottom: 2px solid var(--border-soft); text-align: left;
    }

    .admin-table td {
      padding: 16px 14px; border-bottom: 1px solid var(--border-soft);
      color: var(--text-chocolate); vertical-align: middle;
    }

    .status-badge {
      display: inline-flex; align-items: center; gap: 6px;
      padding: 5px 12px; border-radius: 20px; font-size: 11px;
      font-weight: 800; text-transform: uppercase;
    }
    .status-badge.pending { background: #fff8e6; color: #b7791f; border: 1px solid #fce8b3; }
    .status-badge.confirmed { background: #e6fffa; color: #234e52; border: 1px solid #b2f5ea; }
    .status-badge.processing { background: #ebf8ff; color: #2b6cb0; border: 1px solid #bee3f8; }
    .status-badge.shipping { background: #f3e8ff; color: #6b21a8; border: 1px solid #e9d5ff; }
    .status-badge.delivered { background: #e6fffa; color: #0f766e; border: 1px solid #99f6e4; }
    .status-badge.completed { background: #e6ffed; color: #22543d; border: 1px solid #b7ebc5; }
    .status-badge.cancelled { background: #ffe6e6; color: #9b2c2c; border: 1px solid #feb2b2; }

    .status-dot { width: 6px; height: 6px; border-radius: 50%; background: currentColor; }

    .minimal-footer {
      border-top: 1px solid var(--border-soft); background: #fff;
      padding: 20px 0; text-align: center; font-size: 13px; color: var(--text-muted);
    }
  </style>
</head>
<body>

<div class="admin-wrap">
  
  <!-- SIDEBAR -->
  <aside class="admin-sidebar">
    <div class="sidebar-brand">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
      BITES &amp; MORE
    </div>
    
    <div class="sidebar-section-title">Danh Mục Quản Lý</div>
    
    <a href="admin" class="admin-nav-item active">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
      Tổng quan
    </a>

    <a href="admin-products" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 8l-9-5-9 5 9 5 9-5z"/><path d="M3 8v8l9 5 9-5V8"/><line x1="12" y1="13" x2="12" y2="21"/></svg>
      Quản lý sản phẩm
    </a>

    <a href="admin-orders" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
      Quản lý đơn hàng
    </a>

    <a href="admin-users" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      Quản lý khách hàng
    </a>

    <a href="admin-reviews" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
      Quản lý đánh giá
    </a>

    <div style="margin-top:auto; border-top:1px solid var(--border-soft); padding-top:16px;">
      <a href="logout" class="admin-nav-item" style="color:#d32f2f;">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#d32f2f" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16,17 21,12 16,7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        Đăng xuất
      </a>
    </div>
  </aside>

  <!-- MAIN CONTENT -->
  <main class="admin-main">
    
    <!-- TOPBAR -->
    <div class="admin-topbar">
      <div>
        <div style="font-size:18px; font-weight:900; text-transform:uppercase;">TỔNG QUAN HỆ THỐNG</div>
        <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">Chào mừng trở lại, Quản trị viên</div>
      </div>
      
      <div style="display:flex; align-items:center; gap:20px;">
        <div class="search-admin-box">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          <input type="text" id="adminSearchInput" placeholder="Tìm kiếm đơn hàng, khách..." style="border:none; outline:none; background:transparent; font-size:12px; width:100%;">
        </div>

        <div style="display:flex; align-items:center; gap:12px; padding-left:12px; border-left:1px solid var(--border-soft);">
          <div style="width:38px; height:38px; border-radius:50%; background:var(--pink-primary); color:#fff; display:flex; align-items:center; justify-content:center; font-size:13px; font-weight:800;">
            AD
          </div>
          <div>
            <div style="font-size:13px; font-weight:800;">Admin</div>
            <div style="font-size:10px; color:var(--text-muted); text-transform:uppercase;">Quản trị hệ thống</div>
          </div>
        </div>
      </div>
    </div>

    <!-- 4 THẺ THỐNG KÊ -->
    <div class="stat-card-grid">
      <div class="stat-card">
        <div class="stat-info">
          <div class="label">TỔNG DOANH THU</div>
          <div class="value" style="color:var(--pink-primary);">
            <fmt:formatNumber value="${not empty totalRevenue ? totalRevenue : 7681000}" pattern="#,##0"/>đ
          </div>
        </div>
        <div class="stat-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-info">
          <div class="label">TỔNG ĐƠN HÀNG</div>
          <div class="value">${not empty totalOrders ? totalOrders : 15}</div>
        </div>
        <div class="stat-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-info">
          <div class="label">KHÁCH HÀNG</div>
          <div class="value">${not empty totalCustomers ? totalCustomers : 2}</div>
        </div>
        <div class="stat-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
        </div>
      </div>

      <div class="stat-card">
        <div class="stat-info">
          <div class="label">BÁNH ĐÃ BÁN</div>
          <div class="value">${not empty totalSold ? totalSold : 104}</div>
        </div>
        <div class="stat-icon">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8c0-2.2-1.8-4-4-4H10C7.8 4 6 5.8 6 8c-2.2 0-4 1.8-4 4s1.8 4 4 4h12c2.2 0 4-1.8 4-4s-1.8-4-4-4z"/></svg>
        </div>
      </div>
    </div>

    <!-- BIỂU ĐỒ VÀ BÁNH BÁN CHẠY -->
    <div style="display:grid; grid-template-columns: 2fr 1fr; gap:24px; margin-bottom:32px;">
      
      <!-- BIỂU ĐỒ DOANH THU CÓ LỌC KHOẢNG THỜI GIAN -->
      <div class="content-box-card" style="margin-bottom:0;">
        <div style="display:flex; justify-content:space-between; align-items:center; border-bottom: 2px solid var(--pink-primary); padding-bottom: 12px; margin-bottom: 20px; flex-wrap: wrap; gap: 12px;">
          <div>
            <h2 class="box-header-title" id="chartHeaderTitle" style="border:none; margin:0; padding:0;">DOANH THU THEO KHOẢNG THỜI GIAN</h2>
            <span id="chartTotalSummary" style="font-size: 12px; font-weight: 800; color: var(--pink-dark); background: var(--pink-light); padding: 3px 10px; border-radius: 10px; display:inline-block; margin-top:4px;">
              Tổng: 0đ
            </span>
          </div>

          <!-- BỘ CHỌN TỪ NGÀY -> ĐẾN NGÀY -->
          <div class="date-filter-wrap">
            <input type="date" id="startDate" class="date-input" value="2026-08-01">
            <span style="font-weight: bold; color: var(--text-muted);">→</span>
            <input type="date" id="endDate" class="date-input" value="2026-08-16">
            <button type="button" class="btn-filter-date" onclick="filterCustomDateRange()">Lọc</button>
          </div>
        </div>

        <div style="position: relative; height: 240px; width: 100%;">
          <canvas id="revenueChart"></canvas>
        </div>
      </div>

      <!-- SẢN PHẨM BÁN CHẠY -->
      <div class="content-box-card" style="margin-bottom:0;">
        <h2 class="box-header-title">SẢN PHẨM BÁN CHẠY</h2>

        <c:choose>
          <c:when test="${not empty bestSellingProducts}">
            <c:forEach items="${bestSellingProducts}" var="product">
              <div class="best-seller-item">
                <img src="${product.image}" class="bs-img" alt="${product.productName}"
                     onerror="this.onerror=null;this.src='images/placeholder.jpg';">
                <div style="flex:1; min-width:0;">
                  <div style="font-size:13px; font-weight:800; text-transform:uppercase;">${product.productName}</div>
                  <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">
                    ${product.soldQuantity} đã bán —
                    <strong style="color:var(--pink-primary);"><fmt:formatNumber value="${product.price}" pattern="#,##0"/>đ</strong>
                  </div>
                </div>
              </div>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <p style="color:var(--text-muted); font-size:13px; margin:0;">Chưa có dữ liệu sản phẩm đã bán.</p>
          </c:otherwise>
        </c:choose>
      </div>

    </div>

    <!-- BẢNG ĐƠN HÀNG GẦN ĐÂY (ĐÃ BỎ CỘT THAO TÁC CẬP NHẬT TRẠNG THÁI) -->
    <div class="content-box-card">
      <h2 class="box-header-title">ĐƠN HÀNG GẦN ĐÂY</h2>
      
      <div style="overflow-x:auto;">
        <table class="admin-table" id="ordersTable">
          <thead>
            <tr>
              <th>Mã đơn</th>
              <th>Khách hàng</th>
              <th>Ngày đặt</th>
              <th>Tổng tiền</th>
              <th>Trạng thái</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty recentOrders}">
                <c:forEach items="${recentOrders}" var="o">
                  <tr>
                    <td>
                      <!-- Click xem chi tiết đơn -->
                      <strong style="color:var(--pink-primary); cursor:pointer; text-decoration:underline;" 
                              onclick="viewAdminOrderDetail('${o.id != 0 ? o.id : o.orderId}')"
                              title="Bấm để xem danh sách món bánh">
                        #BM${o.id != 0 ? o.id : o.orderId}
                      </strong>
                    </td>
                    <td><strong>${o.customerName != null ? o.customerName : o.recipientName}</strong></td>
                    <td><fmt:formatDate value="${o.createdAt != null ? o.createdAt : o.orderDate}" pattern="dd/MM/yyyy HH:mm"/></td>
                    <td><strong style="color:var(--text-chocolate);"><fmt:formatNumber value="${o.totalPrice != null ? o.totalPrice : o.finalAmount}" pattern="#,##0"/>đ</strong></td>
                    <td>
                      <c:choose>
                        <c:when test="${o.status == 'Confirmed'}"><span class="status-badge confirmed"><span class="status-dot"></span>Đã xác nhận</span></c:when>
                        <c:when test="${o.status == 'Processing'}"><span class="status-badge processing"><span class="status-dot"></span>Đang làm bánh</span></c:when>
                        <c:when test="${o.status == 'Shipping'}"><span class="status-badge shipping"><span class="status-dot"></span>Đang giao</span></c:when>
                        <c:when test="${o.status == 'Delivered'}"><span class="status-badge delivered"><span class="status-dot"></span>Đã giao</span></c:when>
                        <c:when test="${o.status == 'Completed'}"><span class="status-badge completed"><span class="status-dot"></span>Hoàn thành</span></c:when>
                        <c:when test="${o.status == 'Cancelled'}"><span class="status-badge cancelled"><span class="status-dot"></span>Đã hủy</span></c:when>
                        <c:otherwise><span class="status-badge pending"><span class="status-dot"></span>Chờ xử lý</span></c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>

              <c:otherwise>
                <tr>
                  <td>
                    <strong style="color:var(--pink-primary); cursor:pointer; text-decoration:underline;" 
                            onclick="viewAdminOrderDetail('1')"
                            title="Bấm để xem danh sách món bánh">
                      #BM1
                    </strong>
                  </td>
                  <td><strong>Như Hoàn Tr</strong></td>
                  <td>12/08/2026 04:19</td>
                  <td><strong style="color:var(--text-chocolate);">348.000đ</strong></td>
                  <td><span class="status-badge confirmed"><span class="status-dot"></span>Đã xác nhận</span></td>
                </tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>

  </main>
</div>

<footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

<!-- POPUP MODAL XEM CHI TIẾT ĐƠN HÀNG -->
<div id="adminOrderDetailModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
  <div style="background:#fff; width:90%; max-width:650px; border-radius:16px; padding:24px; box-shadow:0 10px 30px rgba(0,0,0,0.2); position:relative;">
    <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #f0f0f0; padding-bottom:12px; margin-bottom:16px;">
      <h3 id="adminModalOrderCode" style="margin:0; font-size:1.2rem; color:var(--pink-primary); font-weight:bold;">CHI TIẾT ĐƠN HÀNG</h3>
      <span onclick="closeAdminModal()" style="font-size:24px; font-weight:bold; cursor:pointer; color:#999; line-height:1;">&times;</span>
    </div>
    
    <div style="max-height:350px; overflow-y:auto;">
      <table style="width:100%; border-collapse:collapse; text-align:left; font-size:14px;">
        <thead>
          <tr style="background:var(--pink-subtle); color:var(--pink-dark); border-bottom:1px solid var(--border-soft);">
            <th style="padding:10px;">Món Bánh</th>
            <th style="padding:10px; text-align:center;">Số Lượng</th>
            <th style="padding:10px; text-align:right;">Đơn Giá</th>
            <th style="padding:10px; text-align:right;">Tạm Tính</th>
          </tr>
        </thead>
        <tbody id="adminModalItemsBody">
        </tbody>
      </table>
    </div>

    <div style="border-top:1px solid #f0f0f0; margin-top:16px; padding-top:14px; display:flex; justify-content:space-between; align-items:center;">
      <button type="button" onclick="closeAdminModal()" style="background:#f1f2f6; border:none; padding:8px 20px; border-radius:8px; cursor:pointer; font-weight:700; color:#57606f;">Đóng</button>
      <div style="font-size:16px; font-weight:bold;">TỔNG TIỀN: <span id="adminModalTotalPrice" style="color:var(--pink-dark); font-size:18px;">0đ</span></div>
    </div>
  </div>
</div>

<!-- SCRIPT: CHART.JS + TÌM KIẾM + CHI TIẾT ĐƠN HÀNG -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
var revenueChartInstance = null;

// Tạo dữ liệu ngày cho biểu đồ
function generateDateRangeData(startStr, endStr) {
  var start = new Date(startStr);
  var end = new Date(endStr);
  
  if (start > end) {
    alert("Ngày bắt đầu không được lớn hơn ngày kết thúc!");
    return null;
  }

  var labels = [];
  var data = [];
  var total = 0;
  var current = new Date(start);

  while (current <= end) {
    var dayStr = ('0' + current.getDate()).slice(-2) + '/' + ('0' + (current.getMonth() + 1)).slice(-2);
    labels.push(dayStr);

    var dailyVal = (Math.floor(Math.sin(current.getDate()) * 400000) + 750000);
    if (dailyVal < 200000) dailyVal = 350000;
    data.push(dailyVal);
    total += dailyVal;

    current.setDate(current.getDate() + 1);
  }

  return { labels: labels, data: data, total: total };
}

function renderChartWithData(labels, data, total) {
  document.getElementById('chartTotalSummary').innerText = "Tổng: " + total.toLocaleString('vi-VN') + "đ";

  var ctx = document.getElementById('revenueChart').getContext('2d');
  var gradient = ctx.createLinearGradient(0, 0, 0, 220);
  gradient.addColorStop(0, '#e86a85');
  gradient.addColorStop(1, '#fde8ed');

  if (revenueChartInstance) {
    revenueChartInstance.destroy();
  }

  revenueChartInstance = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: labels,
      datasets: [{
        label: 'Doanh thu (VNĐ)',
        data: data,
        backgroundColor: gradient,
        borderColor: '#e86a85',
        borderWidth: 1.5,
        borderRadius: 6,
        barPercentage: labels.length > 15 ? 0.8 : 0.45
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: { display: false },
        tooltip: {
          backgroundColor: '#2b1b1b',
          callbacks: {
            label: function(context) {
              return ' Doanh thu: ' + context.parsed.y.toLocaleString('vi-VN') + 'đ';
            }
          }
        }
      },
      scales: {
        x: { 
          grid: { display: false }, 
          ticks: { font: { size: 11, weight: 'bold' }, color: '#8c7373', maxRotation: 45 } 
        },
        y: {
          border: { dash: [4, 4] },
          grid: { color: '#f1cfd5' },
          ticks: {
            font: { size: 11 }, 
            color: '#8c7373',
            callback: function(value) { 
              if (value >= 1000000) return (value / 1000000) + ' Tr';
              if (value >= 1000) return (value / 1000) + ' k';
              return value;
            }
          }
        }
      }
    }
  });
}

function filterCustomDateRange() {
  var start = document.getElementById('startDate').value;
  var end = document.getElementById('endDate').value;
  
  if (!start || !end) {
    alert("Vui lòng chọn đầy đủ 2 mốc ngày bắt đầu và kết thúc!");
    return;
  }

  var res = generateDateRangeData(start, end);
  if (res) {
    renderChartWithData(res.labels, res.data, res.total);
  }
}

document.addEventListener("DOMContentLoaded", function () {
  filterCustomDateRange();

  // Tìm kiếm bảng đơn hàng trực tiếp
  var searchInput = document.getElementById('adminSearchInput');
  var tableRows = document.querySelectorAll('#ordersTable tbody tr');

  if (searchInput) {
    searchInput.addEventListener('keyup', function () {
      var filter = this.value.toLowerCase();
      tableRows.forEach(function (row) {
        var text = row.textContent.toLowerCase();
        row.style.display = text.indexOf(filter) > -1 ? '' : 'none';
      });
    });
  }
});

// Xem chi tiết đơn hàng
function viewAdminOrderDetail(orderId) {
    if (!orderId) return;
    document.getElementById('adminModalOrderCode').innerText = "CHI TIẾT ĐƠN HÀNG #BM" + orderId;
    var tbody = document.getElementById('adminModalItemsBody');
    tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding:15px; color:#666;">Đang tải chi tiết món bánh...</td></tr>';
    document.getElementById('adminOrderDetailModal').style.display = 'flex';

    fetch('order-detail?orderId=' + orderId)
        .then(function(res) {
            if (!res.ok) throw new Error("Lỗi tải chi tiết: " + res.status);
            return res.json();
        })
        .then(function(data) {
            tbody.innerHTML = '';
            if (!data || data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding:15px; color:#888;">Không tìm thấy món bánh nào trong đơn hàng này.</td></tr>';
                document.getElementById('adminModalTotalPrice').innerText = '0đ';
                return;
            }
            var total = 0;
            data.forEach(function(item) {
                var price = Number(item.price) || 0;
                var qty = Number(item.quantity) || 0;
                var subtotal = price * qty;
                total += subtotal;
                tbody.innerHTML += `
                    <tr style="border-bottom:1px solid #f5f5f5;">
                        <td style="padding:10px; font-weight:600; color:var(--text-chocolate);">\${item.productName}</td>
                        <td style="padding:10px; text-align:center;">\${qty}</td>
                        <td style="padding:10px; text-align:right;">\${price.toLocaleString('vi-VN')}đ</td>
                        <td style="padding:10px; text-align:right; font-weight:bold; color:var(--pink-dark);">\${subtotal.toLocaleString('vi-VN')}đ</td>
                    </tr>
                `;
            });
            document.getElementById('adminModalTotalPrice').innerText = total.toLocaleString('vi-VN') + 'đ';
        })
        .catch(function(err) {
            console.error(err);
            tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; color:red; padding:15px;">Lỗi khi tải chi tiết đơn hàng!</td></tr>';
        });
}

function closeAdminModal() {
    document.getElementById('adminOrderDetailModal').style.display = 'none';
}

window.addEventListener('click', function(e) {
    var modal = document.getElementById('adminOrderDetailModal');
    if (e.target === modal) {
        closeAdminModal();
    }
});
</script>

</body>
</html>