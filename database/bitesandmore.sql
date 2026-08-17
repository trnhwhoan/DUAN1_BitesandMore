
CREATE DATABASE BitesandMore;
GO

USE BitesandMore;
GO


CREATE TABLE [User] (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    full_name NVARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL,
    [password] VARCHAR(255) NOT NULL,
    gender NVARCHAR(10) DEFAULT N'Khác' 
        CHECK (gender IN (N'Nam', N'Nữ', N'Khác')),
    date_of_birth DATE NULL,
    [address] NVARCHAR(255) NULL,
    [role] NVARCHAR(20) DEFAULT N'Customer' 
        CHECK ([role] IN (N'Admin', N'Customer')),
    [status] NVARCHAR(20) DEFAULT N'Active' 
        CHECK ([status] IN (N'Active', N'Inactive', N'Blocked')),
    created_at DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE Brand (
    brand_id INT PRIMARY KEY IDENTITY(1,1),
    brand_name NVARCHAR(100) UNIQUE NOT NULL,
    [description] NVARCHAR(255) NULL,
    [status] NVARCHAR(20) DEFAULT N'Active' 
        CHECK ([status] IN (N'Active', N'Inactive'))
);
GO


CREATE TABLE Category (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name NVARCHAR(255) UNIQUE NOT NULL,
    [description] NVARCHAR(255) NULL,
    [status] NVARCHAR(20) DEFAULT N'Active' 
        CHECK ([status] IN (N'Active', N'Inactive'))
);
GO


CREATE TABLE Product (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name NVARCHAR(255) NOT NULL,
    [description] NVARCHAR(500) NULL,
    price DECIMAL(18,2) NOT NULL CHECK (price >= 0),
    [image] VARCHAR(255) NULL,
    ingredient NVARCHAR(500) NULL,
    expiry_date INT NOT NULL,  -- Hạn sử dụng (ngày)
    quantity INT DEFAULT 0 CHECK (quantity >= 0),
    usage_instructions NVARCHAR(500) NULL,
    discount_percent DECIMAL(5,2) DEFAULT 0 CHECK (discount_percent BETWEEN 0 AND 100),
    is_featured BIT DEFAULT 0,  -- Sản phẩm nổi bật
    is_new BIT DEFAULT 0,  -- Sản phẩm mới
    [status] NVARCHAR(20) DEFAULT N'Active' 
        CHECK ([status] IN (N'Active', N'Inactive')),
    category_id INT NOT NULL,
    brand_id INT NULL,
    created_at DATETIME2(3) NOT NULL DEFAULT CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00')),
    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    FOREIGN KEY (brand_id) REFERENCES Brand(brand_id)
);
GO

CREATE TABLE Cart (
    cart_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    created_at DATETIME2(3) NOT NULL DEFAULT CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00')),
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);
GO


CREATE TABLE Cart_Detail (
    cart_detail_id INT PRIMARY KEY IDENTITY(1,1),
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(18,2) NOT NULL CHECK (unit_price >= 0),
    added_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (cart_id) REFERENCES Cart(cart_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
GO

CREATE TABLE Discount (
    discount_id INT PRIMARY KEY IDENTITY(1,1),
    discount_code VARCHAR(50) UNIQUE NOT NULL,
    [description] NVARCHAR(255) NULL,
    discount_percent DECIMAL(5,2) NOT NULL CHECK (discount_percent BETWEEN 0 AND 100),
    min_order_amount DECIMAL(18,2) DEFAULT 0 CHECK (min_order_amount >= 0),
    max_discount_amount DECIMAL(18,2) NULL CHECK (max_discount_amount >= 0),
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    usage_limit INT NULL CHECK (usage_limit >= 0),
    used_count INT DEFAULT 0 CHECK (used_count >= 0),
    [status] NVARCHAR(20) DEFAULT N'Active' 
        CHECK ([status] IN (N'Active', N'Expired', N'Inactive'))
);
GO

CREATE TABLE Payment (
    payment_id INT PRIMARY KEY IDENTITY(1,1),
    payment_name NVARCHAR(100) NOT NULL 
        CHECK (payment_name IN (N'Tiền mặt', N'Chuyển khoản')),
    [description] NVARCHAR(255) NULL
);
GO

INSERT INTO Payment (payment_name, [description])
SELECT N'Tiền mặt', N'Thanh toán khi nhận hàng'
WHERE NOT EXISTS (SELECT 1 FROM Payment WHERE payment_name = N'Tiền mặt');
INSERT INTO Payment (payment_name, [description])
SELECT N'Chuyển khoản', N'Thanh toán qua chuyển khoản/QR'
WHERE NOT EXISTS (SELECT 1 FROM Payment WHERE payment_name = N'Chuyển khoản');
GO


CREATE TABLE [Order] (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    order_code VARCHAR(20) UNIQUE NOT NULL,
    user_id INT NOT NULL,
    recipient_name NVARCHAR(100) NOT NULL,
    recipient_phone VARCHAR(15) NOT NULL,
    recipient_email VARCHAR(255) NULL,
    order_date DATETIME2(0) NOT NULL DEFAULT CONVERT(datetime2(0), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00')),
    total_amount DECIMAL(18,2) NOT NULL CHECK (total_amount >= 0),
    discount_amount DECIMAL(18,2) DEFAULT 0 CHECK (discount_amount >= 0),
    shipping_fee DECIMAL(10,2) DEFAULT 0 CHECK (shipping_fee >= 0),
    final_amount DECIMAL(18,2) NOT NULL CHECK (final_amount >= 0),
    [status] NVARCHAR(50) DEFAULT N'Pending' 
        CHECK ([status] IN (N'Pending', N'Confirmed', N'Processing', N'Shipping', N'Delivered', N'Completed', N'Cancelled')),
    payment_id INT NOT NULL,
    payment_status NVARCHAR(20) DEFAULT N'Pending' 
        CHECK (payment_status IN (N'Pending', N'Paid', N'Failed')),
    shipping_address NVARCHAR(255) NOT NULL,
    shipping_note NVARCHAR(500) NULL,
    order_note NVARCHAR(500) NULL,
    estimated_delivery DATE NULL,
    created_at DATETIME2(3) NOT NULL DEFAULT CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00')),
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (payment_id) REFERENCES Payment(payment_id)
);
GO

CREATE TABLE Order_Detail (
    order_detail_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(18,2) NOT NULL CHECK (unit_price >= 0),
    subtotal DECIMAL(18,2) NOT NULL CHECK (subtotal >= 0),
    FOREIGN KEY (order_id) REFERENCES [Order](order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
GO

CREATE TABLE Order_Status_History (
    history_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    [status] NVARCHAR(50) NOT NULL 
        CHECK ([status] IN (N'Pending', N'Confirmed', N'Processing', N'Shipping', N'Delivered', N'Completed', N'Cancelled')),
    note NVARCHAR(255) NULL,
    created_at DATETIME2(3) NOT NULL DEFAULT CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00')),
    FOREIGN KEY (order_id) REFERENCES [Order](order_id) ON DELETE CASCADE
);
GO


CREATE TABLE Review (
    review_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    content NVARCHAR(500) NULL,
    is_verified_purchase BIT DEFAULT 0,
    review_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES [User](user_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);
GO
  
-- TẠO INDEX

-- User
CREATE INDEX idx_user_email ON [User](email);
CREATE INDEX idx_user_phone ON [User](phone_number);

-- Product
CREATE INDEX idx_product_category ON Product(category_id);
CREATE INDEX idx_product_brand ON Product(brand_id);
CREATE INDEX idx_product_price ON Product(price);
CREATE INDEX idx_product_name ON Product(product_name);

-- Order
CREATE INDEX idx_order_user ON [Order](user_id);
CREATE INDEX idx_order_status ON [Order]([status]);
CREATE INDEX idx_order_date ON [Order](order_date);
CREATE INDEX idx_order_code ON [Order](order_code);

-- Order Detail
CREATE INDEX idx_orderdetail_order ON Order_Detail(order_id);
CREATE INDEX idx_orderdetail_product ON Order_Detail(product_id);

-- Cart
CREATE INDEX idx_cart_user ON Cart(user_id);

-- Review
CREATE INDEX idx_review_product ON Review(product_id);
CREATE INDEX idx_review_user ON Review(user_id);

-- Discount
CREATE INDEX idx_discount_code ON Discount(discount_code);
CREATE INDEX idx_discount_date ON Discount(start_date, end_date);

-- Order Status History
CREATE INDEX idx_status_history_order ON Order_Status_History(order_id);
GO


-- TRIGGER: Tự động tạo mã đơn hàng
CREATE TRIGGER trg_GenerateOrderCode
ON [Order]
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @new_order_code VARCHAR(20);
    DECLARE @order_id INT;
    
    SELECT @order_id = ISNULL(MAX(order_id), 0) + 1 FROM [Order];
    SET @new_order_code = 'DH-' + FORMAT(GETDATE(), 'yyyyMMdd') + '-' + 
                          RIGHT('000' + CAST(@order_id AS VARCHAR(3)), 3);
    
    INSERT INTO [Order] (
        order_code, user_id, recipient_name, recipient_phone, 
        recipient_email, order_date, total_amount, discount_amount,
        shipping_fee, final_amount, [status], payment_id, payment_status,
        shipping_address, shipping_note, order_note, discount_id,
        estimated_delivery, created_at
    )
    SELECT 
        @new_order_code, user_id, recipient_name, recipient_phone,
        recipient_email, order_date, total_amount, discount_amount,
        shipping_fee, final_amount, [status], payment_id, payment_status,
        shipping_address, shipping_note, order_note, discount_id,
        estimated_delivery, CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00'))
    FROM inserted;
    
    INSERT INTO Order_Status_History (order_id, [status], note, created_at)
    SELECT order_id, [status], N'Tạo đơn hàng', CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00'))
    FROM [Order]
    WHERE order_code = @new_order_code;
END
GO

INSERT INTO Category (category_name, [description], [status])
VALUES 
(N'Bread', N'Các loại bánh mì truyền thống và hiện đại', N'Active'),
(N'Cakes', N'Các loại bánh kem, bánh ngọt nhân kem', N'Active'),
(N'Pastry', N'Các loại bánh ngọt, bánh xốp, bánh phồng', N'Active'),
(N'Cookie', N'Các loại bánh quy, bánh cookie giòn tan', N'Active'),
(N'Donut', N'Các loại bánh rán, donut phủ socola, phủ đường', N'Active'),
(N'Cupcake', N'Các loại bánh cupcake nhỏ xinh, nhiều hương vị', N'Active');
SELECT * FROM Category;

--🥖 Bread
INSERT INTO Product (
    product_name, 
    [description], 
    price, 
    [image], 
    ingredient, 
    expiry_date, 
    quantity, 
    usage_instructions, 
    discount_percent, 
    is_featured, 
    is_new, 
    [status], 
    category_id, 
    brand_id
)
VALUES 
(
    N'Bánh mì Baguette',
    N'Bánh mì Baguette truyền thống Pháp, vỏ giòn tan, ruột mềm xốp, thơm mùi bột mì nguyên chất',
    28000.00,
    'https://i.pinimg.com/736x/34/a4/97/34a497fc88313f66649e0569c8e795ec.jpg',
    N'Bột mì, nước, muối, men bánh mì',
    5,
    100,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng trong vòng 2 ngày sau khi mua.',
    0,
    1,
    1,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì hoa cúc',
    N'Bánh mì hoa cúc mềm xốp, hình dáng hoa cúc đẹp mắt, vị bơ sữa thơm béo ngậy',
    65000.00,
    'https://i.pinimg.com/1200x/12/b5/8e/12b58ecc51dc513790c8dbf4a00a8ba4.jpg',
    N'Bột mì, bơ, sữa tươi, trứng, đường, men bánh mì',
    5,
    50,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng trong vòng 3 ngày.',
    0,
    1,
    1,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì sữa Hokkaido',
    N'Bánh mì sữa Hokkaido mềm mịn như bông, vị ngọt nhẹ, thơm mùi sữa tươi nguyên chất',
    55000.00,
    'https://i.pinimg.com/736x/92/67/87/926787bdc56844c3a9e486841f04c695.jpg',
    N'Bột mì, sữa tươi Hokkaido, bơ, đường, men bánh mì',
    5,
    60,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng trong vòng 3 ngày.',
    0,
    1,
    1,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì bơ tỏi',
    N'Bánh mì bơ tỏi thơm lừng, bơ béo ngậy, tỏi vàng giòn, ăn là ghiền',
    42000.00,
    'https://i.pinimg.com/736x/45/ea/ca/45eaca05a7b549d801ab35e8b3cc7356.jpg',
    N'Bánh mì Baguette, bơ, tỏi, rau mùi, muối',
    3,
    80,
    N'Bảo quản nơi khô ráo, thoáng mát. Có thể hâm nóng trước khi dùng.',
    0,
    0,
    0,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì phô mai',
    N'Bánh mì phô mai với lớp phô mai béo mặn, chảy quyện vào từng thớ bánh',
    45000.00,
    'https://i.pinimg.com/1200x/3d/6a/a4/3d6aa475bf64fda9f7db14fbba472218.jpg',
    N'Bánh mì, phô mai Mozzarella, phô mai Parmesan, bơ, tỏi',
    3,
    70,
    N'Bảo quản nơi khô ráo, thoáng mát. Hâm nóng trước khi dùng để phô mai tan chảy.',
    0,
    0,
    0,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì nguyên cám',
    N'Bánh mì nguyên cám giàu chất xơ, tốt cho sức khỏe, vị thơm đặc trưng của lúa mạch',
    38000.00,
    'https://i.pinimg.com/736x/77/6a/1a/776a1a0cc732ef3648b5d9d4589b8fd2.jpg',
    N'Bột nguyên cám, nước, muối, men bánh mì, hạt lanh, hạt hướng dương',
    5,
    40,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng trong vòng 3-4 ngày.',
    0,
    0,
    1,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì Sourdough',
    N'Bánh mì Sourdough lên men tự nhiên, vị chua nhẹ đặc trưng, vỏ giòn ruột dai',
    78000.00,
    'https://i.pinimg.com/736x/5d/9f/c3/5d9fc32d56126074219b204adc604a58.jpg',
    N'Bột mì, nước, muối, men sourdough tự nhiên',
    7,
    30,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng trong vòng 5-7 ngày.',
    0,
    1,
    1,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì xúc xích',
    N'Bánh mì kẹp xúc xích thơm ngon, kết hợp hài hòa giữa bánh mềm và xúc xích đậm vị',
    35000.00,
    'https://i.pinimg.com/736x/f4/65/2a/f4652adfb19a4e91cf70f99fe2b84fd1.jpg',
    N'Bánh mì, xúc xích Đức, tương cà, tương ớt, rau trộn',
    3,
    90,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì socola',
    N'Bánh mì socola ngọt ngào, nhân socola đen tan chảy, thơm béo khó cưỡng',
    38000.00,
    'https://i.pinimg.com/736x/d2/88/e5/d288e5d9f296e6238a2700365838c00d.jpg',
    N'Bột mì, socola đen, bơ, sữa, đường, men bánh mì',
    4,
    65,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng trong vòng 3 ngày.',
    0,
    0,
    0,
    N'Active',
    1,
    NULL
),
(
    N'Bánh mì đậu đỏ',
    N'Bánh mì nhân đậu đỏ ngọt bùi, vị truyền thống thơm ngon, béo nhẹ',
    36000.00,
    'https://i.pinimg.com/736x/0d/11/11/0d1111874f45622a8b0b21760f250512.jpg',
    N'Bột mì, đậu đỏ, đường, bơ, sữa, men bánh mì',
    4,
    55,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng trong vòng 3 ngày.',
    0,
    0,
    0,
    N'Active',
    1,
    NULL
);

--🍰 Cakes
INSERT INTO Product (
    product_name, 
    [description], 
    price, 
    [image], 
    ingredient, 
    expiry_date, 
    quantity, 
    usage_instructions, 
    discount_percent, 
    is_featured, 
    is_new, 
    [status], 
    category_id, 
    brand_id
)
VALUES 
(
    N'Bánh Tiramisu',
    N'Bánh Tiramisu Ý với lớp kem mascarpone mịn màng, bột cà phê đắng nhẹ, thấm vị rượu rum thơm nồng',
    320000.00,
    'https://i.pinimg.com/736x/5c/69/db/5c69db7b9b956abbc13abc2fcb3bbbc0.jpg',
    N'Kem mascarpone, bánh xốp ladyfinger, cà phê espresso, rượu rum, bột cacao',
    4,
    20,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    1,
    1,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Red Velvet',
    N'Bánh Red Velvet đỏ quyến rũ, kem phô mai tươi mịn, vị bơ sữa béo ngậy, mềm ẩm khó cưỡng',
    390000.00,
    'https://i.pinimg.com/1200x/91/86/5e/91865ec3a35f437be843c7b5b3f0c4e0.jpg',
    N'Bột mì, phô mai cream cheese, bơ, đường, trứng, sữa, phẩm màu đỏ, bột cacao',
    4,
    15,
    N'Bảo quản lạnh trong tủ mát. Dùng trong vòng 3 ngày.',
    0,
    1,
    1,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Cheesecake',
    N'Bánh Cheesecake New York với lớp kem phô mai béo ngậy, đế bánh quy giòn tan, vị chua nhẹ của sữa chua',
    350000.00,
    'https://i.pinimg.com/736x/1d/64/37/1d6437757ae867e8404c5779e4d85b0b.jpg',
    N'Phô mai cream cheese, bánh quy nghiền, bơ, trứng, đường, sữa chua, vani',
    5,
    18,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    1,
    0,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Chocolate',
    N'Bánh Chocolate đậm vị, lớp kem socola đen tan chảy, mềm ẩm, ngọt ngào khó cưỡng',
    330000.00,
    'https://i.pinimg.com/vwebp/1200x/a0/50/79/a050792bb18dfdd41e4559b011fc6c08.webp',
    N'Socola đen, bột cacao, bơ, trứng, đường, bột mì, kem tươi',
    5,
    20,
    N'Bảo quản nơi thoáng mát hoặc tủ mát. Dùng trong vòng 5 ngày.',
    0,
    0,
    0,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Black Forest',
    N'Bánh Black Forest Đức với socola đen, kem tươi, anh đào ngọt ngào, thơm mùi rượu kirsch',
    420000.00,
    'https://i.pinimg.com/vwebp/736x/4e/fd/93/4efd93ac11262c68c8ee5a746f2fac7b.webp',
    N'Socola đen, kem tươi, anh đào, rượu kirsch, bột cacao, bánh xốp socola',
    4,
    12,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    1,
    1,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Matcha',
    N'Bánh Matcha Nhật Bản với bột trà xanh nguyên chất, vị chát nhẹ hòa quyện cùng kem sữa béo mịn',
    360000.00,
    'https://i.pinimg.com/vwebp/736x/dc/a9/15/dca9157fcac9ee7e3b98818a05c8cd1e.webp',
    N'Bột trà xanh matcha, kem sữa tươi, bột mì, trứng, đường, bơ',
    4,
    15,
    N'Bảo quản lạnh trong tủ mát. Dùng trong vòng 3 ngày.',
    0,
    1,
    1,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Carrot',
    N'Bánh Carrot lành mạnh với cà rốt tươi, quả óc chó, kem phô mai béo ngậy, thơm mùi quế',
    290000.00,
    'https://i.pinimg.com/736x/00/dd/66/00dd667caad13114a01e41a13f56d334.jpg',
    N'Cà rốt, phô mai cream cheese, bột mì, đường, trứng, dầu ăn, quế, quả óc chó',
    4,
    20,
    N'Bảo quản lạnh trong tủ mát. Dùng trong vòng 4 ngày.',
    0,
    0,
    0,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Kem Dâu',
    N'Bánh kem dâu tươi mát, lớp kem béo nhẹ, dâu chua ngọt, màu hồng đẹp mắt, thơm ngon',
    390000.00,
    'https://i.pinimg.com/vwebp/1200x/ad/62/12/ad6212628fa7ca2851db2f90bef2bf58.webp',
    N'Kem tươi, dâu tây, bánh xốp, đường, vani, gelatin',
    3,
    15,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    1,
    1,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Mousse Xoài',
    N'Bánh Mousse xoài nhiệt đới, lớp mousse xoài mịn màng, vị chua ngọt thanh mát, đế bánh quy giòn',
    340000.00,
    'https://i.pinimg.com/vwebp/1200x/70/2c/04/702c0438ddf8ec892193ec2ff3c09081.webp',
    N'Xoài tươi, kem tươi, gelatin, bánh quy, bơ, đường, nước cốt chanh',
    3,
    18,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    0,
    1,
    N'Active',
    2,
    NULL
),
(
    N'Bánh Opera',
    N'Bánh Opera Pháp sang trọng với nhiều lớp bánh hạnh nhân, kem cà phê, socola đen, vị đắng nhẹ tinh tế',
    450000.00,
    'https://i.pinimg.com/vwebp/1200x/6d/aa/2c/6daa2c8d29fcc5fb326134c86f8b6039.webp',
    N'Bột hạnh nhân, socola đen, cà phê, kem bơ, bột mì, trứng, đường, siro',
    5,
    10,
    N'Bảo quản lạnh trong tủ mát. Dùng trong vòng 4 ngày.',
    0,
    1,
    1,
    N'Active',
    2,
    NULL
);
--
INSERT INTO Product (
    product_name, 
    [description], 
    price, 
    [image], 
    ingredient, 
    expiry_date, 
    quantity, 
    usage_instructions, 
    discount_percent, 
    is_featured, 
    is_new, 
    [status], 
    category_id, 
    brand_id
)
VALUES 
(
    N'Croissant bơ',
    N'Croissant bơ thơm phức, vỏ giòn tan nhiều lớp, bơ béo ngậy, mềm xốp tan trong miệng',
    32000.00,
    'https://i.pinimg.com/vwebp/1200x/08/5b/27/085b2747d352a7081ca98eb9cf5ec9a4.webp',
    N'Bột mì, bơ lạt, sữa tươi, đường, men bánh mì, muối, trứng',
    3,
    80,
    N'Bảo quản nơi khô ráo, thoáng mát. Hâm nóng trước khi dùng sẽ giòn hơn.',
    0,
    1,
    1,
    N'Active',
    3,
    NULL
),
(
    N'Croissant socola',
    N'Croissant socola nhân socola đen nguyên chất, giòn tan, vị ngọt đắng hòa quyện, thơm béo',
    38000.00,
    'https://i.pinimg.com/736x/53/69/a4/5369a452b2e9da56bf94011d67e42ed0.jpg',
    N'Bột mì, bơ, socola đen, sữa tươi, đường, men bánh mì, trứng',
    3,
    70,
    N'Bảo quản nơi khô ráo, thoáng mát. Hâm nóng trước khi dùng.',
    0,
    1,
    1,
    N'Active',
    3,
    NULL
),
(
    N'Danish trái cây',
    N'Bánh Danish trái cây tươi với lớp bánh xốp nhiều lớp, kem mịn, trái cây chua ngọt tươi mát',
    40000.00,
    'https://i.pinimg.com/1200x/92/21/51/9221515385f5b86f3e819987aa3f696e.jpg',
    N'Bột mì, bơ, kem tươi, trái cây tươi (dâu, kiwi, cam), đường, trứng',
    2,
    50,
    N'Bảo quản nơi thoáng mát. Dùng tươi ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    3,
    NULL
),
(
    N'Bánh tai heo',
    N'Bánh tai heo giòn tan, xốp nhẹ, vị bơ thơm béo, hình dáng đẹp mắt, ăn không ngán',
    22000.00,
    'https://i.pinimg.com/736x/1c/f7/0a/1cf70aef777f770e163f835f8782752e.jpg',
    N'Bột mì, bơ, đường, muối, nước',
    7,
    120,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    0,
    N'Active',
    3,
    NULL
),
(
    N'Éclair',
    N'Éclair Pháp với nhân kem vani mịn màng, phủ socola đen bóng đẹp, giòn bên ngoài, mềm bên trong',
    35000.00,
    'https://i.pinimg.com/vwebp/1200x/99/23/b0/9923b042cd091b10abe5b6fcf2093bc3.webp',
    N'Bột mì, bơ, trứng, sữa tươi, kem vani, socola đen, đường',
    2,
    60,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    0,
    1,
    N'Active',
    3,
    NULL
),
(
    N'Bánh su kem',
    N'Bánh su kem mềm xốp, nhân kem sữa thơm béo ngậy, vỏ bánh vàng giòn, ăn là nghiện',
    18000.00,
    'https://i.pinimg.com/vwebp/1200x/8c/39/c0/8c39c0878ff77c0f57ed9a84e8ecf40f.webp',
    N'Bột mì, bơ, trứng, sữa tươi, kem sữa, đường',
    2,
    100,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    0,
    0,
    N'Active',
    3,
    NULL
),
(
    N'Bánh ngàn lớp',
    N'Bánh ngàn lớp với nhiều lớp bánh mỏng xếp chồng, giòn tan, vị bơ thơm phức, sang trọng',
    45000.00,
    'https://i.pinimg.com/1200x/29/26/c6/2926c6a2f6b3825a440966a664768d83.jpg',
    N'Bột mì, bơ lạt, nước, muối, đường',
    5,
    40,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    1,
    1,
    N'Active',
    3,
    NULL
),
(
    N'Apple Turnover',
    N'Bánh táo Apple Turnover vỏ giòn xốp, nhân táo caramel thơm lừng, ngọt dịu, chua nhẹ',
    36000.00,
    'https://i.pinimg.com/1200x/e3/77/11/e37711f21f928df5016df938413f3123.jpg',
    N'Bột mì, táo tươi, bơ, đường, quế, men bánh mì, trứng',
    3,
    55,
    N'Bảo quản nơi khô ráo, thoáng mát. Hâm nóng trước khi dùng.',
    0,
    0,
    0,
    N'Active',
    3,
    NULL
),
(
    N'Tart trái cây',
    N'Tart trái cây với đế bánh quy giòn tan, kem phô mai mịn, trái cây tươi ngon xếp lớp bắt mắt',
    48000.00,
    'https://i.pinimg.com/736x/b0/44/77/b04477c00bb0c1ecb4f3013ef4f09d5c.jpg',
    N'Bột mì, bơ, kem phô mai, trái cây tươi, đường, trứng, sữa tươi',
    2,
    30,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    1,
    1,
    N'Active',
    3,
    NULL
),
(
    N'Tart trứng Bồ Đào Nha',
    N'Tart trứng Bồ Đào Nha nổi tiếng, vỏ giòn rụm, nhân trứng sữa mềm mịn, vị ngọt vừa, thơm béo',
    25000.00,
    'https://i.pinimg.com/1200x/7c/69/47/7c69470091e267c34990b3676d8d231a.jpg',
    N'Bột mì, bơ, trứng, sữa tươi, đường, kem sữa, vani',
    3,
    90,
    N'Bảo quản nơi thoáng mát. Hâm nóng trước khi dùng.',
    0,
    0,
    0,
    N'Active',
    3,
    NULL
);
    INSERT INTO Product (
    product_name, 
    [description], 
    price, 
    [image], 
    ingredient, 
    expiry_date, 
    quantity, 
    usage_instructions, 
    discount_percent, 
    is_featured, 
    is_new, 
    [status], 
    category_id, 
    brand_id
)
VALUES 
(
    N'Cookie bơ',
    N'Cookie bơ thơm béo, vị bơ đậm đà, giòn tan, màu vàng đẹp mắt',
    10000.00,
    'https://i.pinimg.com/736x/11/dc/a3/11dca3785d212aa284bbb87ff37e49e7.jpg',
    N'Bột mì, bơ, đường, trứng, vani',
    10,
    150,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    0,
    N'Active',
    4,
    NULL
),
(
    N'Cookie socola chip',
    N'Cookie socola chip với những viên socola chip tan chảy, giòn bên ngoài, mềm bên trong',
    12000.00,
    'https://i.pinimg.com/736x/69/c5/a7/69c5a7e539f34246925c4b25403bb281.jpg',
    N'Bột mì, bơ, đường, socola chip, trứng, vani',
    10,
    130,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    1,
    1,
    N'Active',
    4,
    NULL
),
(
    N'Cookie yến mạch',
    N'Cookie yến mạch dinh dưỡng, vị bùi bùi của yến mạch, giòn xốp, tốt cho sức khỏe',
    12000.00,
    'https://i.pinimg.com/1200x/f9/e0/02/f9e00257d5255aee0f9b1914fb9e5bbe.jpg',
    N'Bột mì, yến mạch, bơ, đường, nâu, mật ong, trứng, vani',
    10,
    100,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    1,
    N'Active',
    4,
    NULL
),
(
    N'Cookie socola kép',
    N'Cookie socola kép với socola đen và bột socola đậm đà, ngọt đắng hài hòa, giòn tan',
    15000.00,
    'https://i.pinimg.com/736x/e1/62/fb/e162fb506145a41815a936742681e279.jpg',
    N'Bột mì, socola đen, bột cacao, bơ, đường, trứng, vani',
    10,
    110,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    1,
    1,
    N'Active',
    4,
    NULL
),
(
    N'Cookie matcha',
    N'Cookie matcha Nhật Bản thơm mùi trà xanh, vị chát nhẹ đặc trưng, giòn xốp, màu xanh đẹp mắt',
    15000.00,
    'https://i.pinimg.com/736x/04/54/c2/0454c2e1e3aa1b43d88c9be0c9f68fcd.jpg',
    N'Bột mì, bột matcha, bơ, đường, trứng, vani',
    10,
    95,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    0,
    N'Active',
    4,
    NULL
),
(
    N'Cookie Red Velvet',
    N'Cookie Red Velvet đỏ quyến rũ, vị bơ sữa ngọt ngào, nhân kem phô mai mềm mịn',
    15000.00,
    'https://i.pinimg.com/vwebp/1200x/87/2f/2b/872f2b51a29c0de6c1289b4b5f0ba39e.webp',
    N'Bột mì, bơ, đường, trứng, phô mai cream cheese, phẩm màu đỏ, bột cacao',
    8,
    90,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    0,
    N'Active',
    4,
    NULL
),
(
    N'Cookie bơ đậu phộng',
    N'Cookie bơ đậu phộng bùi béo, vị đậu phộng rang thơm lừng, giòn tan, béo ngậy',
    12000.00,
    'https://i.pinimg.com/736x/59/da/50/59da505167c184358b516eea8bdabd1c.jpg',
    N'Bột mì, bơ đậu phộng, bơ, đường, trứng, vani',
    10,
    120,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    0,
    N'Active',
    4,
    NULL
),
(
    N'Cookie hạnh nhân',
    N'Cookie hạnh nhân với hạnh nhân bùi béo, vị bơ thơm phức, giòn tan sang trọng',
    15000.00,
    'https://i.pinimg.com/1200x/5b/8e/8e/5b8e8e21719e378b8f19f9f14ce53d30.jpg',
    N'Bột mì, hạnh nhân, bơ, đường, trứng, vani',
    12,
    85,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    0,
    N'Active',
    4,
    NULL
),
(
    N'Cookie mắc ca',
    N'Cookie mắc ca cao cấp, hạt mắc ca béo bùi, vị ngọt dịu, giòn tan khó cưỡng',
    18000.00,
    'https://i.pinimg.com/1200x/56/7f/54/567f54982d395358a4fef96c6a7d50dc.jpg',
    N'Bột mì, hạt mắc ca, bơ, đường, trứng, vani',
    12,
    70,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    1,
    1,
    N'Active',
    4,
    NULL
),
(
    N'Cookie socola trắng nam việt quất',
    N'Cookie socola trắng kết hợp nam việt quất chua ngọt, vị socola béo ngậy, quả mọng tươi mát',
    16000.00,
    'https://i.pinimg.com/1200x/30/f7/5c/30f75cb62fdb342d2d365f7a015ec72d.jpg',
    N'Bột mì, socola trắng, nam việt quất khô, bơ, đường, trứng, vani',
    10,
    100,
    N'Bảo quản nơi khô ráo, thoáng mát, tránh ẩm.',
    0,
    0,
    0,
    N'Active',
    4,
    NULL
);
INSERT INTO Product (
    product_name, 
    [description], 
    price, 
    [image], 
    ingredient, 
    expiry_date, 
    quantity, 
    usage_instructions, 
    discount_percent, 
    is_featured, 
    is_new, 
    [status], 
    category_id, 
    brand_id
)
VALUES 
(
    N'Donut đường',
    N'Donut đường truyền thống, phủ lớp đường trắng mịn, bánh mềm xốp, vị ngọt nhẹ, thơm béo',
    20000.00,
    'https://i.pinimg.com/1200x/0e/95/1e/0e951ec90d1518b577fb0245eb7c14c2.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, men bánh mì, đường bột',
    3,
    90,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    5,
    NULL
),
(
    N'Donut socola',
    N'Donut phủ socola đen mịn màng, lớp bánh mềm xốp, vị ngọt đắng quyến rũ, tan chảy trong miệng',
    22000.00,
    'https://i.pinimg.com/vwebp/1200x/ee/21/9b/ee219b70fe7133677e32eebc3c56c53e.webp',
    N'Bột mì, bơ, đường, trứng, sữa tươi, socola đen, men bánh mì',
    3,
    85,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    1,
    1,
    N'Active',
    5,
    NULL
),
(
    N'Donut dâu',
    N'Donut phủ kem dâu hồng xinh xắn, vị chua ngọt thanh mát, màu sắc bắt mắt, thơm mùi dâu tươi',
    22000.00,
    'https://i.pinimg.com/1200x/ca/a0/29/caa0298a738bfe3a3a7dc3babc301631.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, kem dâu, dâu tươi, men bánh mì',
    2,
    80,
    N'Bảo quản nơi thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    5,
    NULL
),
(
    N'Donut Boston Cream',
    N'Donut Boston Cream với nhân kem vani mịn màng, phủ lớp socola bóng đẹp, béo ngậy khó cưỡng',
    28000.00,
    'https://i.pinimg.com/1200x/e2/a0/97/e2a0977c9914df1da1d0ffb18afb07b1.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, kem vani, socola, men bánh mì',
    2,
    60,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    1,
    1,
    N'Active',
    5,
    NULL
),
(
    N'Donut nhân mứt',
    N'Donut nhân mứt trái cây ngọt thơm, lớp bánh mềm xốp, phủ đường bột, vị chua ngọt hài hòa',
    25000.00,
    'https://i.pinimg.com/1200x/ae/5d/d9/ae5dd9a8bd4ef13c9e4275d96b3cc562.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, mứt trái cây, đường bột, men bánh mì',
    3,
    75,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    5,
    NULL
),
(
    N'Donut phủ đường',
    N'Donut phủ đường bột trắng muốt, bánh mềm xốp, vị ngọt thanh, béo nhẹ, thơm vị bơ',
    20000.00,
    'https://i.pinimg.com/vwebp/736x/68/16/a1/6816a126c898b8b157fac887b8520af6.webp',
    N'Bột mì, bơ, đường, trứng, sữa tươi, đường bột, men bánh mì',
    3,
    100,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    5,
    NULL
),
(
    N'Donut matcha',
    N'Donut matcha Nhật Bản với lớp kem trà xanh mịn màng, vị chát nhẹ, ngọt vừa, thơm mùi trà',
    26000.00,
    'https://i.pinimg.com/736x/83/22/86/832286d170fb373d6f22ea099be00c76.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, bột matcha, kem tươi, men bánh mì',
    2,
    70,
    N'Bảo quản nơi thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    5,
    NULL
),
(
    N'Donut Oreo',
    N'Donut Oreo với bánh Oreo giòn tan trên bề mặt, nhân kem socola béo ngậy, ngọt đắm đà',
    30000.00,
    'https://i.pinimg.com/736x/1f/ff/99/1fff9926f473b682a33ac3d12e52e07f.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, bánh Oreo, kem socola, men bánh mì',
    2,
    55,
    N'Bảo quản nơi thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    1,
    1,
    N'Active',
    5,
    NULL
),
(
    N'Donut Caramel',
    N'Donut phủ sốt caramel vàng óng, vị ngọt béo, thơm mùi bơ rang, giòn xốp khó cưỡng',
    26000.00,
    'https://i.pinimg.com/1200x/9a/a3/81/9aa381dc2f8081fc6ab5eadb99827b5e.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, sốt caramel, men bánh mì',
    3,
    65,
    N'Bảo quản nơi khô ráo, thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    5,
    NULL
),
(
    N'Donut Việt quất',
    N'Donut phủ kem việt quất chua ngọt, màu tím bắt mắt, vị trái cây tươi mát, thơm ngon',
    25000.00,
    'https://i.pinimg.com/736x/94/6f/ac/946face6b98f4359c025e89fffc6392e.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, kem việt quất, việt quất tươi, men bánh mì',
    2,
    70,
    N'Bảo quản nơi thoáng mát. Dùng ngon nhất trong ngày.',
    0,
    0,
    0,
    N'Active',
    5,
    NULL
);
INSERT INTO Product (
    product_name, 
    [description], 
    price, 
    [image], 
    ingredient, 
    expiry_date, 
    quantity, 
    usage_instructions, 
    discount_percent, 
    is_featured, 
    is_new, 
    [status], 
    category_id, 
    brand_id
)
VALUES 
(
    N'Cupcake vani',
    N'Cupcake vani cổ điển với kem bơ vani mịn màng, bánh mềm xốp, vị ngọt dịu, thơm phức',
    25000.00,
    'https://i.pinimg.com/736x/84/00/4d/84004d81e2feaf11d1ffacfa176ec76c.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, kem vani, vani',
    4,
    80,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    0,
    0,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake socola',
    N'Cupcake socola đậm đà với kem socola béo mịn, bánh ẩm mềm, vị socola ngọt đắng quyến rũ',
    28000.00,
    'https://i.pinimg.com/vwebp/1200x/47/be/84/47be84309ce929918fadebfd363e9619.webp',
    N'Bột mì, bơ, đường, trứng, sữa tươi, socola đen, bột cacao, kem socola',
    4,
    75,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    1,
    1,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake Red Velvet',
    N'Cupcake Red Velvet đỏ sang trọng với kem phô mai tươi mịn, vị bơ sữa béo ngậy, mềm ẩm',
    32000.00,
    'https://i.pinimg.com/vwebp/1200x/d3/2c/a6/d32ca67be017af00b86d519a5705d54d.webp',
    N'Bột mì, bơ, đường, trứng, sữa tươi, phô mai cream cheese, phẩm màu đỏ, bột cacao',
    4,
    60,
    N'Bảo quản lạnh trong tủ mát. Dùng trong vòng 3 ngày.',
    0,
    1,
    1,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake dâu',
    N'Cupcake dâu tươi mát với kem dâu hồng xinh, bánh mềm, vị chua ngọt thanh, thơm mùi dâu',
    28000.00,
    'https://i.pinimg.com/1200x/c7/f7/4b/c7f74b8c9a946fd64a4d1d35f2115769.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, kem dâu, dâu tươi, vani',
    3,
    70,
    N'Bảo quản lạnh trong tủ mát. Dùng lạnh ngon nhất.',
    0,
    0,
    0,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake matcha',
    N'Cupcake matcha Nhật Bản với kem trà xanh mịn màng, vị chát nhẹ đặc trưng, ngọt vừa, thơm béo',
    30000.00,
    'https://i.pinimg.com/vwebp/1200x/8c/0d/58/8c0d58f2d82d3af4eb9904605847de24.webp',
    N'Bột mì, bơ, đường, trứng, sữa tươi, bột matcha, kem matcha, vani',
    4,
    65,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    0,
    0,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake chanh',
    N'Cupcake chanh tươi mát với kem chanh thơm nhẹ, bánh mềm xốp, vị chua ngọt, sảng khoái',
    27000.00,
    'https://i.pinimg.com/vwebp/736x/60/7e/6d/607e6de4a2c5d062de44acbce27d7733.webp',
    N'Bột mì, bơ, đường, trứng, sữa tươi, chanh tươi, kem chanh, vani',
    3,
    75,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    0,
    0,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake Cookies & Cream',
    N'Cupcake Cookies & Cream với bánh Oreo giòn tan, kem socola béo ngậy, lớp cookie phủ trên đỉnh',
    32000.00,
    'https://i.pinimg.com/vwebp/1200x/95/68/35/9568353032fcf16a202d9256bef82f48.webp',
    N'Bột mì, bơ, đường, trứng, sữa tươi, bánh Oreo, kem socola, vani',
    3,
    55,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    1,
    1,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake caramel muối',
    N'Cupcake caramel muối vị ngọt mặn hài hòa, kem caramel béo ngậy, thơm mùi bơ rang, lớp muối lấm tấm',
    32000.00,
    'https://i.pinimg.com/736x/43/31/0c/43310cd053cc2e4baf646dd0cbcd88d2.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, sốt caramel, muối biển, vani',
    4,
    50,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    0,
    0,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake việt quất',
    N'Cupcake việt quất với kem việt quất chua ngọt, bánh mềm, màu tím đẹp mắt, thơm mùi quả mọng',
    30000.00,
    'https://i.pinimg.com/1200x/1b/32/97/1b3297ece0f285d5c9175e2a73d5b072.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, kem việt quất, việt quất tươi, vani',
    3,
    60,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    0,
    0,
    N'Active',
    6,
    NULL
),
(
    N'Cupcake cà phê',
    N'Cupcake cà phê với kem cà phê đậm đà, bánh mềm xốp, vị đắng nhẹ của cà phê, thơm nồng khó cưỡng',
    28000.00,
    'https://i.pinimg.com/736x/96/ff/66/96ff66d350fb57e32403a1a4c1048d23.jpg',
    N'Bột mì, bơ, đường, trứng, sữa tươi, cà phê espresso, kem cà phê, vani',
    4,
    65,
    N'Bảo quản nơi thoáng mát. Dùng trong vòng 2 ngày.',
    0,
    0,
    0,
    N'Active',
    6,
    NULL
);
-- Xem tất cả sản phẩm
SELECT * FROM Product;
    SELECT * FROM [User];

-- Xem số lượng sản phẩm theo danh mục
SELECT category_id, COUNT(*) AS total_products
FROM Product
GROUP BY category_id;

-- Kiểm tra kết hợp với Category
SELECT 
    p.product_id,
    p.product_name,
    c.category_name,
    p.price,
    p.quantity,
    p.status
FROM Product p
LEFT JOIN Category c ON p.category_id = c.category_id
ORDER BY p.category_id;

-- Tài khoản quản trị mặc định: admin@gmail.com / admin123
IF EXISTS (SELECT 1 FROM [User] WHERE email = 'admin@gmail.com')
BEGIN
    UPDATE [User]
    SET [password] = 'admin123', [role] = N'Admin', [status] = N'Active',
        full_name = N'Admin Hệ Thống', phone_number = '0900000000'
    WHERE email = 'admin@gmail.com';
END
ELSE
BEGIN
INSERT INTO [User] (
    full_name, email, phone_number, password,
    gender, date_of_birth, address, role, status, created_at
)
VALUES (
    N'Nguyễn Văn A',
    'vana@gmail.com',
    '0987654321',
    '123456',
    N'Nam',   
    '2004-05-20',
    N'Đà Nẵng',
    N'Customer',  
    N'Active',    
    GETDATE()
);
INSERT INTO [User] (
    full_name,
    email,
    phone_number,
    password,
    gender,
    date_of_birth,
    address,
    role,
    status,
    created_at
)
VALUES (
    N'Admin Hệ Thống',
    'admin@gmail.com',
    '0900000000',
    'admin123',     
    N'Nam',
    '2000-01-01',
    N'Hà Nội',
    N'Admin',       
    N'Active',      
    GETDATE()
);
END;

-- Tài khoản admin mới (dùng khi tài khoản cũ bị sai thông tin)
IF NOT EXISTS (SELECT 1 FROM [User] WHERE email = 'admin2@bitesandmore.com')
BEGIN
    INSERT INTO [User] (
        full_name, email, phone_number, [password], gender, date_of_birth,
        [address], [role], [status], created_at
    ) VALUES (
        N'Quản trị viên Bites & More',
        'admin2@bitesandmore.com',
        '0900000001',
        'Admin@123',
        N'Khác', '2000-01-01', N'Đà Nẵng', N'Admin', N'Active', GETDATE()
    );
END;

USE BitesandMore;
GO
CREATE OR ALTER TRIGGER trg_GenerateOrderCode
ON [Order]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @new_order_code VARCHAR(20);
    DECLARE @order_id INT;
    SELECT @order_id = ISNULL(MAX(order_id), 0) + 1 FROM [Order];
    SET @new_order_code = 'DH-' + FORMAT(SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00'), 'yyyyMMdd') + '-'
        + RIGHT('000' + CAST(@order_id AS VARCHAR(3)), 3);
    INSERT INTO [Order] (order_code, user_id, recipient_name, recipient_phone, recipient_email,
        order_date, total_amount, discount_amount, shipping_fee, final_amount, [status], payment_id,
        payment_status, shipping_address, shipping_note, order_note, discount_id, estimated_delivery, created_at)
    SELECT @new_order_code, user_id, recipient_name, recipient_phone, recipient_email,
        COALESCE(order_date, CONVERT(datetime2(0), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00'))),
        total_amount, discount_amount, shipping_fee, final_amount, [status], payment_id,
        payment_status, shipping_address, shipping_note, order_note, discount_id, estimated_delivery,
        CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00'))
    FROM inserted;
    INSERT INTO Order_Status_History (order_id, [status], note, created_at)
    SELECT order_id, [status], N'Tạo đơn hàng', CONVERT(datetime2(3), SWITCHOFFSET(SYSDATETIMEOFFSET(), '+07:00'))
    FROM [Order] WHERE order_code = @new_order_code;
END;
GO

USE BitesandMore;
GO

SELECT DB_NAME() AS current_database;
SELECT OBJECT_ID('[dbo].[Order]') AS order_table_id;

SELECT name
FROM sys.triggers
WHERE name = 'trg_GenerateOrderCode';

--- Chuyển về đúng Database của dự án (thay tên Database nếu khác)
USE BitesAndMore;
GO

-- =======================================================
-- 1. THÊM CỘT SHIPPER_ID VÀO BẢNG [Order]
-- =======================================================
IF NOT EXISTS (
    SELECT 1 FROM sys.columns 
    WHERE object_id = OBJECT_ID(N'[Order]') AND name = 'shipper_id'
)
BEGIN
    ALTER TABLE [Order] ADD shipper_id INT NULL;
    
    ALTER TABLE [Order] 
    ADD CONSTRAINT FK_Order_Shipper 
    FOREIGN KEY (shipper_id) REFERENCES [User](user_id);
END
GO

USE BitesandMore;
GO

-- 1. Xóa ràng buộc CHECK cũ trên cột role
DECLARE @constraintName NVARCHAR(200);
SELECT @constraintName = name 
FROM sys.check_constraints 
WHERE parent_object_id = OBJECT_ID(N'[User]') 
  AND parent_column_id = COLUMNPROPERTY(OBJECT_ID(N'[User]'), 'role', 'ColumnId');

IF @constraintName IS NOT NULL
BEGIN
    EXEC('ALTER TABLE [User] DROP CONSTRAINT ' + @constraintName);
END
GO

-- 2. Thêm ràng buộc CHECK mới cho phép các vai trò: Admin, Customer, User, Shipper
ALTER TABLE [User] 
ADD CONSTRAINT CK_User_Role 
CHECK (role IN ('Admin', 'Customer', 'User', 'Shipper', 'admin', 'customer', 'user', 'shipper'));
GO

-- 3. Chèn lại tài khoản Shipper test
IF NOT EXISTS (SELECT 1 FROM [User] WHERE email = 'shipper@bam.com')
BEGIN
    INSERT INTO [User] (full_name, email, password, phone_number, role, status)
    VALUES (N'Nguyễn Văn Shipper', 'shipper@bam.com', '123456', '0905999888', 'Shipper', 'Active');
END
GO

USE BitesandMore;
GO

UPDATE [User]
SET full_name = N'Mai Lê Tuấn Tú'
WHERE email = 'shipper@bam.com';
GO

USE BitesandMore;
GO

IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Notification')
BEGIN
    CREATE TABLE [Notification] (
        notification_id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        order_id INT NULL,
        title NVARCHAR(255) NOT NULL,
        message NVARCHAR(500) NOT NULL,
        icon NVARCHAR(50) DEFAULT '🛵',
        is_read BIT DEFAULT 0,
        created_at DATETIME DEFAULT GETDATE(),
        CONSTRAINT FK_Noti_User FOREIGN KEY (user_id) REFERENCES [User](user_id)
    );
END
GO
