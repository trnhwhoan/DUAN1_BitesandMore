<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Danh Mục Sản Phẩm</title>
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
    
    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      width: 100%;
    }

    /* ĐÃ TĂNG CHIỀU RỘNG PADDING ĐỒNG BỘ VỚI HOME, ABOUT & CONTACT */
    .main-content {
      flex: 1;
      width: 100%;
      padding: 32px 60px 80px 60px;
      box-sizing: border-box;
    }

    .wf-topbar {
      background: #000;
      color: #fff;
      font-size: 11px;
      font-weight: bold;
      text-align: center;
      padding: 8px 20px;
      letter-spacing: 0.5px;
    }

    .wf-header {
      width: 100%;
      box-sizing: border-box;
      padding: 16px 60px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #f8f8f8;
      border-bottom: 1px solid #000;
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .brand-logo {
      color: #000;
      text-decoration: none;
      font-weight: bold;
      font-size: 20px;
      border: 1px solid #000;
      padding: 6px 16px;
      display: inline-block;
      background: #fff;
      transition: all 0.2s;
    }
    .brand-logo:hover { background: #000; color: #fff; }

    .wf-nav { display: flex; gap: 32px; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }

    /* DROPDOWN MENU */
    .dropdown { position: relative; display: inline-block; }
    .dropdown-menu {
      display: none;
      position: absolute;
      top: 100%;
      left: 0;
      background: #fff;
      border: 1px solid #000;
      min-width: 180px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.1);
      z-index: 1000;
    }
    .dropdown-menu a {
      color: #000;
      padding: 10px 16px;
      text-decoration: none;
      display: block;
      font-size: 13px;
      border-bottom: 1px solid #eee;
    }
    .dropdown-menu a:hover { background: #000; color: #fff; }
    .dropdown:hover .dropdown-menu { display: block; }

    .header-actions { display: flex; align-items: center; gap: 20px; }
    .search-box { display: flex; align-items: center; gap: 8px; border: 1px solid #000; padding: 6px 12px; background: #fff; width: 260px; }
    .search-box input { border: none; outline: none; font-size: 13px; width: 100%; background: transparent; }

    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }

    .breadcrumb-bar { font-size: 13px; color: #666; display: flex; align-items: center; gap: 8px; margin-bottom: 32px; }
    .breadcrumb-bar a { color: #666; text-decoration: none; }

    /* LƯỚI 6 DANH MỤC SẢN PHẨM (GRID 3 CỘT x 2 HÀNG) */
    .categories-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 28px;
    }

    .category-card {
      text-align: center;
      padding-bottom: 24px;
      border: 1px solid #000;
      background: #fff;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: transform 0.2s ease;
    }
    .category-card:hover {
      transform: translateY(-4px);
    }

    .category-card img {
      width: 100%;
      height: 220px;
      object-fit: cover;
      margin-bottom: 20px;
      border-bottom: 1px solid #000;
    }

    .category-title {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }

    .category-desc {
      font-size: 13px;
      color: #555;
      padding: 0 20px;
      margin-bottom: 20px;
      line-height: 1.6;
    }

    .btn-view-cat {
      display: inline-block;
      margin: 0 20px;
      padding: 10px 24px;
      text-decoration: none;
      color: #fff;
      background: #000;
      font-weight: bold;
      font-size: 12px;
      letter-spacing: 0.5px;
      border: 1px solid #000;
      transition: all 0.2s;
    }
    .btn-view-cat:hover {
      background: #333;
    }

    .minimal-footer { 
      border-top: 1px solid #000; 
      background: #fff; 
      padding: 24px 0; 
      text-align: center; 
      font-size: 13px; 
      color: #000; 
      width: 100%; 
    }

    @media (max-width: 992px) {
      .main-content, .wf-header { padding-left: 20px; padding-right: 20px; }
      .categories-grid { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND | HOTLINE: 0766 766 999</div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      
      <div class="dropdown">
        <a href="categories.jsp" style="text-decoration:underline; font-weight:bold;">
          Danh mục <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg>
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
      <a href="contact.jsp">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>

      <div class="wf-icons">
        <a href="favorites.jsp" class="ic-btn">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          <span class="badge fav-count">0</span>
        </a>
        <a href="cart.jsp" class="ic-btn">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge cart-count">0</span>
        </a>
        <a href="login.jsp" class="ic-btn">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
        </a>
      </div>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <main class="main-content">
    
    <!-- BREADCRUMB -->
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span> <strong style="color:#000;">Danh Mục Sản Phẩm</strong>
    </div>

    <!-- HERO BANNER -->
    <div style="border:1px solid #000; margin-bottom:40px; overflow:hidden;">
      <div style="height:240px; background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1600') center/cover no-repeat; display:flex; flex-direction:column; align-items:center; justify-content:center; gap:12px; color:#fff;">
        <h1 style="font-size:28px; font-weight:bold; letter-spacing:1px; text-align:center; margin:0; text-transform:uppercase;">KHÁM PHÁ BỘ SƯU TẬP BÁNH BITES &amp; MORE</h1>
        <p style="font-size:14px; color:#eee; text-align:center; margin:0;">Từ những mẻ bánh mì men tự nhiên mỗi sáng đến những chiếc bánh sinh nhật hảo hạng</p>
      </div>
    </div>

    <!-- TIÊU ĐỀ SECTION -->
    <div style="text-align:center; margin-bottom:36px;">
      <h2 style="font-size:22px; font-weight:bold; text-transform:uppercase; letter-spacing:1px; margin:0 0 8px 0;">DANH MỤC BÁNH NỔI BẬT</h2>
      <p style="font-size:14px; color:#666; margin:0;">Chọn một danh mục để xem chi tiết danh sách 10 món bánh thơm ngon nhất</p>
    </div>

    <!-- HIỂN THỊ ĐẦY ĐỦ 6 DANH MỤC SẢN PHẨM -->
    <div class="categories-grid">
      
      <!-- 1. Bánh Mì -->
      <div class="category-card">
        <img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=600" alt="Bánh Mì Thủ Công">
        <div class="category-title">1. Bánh Mì Thủ Công</div>
        <div class="category-desc">Bánh mì men tự nhiên (Sourdough), Baguette Pháp giòn rụm và bánh mì nguyên cám tươi mới mỗi sáng.</div>
        <a href="category?id=1" class="btn-view-cat">XEM BỘ SƯU TẬP (10 MÓN)</a>
      </div>

      <!-- 2. Bánh Kem -->
      <div class="category-card">
        <img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=600" alt="Bánh Kem & Sinh Nhật">
        <div class="category-title">2. Bánh Kem &amp; Sinh Nhật</div>
        <div class="category-desc">Bánh sinh nhật thiết kế theo yêu cầu, Red Velvet quyến rũ, Tiramisu và bánh Chocolate đắng đậm vị.</div>
        <a href="category?id=2" class="btn-view-cat">XEM BỘ SƯU TẬP (10 MÓN)</a>
      </div>

      <!-- 3. Bánh Ngàn Lớp -->
      <div class="category-card">
        <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=600" alt="Bánh Ngọt Pháp">
        <div class="category-title">3. Bánh Ngọt Pháp (Pastry)</div>
        <div class="category-desc">Croissant bơ Pháp xốp mềm, Pain au Chocolat, bánh Tart trái cây tươi và Danish ngàn lớp tinh tế.</div>
        <a href="category?id=3" class="btn-view-cat">XEM BỘ SƯU TẬP (10 MÓN)</a>
      </div>

      <!-- 4. Bánh Quy -->
      <div class="category-card">
        <img src="https://images.unsplash.com/photo-1499636136210-6f4ee915583e?q=80&w=600" alt="Bánh Quy Cookie">
        <div class="category-title">4. Bánh Quy (Cookie)</div>
        <div class="category-desc">Cookie chocolate chip giòn rụm, bánh quy bơ hạt dẻ, Macaron Pháp giòn xốp và Biscotti giòn bùi.</div>
        <a href="category?id=4" class="btn-view-cat">XEM BỘ SƯU TẬP (10 MÓN)</a>
      </div>

      <!-- 5. Bánh Donuts -->
      <div class="category-card">
        <img src="https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=600" alt="Bánh Donuts">
        <div class="category-title">5. Bánh Donuts</div>
        <div class="category-desc">Bánh vòng Donuts phủ dâu tây, socola đắng, đường tuyết giòn rụm và nhân mứt trái cây ngọt ngào.</div>
        <a href="category?id=5" class="btn-view-cat">XEM BỘ SƯU TẬP (10 MÓN)</a>
      </div>

      <!-- 6. Bánh Cupcake -->
      <div class="category-card">
        <img src="https://images.unsplash.com/photo-1519869325930-281384150729?q=80&w=600" alt="Bánh Cupcake">
        <div class="category-title">6. Bánh Cupcake</div>
        <div class="category-desc">Bánh Cupcake nhỏ nhắn trang trí kem bơ béo ngậy, vị Vanilla, Matcha Nhật Bản và Choco Lava phô mai.</div>
        <a href="category?id=6" class="btn-view-cat">XEM BỘ SƯU TẬP (10 MÓN)</a>
      </div>

    </div>

  </main>

  <!-- FOOTER -->
  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

</div>

<script src="js/app.js"></script>
</body>
</html>