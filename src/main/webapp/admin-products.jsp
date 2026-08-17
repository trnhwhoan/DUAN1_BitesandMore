<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Quản Lý Sản Phẩm</title>
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
      height: 100%; margin: 0; padding: 0;
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

    .btn-add-new {
      background: var(--pink-primary); color: #fff;
      padding: 10px 20px; border-radius: 20px; text-decoration: none;
      font-size: 12px; font-weight: 800; text-transform: uppercase;
      display: inline-flex; align-items: center; gap: 8px;
      transition: background 0.2s;
    }
    .btn-add-new:hover { background: var(--pink-dark); }

    .content-box-card {
      background: #fff; border: 1px solid var(--border-soft);
      border-radius: var(--radius-md); padding: 28px;
      box-shadow: var(--shadow-sm);
    }

    .admin-table { width: 100%; border-collapse: separate; border-spacing: 0; font-size: 13px; }
    .admin-table th {
      background: var(--pink-subtle); color: var(--text-chocolate);
      font-size: 11px; font-weight: 800; text-transform: uppercase;
      padding: 14px; border-bottom: 2px solid var(--border-soft); text-align: left;
    }
    .admin-table td { padding: 14px; border-bottom: 1px solid var(--border-soft); vertical-align: middle; }

    .p-thumb { width: 48px; height: 48px; border-radius: 8px; object-fit: cover; border: 1px solid var(--border-soft); }

    .btn-action-icon {
      width: 34px; height: 34px; border-radius: 50%; border: 1px solid var(--border-soft);
      background: #fff; display: inline-flex; align-items: center; justify-content: center;
      color: var(--text-chocolate); text-decoration: none; transition: all 0.2s ease;
    }
    .btn-action-icon:hover { background: var(--pink-subtle); color: var(--pink-primary); border-color: var(--pink-primary); }

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
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
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
        <div style="font-size:18px; font-weight:900; text-transform:uppercase;">QUẢN LÝ SẢN PHẨM</div>
        <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">Danh sách tất cả món bánh đang kinh doanh</div>
      </div>

      <a href="admin-add-product.jsp" class="btn-add-new">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
        THÊM BÁNH MỚI
      </a>
    </div>

    <div class="content-box-card">
      <div style="overflow-x:auto;">
        <table class="admin-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Hình ảnh</th>
              <th>Tên sản phẩm</th>
              <th>Danh mục</th>
              <th>Giá bán</th>
              <th style="text-align:center;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty productList}">
                <c:forEach items="${productList}" var="p">
                  <tr>
                    <td><strong>#${p.id != 0 ? p.id : p.productId}</strong></td>
                    <td><img src="${p.image}" class="p-thumb" onError="this.onerror=null;this.src='images/placeholder.jpg';"></td>
                    <td><strong style="text-transform:uppercase;">${p.productName}</strong></td>
                    <td>
                      <c:choose>
                        <c:when test="${p.categoryId == 4}">
                          <span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;">
                            <span>🥖</span> Bánh mì (Bread)
                          </span>
                        </c:when>
                        <c:when test="${p.categoryId == 3}">
                          <span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;">
                            <span>🍰</span> Bánh kem (Cakes)
                          </span>
                        </c:when>
                        <c:when test="${p.categoryId == 1}">
                          <span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;">
                            <span>🥐</span> Ngọt Bơ &amp; Ngàn Lớp
                          </span>
                        </c:when>
                        <c:when test="${p.categoryId == 5}">
                          <span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;">
                            <span>🍪</span> Bánh quy (Cookie)
                          </span>
                        </c:when>
                        <c:when test="${p.categoryId == 6}">
                          <span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;">
                            <span>🍩</span> Bánh Donuts
                          </span>
                        </c:when>
                        <c:when test="${p.categoryId == 7}">
                          <span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;">
                            <span>🧁</span> Bánh Cupcake
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;">
                            <span>🥐</span> Ngọt Bơ &amp; Ngàn Lớp
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td><strong style="color:var(--pink-primary);"><fmt:formatNumber value="${p.price}" pattern="#,##0"/>đ</strong></td>
                    <td style="text-align:center; white-space:nowrap;">
                      <!-- NÚT CHỈNH SỬA -->
                      <a href="edit-product?id=${p.id != 0 ? p.id : p.productId}" 
                         class="btn-action-icon" 
                         title="Chỉnh sửa sản phẩm"
                         style="margin-right:8px;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                          <path d="M12 20h9"></path>
                          <path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path>
                        </svg>
                      </a>

                      <!-- NÚT XÓA -->
                      <a href="admin-delete-product?id=${p.id != 0 ? p.id : p.productId}" 
                         class="btn-action-icon delete" 
                         title="Xóa bánh" 
                         onclick="return confirm('Bạn có chắc chắn muốn xóa món bánh này không?');"
                         style="border-color:#feb2b2; background:#fff5f5; color:#e53e3e;">
                        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                          <polyline points="3 6 5 6 21 6"></polyline>
                          <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
                          <line x1="10" y1="11" x2="10" y2="17"></line>
                          <line x1="14" y1="11" x2="14" y2="17"></line>
                        </svg>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>

              <c:otherwise>
                <!-- DỮ LIỆU MẪU KHI CHƯA LOAD DATABASE -->
                <tr>
                  <td><strong>#1</strong></td>
                  <td><img src="images/5d9fc32d56126074219b204adc604a58.jpg" class="p-thumb" onError="this.onerror=null;this.src='images/placeholder.jpg';"></td>
                  <td><strong>BÁNH MÌ BAGUETTE</strong></td>
                  <td><span style="display:inline-flex; align-items:center; gap:6px; font-weight:600;"><span>🥖</span> Bánh mì (Bread)</span></td>
                  <td><strong style="color:var(--pink-primary);">28.000đ</strong></td>
                  <td style="text-align:center; white-space:nowrap;">
                    <a href="edit-product?id=1" class="btn-action-icon" title="Chỉnh sửa" style="margin-right:8px;">
                      <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"/><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"/></svg>
                    </a>
                    <a href="admin-delete-product?id=1" class="btn-action-icon delete" title="Xóa" onclick="return confirm('Bạn có chắc muốn xóa bánh này?');" style="border-color:#feb2b2; background:#fff5f5; color:#e53e3e;">
                      <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/><line x1="10" y1="11" x2="10" y2="17"/><line x1="14" y1="11" x2="14" y2="17"/></svg>
                    </a>
                  </td>
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

</body>
</html>