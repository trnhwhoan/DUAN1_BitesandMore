<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Bảng điều khiển Admin</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="css/style.css">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
    }

    .admin-wrap {
      display: flex;
      min-height: 100vh;
    }

    /* SIDEBAR */
    .admin-sidebar {
      width: 240px;
      background: #fff;
      border-right: 1px solid #000;
      padding: 24px 0;
      display: flex;
      flex-direction: column;
      flex-shrink: 0;
    }

    .admin-nav-item {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 24px;
      font-size: 14px;
      color: #000;
      text-decoration: none;
      font-weight: 500;
      transition: background 0.2s;
    }

    .admin-nav-item:hover, .admin-nav-item.active {
      background: #000;
      color: #fff;
    }

    .admin-nav-item:hover svg, .admin-nav-item.active svg {
      stroke: #fff;
    }

    /* MAIN CONTENT */
    .admin-main {
      flex: 1;
      padding: 30px;
      overflow-x: hidden;
    }

    /* TOPBAR */
    .admin-topbar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 28px;
      background: #fff;
      padding: 16px 24px;
      border: 1px solid #000;
    }

    /* STAT CARDS */
    .stat-card {
      background: #fff;
      border: 1px solid #000;
      padding: 20px;
    }
    .stat-card .label {
      font-size: 12px;
      color: #666;
      text-transform: uppercase;
      font-weight: bold;
      margin-bottom: 8px;
    }
    .stat-card .value {
      font-size: 22px;
      font-weight: bold;
    }

    /* CHARTS & TABLES */
    .filter-block {
      background: #fff;
      border: 1px solid #000 !important;
      padding: 20px;
    }

    .chart-box {
      background: #fff;
      border: 1px solid #000;
      padding: 20px;
      height: 220px;
      display: flex;
      align-items: flex-end;
      gap: 16px;
      justify-content: space-around;
    }

    .chart-bar {
      width: 40px;
      background: #000;
      transition: height 0.3s ease;
      cursor: pointer;
    }

    .status-tag {
      padding: 4px 8px;
      font-size: 11px;
      font-weight: bold;
      border-radius: 2px;
      display: inline-block;
    }
    .status-pending { background: #fff3cd; color: #856404; border: 1px solid #ffeba2; }
    .status-delivered { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
  </style>
</head>
<body>

<div class="admin-wrap">
  
  <!-- SIDEBAR MENU TRÁI -->
  <div class="admin-sidebar">
    <div class="wf-logo" style="text-align:center;margin:0 20px 30px;font-weight:bold;font-size:18px;">BITES &amp; MORE</div>
    
    <div style="font-size:11px;text-transform:uppercase;color:#777;padding:0 24px;margin-bottom:10px;font-weight:bold;">Danh Mục Chính</div>
    
    <a href="admin-dashboard.jsp" class="admin-nav-item active">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
      Tổng quan
    </a>

    <a href="admin-products.jsp" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M21 8l-9-5-9 5 9 5 9-5z"/><path d="M3 8v8l9 5 9-5V8"/><line x1="12" y1="13" x2="12" y2="21"/></svg>
      Sản phẩm
    </a>

    <a href="admin-orders.jsp" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
      Đơn hàng
    </a>

    <a href="admin-users.jsp" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      Khách hàng
    </a>

    <div style="margin-top:auto;border-top:1px solid #ddd;padding-top:20px;">
      <a href="login.jsp" class="admin-nav-item">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16,17 21,12 16,7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        Đăng xuất
      </a>
    </div>
  </div>

  <!-- PHẦN NỘI DUNG CHÍNH (MAIN CONTENT) -->
  <div class="admin-main">
    
    <!-- TOPBAR ADMIN -->
    <div class="admin-topbar">
      <div>
        <div style="font-size:20px;font-weight:bold;">Tổng Quan Hệ Thống</div>
        <div style="font-size:13px;color:#666;">Xin chào trở lại, Quản trị viên</div>
      </div>
      
      <div style="display:flex;align-items:center;gap:20px;">
        <div class="input" style="display:flex;align-items:center;gap:8px;color:#777;width:240px;padding:8px 12px;border:1px solid #000;background:#fff;">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          <span style="font-size:13px;">Tìm kiếm...</span>
        </div>
        
        <div class="ic-btn" style="cursor:pointer;position:relative;">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,6 12,13 22,6"/></svg>
          <span class="badge" style="position:absolute;top:-5px;right:-8px;background:#000;color:#fff;font-size:10px;padding:2px 5px;border-radius:50%;">5</span>
        </div>

        <div style="display:flex;align-items:center;gap:10px;">
          <div class="img-ph" style="width:36px;height:36px;border-radius:50%;background:#000;color:#fff;display:flex;align-items:center;justify-content:center;font-size:12px;font-weight:bold;">AD</div>
          <span style="font-size:13px;font-weight:bold;">Admin</span>
        </div>
      </div>
    </div>

    <!-- 4 THẺ THỐNG KÊ STAT CARDS -->
    <div class="row" style="margin-bottom:24px;">
      
      <div class="col-3">
        <div class="stat-card">
          <div class="label">Tổng Doanh Thu</div>
          <div class="value">45.800.000đ</div>
        </div>
      </div>

      <div class="col-3">
        <div class="stat-card">
          <div class="label">Tổng Đơn Hàng</div>
          <div class="value">342</div>
        </div>
      </div>

      <div class="col-3">
        <div class="stat-card">
          <div class="label">Khách Hàng</div>
          <div class="value">1,205</div>
        </div>
      </div>

      <div class="col-3">
        <div class="stat-card">
          <div class="label">Sản Phẩm Đã Bán</div>
          <div class="value">890</div>
        </div>
      </div>

    </div>

    <!-- BIỂU ĐỒ DOANH THU & TOP SẢN PHẨM -->
    <div class="row" style="margin-bottom:24px;">
      
      <!-- Biểu đồ Cột bên trái -->
      <div class="col-8">
        <div class="filter-block">
          <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:16px;font-size:15px;font-weight:bold;">Doanh Thu Theo Tháng</h5>
          <div class="chart-box">
            <div class="chart-bar" style="height:40%;" title="Tháng 1: 4.000.000đ"></div>
            <div class="chart-bar" style="height:65%;" title="Tháng 2: 6.500.000đ"></div>
            <div class="chart-bar" style="height:50%;" title="Tháng 3: 5.000.000đ"></div>
            <div class="chart-bar" style="height:85%;" title="Tháng 4: 8.500.000đ"></div>
            <div class="chart-bar" style="height:70%;" title="Tháng 5: 7.000.000đ"></div>
            <div class="chart-bar" style="height:95%;" title="Tháng 6: 9.500.000đ"></div>
          </div>
        </div>
      </div>

      <!-- Top Bánh Bán Chạy -->
      <div class="col-4">
        <div class="filter-block" style="height:100%;box-sizing:border-box;">
          <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:16px;font-size:15px;font-weight:bold;">Sản Phẩm Bán Chạy</h5>
          
          <div style="display:flex;align-items:center;gap:12px;margin-bottom:16px;">
            <div class="img-ph" style="width:44px;height:44px;flex-shrink:0;background:#f5f5f5;">
              <img src="images/5d9fc32d56126074219b204adc604a58.jpg" style="width:100%;height:100%;object-fit:cover;" onError="this.onerror=null;this.src='images/placeholder.jpg';">
            </div>
            <div style="flex:1;">
              <div style="font-size:13px;font-weight:bold;">Bánh mì Sourdough</div>
              <div style="font-size:12px;color:#666;">230 Đã bán — 78.000đ</div>
            </div>
          </div>

          <div style="display:flex;align-items:center;gap:12px;margin-bottom:16px;">
            <div class="img-ph" style="width:44px;height:44px;flex-shrink:0;background:#f5f5f5;">
              <img src="images/91865ec3a35f437be843c7b5b3f0c4e0.jpg" style="width:100%;height:100%;object-fit:cover;" onError="this.onerror=null;this.src='images/placeholder.jpg';">
            </div>
            <div style="flex:1;">
              <div style="font-size:13px;font-weight:bold;">Bánh Red Velvet</div>
              <div style="font-size:12px;color:#666;">185 Đã bán — 390.000đ</div>
            </div>
          </div>

          <div style="display:flex;align-items:center;gap:12px;">
            <div class="img-ph" style="width:44px;height:44px;flex-shrink:0;background:#f5f5f5;">
              <img src="images/47be84309ce929918fadebfd363e9619.webp" style="width:100%;height:100%;object-fit:cover;" onError="this.onerror=null;this.src='images/placeholder.jpg';">
            </div>
            <div style="flex:1;">
              <div style="font-size:13px;font-weight:bold;">Cupcake Socola</div>
              <div style="font-size:12px;color:#666;">140 Đã bán — 30.500đ</div>
            </div>
          </div>

        </div>
      </div>

    </div>

    <!-- BẢNG ĐƠN HÀNG MỚI NHẤT -->
    <div class="filter-block">
      <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:20px;font-size:15px;font-weight:bold;">Đơn Hàng Gần Đây</h5>
      <table style="width:100%;border-collapse:collapse;font-size:14px;">
        <thead>
          <tr style="border-bottom:2px solid #000;text-align:left;">
            <th style="padding:10px;">Mã đơn</th>
            <th style="padding:10px;">Khách hàng</th>
            <th style="padding:10px;">Ngày đặt</th>
            <th style="padding:10px;">Tổng tiền</th>
            <th style="padding:10px;">Trạng thái</th>
            <th style="padding:10px;text-align:center;">Thao tác</th>
          </tr>
        </thead>
        <tbody>
          <tr style="border-bottom:1px solid #eee;">
            <td style="padding:12px 10px;font-weight:bold;">#BM-1042</td>
            <td style="padding:12px 10px;">Nguyễn Văn A</td>
            <td style="padding:12px 10px;">10/08/2026</td>
            <td style="padding:12px 10px;font-weight:bold;">333.500đ</td>
            <td style="padding:12px 10px;"><span class="status-tag status-pending">Đang xử lý</span></td>
            <td style="display:flex;justify-content:center;gap:12px;padding:12px 10px;cursor:pointer;">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" title="Xem chi tiết"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" title="Chỉnh sửa"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            </td>
          </tr>

          <tr style="border-bottom:1px solid #eee;">
            <td style="padding:12px 10px;font-weight:bold;">#BM-1041</td>
            <td style="padding:12px 10px;">Trần Thị B</td>
            <td style="padding:12px 10px;">09/08/2026</td>
            <td style="padding:12px 10px;font-weight:bold;">180.000đ</td>
            <td style="padding:12px 10px;"><span class="status-tag status-delivered">Đã giao hàng</span></td>
            <td style="display:flex;justify-content:center;gap:12px;padding:12px 10px;cursor:pointer;">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" title="Xem chi tiết"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" title="Chỉnh sửa"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>
</div>

<!-- FOOTER -->
<div style="border-top:1px solid #000; padding:16px 0; text-align:center; font-size:13px; color:#000; background:#fff;">
  &copy; Bites &amp; More. since 2026
</div>

<!-- Nhúng file JS -->
<script src="js/app.js"></script>
</body>
</html>