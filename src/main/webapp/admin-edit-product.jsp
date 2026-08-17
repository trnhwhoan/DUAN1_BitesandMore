<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Sửa Sản Phẩm</title>
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

    .admin-main { flex: 1; padding: 32px 40px; }

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

    .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    .form-group { display: flex; flex-direction: column; gap: 8px; margin-bottom: 18px; }
    .form-group.full-width { grid-column: span 2; }
    .form-label { font-size: 13px; font-weight: 800; text-transform: uppercase; color: var(--text-chocolate); }
    
    .form-control {
      padding: 12px 16px; border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm); font-size: 14px; outline: none; background: #fff;
    }
    .form-control:focus { border-color: var(--pink-primary); }
    textarea.form-control { min-height: 100px; resize: vertical; }

    .category-radio-label {
      display: flex; align-items: center; gap: 10px; padding: 12px 14px;
      border: 1.5px solid var(--border-soft); border-radius: var(--radius-sm);
      background: #fff; cursor: pointer; transition: all 0.2s;
    }
    .category-radio-label:hover {
      border-color: var(--pink-primary);
      background: var(--pink-subtle);
    }
    .category-radio-label input[type="radio"]:checked + .category-icon + span {
      color: var(--pink-primary);
    }

    .btn-group { display: flex; justify-content: flex-end; gap: 12px; margin-top: 24px; }
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
  </style>
</head>
<body>

<div class="admin-wrap">
  <aside class="admin-sidebar">
    <div class="sidebar-brand">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
      BITES &amp; MORE
    </div>
    <div class="sidebar-section-title">Danh Mục Quản Lý</div>
    <a href="admin" class="admin-nav-item">Tổng quan</a>
    <a href="admin-products" class="admin-nav-item active">Quản lý sản phẩm</a>
    <a href="admin-orders" class="admin-nav-item">Quản lý đơn hàng</a>
    <a href="admin-users" class="admin-nav-item">Quản lý khách hàng</a>
    <a href="admin-reviews" class="admin-nav-item">Quản lý đánh giá</a>
  </aside>

  <main class="admin-main">
    <div class="admin-topbar">
      <div>
        <div style="font-size:18px; font-weight:900; text-transform:uppercase;">
          CHỈNH SỬA SẢN PHẨM #${product.id != 0 ? product.id : product.productId}
        </div>
        <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">Cập nhật thông tin chi tiết món bánh</div>
      </div>
      <a href="admin-products" class="btn-back">← Quay lại danh sách</a>
    </div>

    <div class="content-box-card">
      <form action="edit-product" method="POST">
        <!-- ID sản phẩm ẩn -->
        <input type="hidden" name="productId" value="${product.id != 0 ? product.id : product.productId}">

        <div class="form-grid">
          <!-- Tên món bánh -->
          <div class="form-group full-width">
            <label class="form-label">Tên món bánh *</label>
            <input type="text" name="productName" value="${product.productName != null ? product.productName : product.name}" class="form-control" required>
          </div>

          <!-- DANH MỤC DẠNG ICON THEO YÊU CẦU -->
          <div class="form-group full-width">
            <label class="form-label">Danh mục sản phẩm *</label>
            <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(220px, 1fr)); gap: 12px; margin-top: 6px;">
              
              <label class="category-radio-label">
                <input type="radio" name="categoryId" value="4" ${product.categoryId == 4 ? 'checked' : ''} style="accent-color: var(--pink-primary); width: 16px; height: 16px;" required>
                <span class="category-icon" style="font-size: 18px;">🥖</span>
                <span style="font-size: 13px; font-weight: 700; color: var(--text-chocolate);">Bánh mì (Bread)</span>
              </label>

              <label class="category-radio-label">
                <input type="radio" name="categoryId" value="3" ${product.categoryId == 3 ? 'checked' : ''} style="accent-color: var(--pink-primary); width: 16px; height: 16px;">
                <span class="category-icon" style="font-size: 18px;">🍰</span>
                <span style="font-size: 13px; font-weight: 700; color: var(--text-chocolate);">Bánh kem (Cakes)</span>
              </label>

              <label class="category-radio-label">
                <input type="radio" name="categoryId" value="1" ${product.categoryId == 1 ? 'checked' : ''} style="accent-color: var(--pink-primary); width: 16px; height: 16px;">
                <span class="category-icon" style="font-size: 18px;">🥐</span>
                <span style="font-size: 13px; font-weight: 700; color: var(--text-chocolate);">Ngọt Bơ &amp; Ngàn Lớp</span>
              </label>

              <label class="category-radio-label">
                <input type="radio" name="categoryId" value="5" ${product.categoryId == 5 ? 'checked' : ''} style="accent-color: var(--pink-primary); width: 16px; height: 16px;">
                <span class="category-icon" style="font-size: 18px;">🍪</span>
                <span style="font-size: 13px; font-weight: 700; color: var(--text-chocolate);">Bánh quy (Cookie)</span>
              </label>

              <label class="category-radio-label">
                <input type="radio" name="categoryId" value="6" ${product.categoryId == 6 ? 'checked' : ''} style="accent-color: var(--pink-primary); width: 16px; height: 16px;">
                <span class="category-icon" style="font-size: 18px;">🍩</span>
                <span style="font-size: 13px; font-weight: 700; color: var(--text-chocolate);">Bánh Donuts</span>
              </label>

              <label class="category-radio-label">
                <input type="radio" name="categoryId" value="7" ${product.categoryId == 7 ? 'checked' : ''} style="accent-color: var(--pink-primary); width: 16px; height: 16px;">
                <span class="category-icon" style="font-size: 18px;">🧁</span>
                <span style="font-size: 13px; font-weight: 700; color: var(--text-chocolate);">Bánh Cupcake</span>
              </label>

            </div>
          </div>

          <!-- Giá bán -->
          <div class="form-group">
            <label class="form-label">Giá bán (VNĐ) *</label>
            <input type="number" name="price" value="${product.price}" class="form-control" min="0" required>
          </div>

          <!-- Số lượng tồn kho -->
          <div class="form-group">
            <label class="form-label">Số lượng tồn kho *</label>
            <input type="number" name="quantity" value="${product.quantity}" class="form-control" min="0" required>
          </div>

          <!-- Trạng thái kinh doanh -->
          <div class="form-group full-width">
            <label class="form-label">Trạng thái kinh doanh *</label>
            <select name="status" class="form-control">
              <option value="Active" ${product.status == 'Active' ? 'selected' : ''}>Đang bán (Active)</option>
              <option value="Inactive" ${product.status == 'Inactive' ? 'selected' : ''}>Tạm ngưng (Inactive)</option>
            </select>
          </div>

          <!-- Đường dẫn hình ảnh -->
          <div class="form-group full-width">
            <label class="form-label">Đường dẫn hình ảnh (URL/Path) *</label>
            <input type="text" name="imageUrl" value="${product.imageUrl != null ? product.imageUrl : product.image}" class="form-control" required>
          </div>

          <!-- Mô tả sản phẩm -->
          <div class="form-group full-width">
            <label class="form-label">Mô tả sản phẩm</label>
            <textarea name="description" class="form-control">${product.description}</textarea>
          </div>
        </div>

        <div class="btn-group">
          <a href="admin-products" class="btn-back">Hủy bỏ</a>
          <button type="submit" class="btn-submit">CẬP NHẬT BÁNH</button>
        </div>
      </form>
    </div>
  </main>
</div>

</body>
</html>