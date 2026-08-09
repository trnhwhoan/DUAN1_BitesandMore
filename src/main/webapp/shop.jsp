<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Shop</title>
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
    <span>All Products</span>
  </div>

  <!-- MAIN SHOP SECTION -->
  <div class="section" style="padding:40px;">
    <div class="row">
      
      <!-- Cột Trái: Bộ Lọc (Filter Sidebar) -->
      <div class="col-3">
        <div class="filter-block">
          <h5>Search</h5>
          <div class="input" style="display:flex;align-items:center;gap:8px;color:#777;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            Search products...
          </div>
        </div>

        <div class="filter-block">
          <h5>Category</h5>
          <div class="filter-row"><span class="checkbox"></span>Breads</div>
          <div class="filter-row"><span class="checkbox"></span>Cakes</div>
          <div class="filter-row"><span class="checkbox"></span>Pastries</div>
          <div class="filter-row"><span class="checkbox"></span>Cookies</div>
          <div class="filter-row"><span class="checkbox"></span>Donuts</div>
          <div class="filter-row"><span class="checkbox"></span>Cupcakes</div>
        </div>

        <div class="filter-block">
          <h5>Price Range</h5>
          <div style="display:flex;gap:10px;margin-bottom:14px;">
            <input class="input" placeholder="Min">
            <input class="input" placeholder="Max">
          </div>
          <div class="img-ph" style="height:8px;"></div>
        </div>

        <div class="btn btn-dark btn-block">Apply Filters</div>
      </div>

      <!-- Cột Phải: Danh Sách Sản Phẩm -->
      <div class="col-9">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:24px;">
          <div style="font-size:14px;color:#444;">Showing 1-8 of 42 results</div>
          <div style="display:flex;align-items:center;gap:10px;">
            <span style="font-size:13px;font-weight:bold;">Sort By:</span>
            <div class="input" style="width:220px;display:flex;justify-content:space-between;align-items:center;">
              Popularity 
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg>
            </div>
          </div>
        </div>

        <!-- Grid Sản Phẩm (Thêm class row-products để file app.js đổ dữ liệu từ Java vào) -->
        <div class="row row-products">
          
          <!-- Product Card 1 -->
          <div class="col-3" style="margin-bottom:24px;">
            <div class="product-card">
              <div class="img-ph">Image</div>
              <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
              <div class="pc-body">
                <div class="pc-name">Sourdough Bread</div>
                <div class="pc-rating">
                  <span class="stars"><svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg></span>
                  <span>(24)</span>
                </div>
                <div class="pc-price">60.000VND</div>
                <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Add to Cart</div>
              </div>
            </div>
          </div>

          <!-- Product Card 2 -->
          <div class="col-3" style="margin-bottom:24px;">
            <div class="product-card">
              <div class="img-ph">Image</div>
              <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
              <div class="pc-body">
                <div class="pc-name">Chocolate Cupcake</div>
                <div class="pc-rating">
                  <span class="stars"><svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg></span>
                  <span>(18)</span>
                </div>
                <div class="pc-price">30.500VND</div>
                <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Add to Cart</div>
              </div>
            </div>
          </div>

          <!-- Product Card 3 -->
          <div class="col-3" style="margin-bottom:24px;">
            <div class="product-card">
              <div class="img-ph">Image</div>
              <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
              <div class="pc-body">
                <div class="pc-name">Strawberry Tart</div>
                <div class="pc-rating">
                  <span class="stars"><svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg></span>
                  <span>(32)</span>
                </div>
                <div class="pc-price">50.200VND</div>
                <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Add to Cart</div>
              </div>
            </div>
          </div>

          <!-- Product Card 4 -->
          <div class="col-3" style="margin-bottom:24px;">
            <div class="product-card">
              <div class="img-ph">Image</div>
              <div class="fav-icon"><svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg></div>
              <div class="pc-body">
                <div class="pc-name">Red Velvet Cake</div>
                <div class="pc-rating">
                  <span class="stars"><svg width="14" height="14" viewBox="0 0 24 24" fill="#000"><polygon points="12,2 15,9 22,9.5 17,14.5 18.5,21.5 12,17.8 5.5,21.5 7,14.5 2,9.5 9,9"/></svg></span>
                  <span>(50)</span>
                </div>
                <div class="pc-price">180.000VND</div>
                <div class="pc-cart-btn"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Add to Cart</div>
              </div>
            </div>
          </div>

        </div>

        <!-- PAGINATION -->
        <div class="pagination">
          <div class="page-num"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="15,6 9,12 15,18"/></svg></div>
          <div class="page-num active">1</div>
          <div class="page-num">2</div>
          <div class="page-num">3</div>
          <div class="page-num"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg></div>
        </div>

      </div>
    </div>
  </div>

  <!-- FOOTER -->
  <div class="wf-footer">
    <div class="row">
      <div class="col-4 footer-col">
        <h4>Bites &amp; More</h4>
        <p style="max-width:320px;">Freshly baked goods delivered to your door. Placeholder description text for the bakery footer about section.</p>
      </div>
      <div class="col-2 footer-col">
        <h4>Quick Links</h4>
        <a href="home.jsp">Home</a>
        <a href="shop.jsp">Shop</a>
        <a href="about.jsp">About Us</a>
      </div>
      <div class="col-3 footer-col">
        <h4>Customer Service</h4>
        <a href="profile.jsp">My Account</a>
        <a href="favorites.jsp">Wishlist</a>
      </div>
      <div class="col-3 footer-col">
        <h4>Newsletter</h4>
        <p>Subscribe for offers &amp; updates</p>
        <div style="display:flex;gap:8px;">
          <input class="input" placeholder="Email address" style="flex:1;">
          <div class="btn btn-dark btn-sm">Join</div>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <span>© 2026 Bites &amp; More. All rights reserved.</span>
      <span>Privacy Policy &nbsp;|&nbsp; Terms of Service</span>
    </div>
  </div>

</div>

<!-- Nhúng file JS để gọi API Java Servlet -->
<script src="js/app.js"></script>
</body>
</html>