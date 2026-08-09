// Chạy hàm này khi trang shop.html load xong
document.addEventListener("DOMContentLoaded", function () {
    fetch('/api/products') // Đường dẫn khớp với @WebServlet trên Java
        .then(response => response.json())
        .then(data => {
            let productContainer = document.querySelector('.row-products'); // Thẻ chứa danh sách sản phẩm
            if (!productContainer) return;

            let htmlContent = '';
            
            // Duyệt qua từng sản phẩm mà Java Servlet trả về
            data.forEach(product => {
                htmlContent += `
                    <div class="col-3" style="margin-bottom:24px;">
                        <div class="product-card">
                            <div class="img-ph">Image</div>
                            <div class="pc-body">
                                <div class="pc-name">${product.name}</div>
                                <div class="pc-price">$${product.price.toFixed(2)}</div>
                                <div class="pc-cart-btn">Add to Cart</div>
                            </div>
                        </div>
                    </div>
                `;
            });

            // Đổ HTML vào giao diện
            productContainer.innerHTML = htmlContent;
        })
        .catch(error => console.error('Lỗi khi gọi Servlet Java:', error));
});