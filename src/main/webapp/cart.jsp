<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Giỏ Hàng Của Bạn</title>
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
      color: var(--text-chocolate);
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
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
    }

    .breadcrumb-bar { font-size: 13px; color: var(--text-muted); display: flex; align-items: center; gap: 8px; margin-bottom: 28px; }
    .breadcrumb-bar a { color: var(--text-muted); text-decoration: none; transition: color 0.2s; }
    .breadcrumb-bar a:hover { color: var(--pink-primary); }

    .cart-card {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 36px;
      box-sizing: border-box;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    .cart-table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 24px;
    }

    .cart-table th, .cart-table td {
      padding: 16px;
      text-align: left;
      border-bottom: 1px solid var(--border-soft);
    }

    .cart-table th {
      font-size: 12px;
      font-weight: 800;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 2px solid var(--pink-primary);
      color: var(--text-chocolate);
    }

    .cart-item-img {
      width: 64px;
      height: 64px;
      object-fit: cover;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-sm);
      background: var(--pink-subtle);
    }

    .btn-action {
      background: var(--pink-primary);
      color: #fff;
      border: none;
      padding: 12px 28px;
      font-size: 12px;
      font-weight: 700;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      cursor: pointer;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      border-radius: 20px;
      transition: all 0.2s;
      box-shadow: var(--shadow-sm);
    }
    .btn-action:hover {
      background: var(--pink-dark);
      transform: translateY(-1px);
    }

    .minimal-footer { 
      border-top: 1.5px solid var(--border-soft); 
      background: #fff; 
      padding: 20px 0; 
      text-align: center; 
      font-size: 13px; 
      color: var(--text-muted); 
      width: 100%; 
    }

    @media (max-width: 768px) {
      .main-content { padding: 20px; }
      .cart-card { padding: 20px; }
      .cart-table th, .cart-table td { padding: 10px 8px; }
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

      <a href="cart.jsp" class="ic-btn" title="Giỏ hàng" style="border-color:var(--pink-primary); color:var(--pink-primary);">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
      </a>

      <c:choose>
        <c:when test="${not empty sessionScope.account}">
          <a href="profile.jsp" class="ic-btn" title="Tài khoản: ${sessionScope.account.fullName}">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="8" r="4"/>
              <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
            </svg>
          </a>
        </c:when>
        <c:otherwise>
          <a href="login.jsp" class="ic-btn" title="Đăng nhập">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="8" r="4"/>
              <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
            </svg>
          </a>
        </c:otherwise>
      </c:choose>
    </div>
  </header>

  <main class="main-content">
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);">Giỏ hàng</strong>
    </div>

    <div class="cart-card">
      <h1 style="font-size:16px; font-weight:800; text-transform:uppercase; letter-spacing:0.5px; margin-top:0; margin-bottom:24px; border-bottom:2px solid var(--pink-primary); padding-bottom:12px; color:var(--text-chocolate);">GIỎ HÀNG CỦA BẠN</h1>

      <c:choose>
        <c:when test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
          <table class="cart-table">
            <thead>
              <tr>
                <th>Sản phẩm</th>
                <th>Giá bánh</th>
                <th>Số lượng</th>
                <th>Tạm tính</th>
              </tr>
            </thead>
            <tbody>
              <c:set var="totalPrice" value="0" />
              <c:forEach items="${sessionScope.cart}" var="item">
                <c:set var="prod" value="${not empty item.product ? item.product : item}" />
                <c:set var="qty" value="${not empty item.quantity ? item.quantity : 1}" />
                <c:set var="subTotal" value="${prod.price * qty}" />
                <c:set var="totalPrice" value="${totalPrice + subTotal}" />

                <tr>
                  <td>
                    <div style="display:flex; align-items:center; gap:16px;">
                      <img src="${prod.image}" alt="${prod.productName}" class="cart-item-img" onError="this.onerror=null;this.src='images/placeholder.jpg';">
                      <span style="font-weight:700; font-size:13px; text-transform:uppercase; color:var(--text-chocolate);">${prod.productName}</span>
                    </div>
                  </td>
                  <td style="font-size:13px; font-weight:700; color:var(--pink-primary);">
                    <fmt:formatNumber value="${prod.price}" pattern="#,##0"/>đ
                  </td>
                  <td style="font-size:14px; font-weight:700; color:var(--text-chocolate);">
                    ${qty}
                  </td>
                  <td style="font-size:14px; font-weight:800; color:var(--pink-primary);">
                    <fmt:formatNumber value="${subTotal}" pattern="#,##0"/>đ
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <div style="display:flex; justify-content:space-between; align-items:center; border-top:1.5px solid var(--border-soft); padding-top:24px;">
            <a href="shop" style="color:var(--pink-primary); text-decoration:underline; font-size:12px; font-weight:700; text-transform:uppercase;">&larr; Tiếp tục chọn bánh</a>
            
            <div style="text-align:right;">
              <div style="font-size:15px; font-weight:700; margin-bottom:16px; color:var(--text-chocolate);">
                TỔNG CỘNG: <span style="font-size:22px; font-weight:800; color:var(--pink-primary);"><fmt:formatNumber value="${totalPrice}" pattern="#,##0"/>đ</span>
              </div>
              <a href="checkout" class="btn-action">
                TIẾN HÀNH THANH TOÁN
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
              </a>
            </div>
          </div>
        </c:when>

        <c:otherwise>
          <div style="text-align:center; padding:60px 20px;">
            <p style="font-size:14px; color:var(--text-muted); margin-bottom:24px; font-weight:600;">Giỏ hàng của bạn đang trống.</p>
            <a href="shop" class="btn-action">
              KHÁM PHÁ CỬA HÀNG
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
            </a>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </main>

  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

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

<script src="js/app.js"></script>
</body>
</html>
