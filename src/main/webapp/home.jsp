<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<header class="header-container" style="background: #ffffff; border-bottom: 1.5px solid #f1cfd5; position: sticky; top: 0; z-index: 10000; box-shadow: 0 2px 10px rgba(232, 106, 133, 0.05); font-family: system-ui, -apple-system, sans-serif;">
  
  <!-- Banner khuyến mãi phía trên -->
  <div style="background: #e86a85; color: #ffffff; text-align: center; padding: 6px 12px; font-size: 11px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px;">
    🛵 Miễn phí vận chuyển cho đơn hàng trên 100.000VNĐ | Hotline: 0766 766 999
  </div>

  <!-- Thanh Header chính -->
  <div style="max-width: 1200px; margin: 0 auto; padding: 12px 24px; display: flex; align-items: center; justify-content: space-between;">
    
    <!-- Logo -->
    <a href="home" style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 18px; border: 2px solid #e86a85; border-radius: 25px; color: #e86a85; font-weight: 900; font-size: 15px; text-decoration: none; text-transform: uppercase;">
      🧁 BITES &amp; MORE
    </a>

    <!-- Menu điều hướng -->
    <nav style="display: flex; gap: 24px; align-items: center; font-size: 13px; font-weight: 700;">
      <a href="home" style="color: #2b1b1b; text-decoration: none;">🍓 Trang chủ</a>
      <a href="products" style="color: #2b1b1b; text-decoration: none;">Cửa hàng</a>
      <a href="categories" style="color: #2b1b1b; text-decoration: none;">🍑 Danh mục</a>
      <a href="about" style="color: #2b1b1b; text-decoration: none;">Giới thiệu</a>
      <a href="contact" style="color: #2b1b1b; text-decoration: none;">Liên hệ</a>
    </nav>

    <!-- Nhóm icon tiện ích -->
    <div style="display: flex; align-items: center; gap: 12px;">

      <!-- 1. CHUÔNG THÔNG BÁO -->
      <div class="header-notification-box" style="position: relative; display: inline-block;">
        <button type="button" id="btnNotiToggle" onclick="handleNotificationClick(event)" 
                style="cursor: pointer; background: #ffffff; border: 1.5px solid #f1cfd5; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; position: relative; padding: 0; outline: none;">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#2b1b1b" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
            <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
          </svg>
          
          <span id="headerNotiBadge" 
                style="position: absolute; top: -3px; right: -3px; background: #e86a85; color: #ffffff; font-size: 10px; font-weight: 800; min-width: 18px; height: 18px; line-height: 16px; text-align: center; border-radius: 50%; border: 2px solid #ffffff; box-sizing: border-box; display: inline-block;">
            1
          </span>
        </button>

        <!-- Dropdown menu thông báo -->
        <div id="headerNotiDropdown" 
             style="display: none; position: absolute; right: 0; top: 48px; width: 340px; background: #ffffff; border: 1.5px solid #f1cfd5; border-radius: 14px; box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15); z-index: 999999; overflow: hidden; text-align: left;">
          
          <div style="padding: 12px 16px; background: #fff7f8; border-bottom: 1px solid #f1cfd5; display: flex; justify-content: space-between; align-items: center;">
            <strong style="font-size: 13px; color: #2b1b1b; text-transform: uppercase;">🔔 Thông báo đơn hàng</strong>
            <span style="font-size: 11px; color: #e86a85; cursor: pointer; font-weight: 700;" onclick="clearNotiBadge()">Đã đọc tất cả</span>
          </div>

          <div id="headerNotiContent" style="max-height: 320px; overflow-y: auto;">
            <a href="profile" style="display: block; padding: 12px 16px; border-bottom: 1px solid #fdf2f4; text-decoration: none; color: inherit; background: #fffbfb;">
              <div style="display: flex; gap: 10px; align-items: flex-start;">
                <span style="font-size: 20px;">🛵</span>
                <div>
                  <div style="font-size: 12.5px; font-weight: 700; color: #2b1b1b;">Đơn hàng đang trên đường giao!</div>
                  <div style="font-size: 11.5px; color: #666; margin-top: 2px;">Shipper đã lấy bánh và đang vận chuyển tới địa chỉ của bạn.</div>
                  <div style="font-size: 10px; color: #999; margin-top: 4px;">Vừa xong</div>
                </div>
              </div>
            </a>
            <a href="profile" style="display: block; padding: 12px 16px; border-bottom: 1px solid #fdf2f4; text-decoration: none; color: inherit;">
              <div style="display: flex; gap: 10px; align-items: flex-start;">
                <span style="font-size: 20px;">👨‍🍳</span>
                <div>
                  <div style="font-size: 12.5px; font-weight: 700; color: #2b1b1b;">Bếp đang chuẩn bị bánh</div>
                  <div style="font-size: 11.5px; color: #666; margin-top: 2px;">Đơn hàng của bạn đã được xác nhận và đang được chuẩn bị.</div>
                  <div style="font-size: 10px; color: #999; margin-top: 4px;">Hôm nay</div>
                </div>
              </div>
            </a>
          </div>

          <div style="padding: 10px; text-align: center; border-top: 1px solid #f1cfd5; background: #fafafa;">
            <a href="profile" style="font-size: 12px; font-weight: 700; color: #e86a85; text-decoration: none;">Xem tất cả đơn hàng &rsaquo;</a>
          </div>
        </div>
      </div>

      <!-- 2. GIỎ HÀNG -->
      <a href="cart" style="cursor: pointer; background: #ffffff; border: 1.5px solid #f1cfd5; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; position: relative; text-decoration: none; color: #2b1b1b;">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <circle cx="9" cy="21" r="1"></circle>
          <circle cx="20" cy="21" r="1"></circle>
          <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"></path>
        </svg>
        <span style="position: absolute; top: -3px; right: -3px; background: #e86a85; color: #ffffff; font-size: 10px; font-weight: 800; min-width: 18px; height: 18px; line-height: 16px; text-align: center; border-radius: 50%; border: 2px solid #ffffff; box-sizing: border-box;">
          ${not empty sessionScope.cartCount ? sessionScope.cartCount : 0}
        </span>
      </a>

      <!-- 3. TÀI KHOẢN / ĐĂNG NHẬP -->
      <c:choose>
        <c:when test="${not empty sessionScope.account}">
          <a href="profile" title="${sessionScope.account.fullName}" style="cursor: pointer; background: #ffffff; border: 1.5px solid #f1cfd5; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; text-decoration: none; color: #e86a85; font-weight: bold; overflow: hidden;">
            <c:choose>
              <c:when test="${not empty sessionScope.account.avatar}">
                <img src="${sessionScope.account.avatar}" style="width: 100%; height: 100%; object-fit: cover;" alt="Avatar">
              </c:when>
              <c:otherwise>
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                  <circle cx="12" cy="7" r="4"></circle>
                </svg>
              </c:otherwise>
            </c:choose>
          </a>
        </c:when>
        <c:otherwise>
          <a href="login.jsp" style="cursor: pointer; background: #ffffff; border: 1.5px solid #f1cfd5; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; text-decoration: none; color: #2b1b1b;">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
              <circle cx="12" cy="7" r="4"></circle>
            </svg>
          </a>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</header>

