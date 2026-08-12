<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Đặt hàng thành công</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
    }
    
    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    .main-content {
      flex: 1;
      width: 100%;
      max-width: 680px;
      margin: 40px auto 60px auto;
      padding: 0 20px;
      box-sizing: border-box;
    }

    /* STEP BAR */
    .step-container {
      display: flex;
      justify-content: center;
      align-items: center;
      gap: 20px;
      margin-bottom: 32px;
    }
    .step-item {
      display: flex;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      font-weight: bold;
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
    }
    .step-item.active .step-number { background: #000; color: #fff; }
    .step-line { width: 40px; height: 1px; background: #000; }

    /* SUCCESS BOX */
    .success-card {
      background: #fff;
      border: 1px solid #000;
      padding: 40px 32px;
      text-align: center;
    }

    .success-icon-wrap {
      width: 64px;
      height: 64px;
      background: #000;
      color: #fff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px auto;
    }

    .order-details-box {
      background: #fafafa;
      border: 1px solid #e5e5e5;
      padding: 20px;
      text-align: left;
      font-size: 14px;
      margin: 24px 0 32px 0;
      line-height: 1.8;
    }

    .detail-row {
      display: flex;
      justify-content: space-between;
      border-bottom: 1px dashed #e0e0e0;
      padding-bottom: 8px;
      margin-bottom: 8px;
    }
    .detail-row:last-child {
      border-bottom: none;
      padding-bottom: 0;
      margin-bottom: 0;
    }

    .btn-group {
      display: flex;
      justify-content: center;
      gap: 12px;
      flex-wrap: wrap;
    }

    .btn-custom {
      padding: 12px 24px;
      font-size: 13px;
      font-weight: bold;
      text-decoration: none;
      transition: all 0.2s ease;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      cursor: pointer;
    }

    .btn-primary-dark {
      background: #000;
      color: #fff;
      border: 1px solid #000;
    }
    .btn-primary-dark:hover {
      background: #333;
    }

    .btn-outline-dark {
      background: #fff;
      color: #000;
      border: 1px solid #000;
    }
    .btn-outline-dark:hover {
      background: #f0f0f0;
    }
  </style>
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar" style="background:#000;color:#fff;text-align:center;padding:8px;font-size:12px;letter-spacing:0.5px;">
    MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;HOTLINE: (000) 123-4567
  </div>
  
  <!-- HEADER -->
  <div class="wf-header" style="border-bottom:1px solid #000;padding:16px 20px;display:flex;justify-content:space-between;align-items:center;background:#fff;">
    <div class="wf-logo" style="font-weight:900;font-size:20px;letter-spacing:1px;">BITES &amp; MORE</div>
    <nav class="wf-nav" style="display:flex;gap:20px;font-size:13px;font-weight:bold;">
      <a href="home" style="color:#000;text-decoration:none;">Trang chủ</a>
      <a href="shop" style="color:#000;text-decoration:none;">Cửa hàng</a>
      <a href="about" style="color:#000;text-decoration:none;">Giới thiệu</a>
      <a href="contact" style="color:#000;text-decoration:none;">Liên hệ</a>
    </nav>
  </div>

  <!-- MAIN CONTENT -->
  <main class="main-content">

    <!-- STEP PROGRESS BAR -->
    <div class="step-container">
      <div class="step-item">
        <div class="step-number">1</div>
        <span>Giỏ hàng</span>
      </div>
      <div class="step-line"></div>
      <div class="step-item">
        <div class="step-number">2</div>
        <span>Giao hàng</span>
      </div>
      <div class="step-line"></div>
      <div class="step-item active">
        <div class="step-number">3</div>
        <span>Hoàn tất</span>
      </div>
    </div>

    <!-- KHỐI THÔNG BÁO TỔNG THỂ -->
    <div class="success-card">
      
      <div class="success-icon-wrap">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
      </div>

      <h1 style="font-size:24px;font-weight:bold;margin:0 0 12px 0;letter-spacing:0.5px;">ĐẶT HÀNG THÀNH CÔNG!</h1>
      
      <p style="font-size:14px;color:#555;margin:0;line-height:1.6;">
        Cảm ơn <strong style="color:#000;"><c:out value="${sessionScope.lastOrder.recipientName}" default="Khách hàng"/></strong> đã tin tưởng lựa chọn <strong>Bites &amp; More</strong>.<br>
        Đơn hàng của bạn đã được tiếp nhận và đang trong quá trình xử lý.
      </p>

      <!-- THÔNG TIN ĐƠN HÀNG LẤY TỪ DATABASE / SESSION -->
      <div class="order-details-box">
        <div class="detail-row">
          <span style="color:#666;">Mã đơn hàng:</span>
          <!-- Hiển thị Mã ID chuẩn theo Auto-Increment trong DB (VD: #BM-1024) -->
          <strong style="color:#000;font-size:15px;">#BM-<c:out value="${sessionScope.lastOrder.orderId}"/></strong>
        </div>

        <c:if test="${not empty sessionScope.lastOrder.recipientPhone}">
          <div class="detail-row">
            <span style="color:#666;">Số điện thoại:</span>
            <span><c:out value="${sessionScope.lastOrder.recipientPhone}"/></span>
          </div>
        </c:if>

        <c:if test="${not empty sessionScope.lastOrder.shippingAddress}">
          <div class="detail-row">
            <span style="color:#666;">Địa chỉ nhận hàng:</span>
            <span style="text-align:right;max-width:260px;"><c:out value="${sessionScope.lastOrder.shippingAddress}"/></span>
          </div>
        </c:if>

        <div class="detail-row">
          <span style="color:#666;">Phương thức thanh toán:</span>
          <span><c:out value="${sessionScope.lastPaymentName}" default="Tiền mặt"/></span>
        </div>

        <div class="detail-row" style="border:none;margin-top:12px;padding-top:8px;border-top:1px solid #000;">
          <span style="font-weight:bold;color:#000;font-size:15px;">Tổng thanh toán:</span>
          <strong style="font-size:18px;color:#000;">
            <fmt:formatNumber value="${sessionScope.lastOrder.finalAmount}" pattern="#,##0"/>đ
          </strong>
        </div>
      </div>

      <!-- NÚT HÀNH ĐỘNG -->
      <div class="btn-group">
        <a href="shop" class="btn-custom btn-primary-dark">
          TIẾP TỤC MUA SẮM
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
        </a>
        <a href="home" class="btn-custom btn-outline-dark">VỀ TRANG CHỦ</a>
      </div>

    </div>

  </main>

  <!-- FOOTER -->
  <footer style="border-top:1px solid #000; padding:20px 0; text-align:center; font-size:13px; color:#000; background:#fff; margin-top:auto;">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>
</body>
</html>
