<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vie">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Cửa Hàng</title>
  <link rel="stylesheet" href="CSS/style.css">
  <style>
    .dropdown { position: relative; display: inline-block; }
    .dropdown-menu { display: none; position: absolute; top: 100%; left: 0; background: #fff; min-width: 160px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); padding: 8px 0; z-index: 99; border: 1px solid #eee; }
    .dropdown-menu a { color: #333; padding: 8px 16px; display: block; text-decoration: none; font-size: 14px; }
    .dropdown-menu a:hover { background: #f5f5f5; font-weight: bold; }
    .dropdown:hover .dropdown-menu { display: block; }
    
    .filter-row { cursor: pointer; padding: 8px 0; font-size: 14px; display: flex; align-items: center; gap: 8px; }
    .filter-row:hover { font-weight: bold; }
    
    /* Style cho Card Sản Phẩm */
    .shop-card { border: 1px solid #e5e5e5; border-radius: 4px; overflow: hidden; position: relative; background: #fff; height: 100%; display: flex; flex-direction: column; }
    .shop-card-img { width: 100%; height: 180px; object-fit: cover; display: block; }
    .shop-card-body { padding: 12px; flex: 1; display: flex; flex-direction: column; justify-content: space-between; }
    .shop-card-title { font-weight: bold; font-size: 15px; margin-bottom: 6px; color: #000; }
    .shop-card-price { font-weight: bold; font-size: 14px; color: #d9534f; margin: 6px 0; }
    .shop-cart-btn { background: #000; color: #fff; text-align: center; padding: 8px; font-size: 13px; font-weight: bold; border-radius: 3px; cursor: pointer; text-decoration: none; display: flex; align-items: center; justify-content: center; gap: 6px; }
    .shop-cart-btn:hover { background: #333; }
  </style>
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
      <a href="shop.jsp" style="text-decoration:underline;">Cửa hàng</a>
      
      <div class="dropdown">
        <a href="categories.jsp">Danh mục 
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
    <span>Cửa hàng</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span id="category-title">Tất Cả Sản Phẩm</span>
  </div>

  <!-- HERO BANNER CỬA HÀNG -->
  <div class="section" style="padding:0;">
    <div style="height:180px; background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)), url('https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=1200') center/cover no-repeat; display:flex; flex-direction:column; align-items:center; justify-content:center; color:#fff;">
      <h2 style="font-size:26px; margin:0 0 8px 0; letter-spacing:1px;" id="banner-title">DANH MỤC SẢN PHẨM</h2>
      <p style="font-size:13px; margin:0; opacity:0.9;">Tươi ngon mỗi ngày — Nướng thủ công từ nguyên liệu hữu cơ</p>
    </div>
  </div>

  <!-- MAIN SHOP SECTION -->
  <div class="section" style="padding:40px;">
    <div class="row">
      
      <!-- Cột Trái: Bộ Lọc Sidebar -->
      <div class="col-3">
        <div class="filter-block">
          <h5>TÌM KIẾM</h5>
          <div class="input" style="display:flex;align-items:center;gap:8px;color:#777;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
            Tên bánh...
          </div>
        </div>

        <div class="filter-block">
          <h5>DANH MỤC BÁNH</h5>
          <div class="filter-row" onclick="location.href='shop.jsp?category=all'">Tất cả sản phẩm</div>
          <div class="filter-row" onclick="location.href='shop.jsp?category=breads'">Bánh Mì (Breads)</div>
          <div class="filter-row" onclick="location.href='shop.jsp?category=cakes'">Bánh Kem (Cakes)</div>
          <div class="filter-row" onclick="location.href='shop.jsp?category=pastries'">Bánh Ngàn Lớp (Pastries)</div>
          <div class="filter-row" onclick="location.href='shop.jsp?category=cookies'">Bánh Quy (Cookies)</div>
          <div class="filter-row" onclick="location.href='shop.jsp?category=donuts'">Bánh Donuts</div>
          <div class="filter-row" onclick="location.href='shop.jsp?category=cupcakes'">Bánh Cupcake</div>
        </div>

        <div class="filter-block">
          <h5>KHOẢNG GIÁ (VND)</h5>
          <div style="display:flex;gap:10px;margin-bottom:14px;">
            <input class="input" placeholder="Từ">
            <input class="input" placeholder="Đến">
          </div>
        </div>

        <div class="btn btn-dark btn-block" style="cursor:pointer;text-align:center;">Áp Dụng Bộ Lọc</div>
      </div>

      <!-- Cột Phải: Danh Sách Sản Phẩm -->
      <div class="col-9">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;">
          <div style="font-size:14px;color:#444;" id="result-count">Đang tải sản phẩm...</div>
          <div style="display:flex;align-items:center;gap:10px;">
            <span style="font-size:13px;font-weight:bold;">Sắp xếp:</span>
            <select class="input" style="width:180px; padding:6px;">
              <option>Phổ biến nhất</option>
              <option>Giá: Thấp đến Cao</option>
              <option>Giá: Cao đến Thấp</option>
            </select>
          </div>
        </div>

        <!-- Grid Sản Phẩm Render Trực Tiếp -->
        <div class="row" id="shop-products-grid"></div>

        <!-- PAGINATION -->
        <div class="pagination" style="margin-top:30px;">
          <div class="page-num"><svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="15,6 9,12 15,18"/></svg></div>
          <div class="page-num active">1</div>
          <div class="page-num">2</div>
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
        <p style="max-width:320px;">Những mẻ bánh mới nướng thơm ngon giao tận tay bạn mỗi ngày. Chất lượng organic thuần khiết.</p>
      </div>
      <div class="col-2 footer-col">
        <h4>Đường Dẫn</h4>
        <a href="home.jsp">Trang chủ</a>
        <a href="shop.jsp">Cửa hàng</a>
        <a href="about.jsp">Giới thiệu</a>
      </div>
      <div class="col-3 footer-col">
        <h4>Dịch Vụ Khách Hàng</h4>
        <a href="profile.jsp">Tài khoản của tôi</a>
        <a href="favorites.jsp">Sản phẩm yêu thích</a>
      </div>
      <div class="col-3 footer-col">
        <h4>Nhận Tin Khuyến Mãi</h4>
        <p>Đăng ký email để nhận thông tin ưu đãi mới nhất</p>
        <div style="display:flex;gap:8px;">
          <input class="input" placeholder="Địa chỉ email" style="flex:1;">
          <div class="btn btn-dark btn-sm">Đăng ký</div>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <span>© 2026 Bites &amp; More. Bản quyền thuộc về tiệm bánh.</span>
      <span>Chính sách bảo mật &nbsp;|&nbsp; Điều khoản dịch vụ</span>
    </div>
  </div>

</div>

<!-- SCRIPT ĐỘC LẬP TỰ ĐỘNG ĐỔ ẢNH VÀ THÔNG TIN BÁNH -->
<script>
  window.addEventListener('DOMContentLoaded', function() {
    const bakeryItems = [
      // Bánh mì (breads)
      { cat: 'breads', name: 'Bánh Mì Sourdough Men Tự Nhiên', price: '60.000VND', reviews: 24, img: 'https://images.unsplash.com/photo-1509440159596-0249088772ff?q=80&w=400' },
      { cat: 'breads', name: 'Bánh Mì Baguette Pháp Giòn', price: '35.000VND', reviews: 30, img: 'https://images.unsplash.com/photo-1589367920969-ab8e050bbb04?q=80&w=400' },
      { cat: 'breads', name: 'Bánh Mì Nguyên Cám Hạt Dinh Dưỡng', price: '55.000VND', reviews: 19, img: 'https://images.unsplash.com/photo-1549931319-a545dcf3bc73?q=80&w=400' },
      { cat: 'breads', name: 'Bánh Mì Sandwich Bơ Sữa', price: '40.000VND', reviews: 15, img: 'https://images.unsplash.com/photo-1534620808146-d33bb39128b2?q=80&w=400' },

      // Bánh kem (cakes)
      { cat: 'cakes', name: 'Bánh Kem Red Velvet Hảo Hạng', price: '180.000VND', reviews: 50, img: 'https://images.unsplash.com/photo-1586985289688-ca3cf47d3e6e?q=80&w=400' },
      { cat: 'cakes', name: 'Bánh Kem Dâu Tây Tươi', price: '220.000VND', reviews: 42, img: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?q=80&w=400' },
      { cat: 'cakes', name: 'Bánh Kem Chocolate Truffle', price: '250.000VND', reviews: 38, img: 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?q=80&w=400' },
      { cat: 'cakes', name: 'Bánh Kem Matcha Trà Xanh', price: '195.000VND', reviews: 28, img: 'https://images.unsplash.com/photo-1535141192574-5d4897c13136?q=80&w=400' },

      // Bánh ngàn lớp (pastries)
      { cat: 'pastries', name: 'Bánh Croissant Bơ Pháp', price: '45.000VND', reviews: 60, img: 'https://images.unsplash.com/photo-1555507036-ab1f4038808a?q=80&w=400' },
      { cat: 'pastries', name: 'Bánh Tart Dâu Tây Ngọt Ngào', price: '50.200VND', reviews: 32, img: 'https://images.unsplash.com/photo-1519869325930-281384150729?q=80&w=400' },

      // Bánh Quy (cookies)
      { cat: 'cookies', name: 'Bánh Quy Chocolate Chip', price: '25.000VND', reviews: 45, img: 'https://images.unsplash.com/photo-1499636136210-6f4ee915583e?q=80&w=400' },

      // Bánh Donuts
      { cat: 'donuts', name: 'Bánh Donut Dâu Glaze', price: '30.000VND', reviews: 22, img: 'https://images.unsplash.com/photo-1551024709-8f23befc6f87?q=80&w=400' },

      // Bánh Cupcakes
      { cat: 'cupcakes', name: 'Bánh Chocolate Cupcake', price: '30.500VND', reviews: 18, img: 'https://images.unsplash.com/photo-1576618148400-f54bed99fcfd?q=80&w=400' }
    ];

    const categoryTitles = {
      'breads': 'Bánh Mì',
      'cakes': 'Bánh Kem & Sinh Nhật',
      'pastries': 'Bánh Ngàn Lớp',
      'cookies': 'Bánh Quy',
      'donuts': 'Bánh Donuts',
      'cupcakes': 'Bánh Cupcake',
      'all': 'Tất Cả Sản Phẩm'
    };

    const params = new URLSearchParams(window.location.search);
    const activeCat = params.get('category') || 'all';

    const itemsToShow = (activeCat === 'all') 
      ? bakeryItems 
      : bakeryItems.filter(item => item.cat === activeCat);

    const titleText = categoryTitles[activeCat] || 'Tất Cả Sản Phẩm';
    document.getElementById('category-title').innerText = titleText;
    document.getElementById('banner-title').innerText = titleText.toUpperCase();
    document.getElementById('result-count').innerText = `Hiển thị ${itemsToShow.length} sản phẩm thuộc danh mục ${titleText}`;

    const grid = document.getElementById('shop-products-grid');
    grid.innerHTML = itemsToShow.map(item => `
      <div class="col-3" style="margin-bottom:24px;">
        <div class="shop-card">
          <img src="${item.img}" alt="${item.name}" class="shop-card-img">
          <div class="shop-card-body">
            <div>
              <div class="shop-card-title">${item.name}</div>
              <div style="font-size:12px;color:#777;">★ 5.0 (${item.reviews} đánh giá)</div>
            </div>
            <div>
              <div class="shop-card-price">${item.price}</div>
              <div class="shop-cart-btn">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> 
                Thêm Giỏ Hàng
              </div>
            </div>
          </div>
        </div>
      </div>
    `).join('');
  });
</script>
</body>
</html>