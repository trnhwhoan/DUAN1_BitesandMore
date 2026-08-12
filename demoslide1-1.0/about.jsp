<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Giới thiệu</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* SYSTEM DESIGN VARIABLES (ĐỒNG BỘ VỚI HOME.JSP & SHOP.JSP) */
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
    
    /* KHUNG NỘI DUNG GIỚI THIỆU */
    .about-box {
      border: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 48px 60px;
      margin-bottom: 40px;
      box-sizing: border-box;
      width: 100%;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }

    .about-hero-img {
      width: 100%;
      height: 420px;
      object-fit: cover;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-md);
      margin-bottom: 40px;
    }
    
    .section-title {
      font-size: 20px;
      font-weight: 800;
      color: var(--text-chocolate);
      border-bottom: 2px solid var(--pink-primary);
      padding-bottom: 12px;
      margin-bottom: 28px;
      letter-spacing: 0.5px;
      display: flex;
      align-items: center;
      justify-content: space-between;
    }

    .about-desc {
      font-size: 15px;
      color: var(--text-muted);
      line-height: 1.9;
      margin-bottom: 24px;
      text-align: justify;
    }

    /* CON SỐ THỐNG KÊ */
    .stats-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin: 40px 0;
    }
    .stat-card {
      border: 1.5px solid var(--border-soft);
      padding: 28px 16px;
      text-align: center;
      background: var(--pink-subtle);
      border-radius: var(--radius-md);
      transition: all 0.25s ease;
    }
    .stat-card:hover {
      border-color: var(--pink-primary);
      transform: translateY(-3px);
      box-shadow: var(--shadow-sm);
    }
    .stat-number {
      font-size: 38px;
      font-weight: 900;
      color: var(--pink-primary);
      margin-bottom: 6px;
    }
    .stat-label {
      font-size: 13px;
      font-weight: 700;
      text-transform: uppercase;
      color: var(--text-chocolate);
      letter-spacing: 0.5px;
    }

    /* GIÁ TRỊ CỐT LÕI */
    .values-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 24px;
      margin-bottom: 48px;
    }
    .value-card {
      border: 1.5px solid var(--border-soft);
      padding: 32px;
      background: #fff;
      position: relative;
      border-radius: var(--radius-md);
      transition: all 0.25s ease;
    }
    .value-card:hover {
      border-color: var(--pink-primary);
      transform: translateY(-4px);
      box-shadow: var(--shadow-sm);
    }
    .value-card .num {
      font-size: 12px;
      font-weight: 800;
      padding: 4px 12px;
      display: inline-block;
      margin-bottom: 16px;
      background: var(--pink-primary);
      color: #fff;
      border-radius: 12px;
    }
    .value-card h3 {
      font-size: 17px;
      font-weight: 800;
      margin: 0 0 12px 0;
      color: var(--text-chocolate);
    }
    .value-card p {
      font-size: 14px;
      color: var(--text-muted);
      line-height: 1.7;
      margin: 0;
    }

    /* QUY TRÌNH 5 BƯỚC */
    .process-list {
      display: flex;
      flex-direction: column;
      gap: 16px;
      margin-bottom: 48px;
    }
    .process-item {
      border: 1.5px solid var(--border-soft);
      padding: 20px 24px;
      display: flex;
      align-items: center;
      gap: 20px;
      background: #fff;
      border-radius: var(--radius-md);
      transition: all 0.2s ease;
    }
    .process-item:hover {
      border-color: var(--pink-primary);
      box-shadow: var(--shadow-sm);
    }
    .process-step {
      font-size: 20px;
      font-weight: 800;
      width: 46px;
      height: 46px;
      border-radius: 50%;
      background: var(--pink-light);
      color: var(--pink-primary);
      display: flex;
      align-items: center;
      justify-content: center;
      flex-shrink: 0;
    }
    .process-info h4 {
      margin: 0 0 4px 0;
      font-size: 15px;
      font-weight: 800;
      color: var(--text-chocolate);
    }
    .process-info p {
      margin: 0;
      font-size: 13px;
      color: var(--text-muted);
      line-height: 1.5;
    }

    /* BANNER QUOTE */
    .quote-box {
      border: 1.5px solid var(--border-soft);
      background: linear-gradient(135deg, var(--pink-primary), var(--pink-dark));
      color: #fff;
      padding: 44px 32px;
      text-align: center;
      margin-top: 40px;
      border-radius: var(--radius-lg);
      box-shadow: var(--shadow-sm);
    }
    .quote-box p {
      font-size: 17px;
      font-style: italic;
      margin: 0 0 16px 0;
      line-height: 1.7;
    }
    .quote-box span {
      font-size: 12px;
      text-transform: uppercase;
      letter-spacing: 2px;
      font-weight: 700;
      opacity: 0.9;
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
      .about-box { padding: 24px; }
      .stats-grid { grid-template-columns: repeat(2, 1fr); }
      .values-grid { grid-template-columns: 1fr; }
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
      <a href="about.jsp" class="active">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
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
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span> <strong style="color:var(--text-chocolate);">Giới thiệu</strong>
    </div>

    <div class="about-box">
      <!-- HERO BANNER -->
      <img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1600" alt="Bites & More Artisan Bakery" class="about-hero-img">
      
      <!-- CÂU CHUYỆN THƯƠNG HIỆU -->
      <div class="section-title">
        <span>Câu Chuyện Của Chúng Tôi</span>
        <span style="font-size:12px; font-weight:700; color:var(--pink-primary); background:var(--pink-light); padding:4px 12px; border-radius:12px;">EST. 2015</span>
      </div>
      <p class="about-desc">
        Khởi đầu vào năm 2015 từ một căn bếp nhỏ đong đầy tình yêu dành cho bột mỳ và men nở, <strong>Bites &amp; More</strong> đã từng bước phát triển để trở thành một trong những thương hiệu bánh ngọt thủ công (Artisan Bakery) được yêu thích hàng đầu. Chúng tôi tin rằng, mỗi chiếc bánh sinh ra không đơn thuần chỉ là một món ăn, mà là một tác phẩm nghệ thuật thu nhỏ mang theo hương vị mộc mạc, tinh tế và trọn vẹn sự chân thành.
      </p>
      <p class="about-desc">
        Tại Bites &amp; More, chúng tôi từ chối mọi quy trình sản xuất công nghiệp đại trà. Thay vào đó, mỗi mẻ bánh mì men tự nhiên giòn rụm hay từng chiếc bánh ngọt ngàn lớp thơm lừng bơ Pháp đều được tạo nên bởi đôi bàn tay khéo léo của những người thợ làm bánh lành nghề, kiên nhẫn chăm chút từng công đoạn nhỏ nhất.
      </p>

      <!-- NHỮNG CON SỐ TỰ HÀO -->
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-number">10+</div>
          <div class="stat-label">Năm Kinh Nghiệm</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">60+</div>
          <div class="stat-label">Công Thức Bánh Độc Quyền</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">100%</div>
          <div class="stat-label">Nguyên Liệu Tự Nhiên</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">50K+</div>
          <div class="stat-label">Khách Hàng Hài Lòng</div>
        </div>
      </div>

      <!-- TRIẾT LÝ & TRẢI NGHIỆM -->
      <div class="section-title">Tầm Nhìn &amp; Giá Trị Cốt Lõi</div>
      <div class="values-grid">
        <div class="value-card">
          <div class="num">01</div>
          <h3>Nguyên Liệu Thuần Khiết</h3>
          <p>Chúng tôi tuyển chọn khắt khe 100% bột mỳ hữu cơ, bơ động vật nguyên chất nhập khẩu từ Pháp và men tươi tự nhiên. Tuyệt đối không hóa chất bảo quản hay hương liệu nhân tạo.</p>
        </div>
        <div class="value-card">
          <div class="num">02</div>
          <h3>Kỹ Thuật Bánh Thủ Công</h3>
          <p>Giữ trọn phương pháp ủ men chậm truyền thống kéo dài đến 24 giờ. Quy trình này giúp cấu trúc bánh xốp nhẹ, có độ dai vừa phải và mùi thơm đặc trưng không thể lẫn lộn.</p>
        </div>
        <div class="value-card">
          <div class="num">03</div>
          <h3>Tươi Mới Mỗi Ngày</h3>
          <p>Tất cả các sản phẩm trưng bày tại cửa hàng đều được nướng mới vào đúng 6:00 sáng mỗi ngày. Bánh chưa bán hết trong ngày luôn được xử lý để đảm bảo độ tươi mới tuyệt đối.</p>
        </div>
      </div>

      <!-- QUY TRÌNH TẠO NÊN CHIẾC BÁNH HOÀN HẢO -->
      <div class="section-title">Quy Trình Tạo Nên Chiếc Bánh Hoàn Hảo</div>
      <div class="process-list">
        <div class="process-item">
          <div class="process-step">1</div>
          <div class="process-info">
            <h4>Tuyển Chọn Nguyên Liệu</h4>
            <p>Lựa chọn cẩn thận những bao bột mỳ thượng hạng, trái cây tươi theo mùa và bơ thơm ngậy.</p>
          </div>
        </div>
        <div class="process-item">
          <div class="process-step">2</div>
          <div class="process-info">
            <h4>Ủ Men Tự Nhiên (Sourdough Starter)</h4>
            <p>Nuôi dưỡng con men tự nhiên theo tỉ lệ chuẩn xác để bánh đạt độ nở hoàn hảo và dễ tiêu hóa.</p>
          </div>
        </div>
        <div class="process-item">
          <div class="process-step">3</div>
          <div class="process-info">
            <h4>Tạo Hình Thủ Công</h4>
            <p>Thợ làm bánh cẩn thận nhào nặn, cán lót từng lớp bơ mỏng nhẹ để tạo nên độ giòn xốp tuyệt mỹ.</p>
          </div>
        </div>
        <div class="process-item">
          <div class="process-step">4</div>
          <div class="process-info">
            <h4>Nướng Bánh Ở Nhiệt Độ Chuẩn</h4>
            <p>Căn chỉnh thời gian và nhiệt độ lò nướng để lớp vỏ ngoài vàng gạch giòn tan, bên trong mềm ẩm.</p>
          </div>
        </div>
        <div class="process-item">
          <div class="process-step">5</div>
          <div class="process-info">
            <h4>Giao Tận Tay Khách Hàng</h4>
            <p>Đóng gói cẩn thận trong bao bì thân thiện với môi trường và giao nhanh trong ngày.</p>
          </div>
        </div>
      </div>

      <!-- BANNER LỜI CAM KẾT -->
      <div class="quote-box">
        <p>"Chúng tôi không chỉ bán bánh, chúng tôi gửi gắm sự ấm áp, niềm vui và khoảnh khắc ngọt ngào nhất vào từng chiếc hộp trao tận tay bạn."</p>
        <span>— Đội Ngũ Thợ Bánh Bites &amp; More —</span>
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
