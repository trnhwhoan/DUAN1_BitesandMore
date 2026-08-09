<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vie">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Liên Hệ</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN VỚI HOÁ ĐƠN TỪ 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: 0766 766 999</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp" style="text-decoration:underline;">Liên hệ</a>
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
    <span>Liên Hệ</span>
  </div>

  <!-- MAP BANNER -->
  <div class="section" style="padding:0;">
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3833.837262078693!2d108.21980837583091!3d16.073926539970908!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142183120155555%3A0x28974a9582103d36!2zRMOgIE7huqVuZw!5e0!3m2!1svi!2s!4v1700000000000!5m2!1svi!2s" width="100%" height="280" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
  </div>

  <!-- CONTACT INFO & FORM -->
  <div class="section" style="padding:40px;">
    <div class="section-title">Liên Hệ Với Chúng Tôi</div>
    <div class="section-subtitle">Rất hân hạnh được nghe góp ý và hỗ trợ bạn</div>
    
    <!-- 3 Block Thông Tin Liên Hệ -->
    <div class="row" style="margin-bottom:40px;">
      
      <!-- Block 1: Địa chỉ -->
      <div class="col-4" style="text-align:center;">
        <div class="img-ph" style="height:64px;width:64px;border-radius:50%;margin:0 auto 14px;display:flex;align-items:center;justify-content:center;">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
            <path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
          </svg>
        </div>
        <div style="font-weight:bold;margin-bottom:6px;">Địa Chỉ Cửa Hàng</div>
        <div style="font-size:13px;color:#444;">123 Phố Bánh Ngọt, TP. Đà Nẵng</div>
      </div>

      <!-- Block 2: Số điện thoại -->
      <div class="col-4" style="text-align:center;">
        <div class="img-ph" style="height:64px;width:64px;border-radius:50%;margin:0 auto 14px;display:flex;align-items:center;justify-content:center;">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
            <path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1.9.3 1.8.6 2.7a2 2 0 0 1-.4 2.1L8 9.9a16 16 0 0 0 6 6l1.4-1.4a2 2 0 0 1 2.1-.4c.9.3 1.8.5 2.7.6a2 2 0 0 1 1.8 2.1z"/>
          </svg>
        </div>
        <div style="font-weight:bold;margin-bottom:6px;">Điện Thoại Hỗ Trợ</div>
        <div style="font-size:13px;color:#444;">0766 766 999</div>
      </div>

      <!-- Block 3: Email -->
      <div class="col-4" style="text-align:center;">
        <div class="img-ph" style="height:64px;width:64px;border-radius:50%;margin:0 auto 14px;display:flex;align-items:center;justify-content:center;">
          <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
            <rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,6 12,13 22,6"/>
          </svg>
        </div>
        <div style="font-weight:bold;margin-bottom:6px;">Email Liên Hệ</div>
        <div style="font-size:13px;color:#444;">hello@bitesandmore.com</div>
      </div>

    </div>

    <!-- Form Gửi Tin Nhắn -->
    <div class="row">
      <div class="col-6">
        <img src="https://images.unsplash.com/photo-1517433670267-08bbd4be890f?q=80&w=600" alt="Không gian tiệm bánh" style="width:100%; height:420px; object-fit:cover;">
      </div>
      <div class="col-6">
        <div class="filter-block">
          <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:20px;">Gửi Tin Nhắn Cho Chúng Tôi</h5>
          <form action="contact" method="POST">
            <div class="row">
              <div class="col-6 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Họ và Tên</label>
                <input type="text" name="name" class="input" placeholder="Nhập tên của bạn" required>
              </div>
              <div class="col-6 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Email</label>
                <input type="email" name="email" class="input" placeholder="example@gmail.com" required>
              </div>
            </div>
            
            <div class="field" style="margin-top:16px;">
              <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Chủ Đề</label>
              <input type="text" name="subject" class="input" placeholder="Nhập chủ đề cần tư vấn" required>
            </div>

            <div class="field" style="margin-top:16px;">
              <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Nội Dung Tin Nhắn</label>
              <textarea name="message" class="input" rows="5" placeholder="Viết nội dung tin nhắn của bạn tại đây..." required style="resize:vertical;"></textarea>
            </div>

            <button type="submit" class="btn btn-dark" style="margin-top:20px;display:inline-flex;align-items:center;gap:8px;cursor:pointer;">
              Gửi Tin Nhắn
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.5"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
            </button>
          </form>
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
</body>
</html>