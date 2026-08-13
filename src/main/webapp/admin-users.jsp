<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Quản Lý Khách Hàng</title>
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

    .admin-table { width: 100%; border-collapse: separate; border-spacing: 0; font-size: 13px; }
    .admin-table th {
      background: var(--pink-subtle); color: var(--text-chocolate);
      font-size: 11px; font-weight: 800; text-transform: uppercase;
      padding: 14px; border-bottom: 2px solid var(--border-soft); text-align: left;
    }
    .admin-table td { padding: 16px 14px; border-bottom: 1px solid var(--border-soft); vertical-align: middle; }

    .user-avatar-mini {
      width: 36px; height: 36px; border-radius: 50%;
      background: var(--pink-primary); color: #fff;
      display: flex; align-items: center; justify-content: center;
      font-weight: 800; font-size: 12px;
    }

    .role-badge {
      padding: 4px 10px; border-radius: 12px; font-size: 10px; font-weight: 800;
      text-transform: uppercase; background: var(--pink-light); color: var(--pink-primary);
    }

    .btn-action-icon {
      width: 32px; height: 32px; border-radius: 50%; border: 1px solid var(--border-soft);
      display: inline-flex; align-items: center; justify-content: center;
      color: var(--text-chocolate); text-decoration: none; transition: all 0.2s;
    }
    .btn-action-icon:hover { background: #ffe6e6; color: #d32f2f; border-color: #f8b4b4; }

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

    <a href="admin-users" class="admin-nav-item active">
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
        <div style="font-size:18px; font-weight:900; text-transform:uppercase;">QUẢN LÝ KHÁCH HÀNG</div>
        <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">Danh sách các tài khoản người dùng trong hệ thống</div>
      </div>
    </div>

    <div class="content-box-card">
      <div style="overflow-x:auto;">
        <table class="admin-table">
          <thead>
            <tr>
              <th>ID</th>
              <th>Avatar</th>
              <th>Họ và tên</th>
              <th>Email</th>
              <th>Số điện thoại</th>
              <th>Vai trò</th>
              <th style="text-align:center;">Thao tác</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty userList}">
                <c:forEach items="${userList}" var="u">
                  <tr>
                    <td><strong>#${u.id}</strong></td>
                    <td>
                      <c:choose>
                        <c:when test="${not empty u.avatar}">
                          <img src="${u.avatar}" style="width:36px; height:36px; border-radius:50%; object-fit:cover;">
                        </c:when>
                        <c:otherwise>
                          <div class="user-avatar-mini">${u.fullName.substring(0, 1).toUpperCase()}</div>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td><strong style="text-transform:capitalize;">${u.fullName}</strong></td>
                    <td>${u.email}</td>
                    <td>${not empty u.phoneNumber ? u.phoneNumber : 'Chưa cập nhật'}</td>
                    <td><span class="role-badge">${u.role}</span></td>
                    <td style="text-align:center;">
                      <a href="delete-user?id=${u.id}" class="btn-action-icon" title="Khóa/Xóa tài khoản" onclick="return confirm('Bạn có chắc muốn xóa khách hàng này?');">
                        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </c:when>

              <c:otherwise>
                <!-- DỮ LIỆU MẪU KHI CHƯA LOAD DATABASE -->
                <tr>
                  <td><strong>#1</strong></td>
                  <td><div class="user-avatar-mini">H</div></td>
                  <td><strong>Như Hoàn Tr</strong></td>
                  <td>nhuhoan21@gmail.com</td>
                  <td>0766766341</td>
                  <td><span class="role-badge">CUSTOMER</span></td>
                  <td style="text-align:center;">
                    <a href="#" class="btn-action-icon" title="Xóa"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></a>
                  </td>
                </tr>
                <tr>
                  <td><strong>#2</strong></td>
                  <td><div class="user-avatar-mini">A</div></td>
                  <td><strong>Admin User</strong></td>
                  <td>admin@bitesandmore.com</td>
                  <td>0905123456</td>
                  <td><span class="role-badge" style="background:#e6fffa; color:#234e52;">ADMIN</span></td>
                  <td style="text-align:center;">
                    <a href="#" class="btn-action-icon" title="Xóa"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg></a>
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
