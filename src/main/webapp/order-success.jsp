<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
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
    /* SYSTEM DESIGN VARIABLES (ĐỒNG BỘ VỚI HOME.JSP) */
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
      --shadow-md: 0 8px 24px rgba(232, 106, 133, 0.12);
      --radius-sm: 8px;
      --radius-md: 12px;
      --radius-lg: 16px;
    }

    /* CANVAS BÁNH RƠI LẢ TẢ */
    #sweet-falling-canvas {
      position: fixed;
      top: 0;
      left: 0;
      width: 100vw;
      height: 100vh;
      pointer-events: none;
      z-index: 9999;
      opacity: 0.8;
    }

    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: var(--bg-cream);
      color: var(--text-chocolate);
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
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

    /* TOPBAR & HEADER */
    .wf-topbar {
      background: linear-gradient(135deg, var(--pink-primary), var(--pink-dark));
      color: #fff;
      font-size: 11px;
      font-weight: 600;
      letter-spacing: 0.5px;
      text-align: center;
      padding: 8px 20px;
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
    }

    .wf-header {
      width: 100%;
      box-sizing: border-box;
      padding: 16px 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: rgba(250, 247, 245, 0.95);
      backdrop-filter: blur(8px);
      border-bottom: 1px solid var(--border-soft);
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .brand-logo {
      color: var(--pink-primary);
      text-decoration: none;
      font-weight: 800;
      font-size: 20px;
      border: 2px solid var(--pink-primary);
      padding: 6px 16px;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: #fff;
      border-radius: var(--radius-sm);
      transition: all 0.25s ease;
      box-shadow: var(--shadow-sm);
    }
    .brand-logo:hover {
      background: var(--pink-primary);
      color: #fff;
      transform: translateY(-1px);
    }

    .wf-nav {
      display: flex;
      gap: 28px;
      align-items: center;
    }
    .wf-nav a {
      color: var(--text-chocolate);
      text-decoration: none;
      font-size: 13px;
      font-weight: 600;
      transition: color 0.2s;
    }
    .wf-nav a:hover, .wf-nav a.active {
      color: var(--pink-primary);
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
      font-weight: 700;
      color: var(--text-muted);
    }
    .step-number {
      width: 30px;
      height: 30px;
      border-radius: 50%;
      border: 1.5px solid var(--border-soft);
      background: #fff;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 12px;
      color: var(--text-muted);
    }
    .step-item.active {
      color: var(--pink-primary);
    }
    .step-item.active .step-number { 
      background: var(--pink-primary); 
      color: #fff; 
      border-color: var(--pink-primary);
    }
    .step-line { width: 40px; height: 2px; background: var(--pink-primary); }

    /* SUCCESS BOX */
    .success-card {
      background: #fff;
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-lg);
      padding: 40px 32px;
      text-align: center;
      box-shadow: var(--shadow-md);
    }

    .success-icon-wrap {
      width: 60px;
      height: 60px;
      background: var(--pink-primary);
      color: #fff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 20px auto;
      box-shadow: var(--shadow-sm);
    }

    .order-details-box {
      background: var(--pink-subtle);
      border: 1.5px solid var(--border-soft);
      border-radius: var(--radius-md);
      padding: 20px;
      text-align: left;
      font-size: 13px;
      margin: 24px 0 32px 0;
      line-height: 1.8;
      color: var(--text-muted);
    }

    .detail-row {
      display: flex;
      justify-content: space-between;
      border-bottom: 1px dashed var(--border-soft);
      padding-bottom: 8px;
      margin-bottom: 8px;
    }
    .detail-row:last-child {
      border-bottom: none;
      padding-bottom: 0;
      margin-bottom: 0;
    }
    .detail-row strong, .detail-row span:last-child {
      color: var(--text-chocolate);
    }

    .btn-group {
      display: flex;
      justify-content: center;
      gap: 12px;
      flex-wrap: wrap;
    }

    .btn-custom {
      padding: 12px 24px;
      font-size: 12px;
      font-weight: 700;
      text-decoration: none;
      transition: all 0.2s ease;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      cursor: pointer;
      border-radius: 20px;
    }

    .btn-primary-dark {
      background: var(--pink-primary);
      color: #fff;
      border: none;
      box-shadow: var(--shadow-sm);
    }
    .btn-primary-dark:hover {
      background: var(--pink-dark);
      transform: translateY(-1px);
    }

    .btn-outline-dark {
      background: #fff;
      color: var(--pink-primary);
      border: 1.5px solid var(--pink-primary);
    }
    .btn-outline-dark:hover {
      background: var(--pink-light);
    }

    .minimal-footer {
      border-top: 1.5px solid var(--border-soft);
      background: #fff;
      padding: 20px 0;
      text-align: center;
      font-size: 13px;
      color: var(--text-muted);
      margin-top: auto;
    }
  </style>
</head>
<body>

<!-- CANVAS BÁNH RƠI LẢ TẢ -->
<canvas id="sweet-falling-canvas"></canvas>

