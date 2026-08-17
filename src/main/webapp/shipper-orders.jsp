<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Bảng Làm Việc Shipper</title>
  <style>
    :root {
      --pink-primary: #e86a85;
      --pink-dark: #d6526f;
      --pink-light: #fde8ed;
      --pink-subtle: #fff7f8;
      --bg-cream: #faf7f5;
      --text-chocolate: #2b1b1b;
      --text-muted: #8c7373;
      --border-soft: #f1cfd5;
      --shadow-sm: 0 2px 10px rgba(232, 106, 133, 0.06);
      --radius-sm: 8px;
      --radius-md: 12px;
    }

    body {
      margin: 0; padding: 24px 40px; background-color: var(--bg-cream);
      font-family: system-ui, -apple-system, sans-serif; color: var(--text-chocolate);
    }

    .shipper-topbar {
      display: flex; justify-content: space-between; align-items: center;
      margin-bottom: 24px; background: #fff; padding: 18px 28px;
      border: 1px solid var(--border-soft); border-radius: var(--radius-md);
      box-shadow: var(--shadow-sm);
    }

    /* 3 TABS HEADER */
    .tab-container {
      display: flex; gap: 12px; margin-bottom: 20px;
    }
    .tab-btn {
      padding: 10px 22px; font-size: 13px; font-weight: 800; border-radius: 20px;
      border: 1.5px solid var(--border-soft); background: #fff; color: var(--text-chocolate);
      cursor: pointer; transition: all 0.2s;
    }
    .tab-btn.active {
      background: var(--pink-primary); color: #fff; border-color: var(--pink-primary);
    }

    .content-box-card {
      background: #fff; border: 1px solid var(--border-soft);
      border-radius: var(--radius-md); padding: 28px; box-shadow: var(--shadow-sm);
    }

    .shipper-table { width: 100%; border-collapse: separate; border-spacing: 0; font-size: 13px; table-layout: fixed; }
    .shipper-table th {
      background: var(--pink-subtle); color: var(--text-chocolate);
      font-size: 11px; font-weight: 800; text-transform: uppercase;
      padding: 14px; border-bottom: 2px solid var(--border-soft); text-align: left;
    }
    .shipper-table td { padding: 16px 14px; border-bottom: 1px solid var(--border-soft); vertical-align: middle; }

    .clickable-row { cursor: pointer; transition: background 0.15s; }
    .clickable-row:hover { background: var(--pink-subtle); }

    /* STATUS BADGE */
    .status-badge {
      display: inline-flex; align-items: center; gap: 4px;
      padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase;
    }
    .status-badge.confirmed { background: #e6fffa; color: #234e52; }
    .status-badge.processing { background: #ebf8ff; color: #2b6cb0; }
    .status-badge.shipping { background: #f3e8ff; color: #6b21a8; }
    .status-badge.delivered { background: #e6ffed; color: #22543d; }

    /* BUTTONS */
    .btn-action {
      padding: 6px 14px; border-radius: 20px; font-size: 11px; font-weight: 800;
      border: none; cursor: pointer; text-transform: uppercase; transition: opacity 0.2s;
    }
    .btn-take { background: #2563eb; color: #fff; }
    .btn-pickup { background: #f59e0b; color: #fff; }
    .btn-finish { background: #10b981; color: #fff; }
    .btn-action:hover { opacity: 0.85; }

    /* POPUP MODAL */
    .modal-overlay {
      position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
      background: rgba(0,0,0,0.4); backdrop-filter: blur(2px);
      display: flex; align-items: center; justify-content: center; z-index: 9999;
    }
    .modal-box {
      background: #fff; width: 520px; max-width: 90%; border-radius: 12px;
      border: 1.5px solid var(--border-soft); overflow: hidden; padding: 24px;
    }
  </style>
</head>
<body>

  <!-- TOPBAR -->
  <div class="shipper-topbar">
    <div>
      <div style="font-size:18px; font-weight:900; color:var(--pink-primary); text-transform:uppercase;">
        🛵 BẢNG ĐIỀU KHIỂN GIAO HÀNG
      </div>
      <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">
        Xin chào, <strong>${sessionScope.account.fullName}</strong>
      </div>
    </div>
    <a href="logout" style="color:#d32f2f; font-weight:700; font-size:13px; text-decoration:none;">Đăng xuất</a>
  </div>

  <c:if test="${not empty sessionScope.shipperMsg}">
    <div style="background:#e6ffed; border:1px solid #b7ebc5; color:#22543d; padding:12px 18px; border-radius:8px; margin-bottom:18px; font-weight:bold; font-size:13px;">
      ${sessionScope.shipperMsg}
    </div>
    <c:remove var="shipperMsg" scope="session"/>
  </c:if>

  <!-- 3 TAB ĐIỀU HƯỚNG -->
  <div class="tab-container">
    <button class="tab-btn active" id="btn-tab-available" onclick="switchTab('tab-available', this)">
      📦 Đơn hàng mới (${availableOrders.size()})
    </button>
    <button class="tab-btn" id="btn-tab-active" onclick="switchTab('tab-active', this)">
      🛵 Đơn đang giao (${activeOrders.size()})
    </button>
    <button class="tab-btn" id="btn-tab-completed" onclick="switchTab('tab-completed', this)">
      ✅ Đơn đã hoàn tất (${completedOrders.size()})
    </button>
  </div>

  <!-- ================= TAB 1: ĐƠN HÀNG MỚI (CHỜ NHẬN) ================= -->
  <div id="tab-available" class="tab-pane content-box-card">
    <div style="overflow-x:auto;">
      <table class="shipper-table">
        <thead>
          <tr>
            <th style="width:8%;">Mã Đơn</th>
            <th style="width:16%;">Khách Hàng</th>
            <th style="width:12%;">Số Điện Thoại</th>
            <th style="width:26%;">Địa Chỉ Nhận Hàng</th>
            <th style="width:12%;">Thu Hộ (COD)</th>
            <th style="width:12%; text-align:center;">Trạng Thái</th>
            <th style="width:14%; text-align:center;">Thao Tác</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty availableOrders}">
              <c:forEach items="${availableOrders}" var="o">
                <tr class="clickable-row" onclick="viewOrderDetail('${o.id != 0 ? o.id : o.orderId}')" title="Bấm xem chi tiết">
                  <td><strong style="color:var(--pink-primary); text-decoration:underline;">#BM${o.id != 0 ? o.id : o.orderId}</strong></td>
                  <td><strong>${o.recipientName}</strong></td>
                  <td onclick="event.stopPropagation();"><a href="tel:${o.recipientPhone}" style="color:#2563eb; font-weight:bold; text-decoration:none;">${o.recipientPhone}</a></td>
                  <td style="word-break:break-word;">${o.shippingAddress}</td>
                  <td><strong style="color:var(--pink-primary);"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/>đ</strong></td>
                  <td style="text-align:center;"><span class="status-badge confirmed">Chờ nhận</span></td>
                  <td style="text-align:center;" onclick="event.stopPropagation();">
                    <form action="shipper" method="POST" style="margin:0;">
                      <input type="hidden" name="orderId" value="${o.id != 0 ? o.id : o.orderId}">
                      <input type="hidden" name="action" value="take_order">
                      <button type="submit" class="btn-action btn-take">🛵 Nhận giao</button>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr><td colspan="7" style="text-align:center; padding:32px; color:var(--text-muted);">Hiện không có đơn hàng mới nào cần nhận.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <!-- ================= TAB 2: ĐƠN ĐANG GIAO (TIẾN ĐỘ) ================= -->
  <div id="tab-active" class="tab-pane content-box-card" style="display:none;">
    <div style="overflow-x:auto;">
      <table class="shipper-table">
        <thead>
          <tr>
            <th style="width:8%;">Mã Đơn</th>
            <th style="width:16%;">Khách Hàng</th>
            <th style="width:12%;">Số Điện Thoại</th>
            <th style="width:24%;">Địa Chỉ Nhận Hàng</th>
            <th style="width:12%;">Thu Hộ (COD)</th>
            <th style="width:12%; text-align:center;">Trạng Thái</th>
            <th style="width:16%; text-align:center;">Cập Nhật Tiến Độ</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty activeOrders}">
              <c:forEach items="${activeOrders}" var="o">
                <tr class="clickable-row" onclick="viewOrderDetail('${o.id != 0 ? o.id : o.orderId}')" title="Bấm xem chi tiết">
                  <td><strong style="color:var(--pink-primary); text-decoration:underline;">#BM${o.id != 0 ? o.id : o.orderId}</strong></td>
                  <td><strong>${o.recipientName}</strong></td>
                  <td onclick="event.stopPropagation();"><a href="tel:${o.recipientPhone}" style="color:#2563eb; font-weight:bold; text-decoration:none;">${o.recipientPhone}</a></td>
                  <td style="word-break:break-word;">${o.shippingAddress}</td>
                  <td><strong style="color:var(--pink-primary);"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/>đ</strong></td>
                  <td style="text-align:center;">
                    <c:choose>
                      <c:when test="${o.status == 'Shipping' || o.status == 'Đang giao'}">
                        <span class="status-badge shipping">Đang đi giao</span>
                      </c:when>
                      <c:otherwise>
                        <span class="status-badge processing">Đã nhận đơn</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td style="text-align:center;" onclick="event.stopPropagation();">
                    <form action="shipper" method="POST" style="margin:0;">
                      <input type="hidden" name="orderId" value="${o.id != 0 ? o.id : o.orderId}">
                      <c:choose>
                        <%-- Đã nhận đơn -> Nút xác nhận đã lấy bánh --%>
                        <c:when test="${o.status == 'Processing' || o.status == 'Đang làm bánh'}">
                          <input type="hidden" name="action" value="start_shipping">
                          <button type="submit" class="btn-action btn-pickup">📦 Đã lấy bánh (Đi giao)</button>
                        </c:when>
                        <%-- Đang đi giao -> Nút xác nhận đã giao thành công --%>
                        <c:otherwise>
                          <input type="hidden" name="action" value="finish_delivery">
                          <button type="submit" class="btn-action btn-finish" onclick="return confirm('Xác nhận đã giao đơn #BM${o.id != 0 ? o.id : o.orderId} thành công?');">
                            ✓ Đã giao xong
                          </button>
                        </c:otherwise>
                      </c:choose>
                    </form>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr><td colspan="7" style="text-align:center; padding:32px; color:var(--text-muted);">Bạn chưa có đơn hàng nào đang tiến hành giao.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <!-- ================= TAB 3: ĐƠN ĐÃ HOÀN TẤT (LỊCH SỬ GIAO HÀNG) ================= -->
  <div id="tab-completed" class="tab-pane content-box-card" style="display:none;">
    <div style="overflow-x:auto;">
      <table class="shipper-table">
        <thead>
          <tr>
            <th style="width:10%;">Mã Đơn</th>
            <th style="width:18%;">Khách Hàng</th>
            <th style="width:14%;">Số Điện Thoại</th>
            <th style="width:28%;">Địa Chỉ Đã Giao</th>
            <th style="width:14%;">Đã Thu COD</th>
            <th style="width:16%; text-align:center;">Trạng Thái</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty completedOrders}">
              <c:forEach items="${completedOrders}" var="o">
                <tr class="clickable-row" onclick="viewOrderDetail('${o.id != 0 ? o.id : o.orderId}')" title="Bấm xem chi tiết">
                  <td><strong style="color:var(--pink-primary); text-decoration:underline;">#BM${o.id != 0 ? o.id : o.orderId}</strong></td>
                  <td><strong>${o.recipientName}</strong></td>
                  <td>${o.recipientPhone}</td>
                  <td style="word-break:break-word;">${o.shippingAddress}</td>
                  <td><strong style="color:var(--pink-primary);"><fmt:formatNumber value="${o.totalAmount}" pattern="#,##0"/>đ</strong></td>
                  <td style="text-align:center;">
                    <span class="status-badge delivered">✓ Đã giao thành công</span>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr><td colspan="6" style="text-align:center; padding:32px; color:var(--text-muted);">Chưa có đơn hàng nào được hoàn tất.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

  <!-- POPUP XEM CHI TIẾT ĐƠN HÀNG -->
  <div id="orderDetailModal" class="modal-overlay" style="display:none;">
    <div class="modal-box">
      <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1.5px solid var(--border-soft); padding-bottom:12px; margin-bottom:14px;">
        <h3 id="modalOrderCode" style="margin:0; font-size:16px; color:var(--pink-primary);">CHI TIẾT ĐƠN HÀNG</h3>
        <button type="button" onclick="closeOrderModal()" style="background:none; border:none; font-size:22px; cursor:pointer;">&times;</button>
      </div>
      
      <table style="width:100%; border-collapse:collapse; font-size:13px;">
        <thead>
          <tr style="background:var(--pink-subtle); text-align:left;">
            <th style="padding:8px;">Món Bánh</th>
            <th style="padding:8px; text-align:center;">Số lượng</th>
            <th style="padding:8px; text-align:right;">Thành tiền</th>
          </tr>
        </thead>
        <tbody id="modalItemsBody"></tbody>
      </table>

      <div style="margin-top:16px; text-align:right; font-weight:bold; font-size:14px; border-top:1px dashed var(--border-soft); padding-top:12px;">
        TỔNG TIỀN: <span id="modalTotalPrice" style="color:var(--pink-primary); font-size:16px;">0đ</span>
      </div>
    </div>
  </div>

  <script>
    function switchTab(tabId, btn) {
      document.querySelectorAll('.tab-pane').forEach(p => p.style.display = 'none');
      document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
      document.getElementById(tabId).style.display = 'block';
      btn.classList.add('active');
    }

    function viewOrderDetail(orderId) {
      document.getElementById('modalOrderCode').innerText = "CHI TIẾT ĐƠN HÀNG #BM" + orderId;
      var tbody = document.getElementById('modalItemsBody');
      tbody.innerHTML = '<tr><td colspan="3" style="text-align:center; padding:15px;">Đang tải...</td></tr>';
      document.getElementById('orderDetailModal').style.display = 'flex';

      fetch('order-detail?orderId=' + orderId)
        .then(res => res.json())
        .then(data => {
          tbody.innerHTML = '';
          var total = 0;
          data.forEach(item => {
            var subtotal = (item.price || 0) * (item.quantity || 0);
            total += subtotal;
            tbody.innerHTML += `
              <tr style="border-bottom:1px solid #eee;">
                <td style="padding:8px; font-weight:600;">\${item.productName || 'Bánh tươi'}</td>
                <td style="padding:8px; text-align:center;">\${item.quantity}</td>
                <td style="padding:8px; text-align:right; color:var(--pink-primary); font-weight:bold;">\${subtotal.toLocaleString('vi-VN')}đ</td>
              </tr>
            `;
          });
          document.getElementById('modalTotalPrice').innerText = total.toLocaleString('vi-VN') + 'đ';
        })
        .catch(() => {
          tbody.innerHTML = '<tr><td colspan="3" style="text-align:center; color:red; padding:10px;">Lỗi tải dữ liệu</td></tr>';
        });
    }

    function closeOrderModal() {
      document.getElementById('orderDetailModal').style.display = 'none';
    }
  </script>
</body>
</html>