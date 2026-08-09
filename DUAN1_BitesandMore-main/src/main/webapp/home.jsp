<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vie">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Trang Chủ</title>
  <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">FREE SHIP VỚI HOÁ ĐƠN TỪ 199.000VND&nbsp;&nbsp;|&nbsp;&nbsp; LIÊN HỆ NGAY: 0766 766 999</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
    <nav class="wf-nav">
      <a href="home.jsp" style="text-decoration:underline;">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="wf-searchbar">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <span>Tìm kiếm sản phẩm...</span>
    </div>
    <div class="wf-icons">
      <a href="favorites.jsp" class="ic-btn">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge">3</span>
      </a>
      <a href="cart.jsp" class="ic-btn">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge">2</span>
      </a>
      <a href="login.jsp" class="ic-btn">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a>
    </div>
  </div>

  <!-- HERO BANNER -->
  <div class="section" style="padding:0;">
    <div style="display:flex;align-items:center;">
      <img src="images/banner.jpg" alt="Sourdough Bread" style="width:100%; height:220px; object-fit:cover;">
    </div>
    <div style="padding:40px 80px;text-align:center;border-top:1px solid #000;">
      <div style="font-size:30px;font-weight:bold;margin-bottom:12px;">BÁNH NGON, BÁNH TƯƠI</div>
      <div style="font-size:14px;color:#444;margin-bottom:20px;">Hãy cùng khám phá những món bánh ngon nhất!</div>
      <a href="shop.jsp" class="btn btn-dark">MUA NGAY 
        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><line x1="4" y1="12" x2="20" y2="12"/><polyline points="14,6 20,12 14,18"/></svg>
      </a>
    </div>
  </div>

  <!-- PROMOTION -->
  <div class="section">
    <div class="row" style="align-items:center;">
     <div class="col-6">
  <img src="https://i.pinimg.com/736x/68/32/f4/6832f494796bd602418e07a6ac36c04c.jpg" alt="Bakery Image" style="width:100%; height:340px; object-fit:cover;">
