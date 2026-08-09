<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Product Detail</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">FREE DELIVERY ON ORDERS OVER 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;CALL US: (000) 123-4567</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
    <nav class="wf-nav">
      <a href="home.jsp">Home</a>
      <a href="shop.jsp" style="text-decoration:underline;">Shop</a>
      <a href="categories.jsp">Categories <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">About</a>
      <a href="contact.jsp">Contact</a>
    </nav>
    <div class="wf-searchbar">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <span>Search products...</span>
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
    <span>Home</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span>Shop</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span>Cakes</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span>Red Velvet Cake</span>
  </div>

  <!-- MAIN PRODUCT DETAIL -->
  <div class="section" style="padding:40px;">
    <div class="row">
      
      <!-- Cột Trái: Hình Ảnh Sản Phẩm -->
      <div class="col-6">
        <div class="img-ph" style="height:480px;margin-bottom:16px;">Image (Main Product Image)</div>
        <div class="row">
          <div class="col-3"><div class="img-ph" style="height:100px;">Image 1</div></div>
          <div class="col-3"><div class="img-ph" style="height:100px;">Image 2</div></div>
          <div class="col-3"><div class="img-ph" style="height:100px;">Image 3</div></div>
          <div class="col-3"><div class="img-ph" style="height:100px;">Image 4</div></div>
        </div>
      </div>

      <!-- Cột Phải: Thông Tin Sản Phẩm -->
      <div class="col-6" style="padding-left:20px;">
        <div style="font-size:26px;font-weight:bold;margin-bottom:10px;">Red Velvet Cake</div>
        
        <!-- Rating Stars -->
        <div style="display:flex;align-items:center;gap:10px;margin-bottom:16px;">
          <span class="stars" style="display:flex;gap:2px;">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          </span>
          <span style="font-size:13px;color:#555;">(36 reviews)</span>
        </div>

        <div style="font-size:26px;font-weight:bold;margin-bottom:18px;">180.000VND</div>
        <div style="font-size:14px;color:#444;line-height:1.8;margin-bottom:24px;">Placeholder short description text for the product summarizing key ingredients and highlights of this bakery item.</div>
        
        <hr style="border:none;border-top:1px solid #000;margin-bottom:24px;">

        <!-- Tăng giảm số lượng -->
        <div style="display:flex;align-items:center;gap:20px;margin-bottom:24px;">
          <span style="font-weight:bold;font-size:13px;">Quantity</span>
          <div style="display:flex;border:1px solid #000;align-items:center;">
            <button style="padding:10px 16px;border:none;border-right:1px solid #000;background:#fff;cursor:pointer;">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><line x1="5" y1="12" x2="19" y2="12"/></svg>
            </button>
            <div style="padding:10px 20px;font-weight:bold;">1</div>
            <button style="padding:10px 16px;border:none;border-left:1px solid #000;background:#fff;cursor:pointer;">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><line x1="12" y1="5" x2="12" y2="19"/><line x1="5" y1="12" x2="19" y2="12"/></svg>
            </button>
          </div>
        </div>

        <!-- Các nút bấm mua hàng -->
        <div style="display:flex;gap:16px;">
          <button class="btn" style="flex:1;display:inline-flex;align-items:center;justify-content:center;gap:8px;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> 
            Add to Cart
          </button>
          <a href="checkout.jsp" class="btn btn-dark" style="flex:1;">Buy Now</a>
          <button class="btn" style="width:56px;padding:12px;">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
          </button>
        </div>

      </div>
    </div>
  </div>

  <!-- TABS MÔ TẢ & ĐÁNH GIÁ -->
  <div class="section" style="padding:40px;">
    <div style="display:flex;gap:40px;border-bottom:1px solid #000;margin-bottom:24px;">
      <div style="padding-bottom:14px;border-bottom:2px solid #000;font-weight:bold;font-size:14px;cursor:pointer;">Description</div>
      <div style="padding-bottom:14px;font-weight:bold;font-size:14px;color:#555;cursor:pointer;">Reviews (36)</div>
      <div style="padding-bottom:14px;font-weight:bold;font-size:14px;color:#555;cursor:pointer;">Shipping Info</div>
    </div>

    <div style="font-size:14px;color:#444;line-height:1.8;max-width:1100px;margin-bottom:40px;">Placeholder long-form description text for the product detail tab, explaining ingredients, allergens, storage instructions, and preparation details.</div>

    <!-- Customer Reviews -->
    <div class="section-title" style="text-align:left;margin-bottom:20px;">Customer Reviews</div>
    
    <div style="display:flex;gap:20px;padding:20px 0;border-bottom:1px solid #ccc;">
      <div class="img-ph" style="width:56px;height:56px;border-radius:50%;flex-shrink:0;">Img</div>
      <div>
        <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Alice Johnson</div>
        <div style="margin-bottom:8px;display:flex;gap:2px;">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
        </div>
        <div style="font-size:13px;color:#444;">Bánh rất mềm, thơm ngọt vừa phải! Đóng gói đẹp và giao hàng cực nhanh.</div>
      </div>
    </div>

    <div style="display:flex;gap:20px;padding:20px 0;border-bottom:1px solid #ccc;">
      <div class="img-ph" style="width:56px;height:56px;border-radius:50%;flex-shrink:0;">Img</div>
      <div>
        <div style="font-weight:bold;font-size:14px;margin-bottom:4px;">Mark Lee</div>
        <div style="margin-bottom:8px;display:flex;gap:2px;">
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg>
        </div>
        <div style="font-size:13px;color:#444;">Bánh ngon, kem béo ngậy đúng vị Red Velvet chuẩn.</div>
      </div>
    </div>
  </div>

  <!-- RELATED PRODUCTS -->
  <div class="section" style="padding:40px;">
    <div class="section-title" style="margin-bottom:24px;">Related Products</div>
    <div class="row">
      
      <div class="col-3">
        <div class="product-card">
          <div class="img-ph">Image</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Sourdough Bread</div>
            <div class="pc-price">60.000VND</div>
            <div class="pc-cart-btn">Add to Cart</div>
          </div>
        </div>
      </div>

      <div class="col-3">
        <div class="product-card">
          <div class="img-ph">Image</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Chocolate Cupcake</div>
            <div class="pc-price">30.500VND</div>
            <div class="pc-cart-btn">Add to Cart</div>
          </div>
        </div>
      </div>

      <div class="col-3">
        <div class="product-card">
          <div class="img-ph">Image</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Strawberry Tart</div>
            <div class="pc-price">50.200VND</div>
            <div class="pc-cart-btn">Add to Cart</div>
          </div>
        </div>
      </div>

      <div class="col-3">
        <div class="product-card">
          <div class="img-ph">Image</div>
          <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
          <div class="pc-body">
            <div class="pc-name">Butter Croissant</div>
            <div class="pc-price">40.000VND</div>
            <div class="pc-cart-btn">Add to Cart</div>
          </div>
        </div>
      </div>

    </div>
  </div>

  <!-- FOOTER -->
  <div class="wf-footer">
    <div class="footer-bottom">
      <span>© 2026 Bites &amp; More. All rights reserved.</span>
      <span>Privacy Policy &nbsp;|&nbsp; Terms of Service</span>
    </div>
  </div>

</div>

<!-- Nhúng file JS để gọi Servlet -->
<script src="js/app.js"></script>
</body>
</html>