<!-- JAVASCRIPT ĐIỀU KHIỂN CHUÔNG THÔNG BÁO -->
<script>
  function handleNotificationClick(e) {
    e.stopPropagation();
    var dropdown = document.getElementById("headerNotiDropdown");
    if (!dropdown) return;
    
    if (dropdown.style.display === "none" || dropdown.style.display === "") {
      dropdown.style.display = "block";
      if (typeof fetchRealNotificationData === "function") {
        fetchRealNotificationData();
      }
    } else {
      dropdown.style.display = "none";
    }
  }

  function clearNotiBadge() {
    var badge = document.getElementById("headerNotiBadge");
    if (badge) badge.style.display = "none";
  }

  document.addEventListener("click", function(e) {
    var dropdown = document.getElementById("headerNotiDropdown");
    var btn = document.getElementById("btnNotiToggle");
    if (dropdown && !dropdown.contains(e.target) && e.target !== btn && !btn.contains(e.target)) {
      dropdown.style.display = "none";
    }
  });

  function fetchRealNotificationData() {
    fetch('api/notifications')
      .then(res => {
        if (!res.ok) throw new Error("API chưa sẵn sàng");
        return res.json();
      })
      .then(data => {
        if (data && data.length > 0) {
          var container = document.getElementById("headerNotiContent");
          var html = "";
          var unread = 0;
          data.forEach(item => {
            if (!item.isRead) unread++;
            html += `
              <a href="profile" style="display: block; padding: 12px 16px; border-bottom: 1px solid #fdf2f4; text-decoration: none; color: inherit; background: \${item.isRead ? '#ffffff' : '#fff8f9'};">
                <div style="display: flex; gap: 10px; align-items: flex-start;">
                  <span style="font-size: 20px;">\${item.icon || '📦'}</span>
                  <div>
                    <div style="font-size: 12.5px; font-weight: 700; color: #2b1b1b;">\${item.title}</div>
                    <div style="font-size: 11.5px; color: #666; margin-top: 2px;">\${item.message}</div>
                  </div>
                </div>
              </a>
            `;
          });
          container.innerHTML = html;
          var badge = document.getElementById("headerNotiBadge");
          if (badge) {
            if (unread > 0) {
              badge.innerText = unread;
              badge.style.display = "inline-block";
            } else {
              badge.style.display = "none";
            }
          }
        }
      })
      .catch(err => {
        console.log("Dùng giao diện tĩnh:", err);
      });
  }
</script>