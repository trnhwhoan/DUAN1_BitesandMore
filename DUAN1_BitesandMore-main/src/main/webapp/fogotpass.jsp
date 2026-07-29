<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Forgot Password</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="wire-page">

  <!-- TOPBAR -->
  <div class="wf-topbar">FREE DELIVERY ON ORDERS OVER 100.000VND&nbsp;&nbsp;|&nbsp;&nbsp;CALL US: (000) 123-4567</div>
  
  <!-- HEADER -->
  <div class="wf-header">
    <div class="wf-logo">BITES &amp; MORE</div>
    <nav class="wf-nav">
      <a href="home.jsp">Home</a>
      <a href="shop.jsp">Shop</a>
      <a href="categories.jsp">Categories <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="6,9 12,15 18,9"/></svg></a>
      <a href="about.jsp">About</a>
      <a href="contact.jsp">Contact</a>
    </nav>
    <div class="wf-searchbar">
      <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="11" cy="11" r="7"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      <span>Search products...</span>
    </div>
  </div>

  <!-- MAIN FORGOT PASSWORD FORM -->
  <div class="section" style="display:flex;justify-content:center;padding:60px 40px;">
    <div style="width:100%;max-width:480px;">
      
      <!-- Icon Lock SVG -->
      <div class="img-ph" style="height:70px;width:70px;border-radius:50%;margin:0 auto 24px;">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
          <rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/>
        </svg>
      </div>

      <div style="font-size:26px;font-weight:bold;text-align:center;margin-bottom:8px;">Reset Your Password</div>
      <div style="font-size:14px;color:#444;text-align:center;margin-bottom:32px;">Enter your email and we'll send you a reset link</div>

      <div class="filter-block">
        <!-- Form gửi email sang ForgotPasswordServlet bằng POST -->
        <form action="forgot-password" method="POST">
          
          <div class="field">
            <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Email Address</label>
            <input type="email" name="email" class="input" placeholder="you@example.com" required>
          </div>

          <button type="submit" class="btn btn-dark btn-block" style="margin-top:20px;">Send Reset Link</button>
        
        </form>

        <div style="text-align:center;margin-top:24px;font-size:13px;display:flex;align-items:center;justify-content:center;gap:6px;">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="15,6 9,12 15,18"/></svg>
          <a href="login.jsp" style="text-decoration:underline;color:#000;font-weight:bold;">Back to Login</a>
        </div>
      </div>

    </div>
  </div>

  <!-- FOOTER -->
  <div class="wf-footer">
    <div class="footer-bottom">
      <span>© 2026 Bites &amp; More. All rights reserved.</span>
      <span>Privacy Policy &nbsp;|&nbsp; Terms of Service</span>
    </div>
  </div>

</div>
</body>
</html>