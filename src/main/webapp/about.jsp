<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Giới thiệu</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    html, body { height: 100%; margin: 0; padding: 0; background-color: #f8f8f8; font-family: system-ui, -apple-system, sans-serif; color: #000; }
    .wire-page { display: flex; flex-direction: column; min-height: 100vh; width: 100%; }
    
    /* ĐÃ GIÃN RỘNG TOÀN BỘ KHUNG NỘI DUNG NHƯ HOME.JSP */
    .main-content { flex: 1; width: 100%; padding: 32px 60px 80px 60px; box-sizing: border-box; }
    
    .wf-topbar { background: #000; color: #fff; font-size: 11px; font-weight: bold; text-align: center; padding: 8px 20px; letter-spacing: 0.5px; }
    .wf-header { width: 100%; box-sizing: border-box; padding: 16px 60px; display: flex; align-items: center; justify-content: space-between; background: #f8f8f8; border-bottom: 1px solid #000; position: sticky; top: 0; z-index: 100; }
    .brand-logo { color: #000; text-decoration: none; font-weight: bold; font-size: 20px; border: 1px solid #000; padding: 6px 16px; display: inline-block; background: #fff; transition: all 0.2s; }
    .brand-logo:hover { background: #000; color: #fff; }
    .wf-nav { display: flex; gap: 32px; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }
    .header-actions { display: flex; align-items: center; gap: 20px; }
    .search-box { display: flex; align-items: center; gap: 8px; border: 1px solid #000; padding: 6px 12px; background: #fff; width: 260px; }
    .search-box input { border: none; outline: none; font-size: 13px; width: 100%; background: transparent; }
    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }
    .breadcrumb-bar { font-size: 13px; color: #666; display: flex; align-items: center; gap: 8px; margin-bottom: 32px; }
    .breadcrumb-bar a { color: #666; text-decoration: none; }
    
    /* KHUNG NỘI DUNG RỘNG MÃN NHÃN GIỐNG HOME.JSP */
    .about-box { border: 1px solid #000; background: #fff; padding: 48px 60px; margin-bottom: 40px; box-sizing: border-box; width: 100%; }
    .about-hero-img { width: 100%; height: 420px; object-fit: cover; border: 1px solid #000; margin-bottom: 40px; }
    
    .section-title { font-size: 22px; font-weight: bold; text-transform: uppercase; border-bottom: 2px solid #000; padding-bottom: 12px; margin-bottom: 28px; letter-spacing: 1.5px; display: flex; align-items: center; justify-content: space-between; }
    .about-desc { font-size: 15px; color: #222; line-height: 1.9; margin-bottom: 24px; text-align: justify; }

    /* CON SỐ THỐNG KÊ GIÃN RỘNG */
    .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 24px; margin: 40px 0; }
    .stat-card { border: 1px solid #000; padding: 32px 20px; text-align: center; background: #fafafa; }
    .stat-number { font-size: 40px; font-weight: 900; color: #000; margin-bottom: 6px; font-family: monospace; }
    .stat-label { font-size: 13px; font-weight: bold; text-transform: uppercase; color: #444; letter-spacing: 1px; }

    /* GIÁ TRỊ CỐT LÕI GIÃN RỘNG 3 CỘT */
    .values-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 28px; margin-bottom: 48px; }
    .value-card { border: 1px solid #000; padding: 32px; background: #fff; position: relative; }
    .value-card .num { font-size: 13px; font-weight: bold; border: 1px solid #000; padding: 4px 10px; display: inline-block; margin-bottom: 16px; background: #000; color: #fff; }
    .value-card h3 { font-size: 18px; font-weight: bold; margin: 0 0 12px 0; text-transform: uppercase; letter-spacing: 0.5px; }
    .value-card p { font-size: 14px; color: #444; line-height: 1.7; margin: 0; }

    /* QUY TRÌNH 5 BƯỚC THOÁNG MẮT */
    .process-list { display: flex; flex-direction: column; gap: 20px; margin-bottom: 48px; }
    .process-item { border: 1px solid #000; padding: 20px 28px; display: flex; align-items: center; gap: 24px; background: #fff; }
    .process-step { font-size: 22px; font-weight: bold; width: 48px; height: 48px; border: 1px solid #000; display: flex; align-items: center; justify-content: center; background: #f0f0f0; flex-shrink: 0; }
    .process-info h4 { margin: 0 0 6px 0; font-size: 15px; font-weight: bold; text-transform: uppercase; letter-spacing: 0.5px; }
    .process-info p { margin: 0; font-size: 14px; color: #555; line-height: 1.5; }

    /* BANNER QUOTE FULL WIDTH */
    .quote-box { border: 1px solid #000; background: #000; color: #fff; padding: 48px 32px; text-align: center; margin-top: 40px; }
    .quote-box p { font-size: 18px; font-style: italic; margin: 0 0 16px 0; line-height: 1.7; letter-spacing: 0.5px; }
    .quote-box span { font-size: 13px; text-transform: uppercase; letter-spacing: 3px; font-weight: bold; color: #ccc; }

    .minimal-footer { border-top: 1px solid #000; background: #fff; padding: 24px 0; text-align: center; font-size: 13px; color: #000; width: 100%; }
    
    @media (max-width: 992px) {
      .main-content, .wf-header { padding-left: 20px; padding-right: 20px; }
      .about-box { padding: 24px; }
      .stats-grid { grid-template-columns: repeat(2, 1fr); }
      .values-grid { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: (000) 123-4567</div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp" style="text-decoration: underline;">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>
      <a href="favorites.jsp" class="ic-btn"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg><span class="badge fav-count">0</span></a>
      <a href="cart.jsp" class="ic-btn"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg><span class="badge cart-count">0</span></a>
      <a href="login.jsp" class="ic-btn"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg></a>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <main class="main-content">
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span> <strong style="color:#000;">Giới thiệu</strong>
    </div>

    <div class="about-box">
      <!-- HERO BANNER GIÃN RỘNG -->
      <img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1600" alt="Bites & More Artisan Bakery" class="about-hero-img">
      
      <!-- CÂU CHUYỆN THƯƠNG HIỆU -->
      <div class="section-title">
        <span>Câu Chuyện Của Chúng Tôi</span>
        <span style="font-size:12px; font-weight:normal; color:#666;">EST. 2015</span>
      </div>
      <p class="about-desc">
        Khởi đầu vào năm 2015 từ một căn bếp nhỏ đong đầy tình yêu dành cho bột mỳ và men nở, <strong>Bites &amp; More</strong> đã từng bước phát triển để trở thành một trong những thương hiệu bánh ngọt thủ công (Artisan Bakery) được yêu thích hàng đầu. Chúng tôi tin rằng, mỗi chiếc bánh sinh ra không đơn thuần chỉ là một món ăn, mà là một tác phẩm nghệ thuật thu nhỏ mang theo hương vị mộc mạc, tinh tế và trọn vẹn sự chân thành.
      </p>
      <p class="about-desc">
        Tại Bites &amp; More, chúng tôi từ chối mọi quy trình sản xuất công nghiệp đại trà. Thay vào đó, mỗi mẻ bánh mì men tự nhiên giòn rụm hay từng chiếc bánh ngọt ngàn lớp thơm lừng bơ Pháp đều được tạo nên bởi đôi bàn tay khéo léo của những người thợ làm bánh lành nghề, kiên nhẫn chăm chút từng công đoạn nhỏ nhất.
      </p>

      <!-- NHỮNG CON SỐ TỰ HÀO GIÃN RỘNG -->
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

<script src="js/app.js"></script>
</body>
</html>