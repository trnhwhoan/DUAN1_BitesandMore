<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vie">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Danh Mục Sản Phẩm</title>
  <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: 0766 766 999</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <a href="home.jsp" class="wf-logo" style="color:#000;text-decoration:none;">BITES &amp; MORE</a>
    
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      
      <div class="dropdown">
        <a href="categories.jsp" style="text-decoration:underline;">Danh mục 
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg>
        </a>
        <div class="dropdown-menu">
          <a href="shop.jsp?category=breads">Bánh mì</a>
          <a href="shop.jsp?category=cakes">Bánh kem</a>
          <a href="shop.jsp?category=pastries">Bánh ngàn lớp</a>
          <a href="shop.jsp?category=cookies">Bánh quy</a>
          <a href="shop.jsp?category=donuts">Bánh Donuts</a>
          <a href="shop.jsp?category=cupcakes">Bánh Cupcake</a>
        </div>
      </div>

      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>

    <!-- SEARCHBAR & ICONS TRONG KHUNG HEADER -->
    <div style="display:flex;align-items:center;gap:20px;flex:1;max-width:500px;justify-content:flex-end;">
      <div class="wf-searchbar" style="margin:0;width:100%;max-width:280px;">
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <span>Tìm kiếm sản phẩm...</span>
      </div>

      <div class="wf-icons">
        <a href="favorites.jsp" class="ic-btn">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          <span class="badge">3</span>
        </a>
        <a href="cart.jsp" class="ic-btn">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
          <span class="badge">2</span>
        </a>
        <a href="login.jsp" class="ic-btn">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
        </a>
      </div>
    </div>
  </div>

  <!-- BREADCRUMB -->
  <div class="breadcrumb">
    <span>Trang chủ</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span>Danh Mục</span>
  </div>

  <!-- HERO BANNER -->
  <div class="section" style="padding:0; position:relative; overflow:hidden;">
    <div style="height:220px; background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1200') center/cover no-repeat; display:flex; flex-direction:column; align-items:center; justify-content:center; gap:12px; color:#fff;">
      <div style="font-size:28px;font-weight:bold;letter-spacing:1px;text-align:center;">KHÁM PHÁ BỘ SƯU TẬP BÁNH</div>
      <div style="font-size:14px;color:#eee;text-align:center;">Từ bánh mì men tự nhiên mỗi sáng đến những chiếc bánh sinh nhật hảo hạng</div>
    </div>
  </div>

  <!-- CATEGORIES GRID SECTION -->
  <div class="section" style="padding:40px;">
    <div class="section-title">Danh Mục Sản Phẩm</div>
    <div class="section-subtitle">Chọn một danh mục để xem tất cả các món bánh thơm ngon sẵn có</div>

    <div class="row">
      
      <!-- Bánh Mì -->
      <div class="col-4" style="margin-bottom:30px;">
        <div class="product-card" style="text-align:center;padding-bottom:20px;border:1px solid #eee;border-radius:4px;overflow:hidden;">
          <img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=400" alt="Bánh Mì Thủ Công" style="width:100%;height:200px;object-fit:cover;margin-bottom:16px;">
          <div style="font-size:18px;font-weight:bold;margin-bottom:8px;">Bánh Mì Thủ Công</div>
          <div style="font-size:13px;color:#555;padding:0 16px;margin-bottom:16px;line-height:1.5;">Bánh mì men tự nhiên, baguette giòn rụm và bánh mì nguyên cám tươi mới mỗi sáng.</div>
          <a href="shop.jsp?category=breads" class="btn btn-dark btn-sm">Xem Bộ Sưu Tập</a>
        </div>
      </div>

      <!-- Bánh Kem -->
      <div class="col-4" style="margin-bottom:30px;">
        <div class="product-card" style="text-align:center;padding-bottom:20px;border:1px solid #eee;border-radius:4px;overflow:hidden;">
          <img src="https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=400" alt="Bánh Kem Cùng Bánh Sinh Nhật" style="width:100%;height:200px;object-fit:cover;margin-bottom:16px;">
          <div style="font-size:18px;font-weight:bold;margin-bottom:8px;">Bánh Kem &amp; Sinh Nhật</div>
          <div style="font-size:13px;color:#555;padding:0 16px;margin-bottom:16px;line-height:1.5;">Bánh sinh nhật thiết kế theo yêu cầu, Red Velvet quyến rũ và bánh chocolate đậm vị.</div>
          <a href="shop.jsp?category=cakes" class="btn btn-dark btn-sm">Xem Bộ Sưu Tập</a>
        </div>
      </div>

      <!-- Bánh Ngàn Lớp -->
      <div class="col-4" style="margin-bottom:30px;">
        <div class="product-card" style="text-align:center;padding-bottom:20px;border:1px solid #eee;border-radius:4px;overflow:hidden;">
          <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=400" alt="Bánh Ngọt Pháp" style="width:100%;height:200px;object-fit:cover;margin-bottom:16px;">
          <div style="font-size:18px;font-weight:bold;margin-bottom:8px;">Bánh Ngọt Pháp</div>
          <div style="font-size:13px;color:#555;padding:0 16px;margin-bottom:16px;line-height:1.5;">Croissant bơ xốp mềm, bánh tart trái cây tươi mát và các loại pastry ngàn lớp tinh tế.</div>
          <a href="shop.jsp?category=pastries" class="btn btn-dark btn-sm">Xem Bộ Sưu Tập</a>
        </div>
      </div>

    </div>
  </div>

  <!-- FOOTER -->
  <div class="wf-footer">
    <div class="footer-bottom">
      <span>© 2026 Bites &amp; More. Bản quyền thuộc về tiệm bánh.</span>
      <span>Chính sách bảo mật &nbsp;|&nbsp; Điều khoản dịch vụ</span>
    </div>
  </div>

</div>

<script src="js/app.js"></script>
</body>
</html>