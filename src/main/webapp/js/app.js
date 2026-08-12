// app.js — Quản lý Load dữ liệu SQL & Bắt sự kiện Thêm Giỏ Hàng / Yêu Thích
// Hàm đồng bộ con số Badge cho TOÀN BỘ các trang
function updateGlobalBadges() {
  var cart = JSON.parse(localStorage.getItem("bites_cart") || "[]");
  var favorites = JSON.parse(localStorage.getItem("bites_favorites") || "[]");

  // Tính tổng số lượng sản phẩm trong giỏ
  var totalCartQty = cart.reduce(function (sum, item) {
    return sum + (item.quantity || 1);
  }, 0);

  // Cập nhật lên tất cả các thẻ có class .cart-count và .fav-count
  document.querySelectorAll(".cart-count").forEach(function (b) {
    b.innerText = totalCartQty;
  });

  document.querySelectorAll(".fav-count").forEach(function (b) {
    b.innerText = favorites.length;
  });
}

// Cho chạy ngay khi trang web vừa tải xong
document.addEventListener("DOMContentLoaded", updateGlobalBadges);

// Bắt sự kiện khi giỏ hàng / yêu thích thay đổi ở các tab khác
window.addEventListener("storage", updateGlobalBadges);
document.addEventListener("DOMContentLoaded", function () {
    const productContainer = document.querySelector('.shop-products');
    
    // --- KHỞI TẠO BADGE SỐ LƯỢNG NỔI TRÊN HEADER ---
    function updateHeaderBadges() {
        const cart = JSON.parse(localStorage.getItem("bites_cart") || "[]");
        const favs = JSON.parse(localStorage.getItem("bites_favorites") || "[]");
        
        const totalCartQty = cart.reduce((sum, item) => sum + (item.quantity || 1), 0);
        
        document.querySelectorAll(".cart-count").forEach(b => b.innerText = totalCartQty);
        document.querySelectorAll(".fav-count").forEach(b => b.innerText = favs.length);
    }

    function initFavIcons() {
        const favorites = JSON.parse(localStorage.getItem("bites_favorites") || "[]");
        const cards = document.querySelectorAll(".product-card");
        
        cards.forEach(card => {
            const nameEl = card.querySelector(".pc-name");
            const favBtn = card.querySelector(".fav-icon");
            if (nameEl && favBtn) {
                const name = nameEl.innerText.trim();
                const isFav = favorites.some(f => f.name === name);
                const svg = favBtn.querySelector("svg");
                if (svg) {
                    svg.setAttribute("fill", isFav ? "#000" : "none");
                }
            }
        });
    }

    updateHeaderBadges();

    if (!productContainer) return;

    // --- 1. GỌI SERVLET ĐỂ LẤY SẢN PHẨM TỪ SQL ---
    fetch('product')
        .then(response => {
            if (!response.ok) throw new Error('Không thể tải sản phẩm: ' + response.status);
            return response.json();
        })
        .then(data => {
            if (!Array.isArray(data)) throw new Error(data.message || 'Dữ liệu sản phẩm không hợp lệ');
            
            productContainer.replaceChildren();

            if (data.length === 0) {
                productContainer.textContent = 'Chưa có sản phẩm trong bảng Product.';
                return;
            }

            data.forEach(product => {
                const card = document.createElement('div');
                card.className = 'product-card';
                card.style.display = 'block';

                const categories = {
                    1: 'bread', 2: 'cake', 3: 'pastry',
                    4: 'cookie', 5: 'donut', 6: 'cupcake'
                };
                card.dataset.category = categories[product.categoryId] || '';

                const fallbackImages = {
                    1: 'images/bread.jpg', 2: 'images/cakes.jpg',
                    3: 'images/pastries.jpg', 4: 'images/cookies.jpg',
                    5: 'images/donuts.jpg', 6: 'images/cupcakes.jpg'
                };
                const fallbackImage = fallbackImages[product.categoryId] || 'images/bread.jpg';
                const imageValue = product.image ? product.image.trim() : '';
                const isImageUrl = /^https?:\/\//i.test(imageValue);
                const isProtocolLessUrl = imageValue.includes('/') && !imageValue.startsWith('images/');
                const image = isImageUrl
                    ? imageValue
                    : (isProtocolLessUrl ? 'https://' + imageValue : (imageValue ? 'images/' + imageValue : fallbackImage));
                
                const price = new Intl.NumberFormat('vi-VN').format(product.price) + 'đ';

                card.innerHTML = `
                    <div class="fav-icon" title="Thêm vào yêu thích">
                        <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="#000" stroke-width="1.5">
                            <path d="M12 21s-7-4.35-9.5-8.5C1 9 2.5 5.5 6 5c2-.3 3.5.8 6 3.3C14.5 5.8 16 4.7 18 5c3.5.5 5 4 3.5 7.5C19 16.65 12 21 12 21z"/>
                        </svg>
                    </div>
                    <div class="img-ph"><img src="${image}" alt=""></div>
                    <div class="pc-body">
                        <div class="pc-name"></div>
                        <div class="pc-price"></div>
                        <div class="pc-cart-btn" style="cursor:pointer;">THÊM VÀO GIỎ</div>
                    </div>`;

                card.querySelector('img').alt = product.name || 'Sản phẩm';
                card.querySelector('.pc-name').textContent = product.name || 'Sản phẩm';
                card.querySelector('.pc-price').textContent = price;
                card.querySelector('img').onerror = function () {
                    this.onerror = null;
                    this.src = fallbackImage;
                };

                productContainer.appendChild(card);
            });

            document.dispatchEvent(new Event('shopProductsLoaded'));
            initFavIcons();
        })
        .catch(error => {
            productContainer.textContent = 'Không tải được sản phẩm: ' + error.message;
            console.error('Lỗi khi gọi Servlet Java:', error);
        });

    // --- 2. BẮT SỰ KIỆN NÚT "THÊM VÀO GIỎ" & "TRÁI TIM" TRÊN TRANG SHOP ---
    document.addEventListener("click", function (e) {
        
        // A. Xử lý Thêm vào giỏ hàng
        const cartBtn = e.target.closest(".pc-cart-btn");
        if (cartBtn) {
            e.preventDefault();
            
            const card = cartBtn.closest(".product-card");
            const name = card.querySelector(".pc-name").innerText.trim();
            const price = card.querySelector(".pc-price").innerText.trim();
            const imgEl = card.querySelector("img");
            const img = imgEl ? imgEl.src : "images/placeholder.jpg";

            let cart = JSON.parse(localStorage.getItem("bites_cart") || "[]");
            const existingIndex = cart.findIndex(item => item.name === name);

            if (existingIndex > -1) {
                cart[existingIndex].quantity = (cart[existingIndex].quantity || 1) + 1;
            } else {
                cart.push({ name: name, price: price, img: img, quantity: 1 });
            }

            localStorage.setItem("bites_cart", JSON.stringify(cart));
            updateHeaderBadges();

            // Hiệu ứng thông báo nút bấm
            const oldText = cartBtn.innerText;
            cartBtn.innerText = "ĐÃ THÊM ✓";
            cartBtn.style.background = "#000";
            cartBtn.style.color = "#fff";
            
            setTimeout(() => {
                cartBtn.innerText = oldText;
                cartBtn.style.background = "";
                cartBtn.style.color = "";
            }, 1000);
            return;
        }

        // B. Xử lý Thả tim yêu thích
        const favBtn = e.target.closest(".fav-icon");
        if (favBtn) {
            e.preventDefault();
            e.stopPropagation();

            const card = favBtn.closest(".product-card");
            const name = card.querySelector(".pc-name").innerText.trim();
            const price = card.querySelector(".pc-price").innerText.trim();
            const imgEl = card.querySelector("img");
            const img = imgEl ? imgEl.src : "images/placeholder.jpg";

            let favorites = JSON.parse(localStorage.getItem("bites_favorites") || "[]");
            const index = favorites.findIndex(f => f.name === name);
            const svg = favBtn.querySelector("svg");

            if (index > -1) {
                favorites.splice(index, 1);
                if (svg) svg.setAttribute("fill", "none");
            } else {
                favorites.push({ name: name, price: price, img: img });
                if (svg) svg.setAttribute("fill", "#000");
            }

            localStorage.setItem("bites_favorites", JSON.stringify(favorites));
            updateHeaderBadges();
        }
    });
});