<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Thanh toán</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
    }
    
    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .main-content {
      flex: 1;
      width: 100%;
      max-width: 1140px;
      margin: 0 auto;
      padding: 20px 20px 60px 20px;
      box-sizing: border-box;
    }

    .breadcrumb {
      max-width: 1140px;
      margin: 0 auto;
      padding: 20px 20px 10px !important;
      border: none !important;
      background: transparent !important;
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      color: #666;
    }
    .breadcrumb a {
      color: #666;
      text-decoration: none;
      transition: color 0.2s;
    }
    .breadcrumb a:hover { color: #000; text-decoration: underline; }
    .breadcrumb span.active { color: #000; font-weight: 600; }

    .wire-page, .section, .wf-footer, .footer-bottom, .filter-block {
      border: none !important;
      background: transparent !important;
      box-shadow: none !important;
    }

    .checkout-grid {
      display: flex;
      gap: 32px;
      align-items: flex-start;
    }
    .checkout-col-left {
      flex: 1.3;
      display: flex;
      flex-direction: column;
      gap: 24px;
    }
    .checkout-col-right {
      flex: 1;
      position: sticky;
      top: 20px;
    }

    .form-box {
      border: 1px solid #000 !important;
      padding: 24px;
      background: #fff;
    }

    .form-row {
      display: flex;
      gap: 16px;
      margin-bottom: 16px;
    }
    .form-row:last-child {
      margin-bottom: 0;
    }
    .form-group {
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    .form-group label {
      font-size: 13px;
      font-weight: bold;
      margin-bottom: 6px;
    }

    .field-input {
      width: 100%;
      height: 42px;
      padding: 0 12px;
      border: 1px solid #000;
      font-size: 14px;
      outline: none;
      box-sizing: border-box;
      background: #fff;
    }
    .field-input:focus {
      background-color: #fafafa;
    }

    .payment-option {
      border: 1px solid #000;
      padding: 14px 16px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 12px;
      background: #fff;
    }

    /* STEP PROGRESS BAR */
    .step-item {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      font-weight: bold;
      transition: all 0.3s ease;
    }
    .step-number {
      width: 28px;
      height: 28px;
      border-radius: 50%;
      border: 1.5px solid #000;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      transition: all 0.3s ease;
    }
    .step-item.active .step-number { background: #000; color: #fff; }
    .step-item.inactive { opacity: 0.4; }

    /* THÔNG BÁO BƯỚC 3 */
    #order-success-box {
      display: none;
      background: #fff;
      border: 1px solid #000;
      padding: 48px 32px;
      text-align: center;
      max-width: 600px;
      margin: 0 auto;
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: (000) 123-4567</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop.jsp">Cửa hàng</a>
      <a href="categories.jsp">Danh mục <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>
    <div class="wf-searchbar">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <span>Tìm kiếm sản phẩm...</span>
    </div>
    <div class="wf-icons">
      <a href="feedback" class="ic-btn feedback-link" title="Góp ý" style="position:relative;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge fav-count">${not empty sessionScope.favoriteList ? sessionScope.favoriteList.size() : 0}</span>
      </a>
      <a href="cart.jsp" class="ic-btn" style="position:relative;">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge cart-count">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
      </a>
<c:choose><c:when test="${not empty sessionScope.account}"><a href="profile.jsp" class="ic-btn account-active" title="Tài khoản: ${sessionScope.account.fullName}">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a></c:when><c:otherwise><a href="login.jsp" class="ic-btn" title="Đăng nhập">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4 7 8 7"/></svg>
      </a></c:otherwise></c:choose>
    </div>
  </div>

  <!-- BREADCRUMB -->
  <div class="breadcrumb">
    <a href="home.jsp">Trang chủ</a>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <a href="cart.jsp">Giỏ hàng</a>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span class="active">Thanh toán</span>
  </div>

  <!-- MAIN CHECKOUT SECTION -->
  <div class="main-content">
    
    <!-- TIẾN TRÌNH STEP BAR -->
    <div style="display:flex;justify-content:center;align-items:center;gap:30px;margin-bottom:36px;">
      <div class="step-item active" id="step-1">
        <div class="step-number">1</div>
        <span>Giỏ hàng</span>
      </div>
      <div style="width:40px;height:1px;background:#000;" id="line-1"></div>
      <div class="step-item active" id="step-2">
        <div class="step-number">2</div>
        <span>Giao hàng &amp; Thanh toán</span>
      </div>
      <div style="width:40px;height:1px;background:#ccc;" id="line-2"></div>
      <div class="step-item inactive" id="step-3">
        <div class="step-number">3</div>
        <span>Xác nhận đơn</span>
      </div>
    </div>

    <!-- KHỐI 1: FORM ĐẶT HÀNG -->
    <c:if test="${not empty error}"><p style="color:#b00020;font-weight:bold;"><c:out value="${error}"/></p></c:if>
    <form id="checkout-form" action="checkout" method="POST">
      <div class="checkout-grid">
        
        <!-- CỘT TRÁI: NHẬP THÔNG TIN -->
        <div class="checkout-col-left">
          
          <!-- THÔNG TIN GIAO HÀNG -->
          <div class="form-box">
            <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin:0 0 20px 0;font-size:16px;font-weight:bold;">THÔNG TIN GIAO HÀNG</h5>
            
            <div class="form-row">
              <div class="form-group">
                <label>Họ *</label>
                <input type="text" name="lastName" id="input-lastName" class="field-input" placeholder="Nguyễn" required>
              </div>
              <div class="form-group">
                <label>Tên *</label>
                <input type="text" name="firstName" id="input-firstName" class="field-input" placeholder="Văn A" required>
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label>Số điện thoại *</label>
                <input type="tel" name="phone" id="input-phone" class="field-input" placeholder="0905 123 456" required>
              </div>
              <div class="form-group">
                <label>Email nhận hóa đơn</label>
                <input type="email" name="email" class="field-input" placeholder="nguyenvana@gmail.com">
              </div>
            </div>
            
            <div class="form-row">
              <div class="form-group">
                <label>Địa chỉ nhận hàng *</label>
                <input type="text" name="address" id="input-address" class="field-input" placeholder="Số nhà, tên đường, phường/xã" required>
              </div>
            </div>
            
            <div class="form-row">
              <div class="form-group">
                <label>Tỉnh / Thành phố *</label>
                <input type="text" name="city" class="field-input" placeholder="Đà Nẵng" required>
              </div>
              <div class="form-group">
                <label>Ghi chú giao hàng</label>
                <input type="text" name="note" class="field-input" placeholder="Giao giờ hành chính, gọi trước khi giao...">
              </div>
            </div>
          </div>

          <!-- PHƯƠNG THỨC THANH TOÁN -->
          <div class="form-box">
            <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin:0 0 20px 0;font-size:16px;font-weight:bold;">PHƯƠNG THỨC THANH TOÁN</h5>
            
            <div style="display:flex;flex-direction:column;gap:12px;">
              <label class="payment-option">
                <input type="radio" name="paymentMethod" value="cod" checked style="width:18px;height:18px;cursor:pointer;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="2" y="6" width="20" height="12" rx="2"/><circle cx="12" cy="12" r="3"/></svg>
                <span style="font-size:14px;font-weight:bold;">Thanh toán khi nhận hàng (COD)</span>
              </label>

              <label class="payment-option">
                <input type="radio" name="paymentMethod" value="card" style="width:18px;height:18px;cursor:pointer;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                <span style="font-size:14px;font-weight:bold;">Thẻ ngân hàng / Chuyển khoản QR</span>
              </label>
            </div>

            <div id="card-fields-box" style="display:none;background:#fafafa;padding:16px;border:1px solid #000;margin-top:16px;">
              <div class="form-row">
                <div class="form-group">
                  <label>Số thẻ / Số tài khoản</label>
                  <input type="text" name="cardNumber" class="field-input" placeholder="0000 0000 0000 0000">
                </div>
              </div>
              <div class="form-row" style="margin-bottom:0;">
                <div class="form-group">
                  <label>Ngày hết hạn</label>
                  <input type="text" name="expiry" class="field-input" placeholder="MM/YY">
                </div>
                <div class="form-group">
                  <label>Mã CVC/CVV</label>
                  <input type="password" name="cvv" class="field-input" placeholder="123">
                </div>
              </div>
            </div>

          </div>

        </div>

        <!-- CỘT PHẢI: TÓM TẮT SẢN PHẨM -->
        <div class="checkout-col-right">
          <div class="form-box">
            <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin:0 0 16px 0;font-size:16px;font-weight:bold;">SẢN PHẨM ĐẶT MUA</h5>
            
            <div id="checkout-item-list" style="max-height:300px;overflow-y:auto;margin-bottom:16px;padding-right:4px;">
              <!-- JS Render -->
            </div>

            <hr style="border:none;border-top:1px solid #000;margin:14px 0;">

            <div style="display:flex;justify-content:space-between;font-size:14px;margin-bottom:10px;"><span>Tạm tính</span><span id="checkout-subtotal" style="font-weight:bold;">0đ</span></div>
            <div style="display:flex;justify-content:space-between;font-size:14px;margin-bottom:10px;"><span>Phí vận chuyển</span><span id="checkout-shipping">0đ</span></div>

            <hr style="border:none;border-top:1px solid #000;margin:14px 0;">

            <div style="display:flex;justify-content:space-between;font-size:18px;font-weight:bold;margin-bottom:24px;"><span>TỔNG CỘNG</span><span id="checkout-total">0đ</span></div>
            
            <button type="submit" class="btn btn-dark btn-block" style="display:flex;align-items:center;justify-content:center;gap:8px;padding:14px;width:100%;font-size:14px;font-weight:bold;cursor:pointer;background:#000;color:#fff;border:none;">
              XÁC NHẬN ĐẶT HÀNG 
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.5"><polyline points="20,6 9,17 4,12"/></svg>
            </button>
          </div>
        </div>

      </div>
    </form>

    <!-- KHỐI 2: XÁC NHẬN ĐƠN HÀNG THÀNH CÔNG (BƯỚC 3) -->
    <div id="order-success-box">
      <div style="width:64px;height:64px;background:#000;color:#fff;border-radius:50%;display:flex;align-items:center;justify-content:center;margin:0 auto 20px auto;">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><polyline points="20,6 9,17 4,12"/></svg>
      </div>
      
      <h3 style="font-size:22px;font-weight:bold;margin-bottom:12px;">ĐẶT HÀNG THÀNH CÔNG!</h3>
      <p style="font-size:14px;color:#555;margin-bottom:24px;line-height:1.6;">
        Cảm ơn bạn <strong id="success-user-name"></strong> đã tin tưởng lựa chọn <strong>Bites &amp; More</strong>.<br>
        Mã đơn hàng của bạn là: <strong id="success-order-id" style="text-decoration:underline;">#BM8892</strong>.
      </p>

      <div style="background:#fafafa;border:1px solid #ddd;padding:16px;text-align:left;font-size:13px;margin-bottom:28px;">
        <div style="margin-bottom:8px;"><strong>Người nhận:</strong> <span id="success-receiver"></span></div>
        <div style="margin-bottom:8px;"><strong>Số điện thoại:</strong> <span id="success-phone"></span></div>
        <div style="margin-bottom:8px;"><strong>Địa chỉ:</strong> <span id="success-address"></span></div>
        <div><strong>Tổng thanh toán:</strong> <span id="success-total" style="font-weight:bold;color:#000;"></span></div>
      </div>

      <div style="display:flex;justify-content:center;gap:12px;">
        <a href="shop.jsp" class="btn btn-dark" style="padding:12px 24px;text-decoration:none;color:#fff;font-weight:bold;font-size:13px;display:inline-block;background:#000;">TIẾP TỤC MUA SẮM</a>
        <a href="home.jsp" class="btn" style="padding:12px 24px;text-decoration:none;color:#000;border:1px solid #000;font-weight:bold;font-size:13px;display:inline-block;">VỀ TRANG CHỦ</a>
      </div>
    </div>

  </div>

  <!-- FOOTER -->
  <div style="border-top:1px solid #000; padding:16px 0; text-align:center; font-size:13px; color:#000; background:#fff;">
    &copy; Bites &amp; More. since 2026
  </div>

</div>

<!-- Dữ liệu giỏ server được dùng làm nguồn chính tại bước thanh toán. -->
<div id="server-cart-data" hidden>
  <c:forEach items="${sessionScope.cart}" var="cartItem">
    <span class="server-cart-item"
      data-id="${cartItem.productId}"
      data-name="<c:out value='${cartItem.product.productName}'/>"
      data-price="${cartItem.product.price}" 
      data-image="<c:out value='${cartItem.product.image}'/>"
      data-quantity="${cartItem.quantity}"></span></span>
  </c:forEach>
</div>

<!-- SCRIPT CHUYỂN BƯỚC VÀ XÁC NHẬN ĐƠN HÀNG -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  var itemListContainer = document.getElementById("checkout-item-list");
  var subtotalEl = document.getElementById("checkout-subtotal");
  var shippingEl = document.getElementById("checkout-shipping");
  var totalEl = document.getElementById("checkout-total");
  var cardFieldsBox = document.getElementById("card-fields-box");
  var paymentRadios = document.querySelectorAll('input[name="paymentMethod"]');
  
  var checkoutForm = document.getElementById("checkout-form");
  var orderSuccessBox = document.getElementById("order-success-box");
  var step3 = document.getElementById("step-3");
  var line2 = document.getElementById("line-2");

  function getCart() {
    var serverItems = Array.from(document.querySelectorAll('.server-cart-item')).map(function (el) {
      return {
        id: el.dataset.id,
        name: el.dataset.name || 'Sản phẩm',
        price: el.dataset.price || '0',
        img: el.dataset.image || 'images/placeholder.jpg',
        quantity: parseInt(el.dataset.quantity, 10) || 1
      };
    });
    if (serverItems.length > 0) return serverItems;
    return JSON.parse(localStorage.getItem("bites_cart") || "[]");
  }

  function formatMoney(amount) {
    return amount.toLocaleString('vi-VN') + 'đ';
  }

  // HÀM ÉP GIÁ TIỀN ĐÃ ĐƯỢC CẢI TIẾN (SỬA LỖI ĐỘI GIÁ HÀNG TRIỆU)
  function parsePrice(priceInput) {
    if (typeof priceInput === 'number') return priceInput;
    if (!priceInput) return 0;
    
    var str = String(priceInput).trim();
    // Bỏ phần chữ sau dấu / (ví dụ: 35.000/hộp -> 35.000)
    str = str.split('/')[0];

    // BigDecimal từ server có dạng 28000.00; dấu chấm ở đây là phần thập phân.
    if (/^\d+\.\d{1,2}$/.test(str)) {
      return parseFloat(str);
    }
    // Nếu giá từ giao diện dạng Việt Nam "35.000" hoặc "35.000,00"
    if (str.includes('.')) {
      // Nếu có cả '.' và ',' (VD: 35.000,00) -> bỏ . lấy phần trước ,
      if (str.includes(',')) {
        str = str.split(',')[0].replace(/\./g, '');
      } else {
        // Trường hợp là 35.000đ -> xóa bỏ tất cả dấu chấm phân cách ngàn
        str = str.replace(/\./g, '');
      }
    } else if (str.includes(',')) {
      // Nếu dạng "35000,00"
      str = str.split(',')[0];
    }

    // Chỉ giữ lại chữ số
    var cleaned = str.replace(/[^0-9]/g, '');
    return parseInt(cleaned, 10) || 0;
  }

  function renderCheckoutSummary() {
    var cart = getCart();

    if (cart.length === 0) {
      if (itemListContainer) {
        itemListContainer.innerHTML = '<div style="font-size:13px;color:#666;text-align:center;padding:20px;">Giỏ hàng trống. <a href="shop.jsp" style="color:#000;text-decoration:underline;">Quay lại cửa hàng</a></div>';
      }
      return;
    }

    var html = "";
    var grandTotal = 0;

    cart.forEach(function (item) {
      var priceNum = parsePrice(item.price);
      var qty = item.quantity || 1;
      var subtotal = priceNum * qty;
      grandTotal += subtotal;

      html += '<div style="display:flex;justify-content:space-between;align-items:center;font-size:13px;margin-bottom:12px;padding-bottom:10px;border-bottom:1px dashed #ddd;gap:12px;">';
      html += '  <div style="display:flex;align-items:center;gap:10px;flex:1;min-width:0;">';
      html += '    <img src="' + item.img + '" style="width:44px;height:44px;object-fit:cover;background:#f5f5f5;flex-shrink:0;" onError="this.onerror=null;this.src=\'images/placeholder.jpg\';">';
      html += '    <div style="overflow:hidden;">';
      html += '      <div style="font-weight:bold;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;">' + item.name + '</div>';
      html += '      <div style="font-size:12px;color:#666;">Số lượng: ' + qty + '</div>';
      html += '    </div>';
      html += '  </div>';
      html += '  <span style="font-weight:bold;flex-shrink:0;margin-left:8px;">' + formatMoney(subtotal) + '</span>';
      html += '</div>';
    });

    if (itemListContainer) itemListContainer.innerHTML = html;

    var shipping = grandTotal >= 100000 ? 0 : 30000;
    if (subtotalEl) subtotalEl.innerText = formatMoney(grandTotal);
    if (shippingEl) shippingEl.innerText = shipping === 0 ? "MIỄN PHÍ" : formatMoney(shipping);
    if (totalEl) totalEl.innerText = formatMoney(grandTotal + shipping);
  }

  paymentRadios.forEach(function (radio) {
    radio.addEventListener("change", function () {
      if (this.value === "card") {
        cardFieldsBox.style.display = "block";
      } else {
        cardFieldsBox.style.display = "none";
      }
    });
  });

  renderCheckoutSummary();
});
</script>

  // NÚT XÁC NHẬN ĐẶT HÀNG -> CHUYỂN SANG BƯỚC 3
  if (checkoutForm) {
    checkoutForm.addEventListener("submit", function (e) {
      // The server validates prices, stock and payment, then persists the order.
      return;

      var cart = getCart();
      if (cart.length === 0) {
        alert("Giỏ hàng trống! Vui lòng chọn bánh trước khi thanh toán.");
        window.location.href = "shop.jsp";
        return;
      }

      // Lấy thông tin từ Input
      var lastName = document.getElementById("input-lastName").value.trim();
      var firstName = document.getElementById("input-firstName").value.trim();
      var phone = document.getElementById("input-phone").value.trim();
      var address = document.getElementById("input-address").value.trim();
      var totalText = totalEl ? totalEl.innerText : "0đ";

      // 1. Cập nhật thông tin vào bảng Bước 3
      document.getElementById("success-user-name").innerText = lastName + " " + firstName;
      document.getElementById("success-receiver").innerText = lastName + " " + firstName;
      document.getElementById("success-phone").innerText = phone;
      document.getElementById("success-address").innerText = address;
      document.getElementById("success-total").innerText = totalText;
      
      // Tạo mã đơn ngẫu nhiên
      document.getElementById("success-order-id").innerText = "#BM" + Math.floor(1000 + Math.random() * 9000);

      // 2. Ẩn form đặt hàng, Hiện khối Bước 3
      checkoutForm.style.display = "none";
      orderSuccessBox.style.display = "block";

      // 3. Cập nhật trạng thái Step Bar sang Bước 3
      if (step3) {
        step3.classList.remove("inactive");
        step3.classList.add("active");
      }
      if (line2) {
        line2.style.background = "#000";
      }

      // 4. Xóa giỏ hàng & Cập nhật lại badge đồng bộ qua app.js
      localStorage.removeItem("bites_cart");
      if (typeof updateGlobalBadges === "function") {
        updateGlobalBadges();
      }

      window.scrollTo({ top: 0, behavior: 'smooth' });
    });
  }

  renderCheckoutSummary();
});
</script>

<!-- SCRIPT APP.JS ĐỒNG BỘ NÚT BADGE TOÀN HỆ THỐNG -->
<script src="js/app.js"></script>
</body>
</html>
