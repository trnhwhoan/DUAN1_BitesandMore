<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vie">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Giới Thiệu</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;LIÊN HỆ: (000) 123-4567</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp" style="text-decoration:underline;">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="wf-searchbar">
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

  <!-- BREADCRUMB -->
  <div class="breadcrumb">
    <span>Trang chủ</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span>Giới Thiệu</span>
  </div>

  <!-- BANNER -->
  <div class="section" style="padding:0;">
    <img src="https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1200" alt="Banner Tiệm Bánh" style="width:100%; height:340px; object-fit:cover;">
  </div>

  <!-- OUR STORY -->
  <div class="section" style="padding:40px;">
    <div class="row" style="align-items:center;">
      <div class="col-6">
        <img src="https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=600" alt="Câu chuyện tiệm bánh" style="width:100%; height:360px; object-fit:cover;">
      </div>
      <div class="col-6" style="padding-left:20px;">
        <div class="tag">CÂU CHUYỆN CỦA CHÚNG TÔI</div>
        <div style="font-size:24px;font-weight:bold;margin:16px 0;">Làm Bánh Bằng Cả Trái Tim Từ 2015</div>
        <div style="font-size:14px;color:#444;line-height:1.8;">
          Thành lập vào năm 2015, Bites &amp; More bắt đầu từ một tiệm bánh gia đình nhỏ với niềm đam mê cháy bỏng dành cho những mẻ bánh thủ công. Chúng tôi tin rằng bí quyết của một chiếc bánh tuyệt vời nằm ở nguyên liệu hữu cơ thuần khiết và sự tâm huyết của người thợ. Mỗi sáng sớm, các thợ bánh của chúng tôi luôn chuẩn bị những mẻ bánh mì men tự nhiên, bánh tart tinh tế và bánh kem đặc trưng tươi ngon nhất.
        </div>
      </div>
    </div>
  </div>

  <!-- OUR VALUES -->
  <div class="section" style="padding:40px;">
    <div class="section-title">Giá Trị Cốt Lõi</div>
    <div class="section-subtitle">Kim chỉ nam trong từng mẻ bánh mỗi ngày</div>
    <div class="row">
      
      <div class="col-3" style="text-align:center;">
        <div class="img-ph" style="height:70px;width:70px;border-radius:50%;margin:0 auto 14px;display:flex;align-items:center;justify-content:center;">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
        </div>
        <div style="font-weight:bold;">100% Hữu Cơ</div>
      </div>

      <div class="col-3" style="text-align:center;">
        <div class="img-ph" style="height:70px;width:70px;border-radius:50%;margin:0 auto 14px;display:flex;align-items:center;justify-content:center;">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/></svg>
        </div>
        <div style="font-weight:bold;">Làm Bằng Yêu Thương</div>
      </div>

      <div class="col-3" style="text-align:center;">
        <div class="img-ph" style="height:70px;width:70px;border-radius:50%;margin:0 auto 14px;display:flex;align-items:center;justify-content:center;">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div style="font-weight:bold;">Tươi Mới Mỗi Ngày</div>
      </div>

      <div class="col-3" style="text-align:center;">
        <div class="img-ph" style="height:70px;width:70px;border-radius:50%;margin:0 auto 14px;display:flex;align-items:center;justify-content:center;">
          <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M23 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
        </div>
        <div style="font-weight:bold;">Đồng Hành Cùng Cộng Đồng</div>
      </div>

    </div>
  </div>

  <!-- MEET OUR TEAM -->
  <div class="section" style="padding:40px;">
    <div class="section-title">Đội Ngũ Của Chúng Tôi</div>
    <div class="section-subtitle">Những con người tâm huyết đằng sau căn bếp</div>
    <div class="row">
      
      <div class="col-3" style="text-align:center;">
        <img src="https://images.unsplash.com/photo-1577219491135-ce391730fb2c?q=80&w=300" alt="Như Hoàn" style="width:100%; height:220px; object-fit:cover;">
        <div style="font-weight:bold;margin-top:14px;">Như Hoàn</div>
        <div style="font-size:12px;color:#666;">Thợ Bánh Chính</div>
      </div>

      <div class="col-3" style="text-align:center;">
        <img src="https://images.unsplash.com/photo-1583394838336-acd977736f90?q=80&w=300" alt="Tuấn Tú" style="width:100%; height:220px; object-fit:cover;">
        <div style="font-weight:bold;margin-top:14px;">Tuấn Tú</div>
        <div style="font-size:12px;color:#666;">Bếp Trưởng Bánh Ngọt</div>
      </div>

      <div class="col-3" style="text-align:center;">
        <img src="https://images.unsplash.com/photo-1556910103-1c02745aae4d?q=80&w=300" alt="Thế Đan" style="width:100%; height:220px; object-fit:cover;">
        <div style="font-weight:bold;margin-top:14px;">Thế Đan</div>
        <div style="font-size:12px;color:#666;">Chuyên Viên Trang Trí</div>
      </div>

      <div class="col-3" style="text-align:center;">
        <img src="https://images.unsplash.com/photo-1581299894007-aaa50297cf16?q=80&w=300" alt="Hạnh Như" style="width:100%; height:220px; object-fit:cover;">
        <div style="font-weight:bold;margin-top:14px;">Hạnh Như</div>
        <div style="font-size:12px;color:#666;">Quản Lý Cửa Hàng</div>
      </div>

    </div>
  </div>

  <!-- STATS -->
  <div class="section" style="padding:40px;">
    <div class="row">
      <div class="col-3" style="text-align:center;">
        <div style="font-size:30px;font-weight:bold;">10+</div>
        <div style="font-size:13px;color:#555;">Năm Kinh Nghiệm</div>
      </div>
      <div class="col-3" style="text-align:center;">
        <div style="font-size:30px;font-weight:bold;">50+</div>
        <div style="font-size:13px;color:#555;">Loại Bánh Đa Dạng</div>
      </div>
      <div class="col-3" style="text-align:center;">
        <div style="font-size:30px;font-weight:bold;">15,000+</div>
        <div style="font-size:13px;color:#555;">Khách Hàng Hài Lòng</div>
      </div>
      <div class="col-3" style="text-align:center;">
        <div style="font-size:30px;font-weight:bold;">100%</div>
        <div style="font-size:13px;color:#555;">Nguyên Liệu Hữu Cơ</div>
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
</body>
</html>