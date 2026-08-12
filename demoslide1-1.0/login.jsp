<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Đăng nhập</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
      font-family: system-ui, -apple-system, sans-serif;
      color: #000;
    }
    
    .wire-page { display: flex; flex-direction: column; min-height: 100vh; width: 100%; }
    .main-content { flex: 1; width: 100%; padding: 40px 20px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; }

    .wf-topbar { background: #000; color: #fff; font-size: 11px; font-weight: bold; text-align: center; padding: 8px 20px; }

    .wf-header {
      width: 100%; box-sizing: border-box; padding: 16px 40px; display: flex; align-items: center; justify-content: space-between; background: #f8f8f8; border-bottom: 1px solid #000; position: sticky; top: 0; z-index: 100;
    }

    .brand-logo { color: #000; text-decoration: none; font-weight: bold; font-size: 20px; border: 1px solid #000; padding: 6px 16px; display: inline-block; background: #fff; transition: all 0.2s; }
    .brand-logo:hover { background: #000; color: #fff; }

    .wf-nav { display: flex; gap: 24px; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }

    .header-actions { display: flex; align-items: center; gap: 20px; }
    .search-box { display: flex; align-items: center; gap: 8px; border: 1px solid #000; padding: 6px 12px; background: #fff; width: 240px; }
    .search-box input { border: none; outline: none; font-size: 13px; width: 100%; background: transparent; }

    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }

    .form-box { width: 100%; max-width: 420px; border: 1px solid #000; padding: 32px; background: #fff; box-sizing: border-box; }
    .field-input { width: 100%; height: 40px; padding: 0 12px; border: 1px solid #000; font-size: 13px; outline: none; box-sizing: border-box; background: #fff; }

    .minimal-footer { border-top: 1px solid #000; background: #fff; padding: 20px 0; text-align: center; font-size: 13px; color: #000; width: 100%; }

    @media (max-width: 600px) {
      .wf-header { flex-direction: column; gap: 12px; padding: 16px; }
      .wf-nav { flex-wrap: wrap; justify-content: center; gap: 12px; }
    }
  </style>
</head>
<body>
<div class="wire-page">

  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: (000) 123-4567</div>
  
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <div class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" placeholder="Tìm kiếm sản phẩm...">
      </div>

      <a href="feedback" class="ic-btn feedback-link" title="Góp ý">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
      </a>

      <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
      </a>

      <a href="login.jsp" class="ic-btn" title="Tài khoản">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a>
    </div>
  </header>

  <main class="main-content">
    <div class="form-box">
      <div style="height:56px;width:56px;border-radius:50%;margin:0 auto 20px;background:#f5f5f5;display:flex;align-items:center;justify-content:center;border:1px solid #000;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg>
      </div>

      <h2 style="font-size:20px;font-weight:bold;text-align:center;margin:0 0 6px 0;">Chào Mừng Trở Lại</h2>
      <div style="font-size:13px;color:#555;text-align:center;margin-bottom:24px;">Đăng nhập vào tài khoản Bites &amp; More</div>

      <c:if test="${not empty requestScope.error}"><div style="color:#b00020;background:#fff0f0;border:1px solid #b00020;padding:10px;margin-bottom:16px;font-size:13px;"><c:out value="${requestScope.error}"/></div></c:if>
      <c:if test="${param.registered eq 'true'}"><div style="color:#087f23;background:#f0fff3;border:1px solid #087f23;padding:10px;margin-bottom:16px;font-size:13px;">Đăng ký thành công. Hãy đăng nhập.</div></c:if>

      <form action="login" method="POST">
        <div style="margin-bottom:14px;">
          <label style="display:block;margin-bottom:6px;font-size:12px;font-weight:bold;">Địa chỉ Email *</label>
          <input type="email" name="email" class="field-input" value="<c:out value='${requestScope.email}'/>" placeholder="vidu@domain.com" required>
        </div>

        <div style="margin-bottom:14px;">
          <label style="display:block;margin-bottom:6px;font-size:12px;font-weight:bold;">Mật khẩu *</label>
          <input type="password" name="password" class="field-input" placeholder="Nhập mật khẩu" required>
        </div>

        <div style="display:flex;justify-content:space-between;align-items:center;margin:16px 0;font-size:12px;">
          <label style="display:flex;align-items:center;gap:6px;cursor:pointer;">
            <input type="checkbox" name="remember"> Ghi nhớ đăng nhập
          </label>
          <a href="forgot-password" style="text-decoration:underline;color:#000;font-weight:bold;">Quên mật khẩu?</a>
        </div>

        <button type="submit" style="width:100%;padding:10px;background:#000;color:#fff;border:none;font-weight:bold;font-size:13px;cursor:pointer;">
          ĐĂNG NHẬP
        </button>
      </form>

      <div style="text-align:center;margin-top:20px;font-size:12px;color:#555;">
        Chưa có tài khoản? <a href="register.jsp" style="text-decoration:underline;font-weight:bold;color:#000;">Đăng ký ngay</a>
      </div>
    </div>
  </main>

  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>
<script src="js/app.js"></script>
</body>
</html>
