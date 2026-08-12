<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- Chưa đăng nhập thì chuyển về trang login.jsp --%>
<c:if test="${empty sessionScope.account}">
  <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Tài Khoản Của Tôi</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    /* DÀN KHUNG RỘNG ĐỀU MÀN HÌNH NHƯ HOME.JSP */
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      background-color: #f8f8f8;
      font-family: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      color: #000;
    }

    .wire-page {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      width: 100%;
    }

    .main-content {
      flex: 1;
      width: 100%;
      max-width: 100% !important;
      padding: 24px 40px 60px 40px;
      box-sizing: border-box;
    }

    /* HEADER & TOPBAR */
    .wf-topbar {
      background: #000;
      color: #fff;
      font-size: 11px;
      font-weight: bold;
      letter-spacing: 0.5px;
      text-align: center;
      padding: 8px 20px;
    }

    .wf-header {
      width: 100%;
      box-sizing: border-box;
      padding: 16px 40px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      background: #f8f8f8;
      border-bottom: 1px solid #000;
      position: sticky;
      top: 0;
      z-index: 100;
    }

    .brand-logo {
      color: #000;
      text-decoration: none;
      font-weight: bold;
      font-size: 20px;
      border: 1px solid #000;
      padding: 6px 16px;
      display: inline-block;
      background: #fff;
      transition: all 0.2s;
    }
    .brand-logo:hover { background: #000; color: #fff; }

    .wf-nav { display: flex; gap: 24px; align-items: center; }
    .wf-nav a { color: #000; text-decoration: none; font-size: 13px; font-weight: bold; }

    .header-actions { display: flex; align-items: center; gap: 20px; }
    .ic-btn { position: relative; display: inline-flex; align-items: center; color: #000; text-decoration: none; }

    .breadcrumb-bar {
      font-size: 12px;
      color: #666;
      display: flex;
      gap: 8px;
      margin-bottom: 24px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
    }
    .breadcrumb-bar a { color: #666; text-decoration: none; }

    .profile-grid {
      display: grid;
      grid-template-columns: 300px 1fr;
      gap: 32px;
      align-items: start;
    }

    /* SIDEBAR CỘT TRÁI */
    .user-sidebar {
      border: 1px solid #000;
      background: #fff;
      padding: 32px 24px;
      text-align: center;
      box-sizing: border-box;
    }

    .avatar-upload-box {
      position: relative;
      width: 100px;
      height: 100px;
      margin: 0 auto 16px;
    }

    .avatar-preview {
      width: 100%;
      height: 100%;
      border-radius: 50%;
      border: 1px solid #000;
      object-fit: cover;
      background: #fafafa;
      display: flex;
      align-items: center;
      justify-content: center;
      overflow: hidden;
    }

    .avatar-edit-label {
      position: absolute;
      bottom: 0;
      right: 0;
      width: 28px;
      height: 28px;
      background: #000;
      color: #fff;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      border: 2px solid #fff;
      transition: transform 0.2s;
    }
    .avatar-edit-label:hover { transform: scale(1.1); }

    .role-badge {
      display: inline-block;
      font-size: 10px;
      font-weight: bold;
      letter-spacing: 1px;
      text-transform: uppercase;
      padding: 3px 10px;
      border: 1px solid #000;
      background: #fafafa;
      margin-top: 6px;
    }

    .side-nav {
      margin-top: 28px;
      border-top: 1px solid #eee;
      padding-top: 20px;
      text-align: left;
    }

    .side-link {
      display: flex;
      align-items: center;
      gap: 12px;
      padding: 12px 14px;
      font-size: 13px;
      font-weight: 600;
      color: #000;
      text-decoration: none;
      border: 1px solid transparent;
      margin-bottom: 6px;
      transition: all 0.2s;
    }

    .side-link.active, .side-link:hover {
      border-color: #000;
      background: #fafafa;
    }

    .side-link.logout {
      color: #d32f2f;
      margin-top: 16px;
      border-top: 1px solid #eee;
      padding-top: 16px;
    }
    .side-link.logout:hover {
      background: #fff5f5;
      border-color: #d32f2f;
    }

    /* CARD CỘT PHẢI */
    .profile-content {
      border: 1px solid #000;
      background: #fff;
      padding: 36px 40px;
      box-sizing: border-box;
    }

    .content-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 2px solid #000;
      padding-bottom: 14px;
      margin-bottom: 28px;
    }

    .content-title {
      font-size: 16px;
      font-weight: bold;
      text-transform: uppercase;
      letter-spacing: 1px;
      margin: 0;
    }

    .btn-edit-toggle {
      border: 1px solid #000;
      background: #fff;
      color: #000;
      padding: 8px 16px;
      font-size: 12px;
      font-weight: bold;
      cursor: pointer;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      transition: all 0.2s;
    }
    .btn-edit-toggle:hover { background: #000; color: #fff; }

    .form-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }

    .form-group {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    .form-group.full-width { grid-column: span 2; }

    .form-label {
      font-size: 11px;
      font-weight: bold;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      color: #555;
    }

    .form-input, .form-select {
      padding: 11px 14px;
      border: 1px solid #ccc;
      font-size: 13px;
      font-family: inherit;
      outline: none;
      background: #fcfcfc;
      transition: border-color 0.2s, background 0.2s;
      width: 100%;
      box-sizing: border-box;
    }

    .form-input:read-only, .form-select:disabled {
      background: #f5f5f5;
      color: #666;
      border-color: #e0e0e0;
      cursor: not-allowed;
    }

    .form-input:focus:not(:read-only), .form-select:focus:not(:disabled) {
      border-color: #000;
      background: #fff;
    }

    /* BỐ CỤC ĐỊA CHỈ HÀNH CHÍNH 2 CẤP (TỈNH - XÃ) */
    .address-select-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 16px;
    }

    .action-row {
      margin-top: 32px;
      display: flex;
      justify-content: flex-end;
      gap: 12px;
    }

    .btn-save {
      background: #000;
      color: #fff;
      border: 1px solid #000;
      padding: 12px 28px;
      font-size: 12px;
      font-weight: bold;
      letter-spacing: 1px;
      text-transform: uppercase;
      cursor: pointer;
      display: none;
      transition: background 0.2s;
    }
    .btn-save:hover { background: #333; }

    .btn-cancel {
      background: #fff;
      color: #000;
      border: 1px solid #000;
      padding: 12px 20px;
      font-size: 12px;
      font-weight: bold;
      letter-spacing: 1px;
      text-transform: uppercase;
      cursor: pointer;
      display: none;
    }

    .minimal-footer {
      border-top: 1px solid #000;
      background: #fff;
      padding: 20px 0;
      text-align: center;
      font-size: 13px;
      color: #000;
      width: 100%;
    }

    @media (max-width: 868px) {
      .profile-grid { grid-template-columns: 1fr; }
      .form-grid { grid-template-columns: 1fr; }
      .form-group.full-width { grid-column: span 1; }
      .address-select-grid { grid-template-columns: 1fr; }
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
      <a href="feedback" class="ic-btn feedback-link" title="Góp ý">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
      </a>

      <a href="cart.jsp" class="ic-btn" title="Giỏ hàng">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
      </a>

      <a href="profile.jsp" class="ic-btn" title="Tài khoản cá nhân" style="opacity:0.5;">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="2">
          <circle cx="12" cy="8" r="4"/>
          <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
        </svg>
      </a>
    </div>
  </header>

  <!-- NỘI DUNG CHÍNH MAIN-CONTENT TRÀN ĐỀU NHƯ HOME.JSP -->
  <main class="main-content">
    
    <div class="breadcrumb-bar">
      <a href="home.jsp">Trang chủ</a> <span>&rsaquo;</span>
      <strong style="color:#000;">Tài khoản của tôi</strong>
    </div>

    <c:if test="${not empty sessionScope.profileError}"><p style="color:#b00020;"><c:out value="${sessionScope.profileError}"/></p><c:remove var="profileError" scope="session"/></c:if>
    <c:if test="${not empty sessionScope.profileSuccess}"><p style="color:#087f23;"><c:out value="${sessionScope.profileSuccess}"/></p><c:remove var="profileSuccess" scope="session"/></c:if>
    <form action="update-profile" method="POST" id="profile-form">
      
      <div class="profile-grid">
        
        <!-- CỘT TRÁI: AVATAR & NAVIGATION MENU -->
        <aside class="user-sidebar">
          
          <div class="avatar-upload-box">
            <div class="avatar-preview">
              <c:choose>
                <c:when test="${not empty sessionScope.account.avatar}">
                  <img id="avatar-img-preview" src="${sessionScope.account.avatar}" alt="Avatar" style="width:100%; height:100%; object-fit:cover;">
                </c:when>
                <c:otherwise>
                  <svg id="avatar-icon-placeholder" width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.2">
                    <circle cx="12" cy="8" r="4"/>
                    <path d="M4 21c0-4 4-7 8-7s8 3 8 7"/>
                  </svg>
                  <img id="avatar-img-preview" src="" alt="Avatar" style="width:100%; height:100%; object-fit:cover; display:none;">
                </c:otherwise>
              </c:choose>
            </div>

            <!-- Icon tải ảnh đại diện -->
            <label for="avatar-input" class="avatar-edit-label" title="Đổi ảnh đại diện">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z"/><circle cx="12" cy="13" r="4"/></svg>
            </label>
            <input type="file" id="avatar-input" name="avatarFile" accept="image/*" style="display:none;" disabled>
          </div>

          <div style="font-size:16px; font-weight:bold; margin-bottom:2px; text-transform:capitalize;">
            ${sessionScope.account.fullName}
          </div>
          <div style="font-size:12px; color:#666; margin-bottom:8px;">
            ${sessionScope.account.email}
          </div>

          <span class="role-badge">
            THÀNH VIÊN ${sessionScope.account.role}
          </span>

          <div class="side-nav">
            <a href="profile.jsp" class="side-link active">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
              Thông tin tài khoản
            </a>
            <a href="cart.jsp" class="side-link">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M6 2L3 6v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/><path d="M16 10a4 4 0 0 1-8 0"/></svg>
              Đơn hàng của tôi
            </a>
            <a href="contact.jsp?feedback=true" class="side-link">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
              Góp ý / Phản hồi
            </a>
            <a href="logout" class="side-link logout">
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#d32f2f" stroke-width="1.5"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
              Đăng xuất
            </a>
          </div>
        </aside>

        <!-- CỘT PHẢI: CHI TIẾT HỒ SƠ & BỘ CHỌN ĐỊA CHỈ HÀNH CHÍNH TỈNH - XÃ -->
        <section class="profile-content">
          <div class="content-header">
            <h1 class="content-title">HỒ SƠ CÁ NHÂN</h1>
            <button type="button" class="btn-edit-toggle" id="btn-toggle-edit">
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/></svg>
              Chỉnh sửa
            </button>
          </div>

          <div class="form-grid">
            
            <div class="form-group">
              <label class="form-label">Họ và tên</label>
              <input type="text" name="fullName" class="form-input editable-field" value="${sessionScope.account.fullName}" readonly required>
            </div>

            <div class="form-group">
              <label class="form-label">Địa chỉ Email (Cố định)</label>
              <input type="email" name="email" class="form-input" value="${sessionScope.account.email}" readonly style="background:#f0f0f0; cursor:not-allowed;">
            </div>

            <div class="form-group">
              <label class="form-label">Số điện thoại</label>
              <input type="text" name="phoneNumber" class="form-input editable-field" value="${not empty sessionScope.account.phoneNumber ? sessionScope.account.phoneNumber : ''}" placeholder="Chưa cập nhật" readonly>
            </div>

            <div class="form-group">
              <label class="form-label">Vai trò tài khoản</label>
              <input type="text" class="form-input" value="${sessionScope.account.role}" readonly style="background:#f0f0f0; text-transform:uppercase; cursor:not-allowed;">
            </div>

            <!-- BỘ CHỌN ĐỊA CHỈ HÀNH CHÍNH CẤP TỈNH / THÀNH PHỐ VÀ XÃ / PHƯỜNG -->
            <div class="form-group full-width">
              <label class="form-label">Tỉnh / Thành phố — Xã / Phường / Thị trấn</label>
              <div class="address-select-grid">
                <select id="city" name="city" class="form-select editable-select" disabled>
                  <option value="" selected>Chọn Tỉnh / Thành phố</option>
                </select>

                <select id="ward" name="ward" class="form-select editable-select" disabled>
                  <option value="" selected>Chọn Xã / Phường / Thị trấn</option>
                </select>
              </div>
            </div>

            <div class="form-group full-width">
              <label class="form-label">Địa chỉ chi tiết (Số nhà, tên đường, thôn/xóm)</label>
              <input type="text" name="streetAddress" class="form-input editable-field" value="${not empty sessionScope.account.address ? sessionScope.account.address : ''}" placeholder="Ví dụ: Số 123 Nguyễn Lương Bằng..." readonly>
            </div>

          </div>

          <!-- NÚT LƯU VÀ HỦY -->
          <div class="action-row">
            <button type="button" class="btn-cancel" id="btn-cancel-edit">HỦY BỎ</button>
            <button type="submit" class="btn-save" id="btn-save-profile">LƯU THAY ĐỔI</button>
          </div>
        </section>

      </div>

    </form>
  </main>

  <!-- FOOTER -->
  <footer class="minimal-footer">
    &copy; Bites &amp; More. since 2026
  </footer>

</div>

<!-- API NẠP ĐỊA CHỈ SIÊU MƯỢT KHÔNG BẮT BUỘC QUẬN/HUYỆN -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/axios/0.21.1/axios.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
  var btnToggle = document.getElementById('btn-toggle-edit');
  var btnCancel = document.getElementById('btn-cancel-edit');
  var btnSave = document.getElementById('btn-save-profile');
  var editableInputs = document.querySelectorAll('.editable-field');
  var editableSelects = document.querySelectorAll('.editable-select');
  var avatarInput = document.getElementById('avatar-input');
  
  var avatarPreview = document.getElementById('avatar-img-preview');
  var avatarPlaceholder = document.getElementById('avatar-icon-placeholder');

  var citis = document.getElementById("city");
  var wards = document.getElementById("ward");

  var isEditing = false;

  // 1. CHUYỂN BẬT/TẮT EDIT
  if (btnToggle) {
    btnToggle.addEventListener('click', function () {
      isEditing = true;
      updateFormMode();
    });
  }

  if (btnCancel) {
    btnCancel.addEventListener('click', function () {
      isEditing = false;
      updateFormMode();
    });
  }

  function updateFormMode() {
    editableInputs.forEach(function (input) {
      if (isEditing) {
        input.removeAttribute('readonly');
        input.style.background = '#fff';
      } else {
        input.setAttribute('readonly', 'readonly');
        input.style.background = '#f5f5f5';
      }
    });

    editableSelects.forEach(function (select) {
      if (isEditing) {
        select.removeAttribute('disabled');
        select.style.background = '#fff';
        select.style.cursor = 'pointer';
      } else {
        select.setAttribute('disabled', 'disabled');
        select.style.background = '#f5f5f5';
        select.style.cursor = 'not-allowed';
      }
    });

    if (avatarInput) {
      if (isEditing) avatarInput.removeAttribute('disabled');
      else avatarInput.setAttribute('disabled', 'disabled');
    }

    if (btnSave) btnSave.style.display = isEditing ? 'inline-block' : 'none';
    if (btnCancel) btnCancel.style.display = isEditing ? 'inline-block' : 'none';
    if (btnToggle) btnToggle.style.display = isEditing ? 'none' : 'inline-flex';
  }

  // 2. PREVIEW AVATAR
  if (avatarInput) {
    avatarInput.addEventListener('change', function (e) {
      var file = e.target.files[0];
      if (file) {
        var reader = new FileReader();
        reader.onload = function (event) {
          if (avatarPreview) {
            avatarPreview.src = event.target.result;
            avatarPreview.style.display = 'block';
          }
          if (avatarPlaceholder) avatarPlaceholder.style.display = 'none';
        };
        reader.readAsDataURL(file);
      }
    });
  }

  // 3. CALL API ĐỊA CHỈ TRỰC TIẾP (TỈNH/THÀNH -> XÃ/PHƯỜNG)
  if (citis && wards) {
    // Lấy danh sách Tỉnh/Thành
    axios.get('https://esgoo.net/api-tinhthanh/1/0.htm')
      .then(function (response) {
        if (response.data.error === 0) {
          var dataTỉnh = response.data.data;
          dataTỉnh.forEach(function (tinh) {
            citis.options[citis.options.length] = new Option(tinh.full_name, tinh.id);
          });
        }
      });

    // Khi chọn Tỉnh -> Tự động nạp toàn bộ Xã/Phường thuộc Tỉnh đó
    citis.addEventListener('change', function () {
      wards.length = 1; // Reset ô Xã/Phường
      var idTinh = this.value;

      if (idTinh !== "") {
        // Lấy danh sách Quận/Huyện của Tỉnh
        axios.get('https://esgoo.net/api-tinhthanh/2/' + idTinh + '.htm')
          .then(function (resQuan) {
            if (resQuan.data.error === 0) {
              var listQuan = resQuan.data.data;
              listQuan.forEach(function (quan) {
                // Lấy tiếp các Xã/Phường của từng Quận/Huyện nạp vào chung
                axios.get('https://esgoo.net/api-tinhthanh/3/' + quan.id + '.htm')
                  .then(function (resXa) {
                    if (resXa.data.error === 0) {
                      resXa.data.data.forEach(function (xa) {
                        wards.options[wards.options.length] = new Option(xa.full_name + " (" + quan.full_name + ")", xa.full_name);
                      });
                    }
                  });
              });
            }
          });
      }
    });
  }
});
</script>

</body>
</html>
