<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Giỏ hàng</title>
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
    
    .wire-page { display: flex; flex-direction: column; min-height: 100vh; width: 100%; }
    .main-content { flex: 1; width: 100%; padding: 24px 40px 60px 40px; box-sizing: border-box; }

    .wf-topbar { background: #000; color: #fff; font-size: 11px; font-weight: bold; text-align: center; padding: 8px 20px; }

    .wf-header {
      width: 100%; box-sizing: border-box; padding: 16px 40px; display: flex; align-items: center; justify-content: space-between; background: #f8f8f8; border-bottom: 1px solid #000; position: sticky; top: 0; z-index: 100;
    }

    .brand-logo { color: #000; text-decoration: none; font-weight: bold; font-size: 20px; border: 1px solid #000; padding: 6px 16px; display: inline-block; background: #fff; transition: all 0.2s; }
    .brand-logo:hover { background: #000; color: #fff; }

    .wf-nav { display: flex; gap: 24px; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }

    .header-actions { display: flex; align-items: center; gap: 20px; }
    .search-box { display: flex; align-items: center; gap: 8px; border: 1px solid #000; padding: 6px 12px; background: #fff; width: 240px; }
    .search-box input { border: none; outline: none; font-size: 13px; width: 100%; background: transparent; }

    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }
    .ic-btn .badge { position: absolute; top: -6px; right: -8px; background: #000; color: #fff; font-size: 10px; font-weight: bold; padding: 2px 5px; border-radius: 50%; }

    .breadcrumb-bar { font-size: 12px; color: #666; display: flex; align-items: center; gap: 8px; margin-bottom: 24px; }
    .breadcrumb-bar a { color: #666; text-decoration: none; }

    .cart-grid { display: grid; grid-template-columns: 1fr 340px; gap: 32px; }
    .cart-box { background: #fff; border: 1px solid #000; padding: 20px; }

    .btn-qty { padding: 6px 12px; border: none; background: #fff; cursor: pointer; }
    .empty-cart-state { display: none; text-align: center; padding: 60px 20px; background: #fff; border: 1px solid #000; }

    .minimal-footer { border-top: 1px solid #000; background: #fff; padding: 20px 0; text-align: center; font-size: 13px; color: #000; width: 100%; }

    @media (max-width: 992px) { .cart-grid { grid-template-columns: 1fr; } }
  </style>
</head>
<body>
<div class="wire-page">

  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: (000) 123-4567</div>
  
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <div class="search-box">
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        <input type="text" placeholder="Tìm kiếm sản phẩm...">
      </div>

      <a href="favorites.jsp" class="ic-btn" title="Yêu thích">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">0</span>
      </a>

      <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">0</span>
      </a>

      <a href="login.jsp" class="ic-btn" title="Tài khoản">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a>
    </div>
  </header>

  <main class="main-content">
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span> <strong style="color:#000;">Giỏ hàng</strong>
    </div>

    <div id="cart-content">
      <h2 style="font-size:20px;font-weight:bold;margin:0 0 20px 0;">Giỏ Hàng Của Bạn (<span class="cart-items-total">2</span> món)</h2>
      
      <div class="cart-grid">
        <div class="cart-box">
          <table style="width:100%;border-collapse:collapse;font-size:13px;">
            <thead>
              <tr style="border-bottom:2px solid #000;text-align:left;">
                <th style="padding:12px 8px;">Sản phẩm</th>
                <th style="padding:12px 8px;">Đơn giá</th>
                <th style="padding:12px 8px;">Số lượng</th>
                <th style="padding:12px 8px;text-align:right;">Thành tiền</th>
              </tr>
            </thead>
            <tbody id="cart-table-body"></tbody>
          </table>

          <div style="display:flex;justify-content:space-between;margin-top:24px;align-items:center;">
            <a href="shop.jsp" style="display:inline-flex;align-items:center;gap:6px;text-decoration:none;color:#000;border:1px solid #000;padding:8px 16px;font-weight:bold;font-size:12px;">
              &lsaquo; Tiếp tục mua sắm
            </a>
            <div style="display:flex;gap:8px;">
              <input style="width:140px;padding:6px 10px;border:1px solid #000;font-size:12px;" placeholder="Mã giảm giá">
              <button type="button" style="padding:6px 14px;background:#000;color:#fff;border:none;cursor:pointer;font-weight:bold;font-size:12px;">Áp dụng</button>
            </div>
          </div>
        </div>

        <div class="cart-box">
          <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin:0 0 16px 0;font-size:15px;font-weight:bold;">TÓM TẮT ĐƠN HÀNG</h5>
          <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:12px;"><span>Tạm tính</span><span id="summary-subtotal" style="font-weight:bold;">0đ</span></div>
          <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:12px;"><span>Phí vận chuyển</span><span id="summary-shipping">0đ</span></div>
          <hr style="border:none;border-top:1px solid #000;margin:12px 0;">
          <div style="display:flex;justify-content:space-between;font-size:16px;font-weight:bold;margin-bottom:20px;"><span>Tổng cộng</span><span id="summary-total">0đ</span></div>
          <a href="checkout.jsp" style="display:flex;align-items:center;justify-content:center;text-decoration:none;color:#fff;background:#000;padding:12px;width:100%;font-weight:bold;font-size:13px;box-sizing:border-box;">
            Tiến hành thanh toán &rsaquo;
          </a>
        </div>
      </div>
    </div>

    <div class="empty-cart-state" id="empty-cart-state">
      <div style="font-size:16px;font-weight:bold;margin-bottom:8px;">Giỏ hàng của bạn đang trống</div>
      <a href="shop.jsp" style="display:inline-block;padding:10px 24px;text-decoration:none;color:#fff;background:#000;font-weight:bold;font-size:12px;">Khám phá cửa hàng</a>
    </div>
  </main>

  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>

<script>
(function() {
  function getCart() { return JSON.parse(localStorage.getItem("bites_cart") || "[]"); }
  function saveCart(cart) { localStorage.setItem("bites_cart", JSON.stringify(cart)); renderCart(); if (typeof updateGlobalBadges === "function") updateGlobalBadges(); }
  function formatMoney(amount) { return amount.toLocaleString('vi-VN') + 'đ'; }
  function parsePrice(priceStr) { if (typeof priceStr === 'number') return priceStr; return parseInt(String(priceStr).replace(/[^0-9]/g, '')) || 0; }

  function renderCart() {
    var tableBody = document.getElementById("cart-table-body");
    var cartContent = document.getElementById("cart-content");
    var emptyState = document.getElementById("empty-cart-state");
    var subtotalEl = document.getElementById("summary-subtotal");
    var shippingEl = document.getElementById("summary-shipping");
    var totalEl = document.getElementById("summary-total");

    var cart = getCart();
    var grandTotal = 0;

    if (cart.length === 0) {
      if (cartContent) cartContent.style.display = "none";
      if (emptyState) emptyState.style.display = "block";
      return;
    }

    if (cartContent) cartContent.style.display = "block";
    if (emptyState) emptyState.style.display = "none";

    var html = "";
    cart.forEach(function (item, index) {
      var priceNum = parsePrice(item.price);
      var qty = item.quantity || 1;
      var subtotal = priceNum * qty;
      grandTotal += subtotal;

      html += '<tr style="border-bottom:1px solid #ddd;">';
      html += '  <td style="display:flex;align-items:center;gap:12px;padding:12px 8px;">';
      html += '    <img src="' + item.img + '" style="width:50px;height:50px;object-fit:cover;border:1px solid #000;" onError="this.onerror=null;this.src=\'images/placeholder.jpg\';">';
      html += '    <span style="font-weight:bold;">' + item.name + '</span>';
      html += '  </td>';
      html += '  <td style="padding:12px 8px;">' + formatMoney(priceNum) + '</td>';
      html += '  <td style="padding:12px 8px;">';
      html += '    <div style="display:flex;border:1px solid #000;width:90px;align-items:center;">';
      html += '      <button type="button" class="btn-qty action-minus" data-idx="' + index + '">-</button>';
      html += '      <div style="padding:4px 8px;font-weight:bold;flex:1;text-align:center;">' + qty + '</div>';
      html += '      <button type="button" class="btn-qty action-plus" data-idx="' + index + '">+</button>';
      html += '    </div>';
      html += '  </td>';
      html += '  <td style="font-weight:bold;padding:12px 8px;text-align:right;">' + formatMoney(subtotal) + '</td>';
      html += '</tr>';
    });

    tableBody.innerHTML = html;
    var shipping = grandTotal >= 100000 ? 0 : 30000;
    if (shippingEl) shippingEl.innerText = shipping === 0 ? "MIỄN PHÍ" : formatMoney(shipping);
    if (subtotalEl) subtotalEl.innerText = formatMoney(grandTotal);
    if (totalEl) totalEl.innerText = formatMoney(grandTotal + shipping);
  }

  document.addEventListener("click", function (e) {
    var plusBtn = e.target.closest(".action-plus");
    var minusBtn = e.target.closest(".action-minus");
    if (!plusBtn && !minusBtn) return;

    var cart = getCart();
    if (plusBtn) {
      var idx = parseInt(plusBtn.getAttribute("data-idx"));
      cart[idx].quantity = (cart[idx].quantity || 1) + 1;
      saveCart(cart);
    } else if (minusBtn) {
      var idx = parseInt(minusBtn.getAttribute("data-idx"));
      var currentQty = cart[idx].quantity || 1;
      if (currentQty > 1) {
        cart[idx].quantity -= 1;
        saveCart(cart);
      } else {
        if (confirm("Xoá sản phẩm này khỏi giỏ hàng?")) {
          cart.splice(idx, 1);
          saveCart(cart);
        }
      }
    }
  });

  renderCart();
})();
</script>
<script src="js/app.js"></script>
</body>
</html>