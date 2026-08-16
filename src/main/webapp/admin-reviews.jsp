<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Quản Lý Đánh Giá</title>
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

    .content-box-card {
      background: #fff; border: 1px solid var(--border-soft);
      border-radius: var(--radius-md); padding: 28px;
      box-shadow: var(--shadow-sm);
    }

    .admin-table { width: 100%; border-collapse: separate; border-spacing: 0; font-size: 13px; table-layout: fixed; }
    .admin-table th {
      background: var(--pink-subtle); color: var(--text-chocolate);
      font-size: 11px; font-weight: 800; text-transform: uppercase;
      padding: 14px; border-bottom: 2px solid var(--border-soft); text-align: left;
    }
    .admin-table td { padding: 16px 14px; border-bottom: 1px solid var(--border-soft); vertical-align: middle; }

    .star-rating { color: #ffb400; font-size: 14px; }

    /* STATUS BADGE */
    .status-badge {
      display: inline-flex; align-items: center; gap: 6px;
      padding: 4px 10px; border-radius: 20px; font-size: 11px;
      font-weight: 800; text-transform: uppercase;
    }
    .status-badge.visible { background: #e6ffed; color: #22543d; border: 1px solid #b7ebc5; }
    .status-badge.hidden { background: #f1f2f6; color: #747d8c; border: 1px solid #ced6e0; }

    /* TOGGLE BUTTONS */
    .btn-toggle-visibility {
      display: inline-flex; align-items: center; justify-content: center; gap: 6px;
      padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 700;
      text-decoration: none; transition: all 0.2s ease; cursor: pointer; border: 1.5px solid transparent;
    }
    
    .btn-toggle-visibility.btn-hide {
      background: #fff0f3; color: var(--pink-primary); border-color: var(--border-soft);
    }
    .btn-toggle-visibility.btn-hide:hover {
      background: var(--pink-primary); color: #fff; border-color: var(--pink-primary);
    }

    .btn-toggle-visibility.btn-show {
      background: #e6f7ff; color: #096dd9; border-color: #91d5ff;
    }
    .btn-toggle-visibility.btn-show:hover {
      background: #096dd9; color: #fff; border-color: #096dd9;
    }

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

    <a href="admin-reviews" class="admin-nav-item active">
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
        <div style="font-size:18px; font-weight:900; text-transform:uppercase;">QUẢN LÝ ĐÁNH GIÁ &amp; PHẢN HỒI</div>
        <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">Xem và kiểm duyệt trạng thái ẩn / hiện đánh giá của khách hàng</div>
      </div>
    </div>

    <div class="content-box-card">
      <div style="overflow-x:auto;">
        <table class="admin-table">
          <thead>
            <tr>
              <th style="width:7%;">ID</th>
              <th style="width:16%;">Khách hàng</th>
              <th style="width:18%;">Món bánh</th>
              <th style="width:10%;">Số sao</th>
              <th style="width:25%;">Nội dung bình luận</th>
              <th style="width:12%; text-align:center;">Trạng thái</th>
              <th style="width:12%; text-align:center;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty reviewList}">
                <c:forEach items="${reviewList}" var="r">
                  <tr style="${r.status == 'Hidden' ? 'opacity:0.6; background:#fafafa;' : ''}">
                    <td><strong>#${r.id}</strong></td>
                    <td><strong>${r.userName}</strong></td>
                    <td><strong style="color:var(--pink-primary);">${r.productName}</strong></td>
                    <td>
                      <span class="star-rating">
                        <c:forEach begin="1" end="${r.rating}">★</c:forEach>
                      </span>
                    </td>
                    <td style="word-break:break-word;">${r.content}</td>
                    <td style="text-align:center;">
                      <c:choose>
                        <c:when test="${r.status == 'Hidden'}">
                          <span class="status-badge hidden">Đã ẩn</span>
                        </c:when>
                        <c:otherwise>
                          <span class="status-badge visible">Hiển thị</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td style="text-align:center;">
                      <c:choose>
                        <c:when test="${r.status == 'Hidden'}">
                          <a href="toggle-review-status?id=${r.id}&status=Active" 
                             class="btn-toggle-visibility btn-show" 
                             title="Bấm để hiển thị lại đánh giá này">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                            Hiện
                          </a>
                        </c:when>
                        <c:otherwise>
                          <a href="toggle-review-status?id=${r.id}&status=Hidden" 
                             class="btn-toggle-visibility btn-hide" 
                             title="Bấm để ẩn đánh giá này"
                             onclick="return confirm('Bạn có chắc muốn ẩn đánh giá này không?');">
                            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/></svg>
                            Ẩn
                          </a>
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>

              <c:otherwise>
                <tr>
                  <td colspan="7" style="text-align:center; padding:32px; color:var(--text-muted);">
                    Chưa có đánh giá nào trong hệ thống.
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