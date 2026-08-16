<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Thêm Bánh Mới</title>
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
      --radius-sm: 8px;
      --radius-md: 12px;
    }

    html, body {
      min-height: 100%; margin: 0; padding: 0;
      background-color: var(--bg-cream);
      font-family: system-ui, -apple-system, sans-serif;
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
    }
    .admin-nav-item:hover svg, .admin-nav-item.active svg { stroke: #fff; }

    /* MAIN */
    .admin-main { flex: 1; padding: 32px 40px; overflow-x: hidden; }

    .admin-topbar {
      display: flex; justify-content: space-between; align-items: center;
      margin-bottom: 28px; background: #fff; padding: 18px 28px;
      border: 1px solid var(--border-soft); border-radius: var(--radius-md);
      box-shadow: var(--shadow-sm);
    }

    .content-box-card {
      background: #fff; border: 1px solid var(--border-soft);
      border-radius: var(--radius-md); padding: 32px;
      box-shadow: var(--shadow-sm); max-width: 800px; margin: 0 auto;
    }

    .form-grid {
      display: grid; grid-template-columns: 1fr 1fr; gap: 20px;
    }

    .form-group {
      display: flex; flex-direction: column; gap: 8px; margin-bottom: 18px;
    }

    .form-group.full-width { grid-column: span 2; }

    .form-label {
      font-size: 13px; font-weight: 800; text-transform: uppercase; color: var(--text-chocolate);
    }

    .form-control {
      padding: 12px 16px; border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm); font-size: 14px; font-family: inherit;
      outline: none; transition: border-color 0.2s; background: #fff;
    }

    .form-control:focus {
      border-color: var(--pink-primary);
    }

    textarea.form-control {
      resize: vertical; min-height: 100px;
    }

    .btn-group {
      display: flex; justify-content: flex-end; gap: 12px; margin-top: 24px;
    }

    .btn-submit {
      background: var(--pink-primary); color: #fff; border: none;
      padding: 12px 28px; border-radius: var(--radius-sm); font-size: 13px;
      font-weight: 800; text-transform: uppercase; cursor: pointer; transition: background 0.2s;
    }

    .btn-submit:hover { background: var(--pink-dark); }

    .btn-back {
      background: #f1f2f6; color: #57606f; border: none;
      padding: 12px 24px; border-radius: var(--radius-sm); font-size: 13px;
      font-weight: 700; text-decoration: none; display: inline-flex; align-items: center;
    }

    .alert-error {
      background: #ffe6e6; color: #d32f2f; border: 1px solid #feb2b2;
      padding: 12px 16px; border-radius: var(--radius-sm); margin-bottom: 20px; font-size: 13px; font-weight: 600;
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
    
    <a href="admin" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
      Tổng quan
    </a>

    <a href="admin-products" class="admin-nav-item active">
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

  <!-- MAIN -->
  <main class="admin-main">
    
    <div class="admin-topbar">
      <div>
        <div style="font-size:18px; font-weight:900; text-transform:uppercase;">THÊM BÁNH MỚI</div>
        <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">Bổ sung sản phẩm mới vào thực đơn của cửa hàng</div>
      </div>
      <a href="admin-products" class="btn-back">← Quay lại danh sách</a>
    </div>

    <div class="content-box-card">
      
      <c:if test="${not empty error}">
        <div class="alert-error">${error}</div>
      </c:if>

      <form action="admin-products" method="POST">
        <input type="hidden" name="action" value="add">

        <div class="form-grid">
          
          <div class="form-group full-width">
            <label class="form-label" for="productName">Tên món bánh *</label>
            <input type="text" id="productName" name="productName" class="form-control" placeholder="Ví dụ: Bánh Mousse Dâu Tây" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="categoryId">Danh mục *</label>
            <select id="categoryId" name="categoryId" class="form-control" required>
              <option value="1">Bánh Ngọt</option>
              <option value="2">Bánh Mặn</option>
              <option value="3">Bánh Kem</option>
              <option value="4">Bánh Mì Tươi</option>
            </select>
          </div>

          <div class="form-group">
            <label class="form-label" for="price">Giá bán (VNĐ) *</label>
            <input type="number" id="price" name="price" class="form-control" placeholder="Ví dụ: 45000" min="0" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="quantity">Số lượng tồn kho *</label>
            <input type="number" id="quantity" name="quantity" class="form-control" placeholder="Ví dụ: 50" min="0" required>
          </div>

          <div class="form-group">
            <label class="form-label" for="status">Trạng thái kinh doanh *</label>
            <select id="status" name="status" class="form-control">
              <option value="Active">Đang bán (Active)</option>
              <option value="Inactive">Tạm ngưng (Inactive)</option>
            </select>
          </div>

          <div class="form-group full-width">
            <label class="form-label" for="imageUrl">Đường dẫn hình ảnh (URL/Path) *</label>
            <input type="text" id="imageUrl" name="imageUrl" class="form-control" placeholder="Ví dụ: images/strawberry-cake.jpg" required>
          </div>

          <div class="form-group full-width">
            <label class="form-label" for="description">Mô tả sản phẩm</label>
            <textarea id="description" name="description" class="form-control" placeholder="Mô tả hương vị, nguyên liệu, quy cách đóng gói..."></textarea>
          </div>

        </div>

        <div class="btn-group">
          <a href="admin-products" class="btn-back">Hủy bỏ</a>
          <button type="submit" class="btn-submit">Lưu Sản Phẩm</button>
        </div>
      </form>
    </div>

  </main>
</div>

</body>
</html>