<div class="wire-page">

  <!-- TOPBAR VỚI ICON BÁNH MÌ -->
  <div class="wf-topbar">
    <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8c0-2.2-1.8-4-4-4H10C7.8 4 6 5.8 6 8c-2.2 0-4 1.8-4 4s1.8 4 4 4h12c2.2 0 4-1.8 4-4s-1.8-4-4-4z"/><path d="M10 4v12"/><path d="M14 4v12"/></svg>
    MIỄN PHÍ VẬN CHUYỂN CHO ĐƠN HÀNG TRÊN 100.000VND | HOTLINE: 0766 766 999
  </div>
  
  <!-- HEADER -->
  <header class="wf-header">
    <a href="home" class="brand-logo">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
      BITES &amp; MORE
    </a>
    <nav class="wf-nav">
      <a href="home">Trang chủ</a>
      <a href="shop">Cửa hàng</a>
      <a href="about">Giới thiệu</a>
      <a href="contact">Liên hệ</a>
    </nav>
  </header>

  <!-- MAIN CONTENT -->
  <main class="main-content">

    <!-- STEP PROGRESS BAR -->
    <div class="step-container">
      <div class="step-item active">
        <div class="step-number">1</div>
        <span>Giỏ hàng</span>
      </div>
      <div class="step-line"></div>
      <div class="step-item active">
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
        <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
      </div>

      <h1 style="font-size:20px;font-weight:800;margin:0 0 12px 0;color:var(--text-chocolate);">ĐẶT HÀNG THÀNH CÔNG!</h1>
      
      <p style="font-size:14px;color:var(--text-muted);margin:0;line-height:1.6;">
        Cảm ơn <strong style="color:var(--text-chocolate);"><c:out value="${sessionScope.lastOrder.recipientName}" default="Khách hàng"/></strong> đã tin tưởng lựa chọn <strong>Bites &amp; More</strong>.<br>
        Đơn hàng của bạn đã được tiếp nhận và đang trong quá trình xử lý.
      </p>

      <!-- THÔNG TIN ĐƠN HÀNG LẤY TỪ DATABASE / SESSION -->
      <div class="order-details-box">
        <div class="detail-row">
          <span>Mã đơn hàng:</span>
          <strong style="color:var(--pink-primary);font-size:15px;">#BM-<c:out value="${sessionScope.lastOrder.orderId}"/></strong>
        </div>

        <c:if test="${not empty sessionScope.lastOrder.recipientPhone}">
          <div class="detail-row">
            <span>Số điện thoại:</span>
            <span><c:out value="${sessionScope.lastOrder.recipientPhone}"/></span>
          </div>
        </c:if>

        <c:if test="${not empty sessionScope.lastOrder.shippingAddress}">
          <div class="detail-row">
            <span>Địa chỉ nhận hàng:</span>
            <span style="text-align:right;max-width:260px;"><c:out value="${sessionScope.lastOrder.shippingAddress}"/></span>
          </div>
        </c:if>

        <div class="detail-row">
          <span>Phương thức thanh toán:</span>
          <span><c:out value="${sessionScope.lastPaymentName}" default="Tiền mặt"/></span>
        </div>

        <div class="detail-row" style="border:none;margin-top:12px;padding-top:8px;border-top:1.5px solid var(--border-soft);">
          <span style="font-weight:700;color:var(--text-chocolate);font-size:14px;">Tổng thanh toán:</span>
          <strong style="font-size:18px;color:var(--pink-primary);font-weight:800;">
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
  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>

<!-- SCRIPT BÁNH RƠI -->
<script>
  (function() {
    const canvas = document.getElementById('sweet-falling-canvas');
    const ctx = canvas.getContext('2d');

    let width = canvas.width = window.innerWidth;
    let height = canvas.height = window.innerHeight;

    window.addEventListener('resize', () => {
      width = canvas.width = window.innerWidth;
      height = canvas.height = window.innerHeight;
    });

    const items = ['🥐', '🍰', '🍓', '🧁', '🍩', '🍪', '✨', '🍒'];
    const particleCount = 20; 
    const particles = [];

    class Particle {
      constructor() {
        this.reset();
      }

      reset() {
        this.x = Math.random() * width;
        this.y = Math.random() * -height;
        this.size = Math.random() * 14 + 14; 
        this.text = items[Math.floor(Math.random() * items.length)];
        this.speedY = Math.random() * 0.8 + 0.5; 
        this.speedX = Math.random() * 0.4 - 0.2; 
        this.rotation = Math.random() * 360;
        this.spin = Math.random() * 0.02 - 0.01; 
        this.opacity = Math.random() * 0.5 + 0.4;
      }

      update() {
        this.y += this.speedY;
        this.x += Math.sin(this.y * 0.01) * 0.5 + this.speedX;
        this.rotation += this.spin;

        if (this.y > height + 20) {
          this.reset();
          this.y = -20;
        }
      }

      draw() {
        ctx.save();
        ctx.translate(this.x, this.y);
        ctx.rotate(this.rotation);
        ctx.globalAlpha = this.opacity;
        ctx.font = this.size + 'px serif';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(this.text, 0, 0);
        ctx.restore();
      }
    }

    for (let i = 0; i < particleCount; i++) {
      particles.push(new Particle());
    }

    function animate() {
      ctx.clearRect(0, 0, width, height);
      particles.forEach(p => {
        p.update();
        p.draw();
      });
      requestAnimationFrame(animate);
    }

    animate();
  })();
</script>

</body>
</html>