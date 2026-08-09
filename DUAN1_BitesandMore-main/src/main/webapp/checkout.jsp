<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Bites & More — Checkout</title>
  <!-- Nhúng đúng đường dẫn file CSS -->
  <link rel="stylesheet" href="CSS/style.css">
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
    <div class="wf-icons">
      <a href="favorites.jsp" class="ic-btn">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/></svg>
        <span class="badge">3</span>
      </a>
      <a href="cart.jsp" class="ic-btn">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
        <span class="badge">2</span>
      </a>
      <a href="login.jsp" class="ic-btn">
        <svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4 4-7 8-7s8 3 8 7"/></svg>
      </a>
    </div>
  </div>

  <!-- BREADCRUMB -->
  <div class="breadcrumb">
    <span>Home</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span>Cart</span>
    <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><polyline points="9,6 15,12 9,18"/></svg>
    <span>Checkout</span>
  </div>

  <!-- MAIN CHECKOUT SECTION -->
  <div class="section" style="padding:40px;">
    
    <!-- STEP PROGRESS BAR -->
    <div style="display:flex;justify-content:center;gap:60px;margin-bottom:44px;">
      <div style="display:flex;align-items:center;gap:10px;">
        <div style="width:32px;height:32px;border-radius:50%;border:1.5px solid #000;background:#000;color:#fff;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:bold;">1</div>
        <span style="font-size:13px;font-weight:bold;">Cart</span>
      </div>
      <div style="display:flex;align-items:center;gap:10px;">
        <div style="width:32px;height:32px;border-radius:50%;border:1.5px solid #000;background:#000;color:#fff;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:bold;">2</div>
        <span style="font-size:13px;font-weight:bold;">Shipping</span>
      </div>
      <div style="display:flex;align-items:center;gap:10px;">
        <div style="width:32px;height:32px;border-radius:50%;border:1.5px solid #000;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:bold;">3</div>
        <span style="font-size:13px;font-weight:bold;">Payment</span>
      </div>
      <div style="display:flex;align-items:center;gap:10px;">
        <div style="width:32px;height:32px;border-radius:50%;border:1.5px solid #000;display:flex;align-items:center;justify-content:center;font-size:13px;font-weight:bold;">4</div>
        <span style="font-size:13px;font-weight:bold;">Confirmation</span>
      </div>
    </div>

    <!-- FORM CHECKOUT & SUMMARY -->
    <form action="checkout" method="POST">
      <div class="row">
        
        <!-- Cột Trái: Thông Tin Giao Hàng & Thanh Toán -->
        <div class="col-7">
          
          <!-- Address Block -->
          <div class="filter-block">
            <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:20px;">Shipping Address</h5>
            <div class="row">
              <div class="col-6 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">First Name</label>
                <input type="text" name="firstName" class="input" placeholder="John" required>
              </div>
              <div class="col-6 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Last Name</label>
                <input type="text" name="lastName" class="input" placeholder="Doe" required>
              </div>
            </div>
            
            <div class="field" style="margin-top:16px;">
              <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Address</label>
              <input type="text" name="address" class="input" placeholder="Street address" required>
            </div>
            
            <div class="row" style="margin-top:16px;">
              <div class="col-4 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">City</label>
                <input type="text" name="city" class="input" placeholder="City" required>
              </div>
              <div class="col-4 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">State</label>
                <input type="text" name="state" class="input" placeholder="State">
              </div>
              <div class="col-4 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Zip Code</label>
                <input type="text" name="zipCode" class="input" placeholder="00000">
              </div>
            </div>

            <div class="field" style="margin-top:16px;">
              <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Phone Number</label>
              <input type="tel" name="phone" class="input" placeholder="(000) 000-0000" required>
            </div>
          </div>

          <!-- Payment Method Block -->
          <div class="filter-block" style="margin-top:30px;">
            <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:20px;">Payment Method</h5>
            
            <div style="display:flex;flex-direction:column;gap:12px;margin-bottom:20px;">
              <label style="display:flex;align-items:center;gap:10px;cursor:pointer;font-size:13px;font-weight:bold;">
                <input type="radio" name="paymentMethod" value="card" checked style="width:16px;height:16px;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="1" y="4" width="22" height="16" rx="2"/><line x1="1" y1="10" x2="23" y2="10"/></svg>
                Credit / Debit Card
              </label>

              <label style="display:flex;align-items:center;gap:10px;cursor:pointer;font-size:13px;font-weight:bold;">
                <input type="radio" name="paymentMethod" value="cod" style="width:16px;height:16px;">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5"><rect x="2" y="6" width="20" height="12" rx="2"/><circle cx="12" cy="12" r="3"/></svg>
                Cash on Delivery (COD)
              </label>
            </div>

            <div class="row">
              <div class="col-12 field">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Card Number</label>
                <input type="text" name="cardNumber" class="input" placeholder="0000 0000 0000 0000">
              </div>
              <div class="col-6 field" style="margin-top:16px;">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">Expiry Date</label>
                <input type="text" name="expiry" class="input" placeholder="MM/YY">
              </div>
              <div class="col-6 field" style="margin-top:16px;">
                <label style="display:block;margin-bottom:6px;font-size:13px;font-weight:bold;">CVV</label>
                <input type="password" name="cvv" class="input" placeholder="123">
              </div>
            </div>
          </div>

        </div>

        <!-- Cột Phải: Order Summary -->
        <div class="col-5">
          <div class="filter-block">
            <h5 style="border-bottom:1px solid #000;padding-bottom:10px;margin-bottom:16px;">Order Summary</h5>
            
            <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:12px;">
              <span>Sourdough Bread x1</span>
              <span style="font-weight:bold;">180.000VND</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:12px;">
              <span>Chocolate Cupcake x1</span>
              <span style="font-weight:bold;">30.500VND</span>
            </div>
            <div style="display:flex;justify-content:space-between;font-size:13px;margin-bottom:12px;">
              <span>Red Velvet Cake x1</span>
              <span style="font-weight:bold;">180.000VND</span>
            </div>

            <hr style="border:none;border-top:1px solid #000;margin:14px 0;">

            <div style="display:flex;justify-content:space-between;font-size:14px;margin-bottom:10px;"><span>Subtotal</span><span>350.000VND</span></div>
            <div style="display:flex;justify-content:space-between;font-size:14px;margin-bottom:10px;"><span>Shipping</span><span>50.000VND</span></div>

            <hr style="border:none;border-top:1px solid #000;margin:14px 0;">

            <div style="display:flex;justify-content:space-between;font-size:18px;font-weight:bold;margin-bottom:24px;"><span>Total</span><span>400.000VND</span></div>
            
            <button type="submit" class="btn btn-dark btn-block" style="display:inline-flex;align-items:center;justify-content:center;gap:8px;">
              Confirm Order 
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.5"><polyline points="20,6 9,17 4,12"/></svg>
            </button>
          </div>
        </div>

      </div>
    </form>

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