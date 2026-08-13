<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Danh Mục Sản Phẩm</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* SYSTEM DESIGN VARIABLES (ĐỒNG BỘ HOÀN TOÀN VỚI HOME.JSP) */
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

    .wf-nav {
      display: flex;
      gap: 28px;
      align-items: center;
    }
    .wf-nav a {
      color: var(--text-chocolate);
      text-decoration: none;
      font-size: 13px;
      font-weight: 600;
      transition: color 0.2s;
    }
    .wf-nav a:hover, .wf-nav a.active {
      color: var(--pink-primary);
    }

    /* DROPDOWN MENU */
    .dropdown { position: relative; display: inline-block; }
    .dropdown-menu {
      display: none;
      position: absolute;
      top: 100%;
      left: 0;
      background: #fff;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-md);
      min-width: 200px;
      box-shadow: var(--shadow-md);
      z-index: 1000;
      overflow: hidden;
    }
    .dropdown-menu a {
      color: var(--text-chocolate);
      padding: 10px 16px;
      text-decoration: none;
      display: block;
      font-size: 13px;
      font-weight: 600;
      border-bottom: 1px solid var(--pink-subtle);
      transition: all 0.2s;
    }
    .dropdown-menu a:hover {
      background: var(--pink-light);
      color: var(--pink-primary);
    }
    .dropdown:hover .dropdown-menu { display: block; }

    .header-actions {
      display: flex;
      align-items: center;
      gap: 16px;
    }

    .search-box {
      display: flex;
      align-items: center;
      gap: 8px;
      border: 1.5px solid var(--border-soft);
      padding: 8px 14px;
      background: #fff;
      width: 220px;
      border-radius: 20px;
      transition: all 0.2s;
    }
    .search-box:focus-within {
      border-color: var(--pink-primary);
      box-shadow: 0 0 0 3px rgba(232, 106, 133, 0.15);
    }
    .search-box input {
      border: none;
      outline: none;
      font-size: 12px;
      width: 100%;
      background: transparent;
      color: var(--text-chocolate);
    }

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

    .breadcrumb-bar {
      font-size: 13px;
      color: var(--text-muted);
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 28px;
    }
    .breadcrumb-bar a {
      color: var(--text-muted);
      text-decoration: none;
      transition: color 0.2s;
    }
    .breadcrumb-bar a:hover {
      color: var(--pink-primary);
    }

    /* HERO BANNER SECTION */
    .hero-cat-banner {
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-lg);
      margin-bottom: 40px;
      overflow: hidden;
      box-shadow: var(--shadow-sm);
    }
    .hero-cat-content {
      height: 240px;
      background: linear-gradient(rgba(45, 30, 30, 0.55), rgba(45, 30, 30, 0.55)), url('https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1600') center/cover no-repeat;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      gap: 12px;
      color: #fff;
      text-align: center;
      padding: 0 20px;
    }

    /* SECTION TITLE WITH ICON */
    .section-header {
      text-align: center;
      margin-bottom: 36px;
    }
    .section-title {
      font-size: 20px;
      font-weight: 800;
      color: var(--text-chocolate);
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      margin: 0 0 6px 0;
    }
    .section-subtitle {
      font-size: 13px;
      color: var(--text-muted);
      margin: 0;
    }

    /* LƯỚI 6 DANH MỤC SẢN PHẨM */
    .categories-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
    }

    .category-card {
      text-align: center;
      padding-bottom: 24px;
      border: 1.5px solid var(--border-soft);
      background: #fff;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: all 0.25s ease;
      border-radius: var(--radius-md);
      overflow: hidden;
    }
    .category-card:hover {
      transform: translateY(-4px);
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-md);
    }

    .category-card img {
      width: 100%;
      height: 220px;
      object-fit: cover;
      margin-bottom: 18px;
      border-bottom: 1.5px solid var(--border-soft);
      transition: transform 0.4s ease;
    }
    .category-card:hover img {
      transform: scale(1.04);
    }

    .category-title {
      font-size: 17px;
      font-weight: 800;
      margin-bottom: 8px;
      color: var(--text-chocolate);
    }

    .category-desc {
      font-size: 13px;
      color: var(--text-muted);
      padding: 0 20px;
      margin-bottom: 20px;
      line-height: 1.6;
    }

    .btn-view-cat {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      margin: 0 20px;
      padding: 10px 20px;
      text-decoration: none;
      color: #fff;
      background: var(--pink-primary);
      font-weight: 700;
      font-size: 12px;
      border-radius: 20px;
      transition: all 0.2s;
      box-shadow: var(--shadow-sm);
    }
    .btn-view-cat:hover {
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

    @media (max-width: 992px) {
      .main-content, .wf-header { padding-left: 20px; padding-right: 20px; }
      .categories-grid { grid-template-columns: 1fr; }
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
    MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND | HOTLINE: 0766 766 999
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
      
      <div class="dropdown">
        <a href="categories.jsp" class="active">
          Danh mục <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg>
        </a>
        <div class="dropdown-menu">
          <a href="category?id=1">Bánh Mì Thủ Công</a>
          <a href="category?id=2">Bánh Kem &amp; Sinh Nhật</a>
          <a href="category?id=3">Bánh Ngọt Pháp (Pastry)</a>
          <a href="category?id=4">Bánh Quy (Cookie)</a>
          <a href="category?id=5">Bánh Donuts</a>
          <a href="category?id=6">Bánh Cupcake</a>
        </div>
      </div>

      <a href="about.jsp">Giới thiệu</a>
      <a href="contact">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>

      <div style="display:flex; gap:12px;">
        <a href="feedback" class="ic-btn feedback-link" title="Góp ý">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
        </a>
        <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
        </a>
        <c:choose>
          <c:when test="${not empty sessionScope.account}">
            <a href="profile.jsp" class="ic-btn" title="Tài khoản: ${sessionScope.account.fullName}">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
            </a>
          </c:when>
          <c:otherwise>
            <a href="login.jsp" class="ic-btn" title="Đăng nhập">
              <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8 7"/></svg>
            </a>
          </c:otherwise>
        </c:choose>
      </div>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <main class="main-content">
    
    <!-- BREADCRUMB -->
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span> <strong style="color:var(--text-chocolate);">Danh Mục Sản Phẩm</strong>
    </div>

    <!-- HERO BANNER -->
    <div class="hero-cat-banner">
      <div class="hero-cat-content">
        <h1 style="font-size:26px; font-weight:800; letter-spacing:0.5px; margin:0; text-transform:uppercase;">KHÁM PHÁ BỘ SƯU TẬP BÁNH BITES &amp; MORE</h1>
        <p style="font-size:14px; color:var(--pink-light); margin:0;">Từ những mẻ bánh mì men tự nhiên mỗi sáng đến những chiếc bánh sinh nhật hảo hạng</p>
      </div>
    </div>

    <!-- TIÊU ĐỀ SECTION -->
    <div class="section-header">
      <h2 class="section-title">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="2.5"><circle cx="12" cy="12" r="10"/><path d="M8 12h8"/></svg>
        DANH MỤC BÁNH NỔI BẬT
      </h2>
      <p class="section-subtitle">Chọn một danh mục để xem chi tiết danh sách các món bánh thơm ngon nhất</p>
    </div>

    <!-- HIỂN THỊ ĐẦY ĐỦ 6 DANH MỤC SẢN PHẨM -->
    <div class="categories-grid">
      
      <!-- 1. Bánh Mì -->
      <div class="category-card">
        <div style="overflow:hidden;">
          <img src="https://i.pinimg.com/736x/8d/92/72/8d92724194cef22a50d224b7180eda5b.jpg" alt="Bánh Mì Thủ Công">
        </div>
        <div class="category-title">1. Bánh Mì Thủ Công</div>
        <div class="category-desc">Bánh mì men tự nhiên (Sourdough), Baguette Pháp giòn rụm và bánh mì nguyên cám tươi mới mỗi sáng.</div>
        <a href="category?id=1" class="btn-view-cat">
          XEM BỘ SƯU TẬP
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
        </a>
      </div>

      <!-- 2. Bánh Kem -->
      <div class="category-card">
        <div style="overflow:hidden;">
          <img src="https://i.pinimg.com/1200x/bc/c6/f2/bcc6f26068a07978dd74e10e4049e886.jpg" alt="Bánh Kem & Sinh Nhật">
        </div>
        <div class="category-title">2. Bánh Kem &amp; Sinh Nhật</div>
        <div class="category-desc">Bánh sinh nhật thiết kế theo yêu cầu, Red Velvet quyến rũ, Tiramisu và bánh Chocolate đắng đậm vị.</div>
        <a href="category?id=2" class="btn-view-cat">
          XEM BỘ SƯU TẬP
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
        </a>
      </div>

      <!-- 3. Bánh Ngàn Lớp -->
      <div class="category-card">
        <div style="overflow:hidden;">
          <img src="https://i.pinimg.com/1200x/84/75/b2/8475b2a82f22230a18b2c0917bc24468.jpg" alt="Bánh Ngọt Pháp">
        </div>
        <div class="category-title">3. Bánh Ngọt Pháp (Pastry)</div>
        <div class="category-desc">Croissant bơ Pháp xốp mềm, Pain au Chocolat, bánh Tart trái cây tươi và Danish ngàn lớp tinh tế.</div>
        <a href="category?id=3" class="btn-view-cat">
          XEM BỘ SƯU TẬP
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
        </a>
      </div>

      <!-- 4. Bánh Quy -->
      <div class="category-card">
        <div style="overflow:hidden;">
          <img src="https://i.pinimg.com/736x/ea/56/28/ea56287268501401d9abc88c074c1b26.jpg" alt="Bánh Quy Cookie">
        </div>
        <div class="category-title">4. Bánh Quy (Cookie)</div>
        <div class="category-desc">Cookie chocolate chip giòn rụm, bánh quy bơ hạt dẻ, Macaron Pháp giòn xốp và Biscotti giòn bùi.</div>
        <a href="category?id=4" class="btn-view-cat">
          XEM BỘ SƯU TẬP
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
        </a>
      </div>

      <!-- 5. Bánh Donuts -->
      <div class="category-card">
        <div style="overflow:hidden;">
          <img src="https://i.pinimg.com/1200x/7e/d8/5e/7ed85e3fc962d1dce13b0fad7d87b190.jpg" alt="Bánh Donuts">
        </div>
        <div class="category-title">5. Bánh Donuts</div>
        <div class="category-desc">Bánh vòng Donuts phủ dâu tây, socola đắng, đường tuyết giòn rụm và nhân mứt trái cây ngọt ngào.</div>
        <a href="category?id=5" class="btn-view-cat">
          XEM BỘ SƯU TẬP
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
        </a>
      </div>

      <!-- 6. Bánh Cupcake -->
      <div class="category-card">
        <div style="overflow:hidden;">
          <img src="https://i.pinimg.com/736x/be/75/7f/be757f3640f6139f8bfdfe61a1e79dd1.jpg" alt="Bánh Cupcake">
        </div>
        <div class="category-title">6. Bánh Cupcake</div>
        <div class="category-desc">Bánh Cupcake nhỏ nhắn trang trí kem bơ béo ngậy, vị Vanilla, Matcha Nhật Bản và Choco Lava phô mai.</div>
        <a href="category?id=6" class="btn-view-cat">
          XEM BỘ SƯU TẬP
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
        </a>
      </div>

    </div>

  </main>

  <!-- FOOTER -->
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
