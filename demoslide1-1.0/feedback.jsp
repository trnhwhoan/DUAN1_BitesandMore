<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites &amp; More — Góp ý</title>
  <link rel="stylesheet" href="css/style.css">
  <style>
    .feedback-wrap { max-width:720px; margin:45px auto; padding:0 20px; }
    .feedback-card { background:#fff; border:1px solid #000; padding:32px; }
    .feedback-card h1 { margin:0 0 8px; font-size:24px; text-transform:uppercase; }
    .feedback-card p { color:#666; font-size:13px; margin-bottom:24px; }
    .feedback-grid { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
    .feedback-field { display:flex; flex-direction:column; gap:6px; margin-bottom:14px; }
    .feedback-field.full { grid-column:1 / -1; }
    .feedback-field label { font-size:12px; font-weight:bold; }
    .feedback-field input, .feedback-field select, .feedback-field textarea { border:1px solid #000; padding:11px; font:inherit; font-size:13px; box-sizing:border-box; }
    .feedback-field textarea { min-height:130px; resize:vertical; }
    @media(max-width:600px){ .feedback-grid{grid-template-columns:1fr}.feedback-field.full{grid-column:auto} }
  </style>
</head>
<body>
<div class="wire-page">
  <div class="wf-topbar">BITES &amp; MORE — Ý KIẾN CỦA BẠN GIÚP CHÚNG TÔI TỐT HƠN</div>
  <header class="wf-header">
    <a href="home" class="brand-logo">BITES &amp; MORE</a>
    <nav class="wf-nav"><a href="home">Trang chủ</a><a href="shop">Cửa hàng</a><a href="contact.jsp">Liên hệ</a></nav>
  </header>
  <main class="feedback-wrap">
    <div class="feedback-card">
      <h1>Góp ý &amp; phản hồi</h1>
      <p>Hãy chia sẻ trải nghiệm của bạn để Bites &amp; More phục vụ tốt hơn.</p>
      <c:if test="${not empty requestScope.error}"><div style="color:#b00020;border:1px solid #b00020;padding:10px;margin-bottom:16px;font-size:13px;"><c:out value="${requestScope.error}"/></div></c:if>
      <form action="feedback" method="POST">
        <div class="feedback-grid">
          <div class="feedback-field"><label>Họ và tên *</label><input name="name" required value="<c:out value='${param.name}'/>"/></div>
          <div class="feedback-field"><label>Email *</label><input type="email" name="email" required value="<c:out value='${param.email}'/>"/></div>
          <div class="feedback-field"><label>Chủ đề</label><select name="topic"><option>Góp ý chung</option><option>Chất lượng sản phẩm</option><option>Giao hàng</option><option>Dịch vụ khách hàng</option></select></div>
          <div class="feedback-field"><label>Đánh giá</label><select name="rating"><option value="5/5">★★★★★ — Rất hài lòng</option><option value="4/5">★★★★☆ — Hài lòng</option><option value="3/5">★★★☆☆ — Bình thường</option><option value="2/5">★★☆☆☆ — Chưa tốt</option><option value="1/5">★☆☆☆☆ — Không hài lòng</option></select></div>
          <div class="feedback-field full"><label>Nội dung góp ý *</label><textarea name="content" required placeholder="Nhập góp ý của bạn..."><c:out value="${param.content}"/></textarea></div>
        </div>
        <button type="submit" class="btn-action" style="width:100%;cursor:pointer;">GỬI PHẢN HỒI</button>
      </form>
    </div>
  </main>
  <footer class="minimal-footer">&copy; Bites &amp; More. since 2026</footer>
</div>
</body>
</html>