</div>
      <div class="col-6" style="padding-left:20px;">
        <div class="tag">ƯU ĐÃI CÓ HẠN, HỐT NGAY KHẺO HẾT</div>
        <div style="font-size:24px;font-weight:bold;margin:16px 0;">Giảm 20% cho Cake Strawberry MewMew vừa mới ra mắt!</div>
        <div style="font-size:14px;color:#444;margin-bottom:24px;line-height:1.7;">Và còn rất nhiều ưu đãi hấp dẫn khác đang chờ đợi bạn!</div>
        <div class="btn btn-dark">NHẬN ƯU ĐÃI NGAY</div>
      </div>
    </div>
  </div>

  <!-- CATEGORIES -->
  <div class="section">
    <div class="section-title">Các loại bánh</div>
    <div class="section-subtitle">Cùng khám phá các loại bánh ngon nhất!</div>
    <div class="row">
      <div class="col-2" style="text-align:center;margin-bottom:20px;"><div class="img-ph" style="height:140px;"><img src="images/bread.jpg" alt="Bread" style="width:100%; height:100%; object-fit:cover;"></div><div style="margin-top:12px;font-size:14px;font-weight:bold;">Bánh mì</div></div>
      <div class="col-2" style="text-align:center;margin-bottom:20px;"><div class="img-ph" style="height:140px;"><img src="images/cakes.jpg" alt="Cake" style="width:100%; height:100%; object-fit:cover;"></div><div style="margin-top:12px;font-size:14px;font-weight:bold;">Bánh kem</div></div>
      <div class="col-2" style="text-align:center;margin-bottom:20px;"><div class="img-ph" style="height:140px;"><img src="images/pastries.jpg" alt="Pastry" style="width:100%; height:100%; object-fit:cover;"></div><div style="margin-top:12px;font-size:14px;font-weight:bold;">Bánh ngàn lớp</div></div>
      <div class="col-2" style="text-align:center;margin-bottom:20px;"><div class="img-ph" style="height:140px;"><img src="images/cookies.jpg" alt="Cookie" style="width:100%; height:100%; object-fit:cover;"></div><div style="margin-top:12px;font-size:14px;font-weight:bold;">Bánh quy</div></div>
      <div class="col-2" style="text-align:center;margin-bottom:20px;"><div class="img-ph" style="height:140px;"><img src="images/donuts.jpg" alt="Donut" style="width:100%; height:100%; object-fit:cover;"></div><div style="margin-top:12px;font-size:14px;font-weight:bold;">Bánh Donut</div></div>
      <div class="col-2" style="text-align:center;margin-bottom:20px;"><div class="img-ph" style="height:140px;"><img src="images/cupcakes.jpg" alt="Cupcake" style="width:100%; height:100%; object-fit:cover;"></div><div style="margin-top:12px;font-size:14px;font-weight:bold;">Bánh Cupcake</div></div>
    </div>
  </div>

  <!-- FEATURED PRODUCTS -->
  <div class="section">
    <div class="section-title">Sản Phẩm Nổi Bật</div>
    <div class="section-subtitle">Những món bánh được yêu thích nhất từ tiệm chúng tôi</div>
    <div class="row row-products">
      
      <!-- Card 1 -->
      <div class="col-3" style="margin-bottom:24px;">
        <div class="product-card">
          <div class="img-ph">Hình ảnh</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Bánh mì Men Tự Nhiên</div>
            <div class="pc-rating">
              <span class="stars">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              </span>
              <span>(24)</span>
            </div>
            <div class="pc-price">60.000VND</div>
            <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Thêm vào giỏ</div>
          </div>
        </div>
      </div>

      <!-- Card 2 -->
      <div class="col-3" style="margin-bottom:24px;">
        <div class="product-card">
          <div class="img-ph">Hình ảnh</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Bánh Cupcake Socola</div>
            <div class="pc-rating">
              <span class="stars">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              </span>
              <span>(18)</span>
            </div>
            <div class="pc-price">30.500VND</div>
            <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Thêm vào giỏ</div>
          </div>
        </div>
      </div>

      <!-- Card 3 -->
      <div class="col-3" style="margin-bottom:24px;">
        <div class="product-card">
          <div class="img-ph">Hình ảnh</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Bánh Tart Dâu Tây</div>
            <div class="pc-rating">
              <span class="stars">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              </span>
              <span>(32)</span>
            </div>
            <div class="pc-price">50.000VND</div>
            <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Thêm vào giỏ</div>
          </div>
        </div>
      </div>

      <!-- Card 4 -->
      <div class="col-3" style="margin-bottom:24px;">
        <div class="product-card">
          <div class="img-ph">Hình ảnh</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Bánh Kem Red Velvet</div>
            <div class="pc-rating">
              <span class="stars">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
                <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
              </span>
              <span>(50)</span>
            </div>
            <div class="pc-price">180.000VND</div>
            <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Thêm vào giỏ</div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- PROMOTIONAL BANNER -->
  <div class="section" style="padding:0;">
    <div class="img-ph" style="height:240px;">Hình ảnh (Banner Quảng Cáo)</div>
  </div>

  <!-- FOOTER -->
  <div class="wf-footer">
    <div class="row">
      <div class="col-4 footer-col">
        <h4>Bites &amp; More</h4>
        <p style="max-width:320px;">Bánh tươi mỗi ngày, giao tận nơi cho bạn. Tiệm bánh chuyên cung cấp các loại bánh ngọt và bánh mì chất lượng.</p>
        <div class="footer-social">
          <span><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M15 3h-2a4 4 0 0 0-4 4v3H7v3h2v8h3v-8h2.5l.5-3H12V7a1 1 0 0 1 1-1h2z"/></svg></span>
          <span><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M22 5.8c-.7.3-1.5.6-2.3.7.8-.5 1.4-1.3 1.7-2.3-.8.5-1.7.8-2.6 1a4 4 0 0 0-6.9 3.7A11.5 11.5 0 0 1 3.3 4.6a4 4 0 0 0 1.2 5.4c-.6 0-1.2-.2-1.7-.5v.1a4 4 0 0 0 3.2 4 4 4 0 0 1-1.8.1 4 4 0 0 0 3.8 2.8A8 8 0 0 1 2 18.5a11.4 11.4 0 0 0 6.3 1.8c7.5 0 11.7-6.3 11.7-11.7v-.5c.8-.6 1.5-1.3 2-2.1z"/></svg></span>
          <span><svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="2" width="20" height="20" rx="5"/><circle cx="12" cy="12" r="4"/><circle cx="18" cy="6" r="1"/></svg></span>
        </div>
      </div>
      <div class="col-2 footer-col">
        <h4>Liên Kết Nhanh</h4>
        <a href="home.jsp">Trang chủ</a>
        <a href="shop.jsp">Cửa hàng</a>
        <a href="about.jsp">Giới thiệu</a>
      </div>
      <div class="col-3 footer-col">
        <h4>Hỗ Trợ Khách Hàng</h4>
        <a href="profile.jsp">Tài khoản của tôi</a>
        <a href="favorites.jsp">Sản phẩm yêu thích</a>
      </div>
      <div class="col-3 footer-col">
        <h4>Đăng Ký Nhận Tin</h4>
        <p>Đăng ký để nhận ưu đãi &amp; thông tin mới nhất</p>
        <div style="display:flex;gap:8px;">
          <input class="input" placeholder="Địa chỉ Email" style="flex:1;">
          <div class="btn btn-dark btn-sm">Tham gia</div>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <span>© 2026 Bites &amp; More. Bản quyền thuộc về tiệm bánh.</span>
      <span>Chính sách bảo mật &nbsp;|&nbsp; Điều khoản dịch vụ</span>
    </div>
  </div>

</div>

<!-- NHÚNG FILE JS ĐỂ KẾT NỐI VỚI BACKEND -->
<script src="js/app.js"></script>
</body>
</html>