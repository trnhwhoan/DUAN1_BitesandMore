<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Giỏ Hàng Của Bạn</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    :root {
      --pink-primary: #e86a85;
      --pink-dark: #d6526f;
      --pink-light: #fde8ed;
      --pink-subtle: #fff5f7;
      --bg-cream: #faf7f5;
      --text-chocolate: #2d1e1e;
      --text-muted: #7a6363;
      --border-soft: #f4c2c2;
      --shadow-sm: 0 4px 12px rgba(232, 106, 133, 0.08);
      --radius-sm: 8px;
      --radius-md: 12px;
      --radius-lg: 16px;
    }

    html, body {
      height: 100%; margin: 0; padding: 0;
      background-color: var(--bg-cream);
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: var(--text-chocolate);
    }

    .wire-page { display: flex; flex-direction: column; min-height: 100vh; width: 100%; }

    .main-content {
      flex: 1; width: 100%;
      padding: 24px 40px 60px 40px; box-sizing: border-box;
    }

    /* TOPBAR & HEADER */
    .wf-topbar {
      background: linear-gradient(135deg, var(--pink-primary), var(--pink-dark));
      color: #fff; font-size: 11px; font-weight: 600; text-align: center; padding: 8px 20px;
    }

    .wf-header {
      width: 100%; box-sizing: border-box; padding: 16px 40px;
      display: flex; align-items: center; justify-content: space-between;
      background: rgba(250, 247, 245, 0.95); border-bottom: 1px solid var(--border-soft);
      position: sticky; top: 0; z-index: 100;
    }

    .brand-logo {
      color: var(--pink-primary); text-decoration: none; font-weight: 800; font-size: 20px;
      border: 2px solid var(--pink-primary); padding: 6px 16px; background: #fff;
      border-radius: var(--radius-sm);
    }

    .wf-nav { display: flex; gap: 28px; align-items: center; }
    .wf-nav a { color: var(--text-chocolate); text-decoration: none; font-size: 13px; font-weight: 600; }
    .wf-nav a:hover { color: var(--pink-primary); }

    .header-actions { display: flex; align-items: center; gap: 16px; }
    .ic-btn {
      position: relative; display: inline-flex; align-items: center; justify-content: center;
      width: 38px; height: 38px; border-radius: 50%; background: #fff;
      border: 1px solid var(--border-soft); color: var(--text-chocolate); text-decoration: none;
    }

    .badge {
      position: absolute; top: -4px; right: -4px; background: var(--pink-primary);
      color: #fff; font-size: 10px; font-weight: bold; width: 18px; height: 18px;
      border-radius: 50%; display: flex; align-items: center; justify-content: center; border: 2px solid #fff;
    }

    .breadcrumb-bar {
      font-size: 13px; color: var(--text-muted); display: flex; align-items: center; gap: 8px; margin-bottom: 24px;
    }
    .breadcrumb-bar a { color: var(--text-muted); text-decoration: none; }

    /* CARD GIỎ HÀNG */
    .cart-card {
      border: 1.5px solid var(--border-soft); background: #fff;
      border-radius: var(--radius-lg); padding: 36px; box-sizing: border-box;
      box-shadow: var(--shadow-sm); margin-bottom: 32px;
    }

    .cart-title {
      font-size: 18px; font-weight: 800; text-transform: uppercase;
      letter-spacing: 0.5px; color: var(--text-chocolate); margin: 0 0 24px 0;
      border-bottom: 2px solid var(--pink-primary); padding-bottom: 12px;
    }

    /* BẢNG SẢN PHẨM GIỎ HÀNG */
    .cart-table { width: 100%; border-collapse: separate; border-spacing: 0; }
    .cart-table th {
      background: var(--pink-subtle); color: var(--text-chocolate);
      font-size: 12px; font-weight: 800; text-transform: uppercase;
      padding: 14px 16px; border-bottom: 2px solid var(--border-soft); text-align: left;
    }
    .cart-table td { padding: 18px 16px; border-bottom: 1px solid var(--border-soft); vertical-align: middle; }

    .cart-item-img {
      width: 64px; height: 64px; border-radius: var(--radius-sm);
      object-fit: cover; border: 1px solid var(--border-soft); flex-shrink: 0;
    }

    /* BỘ TĂNG GIẢM SỐ LƯỢNG */
    .qty-control {
      display: inline-flex; align-items: center;
      border: 1.5px solid var(--border-soft); border-radius: 20px;
      overflow: hidden; background: #fff;
    }

    .qty-btn {
      width: 32px; height: 32px; border: none; background: transparent;
      font-size: 16px; font-weight: bold; cursor: pointer; color: var(--text-chocolate);
      transition: background 0.2s;
    }
    .qty-btn:hover { background: var(--pink-light); color: var(--pink-primary); }

    .qty-input {
      width: 36px; height: 32px; border: none; text-align: center;
      font-size: 13px; font-weight: bold; outline: none; font-family: inherit;
    }

    .btn-remove-item {
      width: 32px; height: 32px; border-radius: 50%; border: 1px solid var(--border-soft);
      display: inline-flex; align-items: center; justify-content: center;
      color: var(--text-muted); text-decoration: none; transition: all 0.2s;
    }
    .btn-remove-item:hover { background: #ffe6e6; color: #d32f2f; border-color: #f8b4b4; }

    .cart-footer-row {
      display: flex; justify-content: space-between; align-items: center;
      margin-top: 32px; padding-top: 20px; border-top: 1.5px solid var(--border-soft);
    }

    .btn-continue {
      color: var(--text-chocolate); text-decoration: none; font-size: 13px;
      font-weight: 700; transition: color 0.2s;
    }
    .btn-continue:hover { color: var(--pink-primary); }

    .btn-checkout {
      background: var(--pink-primary); color: #fff; border: none;
      padding: 12px 32px; border-radius: 24px; font-size: 13px; font-weight: 700;
      text-transform: uppercase; cursor: pointer; text-decoration: none;
      display: inline-flex; align-items: center; gap: 8px; box-shadow: var(--shadow-sm);
      transition: background 0.2s;
    }
    .btn-checkout:hover { background: var(--pink-dark); }

    .minimal-footer {
      border-top: 1.5px solid var(--border-soft); background: #fff;
      padding: 20px 0; text-align: center; font-size: 13px; color: var(--text-muted);
    }
  </style>
</head>
<body>

<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">
    MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: 0766 766 999
  </div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home.jsp" class="brand-logo">BITES &amp; MORE</a>
    
    <nav class="wf-nav">
      <a href="home.jsp">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="categories.jsp">Danh mục</a>
      <a href="about.jsp">Giới thiệu</a>
      <a href="contact.jsp">Liên hệ</a>
    </nav>

    <div class="header-actions">
      <a href="cart" class="ic-btn" title="Giỏ hàng" style="border-color:var(--pink-primary); color:var(--pink-primary);">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge">${not empty sessionScope.cartSize ? sessionScope.cartSize : 0}</span>
      </a>

      <a href="profile.jsp" class="ic-btn" title="Tài khoản">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a>
    </div>
  </header>

  <main class="main-content">
    
    <!-- BREADCRUMB -->
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <strong style="color:var(--text-chocolate);">Giỏ hàng</strong>
    </div>

    <div class="cart-card">
      <h1 class="cart-title">GIỎ HÀNG CỦA BẠN</h1>

      <c:choose>
        <c:when test="${not empty sessionScope.cart && sessionScope.cart.size() > 0}">
          
          <div style="overflow-x:auto;">
            <table class="cart-table">
              <thead>
                <tr>
                  <th style="width: 45%;">SẢN PHẨM</th>
                  <th style="width: 15%;">GIÁ BÁNH</th>
                  <th style="width: 20%; text-align: center;">SỐ LƯỢNG</th>
                  <th style="width: 15%;">TẠM TÍNH</th>
                  <th style="width: 5%; text-align: center;">XÓA</th>
                </tr>
              </thead>
              <tbody>
                <c:set var="totalMoney" value="0" />
                <c:forEach items="${sessionScope.cart}" var="item">
                  <c:set var="itemSubtotal" value="${item.product.price * item.quantity}" />
                  <c:set var="totalMoney" value="${totalMoney + itemSubtotal}" />

                  <tr>
                    <td>
                      <div style="display: flex; align-items: center; gap: 16px;">
                        <img src="${item.product.image}" class="cart-item-img" onError="this.onerror=null;this.src='images/placeholder.jpg';">
                        <strong style="font-size: 14px; text-transform: uppercase;">${item.product.productName}</strong>
                      </div>
                    </td>

                    <td>
                      <strong style="color: var(--pink-primary);">
                        <fmt:formatNumber value="${item.product.price}" pattern="#,##0"/>đ
                      </strong>
                    </td>

                    <!-- CỘT NÚT TĂNG GIẢM SỐ LƯỢNG NỐI TRỰC TIẾP CARTSERVLET -->
                    <td style="text-align: center;">
                      <div class="qty-control">
                        <button type="button" class="qty-btn" onclick="updateQty('${item.productId}', ${item.quantity - 1})">-</button>
                        <input type="text" class="qty-input" value="${item.quantity}" readonly>
                        <button type="button" class="qty-btn" onclick="updateQty('${item.productId}', ${item.quantity + 1})">+</button>
                      </div>
                    </td>

                    <td>
                      <strong style="color: var(--pink-primary); font-size: 15px;">
                        <fmt:formatNumber value="${itemSubtotal}" pattern="#,##0"/>đ
                      </strong>
                    </td>

                    <td style="text-align: center;">
                      <a href="cart?action=remove&productId=${item.productId}" class="btn-remove-item" title="Xóa món bánh này" onclick="return confirm('Bạn có chắc muốn xóa bánh này khỏi giỏ?');">
                        ✕
                      </a>
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>

          <!-- FOOTER TỔNG TIỀN VÀ NÚT ĐẶT HÀNG -->
          <div class="cart-footer-row">
            <a href="shop" class="btn-continue">&larr; TIẾP TỤC CHỌN BÁNH</a>

            <div style="display: flex; align-items: center; gap: 24px;">
              <div style="font-size: 16px; font-weight: 800;">
                TỔNG CỘNG: <span style="color: var(--pink-primary); font-size: 22px; margin-left: 8px;">
                  <fmt:formatNumber value="${totalMoney}" pattern="#,##0"/>đ
                </span>
              </div>

              <a href="checkout.jsp" class="btn-checkout">
                TIẾN HÀNH THANH TOÁN &rarr;
              </a>
            </div>
          </div>

        </c:when>

        <c:otherwise>
          <!-- GIỎ HÀNG TRỐNG -->
          <div style="text-align: center; padding: 60px 20px;">
            <svg width="60" height="60" viewBox="0 0 24 24" fill="none" stroke="var(--pink-primary)" stroke-width="1.5" style="margin-bottom: 16px;">
              <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
            </svg>
            <h3 style="margin: 0 0 8px 0; color: var(--text-chocolate);">Giỏ hàng của bạn đang trống!</h3>
            <p style="color: var(--text-muted); font-size: 13px; margin-bottom: 24px;">Hãy chọn vài món bánh thơm ngon cho ngày mới nhé.</p>
            <a href="shop" class="btn-checkout" style="display: inline-flex;">KHÁM PHÁ CỬA HÀNG</a>
          </div>
        </c:otherwise>
      </c:choose>

    </div>

  </main>

  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>

<!-- SCRIPT GỬI CẬP NHẬT SỐ LƯỢNG VỀ CARTSERVLET (POST) -->
<script>
function updateQty(productId, newQty) {
  // Nếu giảm số lượng xuống 0 -> Xác nhận xóa
  if (newQty <= 0) {
    if (confirm("Bạn có muốn xóa món bánh này khỏi giỏ hàng?")) {
      window.location.href = "cart?action=remove&productId=" + productId;
    }
    return;
  }

  // Tạo Form submit ngầm gửi dữ liệu cập nhật về CartServlet
  var form = document.createElement('form');
  form.method = 'POST';
  form.action = 'cart';

  var actionInput = document.createElement('input');
  actionInput.type = 'hidden';
  actionInput.name = 'action';
  actionInput.value = 'update';
  form.appendChild(actionInput);

  var pIdInput = document.createElement('input');
  pIdInput.type = 'hidden';
  pIdInput.name = 'productId';
  pIdInput.value = productId;
  form.appendChild(pIdInput);

  var qtyInput = document.createElement('input');
  qtyInput.type = 'hidden';
  qtyInput.name = 'quantity';
  qtyInput.value = newQty;
  form.appendChild(qtyInput);

  document.body.appendChild(form);
  form.submit();
}
</script>

</body>
</html>