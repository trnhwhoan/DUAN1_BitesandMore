<!DOCTYPE html>
<html lang="vie">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Admin Dashboard</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="CSS/style.css">
</head>
<body>

<div class="admin-wrap">
  
  <!-- SIDEBAR MENU TRÁI -->
  <div class="admin-sidebar">
    <div class="wf-logo" style="text-align:center;margin:0 20px 30px;">BITES &amp; MORE</div>
    
    <div style="font-size:11px;text-transform:uppercase;color:#777;padding:0 24px;margin-bottom:10px;font-weight:bold;">Main Menu</div>
    
    <a href="admin-dashboard.jsp" class="admin-nav-item active">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
      Dashboard
    </a>

    <a href="admin-products.jsp" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M21 8l-9-5-9 5 9 5 9-5z"/><path d="M3 8v8l9 5 9-5V8"/><line x1="12" y1="13" x2="12" y2="21"/></svg>
      Products
    </a>

    <a href="admin-orders.jsp" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
      Orders
    </a>

    <a href="admin-users.jsp" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      Customers
    </a>

    <div style="margin-top:auto;border-top:1px solid #000;padding-top:20px;">
      <a href="login.jsp" class="admin-nav-item">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16,17 21,12 16,7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        Log Out
      </a>
    </div>
  </div>

  <!-- PHẦN NỘI DUNG CHÍNH (MAIN CONTENT) -->
  <div class="admin-main">
    
    <!-- TOPBAR ADMIN -->
    <div class="admin-topbar">
      <div>
        <div style="font-size:22px;font-weight:bold;">Dashboard Overview</div>
        <div style="font-size:13px;color:#666;">Welcome back, Admin</div>
      </div>
      
      <div style="display:flex;align-items:center;gap:20px;">
        <div class="input" style="display:flex;align-items:center;gap:8px;color:#777;width:240px;padding:8px 12px;">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
          Search...
        </div>
        
        <div class="ic-btn" style="cursor:pointer;">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,6 12,13 22,6"/></svg>
          <span class="badge">5</span>
        </div>

        <div style="display:flex;align-items:center;gap:10px;">
          <div class="img-ph" style="width:40px;height:40px;border-radius:50%;">Img</div>
          <span style="font-size:13px;font-weight:bold;">Admin</span>
        </div>
      </div>
    </div>

    <!-- 4 THẺ THỐNG KÊ STAT CARDS -->
    <div class="row" style="margin-bottom:24px;">
      
      <div class="col-3">
        <div class="stat-card">
          <div class="label">Total Revenue</div>
          <div class="value">400.000VND</div>
        </div>
      </div>

      <div class="col-3">
        <div class="stat-card">
          <div class="label">Total Orders</div>
          <div class="value">342</div>
        </div>
      </div>

      <div class="col-3">
        <div class="stat-card">
          <div class="label">Total Customers</div>
          <div class="value">1,205</div>
        </div>
      </div>

      <div class="col-3">
        <div class="stat-card">
          <div class="label">Products Sold</div>
          <div class="value">890</div>
        </div>
      </div>

    </div>

    <!-- BẢO BIỂU ĐỒ DOANH THU & TOP SẢN PHẨM -->
    <div class="row" style="margin-bottom:24px;">
      
      <!-- Chart Cột bên trái -->
      <div class="col-8">
        <div class="chart-box">
          <div class="chart-bar" style="height:40%;" title="Jan: 40.000VND"></div>
          <div class="chart-bar" style="height:65%;" title="Feb: 65.000VND"></div>
          <div class="chart-bar" style="height:50%;" title="Mar: 50.000VND"></div>
          <div class="chart-bar" style="height:85%;" title="Apr: 85.000VND"></div>
          <div class="chart-bar" style="height:70%;" title="May: 70.000VND"></div>
          <div class="chart-bar" style="height:95%;" title="Jun: 95.000VND"></div>
        </div>
        <div style="text-align:center;font-size:12px;color:#666;margin-top:10px;">Revenue Chart (Monthly)</div>
      </div>

      <!-- Top Bánh Bán Chạy -->
      <div class="col-4">
        <div class="filter-block" style="height:320px;overflow-y:auto;">
          <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:16px;">Top Products</h5>
          
          <div style="display:flex;align-items:center;gap:12px;margin-bottom:16px;">
            <div class="img-ph" style="width:44px;height:44px;flex-shrink:0;">Img</div>
            <div style="flex:1;">
              <div style="font-size:13px;font-weight:bold;">Sourdough Bread</div>
              <div style="font-size:12px;color:#666;">230 Sold — 60.000VND</div>
            </div>
          </div>

          <div style="display:flex;align-items:center;gap:12px;margin-bottom:16px;">
            <div class="img-ph" style="width:44px;height:44px;flex-shrink:0;">Img</div>
            <div style="flex:1;">
              <div style="font-size:13px;font-weight:bold;">Red Velvet Cake</div>
              <div style="font-size:12px;color:#666;">185 Sold — 180.000VND</div>
            </div>
          </div>

          <div style="display:flex;align-items:center;gap:12px;margin-bottom:16px;">
            <div class="img-ph" style="width:44px;height:44px;flex-shrink:0;">Img</div>
            <div style="flex:1;">
              <div style="font-size:13px;font-weight:bold;">Chocolate Cupcake</div>
              <div style="font-size:12px;color:#666;">140 Sold — 30.500VND</div>
            </div>
          </div>

        </div>
      </div>

    </div>

    <!-- BẢNG ĐƠN HÀNG MỚI NHẤT -->
    <div class="filter-block">
      <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:20px;">Latest Orders</h5>
      <table style="width:100%;border-collapse:collapse;font-size:14px;">
        <thead>
          <tr style="border-bottom:2px solid #000;text-align:left;">
            <th style="padding:10px;">Order ID</th>
            <th style="padding:10px;">Customer</th>
            <th style="padding:10px;">Date</th>
            <th style="padding:10px;">Amount</th>
            <th style="padding:10px;">Status</th>
            <th style="padding:10px;">Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr style="border-bottom:1px solid #ccc;">
            <td style="padding:12px 10px;font-weight:bold;">#BM-1042</td>
            <td style="padding:12px 10px;">John Doe</td>
            <td style="padding:12px 10px;">Jul 22, 2026</td>
            <td style="padding:12px 10px;font-weight:bold;">32.500VND</td>
            <td style="padding:12px 10px;"><span class="tag">Pending</span></td>
            <td style="display:flex;gap:10px;padding:12px 10px;cursor:pointer;">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            </td>
          </tr>

          <tr style="border-bottom:1px solid #ccc;">
            <td style="padding:12px 10px;font-weight:bold;">#BM-1041</td>
            <td style="padding:12px 10px;">Jane Smith</td>
            <td style="padding:12px 10px;">Jul 21, 2026</td>
            <td style="padding:12px 10px;font-weight:bold;">18.000VND</td>
            <td style="padding:12px 10px;"><span class="tag">Delivered</span></td>
            <td style="display:flex;gap:10px;padding:12px 10px;cursor:pointer;">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>
</div>

<!-- Nhúng file JS -->
<script src="js/app.js"></script>
</body>
</html>