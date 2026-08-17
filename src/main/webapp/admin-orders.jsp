<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Quản Lý Đơn Hàng</title>
  <link rel="stylesheet" href="css/style.css">
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

    html, body {
      height: 100%; margin: 0; padding: 0;
      background-color: var(--bg-cream);
      font-family: system-ui, -apple-system, sans-serif;
      color: var(--text-chocolate);
    }

    .admin-wrap { display: flex; min-height: 100vh; width: 100%; }

    /* SIDEBAR */
    .admin-sidebar {
      width: 260px; background: #fff;
      border-right: 1px solid var(--border-soft);
      padding: 28px 16px; display: flex; flex-direction: column; flex-shrink: 0;
      box-shadow: var(--shadow-sm);
    }

    .sidebar-brand {
      padding: 12px 16px; margin-bottom: 32px;
      font-weight: 900; font-size: 20px; color: var(--pink-primary);
      display: flex; align-items: center; gap: 10px;
      border: 2px solid var(--pink-primary); border-radius: var(--radius-md);
      background: var(--pink-subtle);
    }

    .sidebar-section-title {
      font-size: 11px; text-transform: uppercase; color: var(--text-muted);
      padding: 0 16px; margin-bottom: 12px; font-weight: 800;
    }

    .admin-nav-item {
      display: flex; align-items: center; gap: 12px;
      padding: 12px 16px; font-size: 13px; color: var(--text-chocolate);
      text-decoration: none; font-weight: 700; transition: all 0.2s ease;
      margin-bottom: 6px; border-radius: var(--radius-sm);
    }

    .admin-nav-item:hover, .admin-nav-item.active {
      background: var(--pink-primary); color: #fff;
    }
    .admin-nav-item:hover svg, .admin-nav-item.active svg { stroke: #fff; }

    /* MAIN */
    .admin-main { flex: 1; padding: 32px 40px; overflow-x: hidden; }

    .admin-topbar {
      display: flex; justify-content: space-between; align-items: center;
      margin-bottom: 28px; background: #fff; padding: 18px 28px;
      border: 1px solid var(--border-soft); border-radius: var(--radius-md);
      box-shadow: var(--shadow-sm);
    }

    .content-box-card {
      background: #fff; border: 1px solid var(--border-soft);
      border-radius: var(--radius-md); padding: 28px;
      box-shadow: var(--shadow-sm);
    }

    .admin-table { width: 100%; border-collapse: separate; border-spacing: 0; font-size: 13px; }
    .admin-table th {
      background: var(--pink-subtle); color: var(--text-chocolate);
      font-size: 11px; font-weight: 800; text-transform: uppercase;
      padding: 14px; border-bottom: 2px solid var(--border-soft); text-align: left;
    }
    .admin-table td { padding: 16px 14px; border-bottom: 1px solid var(--border-soft); vertical-align: middle; }

    .status-badge {
      display: inline-flex; align-items: center; gap: 6px;
      padding: 5px 12px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase;
    }
    .status-badge.pending { background: #fff8e6; color: #b7791f; border: 1px solid #fce8b3; }
    .status-badge.confirmed { background: #e6fffa; color: #234e52; border: 1px solid #b2f5ea; }
    .status-badge.completed { background: #e6ffed; color: #22543d; border: 1px solid #b7ebc5; }
    .status-badge.cancelled { background: #ffe6e6; color: #9b2c2c; border: 1px solid #feb2b2; }

    .status-dot { width: 6px; height: 6px; border-radius: 50%; background: currentColor; }

    .select-status-edit {
      padding: 6px 10px; border: 1px solid var(--border-soft);
      border-radius: var(--radius-sm); font-size: 12px; font-family: inherit; outline: none; background: #fff;
    }

    .btn-save-order {
      background: var(--pink-primary); color: #fff; border: none;
      padding: 7px 14px; border-radius: 20px; font-size: 11px; font-weight: 800;
      cursor: pointer; text-transform: uppercase; transition: background 0.2s;
    }
    .btn-save-order:hover { background: var(--pink-dark); }

    .minimal-footer {
      border-top: 1px solid var(--border-soft); background: #fff;
      padding: 20px 0; text-align: center; font-size: 13px; color: var(--text-muted);
    }

    .status-badge.pending { background: #fff8e6; color: #b7791f; border: 1px solid #fce8b3; }
.status-badge.confirmed { background: #e6fffa; color: #234e52; border: 1px solid #b2f5ea; }
.status-badge.processing { background: #ebf8ff; color: #2b6cb0; border: 1px solid #bee3f8; }
.status-badge.shipping { background: #f3e8ff; color: #6b21a8; border: 1px solid #e9d5ff; }
.status-badge.delivered { background: #e6fffa; color: #0f766e; border: 1px solid #99f6e4; }
.status-badge.completed { background: #e6ffed; color: #22543d; border: 1px solid #b7ebc5; }
.status-badge.cancelled { background: #ffe6e6; color: #9b2c2c; border: 1px solid #feb2b2; }
  </style>
</head>
<body>

<div class="admin-wrap">
  
  <!-- SIDEBAR -->
  <aside class="admin-sidebar">
    <div class="sidebar-brand">
      <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M6 14c-1.5 0-3-1.5-3-3 0-4 3.5-7 9-7s9 3 9 7c0 1.5-1.5 3-3 3"/><path d="M8 14c0 3 2 5 4 5s4-2 4-5"/><path d="M12 4v10"/></svg>
      BITES &amp; MORE
    </div>
    
    <div class="sidebar-section-title">Danh Mục Quản Lý</div>
    
    <a href="admin" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/><rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/></svg>
      Tổng quan
    </a>

    <a href="admin-products" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 8l-9-5-9 5 9 5 9-5z"/><path d="M3 8v8l9 5 9-5V8"/><line x1="12" y1="13" x2="12" y2="21"/></svg>
      Quản lý sản phẩm
    </a>

    <a href="admin-orders" class="admin-nav-item active">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
      Quản lý đơn hàng
    </a>

    <a href="admin-users" class="admin-nav-item">
      <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      Quản lý khách hàng
    </a>

   <a href="admin-reviews" class="admin-nav-item">
  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 11.5a8.38 8.38 0 0 1-.9 3.8 8.5 8.5 0 0 1-7.6 4.7 8.38 8.38 0 0 1-3.8-.9L3 21l1.9-5.7a8.38 8.38 0 0 1-.9-3.8 8.5 8.5 0 0 1 4.7-7.6 8.38 8.38 0 0 1 3.8-.9h.5a8.48 8.48 0 0 1 8 8v.5z"/></svg>
  Quản lý đánh giá
</a>

    <div style="margin-top:auto; border-top:1px solid var(--border-soft); padding-top:16px;">
      <a href="logout" class="admin-nav-item" style="color:#d32f2f;">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#d32f2f" stroke-width="2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16,17 21,12 16,7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
        Đăng xuất
      </a>
    </div>
  </aside>

  <!-- MAIN -->
  <main class="admin-main">
    
    <div class="admin-topbar">
      <div>
        <div style="font-size:18px; font-weight:900; text-transform:uppercase;">QUẢN LÝ ĐƠN HÀNG</div>
        <div style="font-size:12px; color:var(--text-muted); margin-top:2px;">Kiểm tra và cập nhật trạng thái đơn đặt bánh</div>
      </div>
    </div>

    <div class="content-box-card">
      <div style="overflow-x:auto;">
        <table class="admin-table">
          <thead>
            <tr>
              <th>Mã đơn</th>
              <th>Khách hàng</th>
              <th>Số điện thoại</th>
              <th>Địa chỉ giao</th>
              <th>Ngày đặt</th>
              <th>Tổng tiền</th>
              <th>Trạng thái</th>
              <th style="text-align:center;">Cập nhật trạng thái</th>
            </tr>
          </thead>
          <tbody>
            <c:choose>
              <c:when test="${not empty orderList}">
               <c:forEach items="${orderList}" var="o">
  <tr>
    <!-- 1. Mã đơn -->
    <td>
      <strong style="color:var(--pink-primary); cursor:pointer; text-decoration:underline;" 
              onclick="viewAdminOrderDetail('${o.orderId != null ? o.orderId : o.id}')"
              title="Bấm để xem danh sách món bánh">
        #BM${o.orderId != null ? o.orderId : o.id}
      </strong>
    </td>

    <!-- 2. Khách hàng -->
    <td><strong>${o.recipientName != null ? o.recipientName : (o.fullName != null ? o.fullName : o.customerName)}</strong></td>

    <!-- 3. Số điện thoại -->
    <td>${o.recipientPhone != null ? o.recipientPhone : (o.phoneNumber != null ? o.phoneNumber : o.phone)}</td>

    <!-- 4. Địa chỉ giao -->
    <td>${o.shippingAddress != null ? o.shippingAddress : o.address}</td>

    <!-- 5. Ngày đặt -->
    <td><fmt:formatDate value="${o.orderDate != null ? o.orderDate : o.createdAt}" pattern="dd/MM/yyyy HH:mm"/></td>

    <!-- 6. Tổng tiền -->
    <td><strong style="color:var(--text-chocolate);"><fmt:formatNumber value="${o.finalAmount != null ? o.finalAmount : (o.totalAmount != null ? o.totalAmount : o.totalPrice)}" pattern="#,##0"/>đ</strong></td>

    <!-- 7. Huy hiệu trạng thái -->
    <td>
      <c:choose>
        <c:when test="${o.status == 'Confirmed'}"><span class="status-badge confirmed"><span class="status-dot"></span>Đã xác nhận</span></c:when>
        <c:when test="${o.status == 'Processing'}"><span class="status-badge processing"><span class="status-dot"></span>Đang làm bánh</span></c:when>
        <c:when test="${o.status == 'Shipping'}"><span class="status-badge shipping"><span class="status-dot"></span>Đang giao hàng</span></c:when>
        <c:when test="${o.status == 'Delivered'}"><span class="status-badge delivered"><span class="status-dot"></span>Đã giao</span></c:when>
        <c:when test="${o.status == 'Completed'}"><span class="status-badge completed"><span class="status-dot"></span>Hoàn thành</span></c:when>
        <c:when test="${o.status == 'Cancelled'}"><span class="status-badge cancelled"><span class="status-dot"></span>Đã hủy</span></c:when>
        <c:otherwise><span class="status-badge pending"><span class="status-dot"></span>Chờ xử lý</span></c:otherwise>
      </c:choose>
    </td>

    <!-- 8. Form cập nhật trạng thái -->
    <td style="text-align:center;">
      <form action="update-order-status" method="POST" style="display:inline-flex; align-items:center; justify-content:center; gap:8px; margin:0;">
        <input type="hidden" name="orderId" value="${o.orderId != null ? o.orderId : o.id}">
        <select name="status" class="select-status-edit">
          <option value="Pending" ${o.status == 'Pending' ? 'selected' : ''}>Chờ xử lý</option>
          <option value="Confirmed" ${o.status == 'Confirmed' ? 'selected' : ''}>Đã xác nhận</option>
          <option value="Processing" ${o.status == 'Processing' ? 'selected' : ''}>Đang làm bánh</option>
          <option value="Shipping" ${o.status == 'Shipping' ? 'selected' : ''}>Đang giao hàng</option>
          <option value="Delivered" ${o.status == 'Delivered' ? 'selected' : ''}>Đã giao</option>
          <option value="Completed" ${o.status == 'Completed' ? 'selected' : ''}>Hoàn thành</option>
          <option value="Cancelled" ${o.status == 'Cancelled' ? 'selected' : ''}>Đã hủy</option>
        </select>
        <button type="submit" class="btn-save-order">LƯU</button>
      </form>
    </td>
  </tr>
</c:forEach>
              </c:when>

              <c:otherwise>
                <!-- DỮ LIỆU MẪU KHI CHƯA LOAD DATABASE -->
                <tr>
                  <td>
                    <strong style="color:var(--pink-primary); cursor:pointer; text-decoration:underline;" 
                            onclick="viewAdminOrderDetail('1')"
                            title="Bấm để xem danh sách món bánh">
                      #BM1
                    </strong>
                  </td>
                  <td><strong>Như Hoàn Tr</strong></td>
                  <td>0766766341</td>
                  <td>123 Nguyễn Lương Bằng, Đà Nẵng</td>
                  <td>12/08/2026 04:19</td>
                  <td><strong style="color:var(--text-chocolate);">348.000đ</strong></td>
                  <td><span class="status-badge confirmed"><span class="status-dot"></span>Đã xác nhận</span></td>
                  <td style="text-align:center;">
                    <div style="display:inline-flex; align-items:center; gap:8px;">
                      <select class="select-status-edit">
                        <option value="Confirmed" selected>Đã xác nhận</option>
                        <option value="Pending">Chờ xử lý</option>
                        <option value="Completed">Hoàn thành</option>
                      </select>
                      <button type="button" class="btn-save-order">LƯU</button>
                    </div>
                  </td>
                </tr>
              </c:otherwise>
            </c:choose>
          </tbody>
        </table>
      </div>
    </div>

  </main>
</div>

<footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>

<!-- POPUP MODAL XEM CHI TIẾT ĐƠN HÀNG CHO ADMIN -->
<div id="adminOrderDetailModal" style="display:none; position:fixed; z-index:9999; left:0; top:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5); align-items:center; justify-content:center;">
    <div style="background:#fff; width:90%; max-width:650px; border-radius:16px; padding:24px; box-shadow:0 10px 30px rgba(0,0,0,0.2); position:relative;">
        <div style="display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #f0f0f0; padding-bottom:12px; margin-bottom:16px;">
            <h3 id="adminModalOrderCode" style="margin:0; font-size:1.2rem; color:var(--pink-primary); font-weight:bold;">CHI TIẾT ĐƠN HÀNG</h3>
            <span onclick="closeAdminModal()" style="font-size:24px; font-weight:bold; cursor:pointer; color:#999; line-height:1;">&times;</span>
        </div>
        
        <div style="max-height:350px; overflow-y:auto;">
            <table style="width:100%; border-collapse:collapse; text-align:left; font-size:14px;">
                <thead>
                    <tr style="background:var(--pink-subtle); color:var(--pink-dark); border-bottom:1px solid var(--border-soft);">
                        <th style="padding:10px;">Món Bánh</th>
                        <th style="padding:10px; text-align:center;">Số Lượng</th>
                        <th style="padding:10px; text-align:right;">Đơn Giá</th>
                        <th style="padding:10px; text-align:right;">Tạm Tính</th>
                    </tr>
                </thead>
                <tbody id="adminModalItemsBody">
                    <!-- Dữ liệu JS sẽ nạp vào đây -->
                </tbody>
            </table>
        </div>

        <div style="border-top:1px solid #f0f0f0; margin-top:16px; padding-top:14px; display:flex; justify-content:space-between; align-items:center;">
            <button type="button" onclick="closeAdminModal()" style="background:#f1f2f6; border:none; padding:8px 20px; border-radius:8px; cursor:pointer; font-weight:700; color:#57606f;">Đóng</button>
            <div style="font-size:16px; font-weight:bold;">TỔNG TIỀN: <span id="adminModalTotalPrice" style="color:var(--pink-dark); font-size:18px;">0đ</span></div>
        </div>
    </div>
</div>

<!-- SCRIPT FETCH DỮ LIỆU ĐƠN HÀNG -->
<script>
function viewAdminOrderDetail(orderId) {
    if (!orderId) return;
    document.getElementById('adminModalOrderCode').innerText = "CHI TIẾT ĐƠN HÀNG #BM" + orderId;
    var tbody = document.getElementById('adminModalItemsBody');
    tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding:15px; color:#666;">Đang tải chi tiết món bánh...</td></tr>';
    document.getElementById('adminOrderDetailModal').style.display = 'flex';

    fetch('order-detail?orderId=' + orderId)
        .then(function(res) {
            if (!res.ok) throw new Error("Lỗi mạng: " + res.status);
            return res.json();
        })
        .then(function(data) {
            tbody.innerHTML = '';
            if (!data || data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding:15px; color:#888;">Không tìm thấy món bánh nào trong đơn hàng này.</td></tr>';
                document.getElementById('adminModalTotalPrice').innerText = '0đ';
                return;
            }
            var total = 0;
            data.forEach(function(item) {
                var price = Number(item.price) || 0;
                var qty = Number(item.quantity) || 0;
                var subtotal = price * qty;
                total += subtotal;
                tbody.innerHTML += `
                    <tr style="border-bottom:1px solid #f5f5f5;">
                        <td style="padding:10px; font-weight:600; color:var(--text-chocolate);">\${item.productName}</td>
                        <td style="padding:10px; text-align:center;">\${qty}</td>
                        <td style="padding:10px; text-align:right;">\${price.toLocaleString('vi-VN')}đ</td>
                        <td style="padding:10px; text-align:right; font-weight:bold; color:var(--pink-dark);">\${subtotal.toLocaleString('vi-VN')}đ</td>
                    </tr>
                `;
            });
            document.getElementById('adminModalTotalPrice').innerText = total.toLocaleString('vi-VN') + 'đ';
        })
        .catch(function(err) {
            console.error(err);
            tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; color:red; padding:15px;">Lỗi khi tải chi tiết đơn hàng!</td></tr>';
        });
}

function closeAdminModal() {
    document.getElementById('adminOrderDetailModal').style.display = 'none';
}

// Bấm ra ngoài vùng modal để đóng popup
window.addEventListener('click', function(e) {
    var modal = document.getElementById('adminOrderDetailModal');
    if (e.target === modal) {
        closeAdminModal();
    }
});
</script>

</body>
</html>