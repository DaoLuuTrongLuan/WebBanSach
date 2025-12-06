<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Chi tiết sản phẩm - BookStore">
    <title>Chi Tiết Sách - BookStore</title>
    <jsp:include page="/WEB-INF/jsp/common/head.jsp"/>
</head>
<body>
    <jsp:include page="/WEB-INF/jsp/common/header.jsp"/>

    <!-- Main Content -->
    <main class="main">
        <div class="container">
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/">Trang chủ</a>
                <span> / </span>
                <a href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                <span> / </span>
                <c:if test="${product != null}">
                    <span>${product.title}</span>
                </c:if>
                <c:if test="${product == null}">
                    <span>Chi tiết sách</span>
                </c:if>
            </div>

            <!-- Error Message -->
            <c:if test="${error != null}">
                <div class="alert alert-danger" style="padding: 15px; margin: 20px 0; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; border-radius: 4px;">
                    ${error}
                    <a href="${pageContext.request.contextPath}/products" style="display: block; margin-top: 10px;">Quay lại danh sách sản phẩm</a>
                </div>
            </c:if>

            <!-- Product Detail Section -->
            <c:if test="${product != null}">
                <section class="product-detail">
                    <div class="product-images">
                        <div class="main-image">
                            <img src="${product.image}" alt="${product.title}" class="main-img"
                                onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22%3E%3Crect fill=%22%236366f1%22 width=%22300%22 height=%22400%22/%3E%3C/svg%3E'">
                        </div>
                    </div>

                    <div class="product-info">
                        <h1 class="product-title">${product.title}</h1>
                        
                        <div class="product-meta">
                            <span class="author">Tác giả: ${product.authorName}</span>
                            <span class="publisher">NXB: ${product.publisherName}</span>
                        </div>

                        <div class="product-rating">
                            <span class="stars">
                                <c:forEach var="i" begin="1" end="5">
                                    <c:choose>
                                        <c:when test="${i <= product.rating}">★</c:when>
                                        <c:otherwise>☆</c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </span>
                            <span class="review-count">(${product.reviews} đánh giá)</span>
                        </div>

                        <div class="product-price">
                            <span class="original-price">
                                <fmt:formatNumber value="${product.originalPrice}" pattern="#,###"/>đ
                            </span>
                            <span class="sale-price">
                                <fmt:formatNumber value="${product.price}" pattern="#,###"/>đ
                            </span>
                            <c:if test="${product.discount > 0}">
                                <span class="discount-badge">-${product.discount}%</span>
                            </c:if>
                        </div>

                        <div class="product-description">
                            <h3>Mô Tả</h3>
                            <p>${product.description}</p>
                        </div>

                        <div class="product-details">
                            <h3>Thông Tin Chi Tiết</h3>
                            <table class="detail-table">
                                <tr>
                                    <td>Tác Giả:</td>
                                    <td>${product.authorName}</td>
                                </tr>
                                <tr>
                                    <td>Nhà Xuất Bản:</td>
                                    <td>${product.publisherName}</td>
                                </tr>
                                <tr>
                                    <td>Năm Xuất Bản:</td>
                                    <td>${product.year}</td>
                                </tr>
                                <tr>
                                    <td>Số Trang:</td>
                                    <td>${product.pages}</td>
                                </tr>
                                <tr>
                                    <td>Kích Thước:</td>
                                    <td>${product.size}</td>
                                </tr>
                                <tr>
                                    <td>Hình Thức:</td>
                                    <td>${product.format}</td>
                                </tr>
                                <tr>
                                    <td>Trạng Thái:</td>
                                    <td>${product.status}</td>
                                </tr>
                            </table>
                        </div>

                        <!-- Purchase Section -->
                        <div class="purchase-section">
                            <div class="quantity-selector">
                                <label for="quantity">Số Lượng:</label>
                                <div class="quantity-control">
                                    <button class="qty-btn" id="qty-decrease">−</button>
                                    <input type="number" id="quantity" value="1" min="1" max="${product.stock}" class="qty-input">
                                    <button class="qty-btn" id="qty-increase">+</button>
                                </div>
                            </div>

                            <button class="btn btn-primary btn-lg" id="add-to-cart-btn">
                                🛒 Thêm Vào Giỏ Hàng
                            </button>
                            <button class="btn btn-outline btn-lg" id="add-to-wishlist-btn">
                                ❤️ Yêu Thích
                            </button>
                        </div>

                        <!-- Shipping Info -->
                        <div class="shipping-info">
                            <p>✓ Miễn phí vận chuyển cho đơn hàng từ 100.000đ</p>
                            <p>✓ Hàng chính hãng, có bảo hành</p>
                            <p>✓ Hỗ trợ đổi trả trong 30 ngày</p>
                        </div>
                    </div>
                </section>

                <!-- Related Products Section -->
                <c:if test="${not empty relatedProducts}">
                    <section class="related-products-section" style="margin-top: 40px;">
                        <h2 class="section-title">Sách Liên Quan</h2>
                        <div class="products-grid">
                            <c:forEach var="book" items="${relatedProducts}">
                                <div class="product-card" data-product-id="${book.id}">
                                    <div class="product-image">
                                        <img src="${book.image}" alt="${book.title}" 
                                            onerror="this.src='data:image/svg+xml,%3Csvg xmlns=%22http://www.w3.org/2000/svg%22 width=%22300%22 height=%22400%22%3E%3Crect fill=%22%236366f1%22 width=%22300%22 height=%22400%22/%3E%3C/svg%3E'">
                                        <c:if test="${book.discount > 0}">
                                            <div class="product-badge">-${book.discount}%</div>
                                        </c:if>
                                    </div>
                                    <div class="product-info">
                                        <h3 class="product-name">
                                            <a href="${pageContext.request.contextPath}/product?id=${book.id}">${book.title}</a>
                                        </h3>
                                        <p class="product-author">${book.authorName}</p>
                                        <div class="product-rating">
                                            <span class="stars">
                                                <c:forEach var="i" begin="1" end="5">
                                                    <c:choose>
                                                        <c:when test="${i <= book.rating}">★</c:when>
                                                        <c:otherwise>☆</c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                            </span>
                                            <span class="rating-value">${book.rating}</span>
                                        </div>
                                        <div class="product-price">
                                            <span class="product-original-price"><fmt:formatNumber value="${book.originalPrice}" pattern="#,###"/>đ</span>
                                            <span class="product-sale-price"><fmt:formatNumber value="${book.price}" pattern="#,###"/>đ</span>
                                        </div>
                                        <button class="btn btn-primary btn-sm add-to-cart-btn" style="width: 100%; margin-top: 8px;">🛒 Thêm Vào Giỏ</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </c:if>
            </c:if>
        </div>
    </main>

    <jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
        const productId = <c:if test="${product != null}">${product.id}</c:if><c:if test="${product == null}">null</c:if>;

        // Quantity control
        document.getElementById('qty-decrease').addEventListener('click', function() {
            const qtyInput = document.getElementById('quantity');
            if (parseInt(qtyInput.value) > 1) {
                qtyInput.value = parseInt(qtyInput.value) - 1;
            }
        });

        document.getElementById('qty-increase').addEventListener('click', function() {
            const qtyInput = document.getElementById('quantity');
            const maxStock = parseInt(qtyInput.getAttribute('max'));
            if (parseInt(qtyInput.value) < maxStock) {
                qtyInput.value = parseInt(qtyInput.value) + 1;
            }
        });

        // Add to cart
        document.getElementById('add-to-cart-btn').addEventListener('click', function() {
            const quantity = parseInt(document.getElementById('quantity').value) || 1;
            
            // Get product info from page with null checks
            const productTitleEl = document.getElementById('product-title');
            const productImageEl = document.getElementById('main-image');
            const productAuthorEl = document.getElementById('product-author');
            const productPriceEl = document.getElementById('sale-price');
            
            if (!productTitleEl || !productImageEl) {
                alert('Lỗi: Không tìm thấy thông tin sản phẩm');
                return;
            }
            
            const productTitle = productTitleEl.textContent || '';
            const productImage = productImageEl.src || '';
            const productAuthor = productAuthorEl ? productAuthorEl.textContent : '';
            const productPrice = productPriceEl ? productPriceEl.textContent : '0đ';
            
            // Parse product ID from URL
            const urlParams = new URLSearchParams(window.location.search);
            const productId = parseInt(urlParams.get('id'));
            
            if (!productId) {
                alert('Lỗi: Không tìm thấy ID sản phẩm');
                return;
            }
            
            const priceValue = parseInt(productPrice.replace(/\D/g, '')) || 0;
            
            const product = {
                id: productId,
                title: productTitle,
                price: priceValue,
                image: productImage,
                author: productAuthor,
                stock: 999
            };

            // Check if cart is initialized
            if (typeof cart === 'undefined') {
                console.error('Cart not defined');
                alert('Lỗi: Giỏ hàng chưa sẵn sàng. Vui lòng tải lại trang.');
                return;
            }
            
            if (!cart || typeof cart.addProduct !== 'function') {
                console.error('Cart.addProduct is not a function', cart);
                alert('Lỗi: Không thể thêm vào giỏ hàng. Vui lòng tải lại trang.');
                return;
            }
            
            cart.addProduct(product, quantity);
        });

        // Add to wishlist (placeholder - will implement later)
        document.getElementById('add-to-wishlist-btn').addEventListener('click', function() {
            alert('Tính năng wishlist sẽ được kích hoạt sau khi tích hợp đầy đủ');
        });

        // Related products click
        document.querySelectorAll('.related-products-section .product-card').forEach(card => {
            card.addEventListener('click', function(e) {
                if (e.target.closest('.btn')) return;
                const id = this.getAttribute('data-product-id');
                window.location.href = contextPath + '/product?id=' + id;
            });
        });
    </script>
</body>
</html>

