<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Liên Hệ</title>
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
    
    .header-actions { display: flex; align-items: center; gap: 20px; }
    .search-box { display: flex; align-items: center; gap: 8px; border: 1px solid #000; padding: 6px 12px; background: #fff; width: 260px; }
    .search-box input { border: none; outline: none; font-size: 13px; width: 100%; background: transparent; }

    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }

    .breadcrumb-bar { font-size: 13px; color: #666; display: flex; align-items: center; gap: 8px; margin-bottom: 32px; }
    .breadcrumb-bar a { color: #666; text-decoration: none; }

    /* 4 CỘT THÔNG TIN VỚI GIỜ MỞ CỬA */
    .contact-info-grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      margin-bottom: 48px;
    }

    .info-card {
      border: 1px solid #000;
      background: #fff;
      padding: 28px 16px;
      text-align: center;
    }

    .info-card .icon-ph {
      height: 52px;
      width: 52px;
      border-radius: 50%;
      margin: 0 auto 14px;
      background: #fafafa;
      display: flex;
      align-items: center;
      justify-content: center;
      border: 1px solid #000;
    }

    /* KHỐI DỊCH VỤ ĐẶT TIỆC CHUYÊN NGHIỆP */
    .service-banner {
      border: 1px solid #000;
      background: #fff;
      padding: 36px;
      margin-bottom: 48px;
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 28px;
    }

    .service-item h3 {
      font-size: 15px;
      font-weight: bold;
      text-transform: uppercase;
      margin: 0 0 8px 0;
      border-bottom: 1px solid #000;
      padding-bottom: 6px;
    }

    .service-item p {
      font-size: 13px;
      color: #555;
      line-height: 1.6;
      margin: 0;
    }

    /* FORM VÀ HÌNH ẢNH */
    .contact-form-layout {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 32px;
      align-items: stretch;
      margin-bottom: 48px;
    }

    .form-box {
      border: 1px solid #000;
      padding: 36px;
      background: #fff;
    }

    .field-group-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
      margin-bottom: 16px;
    }

    .field-input {
      width: 100%;
      padding: 12px 14px;
      border: 1px solid #000;
      font-size: 13px;
      outline: none;
      box-sizing: border-box;
      background: #fff;
      font-family: inherit;
    }

    .btn-submit {
      margin-top: 16px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      cursor: pointer;
      background: #000;
      color: #fff;
      padding: 14px 28px;
      border: 1px solid #000;
      font-weight: bold;
      font-size: 13px;
      letter-spacing: 0.5px;
      width: 100%;
    }

    /* KHỐI FAQ CÂU HỎI THƯỜNG GẶP */
    .faq-section {
      border: 1px solid #000;
      background: #fff;
      padding: 36px;
    }

    .faq-title {
      font-size: 18px;
      font-weight: bold;
      text-transform: uppercase;
      border-bottom: 2px solid #000;
      padding-bottom: 10px;
      margin-bottom: 24px;
      letter-spacing: 0.5px;
    }

    .faq-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
    }

    .faq-item h4 {
      font-size: 14px;
      font-weight: bold;
      margin: 0 0 6px 0;
    }

    .faq-item p {
      font-size: 13px;
      color: #555;
      line-height: 1.6;
      margin: 0;
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
      .contact-info-grid { grid-template-columns: repeat(2, 1fr); }
      .service-banner, .faq-grid, .contact-form-layout { grid-template-columns: 1fr; }
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
      <a href="categories.jsp">Danh mục <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp" style="text-decoration:underline; font-weight:bold;">Liên hệ</a>
    </nav>
    <div class="header-actions">
      <form action="shop" method="GET" class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" name="keyword" placeholder="Tìm kiếm sản phẩm...">
      </form>
      <a href="feedback" class="ic-btn feedback-link" title="Góp ý">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
      </a>
      <a href="cart.jsp" class="ic-btn">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
      </a>
        <c:choose><c:when test="${not empty sessionScope.account}"><a href="profile.jsp" class="ic-btn" title="Tài khoản: ${sessionScope.account.fullName}"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8 7"/></svg></a></c:when><c:otherwise><a href="login.jsp" class="ic-btn">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
        </a></c:otherwise></c:choose>
    </div>
  </header>

  <!-- MAIN CONTENT -->
  <main class="main-content">
    
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span> <strong style="color:#000;">Liên Hệ</strong>
    </div>

    <!-- MAP BANNER -->
    <div style="margin-bottom:40px; border:1px solid #000; background:#fff; overflow:hidden; height:320px;">
      <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3833.837262078693!2d108.21980837583091!3d16.073926539970908!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3142183120155555%3A0x28974a9582103d36!2zRMOgIE7huqVuZw!5e0!3m2!1svi!2s!4v1700000000000!5m2!1svi!2s" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
    </div>

    <div style="text-align:center; margin-bottom:36px;">
      <h1 style="font-size:24px; font-weight:bold; text-transform:uppercase; letter-spacing:1px; margin:0 0 8px 0;"><c:choose><c:when test="${param.feedback eq 'true'}">GÓP Ý &amp; PHẢN HỒI</c:when><c:otherwise>Hỗ Trợ &amp; Dịch Vụ Khách Hàng</c:otherwise></c:choose></h1>
      <p style="font-size:14px; color:#666; margin:0;">Bites &amp; More luôn sẵn sàng phục vụ những mẻ bánh tươi ngon nhất mỗi ngày</p>
    </div>

    <!-- 4 BLOCK THÔNG TIN CHUYÊN NGHIỆP -->
    <div class="contact-info-grid">
      <div class="info-card">
        <div class="icon-ph">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M21 10c0 6-9 12-9 12s-9-6-9-12a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
        </div>
        <div style="font-weight:bold; margin-bottom:6px; font-size:14px; text-transform:uppercase;">Cửa Hàng</div>
        <div style="font-size:12px; color:#444; line-height:1.5;">123 Phố Bánh Ngọt, Q. Hải Châu, TP. Đà Nẵng</div>
      </div>

      <div class="info-card">
        <div class="icon-ph">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
        </div>
        <div style="font-weight:bold; margin-bottom:6px; font-size:14px; text-transform:uppercase;">Giờ Mở Cửa</div>
        <div style="font-size:12px; color:#444; line-height:1.5;">Thứ 2 - Chủ Nhật<br><strong>06:00 - 22:00</strong></div>
      </div>

      <div class="info-card">
        <div class="icon-ph">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M22 16.9v3a2 2 0 0 1-2.2 2 19.8 19.8 0 0 1-8.6-3.1 19.5 19.5 0 0 1-6-6A19.8 19.8 0 0 1 2.1 4.2 2 2 0 0 1 4.1 2h3a2 2 0 0 1 2 1.7c.1.9.3 1.8.6 2.7a2 2 0 0 1-.4 2.1L8 9.9a16 16 0 0 0 6 6l1.4-1.4a2 2 0 0 1 2.1-.4c.9.3 1.8.5 2.7.6a2 2 0 0 1 1.8 2.1z"/></svg>
        </div>
        <div style="font-weight:bold; margin-bottom:6px; font-size:14px; text-transform:uppercase;">Hotline Đặt Hàng</div>
        <div style="font-size:12px; color:#444; line-height:1.5;">0766 766 999<br><em>(Hỗ trợ 24/7)</em></div>
      </div>

      <div class="info-card">
        <div class="icon-ph">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="2" y="4" width="20" height="16" rx="2"/><polyline points="2,6 12,13 22,6"/></svg>
        </div>
        <div style="font-weight:bold; margin-bottom:6px; font-size:14px; text-transform:uppercase;">Email Khách Hàng</div>
        <div style="font-size:12px; color:#444; line-height:1.5;">hello@bitesandmore.com<br>order@bitesandmore.com</div>
      </div>
    </div>

    <!-- KHỐI DỊCH VỤ ĐẶT TIỆC / EVENT -->
    <div class="service-banner">
      <div class="service-item">
        <h3>Đặt Bánh Sinh Nhật Theo Yêu Cầu</h3>
        <p>Tự do lựa chọn hương vị, nhân bánh và thiết kế mẫu bánh theo cá tính riêng. Vui lòng liên hệ trước 24 giờ.</p>
      </div>
      <div class="service-item">
        <h3>Dịch Vụ Tiệc Teabreak Công Ty</h3>
        <p>Cung cấp các set bánh mỳ, pastry ngọt &amp; mặn nhỏ gọn dành cho sự kiện, hội thảo và tiệc sinh nhật công ty.</p>
      </div>
      <div class="service-item">
        <h3>Giao Bánh Tươi Tận Nơi</h3>
        <p>Giao hàng siêu tốc trong vòng 60 phút nội thành Đà Nẵng. Bảo đảm bánh nguyên vẹn, giữ trọn độ nóng giòn.</p>
      </div>
    </div>

    <!-- FORM VÀ HÌNH ẢNH -->
      <div class="contact-form-layout">
      <c:if test="${param.submitted eq 'true' and not empty sessionScope.lastFeedback}">
        <div style="grid-column:1/-1;border:1px solid #087f23;background:#f3fff5;padding:18px;margin-bottom:20px;font-size:13px;">
          <strong>Đã nhận feedback của bạn!</strong><br>
          Chủ đề: <c:out value="${sessionScope.lastFeedback.topic}"/> · Đánh giá: <c:out value="${sessionScope.lastFeedback.rating}"/><br>
          Nội dung: <c:out value="${sessionScope.lastFeedback.content}"/>
        </div>
      </c:if>
      <div style="border:1px solid #000; overflow:hidden;">
        <img src="https://images.unsplash.com/photo-1517433670267-08bbd4be890f?q=80&w=800" alt="Không gian tiệm bánh Bites & More" style="width:100%; height:100%; min-height:440px; object-fit:cover; display:block;">
      </div>

      <div class="form-box">
        <h2 style="border-bottom:2px solid #000; padding-bottom:12px; margin:0 0 20px 0; font-size:15px; font-weight:bold; text-transform:uppercase;"><c:choose><c:when test="${param.feedback eq 'true'}">GỬI PHẢN HỒI CHO BITES &amp; MORE</c:when><c:otherwise>GỬI TIN NHẮN TƯ VẤN</c:otherwise></c:choose></h2>
        
        <form action="contact" method="POST">
          <div class="field-group-row">
            <div>
              <label style="display:block; margin-bottom:6px; font-size:12px; font-weight:bold; text-transform:uppercase;">Họ và Tên *</label>
              <input type="text" name="name" class="field-input" placeholder="Nhập tên của bạn" required>
            </div>
            <div>
              <label style="display:block; margin-bottom:6px; font-size:12px; font-weight:bold; text-transform:uppercase;">Email *</label>
              <input type="email" name="email" class="field-input" placeholder="example@gmail.com" required>
            </div>
          </div>
          
          <div style="margin-bottom:16px;">
            <label style="display:block; margin-bottom:6px; font-size:12px; font-weight:bold; text-transform:uppercase;">Nhu Cầu *</label>
            <select name="subject" class="field-input" style="height:43px;" required>
              <option value="Đặt bánh lẻ">Đặt bánh mì / bánh ngọt lẻ</option>
              <option value="Đặt bánh sinh nhật">Đặt bánh kem sinh nhật theo thiết kế</option>
              <option value="Đặt tiệc Teabreak">Tư vấn tiệc Teabreak công ty</option>
              <option value="Góp ý dịch vụ">Góp ý chất lượng dịch vụ</option>
            </select>
          </div>

          <div style="margin-bottom:16px;">
            <label style="display:block; margin-bottom:6px; font-size:12px; font-weight:bold; text-transform:uppercase;">Nội Dung *</label>
            <textarea name="message" class="field-input" rows="4" placeholder="Nhập chi tiết yêu cầu bánh hoặc thắc mắc của bạn..." required style="height:auto; resize:vertical; padding-top:10px;"></textarea>
          </div>

          <button type="submit" class="btn-submit">
            GỬI YÊU CẦU TƯ VẤN
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.5"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
          </button>
        </form>
      </div>
    </div>

    <!-- KHỐI FAQ CÂU HỎI THƯỜNG GẶP -->
    <div class="faq-section">
      <div class="faq-title">Câu Hỏi Thường Gặp (FAQ)</div>
      <div class="faq-grid">
        <div class="faq-item">
          <h4>Q: Tôi muốn đặt bánh sinh nhật mẫu riêng thì cần báo trước bao lâu?</h4>
          <p>A: Bạn nên gửi yêu cầu trước ít nhất 24 giờ để đội ngũ thợ bánh chuẩn bị nguyên liệu tươi và tạo hình tỉ mỉ nhất.</p>
        </div>
        <div class="faq-item">
          <h4>Q: Bánh mì tươi có thể bảo quản được trong bao lâu?</h4>
          <p>A: Bánh mì men tự nhiên thưởng thức ngon nhất trong ngày. Bạn có thể bọc kín bảo quản ngăn mát 2-3 ngày và nướng lại trước khi ăn.</p>
        </div>
        <div class="faq-item">
          <h4>Q: Tiệm có hỗ trợ giao hàng tận nơi không?</h4>
          <p>A: Bites &amp; More có đội ngũ shipper riêng hỗ trợ đóng gói và giao hàng cẩn thận toàn thành phố Đà Nẵng.</p>
        </div>
        <div class="faq-item">
          <h4>Q: Tiệm có xuất hóa đơn GTGT (VAT) cho đơn hàng công ty không?</h4>
          <p>A: Có, chúng tôi hỗ trợ xuất hóa đơn VAT đầy đủ cho các đơn hàng đặt tiệc Teabreak hoặc quà tặng doanh nghiệp.</p>
        </div>
      </div>
    </div>

  </main>

  <!-- FOOTER -->
  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

</div>

<script src="js/app.js"></script>
</body>
</html>
