# CERTAIN SHOP - BACKEND COMPLETE WORKFLOW

## I. SYSTEM ARCHITECTURE

### Stack
- **Framework**: Spring Boot 3.x
- **JPA/Hibernate**: ORM for database access
- **Security**: Spring Security + JWT (Authentication)
- **Email**: Spring Mail (JavaMailSender) + `@Async` (Bất đồng bộ)
- **Database**: SQL Server 2019+ (Certain_Shop database)
- **Payment**: VNPay Sandbox integration
- **Shipping**: GHN API integration
- **Async/Scheduling**: `@EnableAsync` + `@EnableScheduling` (tại CertainShopApplication.java)

### Configuration
```properties
Server: localhost:8080
DB: localhost,1433 | user=sa | password=140504
Mail SMTP: smtp.gmail.com:587 (STARTTLS)
Mail Account: carboncreditmarketplace@gmail.com
JWT Secret: certainshop-super-secret-jwt-key-2025-must-be-at-least-256-bits-long
JWT Expiration: 86400000ms (24h)
Refresh Expiration: 604800000ms (7 days)
CORS Origins: http://localhost:5173 (React FE)
```

---

## II. AUTHENTICATION FLOW (Đăng nhập / Đăng ký)

### A. Đăng Ký Tài Khoản (Registration)

```
Frontend (React)
    ↓ POST /api/auth/dang-ky
    ↓ { tenDangNhap, matKhau, xacNhanMatKhau, email, hoTen, soDienThoai, ngaySinh, gioiTinh }
    
AuthApiController.dangKy()
    ↓
NguoiDungService.dangKy(DangKyDto)
    ├─ Validate: check trùng tenDangNhap
    ├─ Validate: check trùng email
    ├─ Validate: xacNhanMatKhau = matKhau
    ├─ Lấy VaiTro "Khách hàng" từ DB
    ├─ Create NguoiDung entity:
    │  ├─ matKhauMaHoa: BCrypt hash của input matKhau
    │  ├─ hoTen, soDienThoai, ngaySinh, gioiTinh
    │  ├─ vaiTro: KHACH_HANG
    │  └─ dangHoatDong: true
    ├─ Save NguoiDung → DB (PrePersist: thoiGianTao=now, dangHoatDong=true)
    ├─ Create GioHang mới cho người dùng
    └─ @Async gửi email chào mừng
       └─ MailService.guiMailChaoMung(email, hoTen, tenDangNhap)
            ├─ Tạo HTML template tiếng Việt
            ├─ Subject: "Chào mừng <hoTen> đến Certain Shop"
            └─ Send via JavaMailSender (bất đồng bộ)

Backend generate JWT Token
    ├─ JwtUtil.taoToken(UserDetails)
    └─ Return to Frontend:
       {
         "success": true,
         "data": {
           "token": "eyJhbGc...",
           "tokenType": "Bearer",
           "nguoiDung": { id, tenDangNhap, hoTen, email, vaiTro: "KHACH_HANG" }
         }
       }
```

### B. Đăng Nhập (Login)

```
Frontend
    ↓ POST /api/auth/dang-nhap
    ↓ { tenDangNhap, matKhau }
    
AuthApiController.dangNhap()
    ├─ AuthenticationManager.authenticate(UsernamePasswordAuthenticationToken)
    │  └─ BaoMatConfig.danhSachNguoiDung() → UserDetailsService
    │     ├─ Load NguoiDung từ DB by tenDangNhap
    │     ├─ Check: dangHoatDong == true (nếu false → throw exception)
    │     ├─ Normalize vaiTro tiếng Việt → ASCII (e.g., "Nhân viên" → "NHAN_VIEN")
    │     └─ Return Spring User với role: ROLE_KHACH_HANG / ROLE_NHAN_VIEN / ROLE_ADMIN
    ├─ BCrypt verify matKhau input vs matKhauMaHoa trong DB
    ├─ Generate JWT Token
    └─ Return:
       {
         "success": true,
         "data": {
           "token": "Bearer ...",
           "nguoiDung": { id, hoTen, email, vaiTro, anhDaiDien }
         }
       }

Frontend store token in localStorage → use in Authorization header for all requests
```

### C. JWT Token Validation

```
Mỗi protected API request phải gồm:
    Header: Authorization: Bearer <token>

JwtAuthenticationFilter (Spring Security Filter Chain)
    ├─ Extract token từ Authorization header
    ├─ JwtUtil.layTenDangNhap(token)
    ├─ JwtUtil.chuKyHopLe(token) → verify HMAC signature + expiration
    ├─ UserDetailsService.loadUserByUsername() → tái load user từ DB
    └─ SecurityContext.setAuthentication() → allow request
    
NguoiDungHienTai utility
    └─ SecurityContextHolder.getContext().getAuthentication()
       └─ Lấy NguoiDung hiện tại từ Spring Security context
```

---

## III. SHOPPING CART FLOW (Giỏ Hàng)

### A. Khởi tạo Giỏ Hàng

```
Khi đăng ký xong → NguoiDungService tạo auto GioHang rỗng
    └─ GioHang.danhSachChiTiet = []
```

### B. Thêm Sản Phẩm Vào Giỏ

```
Frontend
    ↓ POST /gio-hang/them
    ↓ { bienTheId, soLuong }

GioHangController.themVaoGio()
    ├─ Extract NguoiDung từ SecurityContext
    └─ GioHangService.themVaoGio(nguoiDungId, bienTheId, soLuong)
       ├─ Load GioHang by nguoiDungId
       ├─ Load BienThe by bienTheId
       ├─ Validate:
       │  ├─ BienThe.trangThai == true
       │  ├─ soLuong ≤ ${app.sanpham.soLuongMuaToiDa} (default: 5)
       │  └─ soLuong ≤ BienThe.soLuongTon (tồn kho)
       ├─ If GioHangChiTiet exists for this BienThe:
       │  └─ Update: chiTiet.soLuong += soLuong
       └─ Else:
          ├─ Create GioHangChiTiet:
          │  ├─ gioHang: reference
          │  ├─ bienThe: reference
          │  ├─ soLuong: input
          │  ├─ donGia: BienThe.gia
          │  └─ thanhTien: soLuong × donGia (computed field)
          └─ Save to DB

Response: { thanhCong: true, soLuongGio: count, thongBao: "Đã thêm vào giỏ hàng" }
```

### C. Xem Giỏ Hàng

```
Frontend: GET /gio-hang
    ├─ GioHangController.hienThiGioHang()
    ├─ GioHangService.layGioHang(nguoiDungId)
    │  └─ SELECT GioHang WHERE NguoiDungId = ? 
    │     → Eager load danhSachChiTiet (CascadeType.ALL, orphanRemoval=true)
    ├─ GioHangService.tinhTongTien(nguoiDungId)
    │  └─ Sum của tất cả GioHangChiTiet.thanhTien
    └─ Return model: { gioHang, tongTien }

Display:
    - Danh sách chi tiết: BienThe.ảnh, tên, mau, size, giá, số lượng
    - Tính toán tổng tiền
    - Nút: Cập nhật số lượng, Xóa, Tiếp tục mua sắm, Thanh toán
```

### D. Cập Nhật Số Lượng

```
Frontend: POST /gio-hang/cap-nhat
    ↓ { chiTietId, soLuong }

GioHangService.capNhatSoLuong(chiTietId, soLuong, nguoiDungId)
    ├─ Verify ownership: chiTiet.gioHang.nguoiDung.id == currentUser.id
    ├─ If soLuong <= 0: Delete chiTiet
    ├─ Validate: soLuong ≤ soLuongMuaToiDa
    ├─ Validate: soLuong ≤ tồn kho
    └─ Update GioHangChiTiet.soLuong + Save

Response: { thanhCong: true, tongTien: updated_total }
```

### E. Xóa Sản Phẩm Khỏi Giỏ

```
Frontend: POST /gio-hang/xoa
    ↓ { chiTietId }

GioHangService.xoaKhoiGio(chiTietId, nguoiDungId)
    ├─ Verify ownership
    └─ Delete GioHangChiTiet (orphanRemoval=true sẽ auto-delete via JPA)
```

---

## IV. ORDERING FLOW - ONLINE (Đặt Hàng Online)

### A. Checkout Page (Trang Đặt Hàng)

```
Frontend: GET /dat-hang

DatHangController.hienThiDatHang()
    ├─ Check: gioHang.danhSachChiTiet is not empty
    ├─ Fetch danhSachDiaChi: giao hàng trước
    ├─ Fetch voucherHopLe: các mã khuyến mãi khả dụng
    └─ Return model:
       {
         nguoiDung, gioHang, tongTien,
         danhSachDiaChi, voucherHopLe,
         datHangDto: empty form
       }

User fills form:
    - Chọn địa chỉ giao hàng (hoặc nhập mới)
    - Nhập số điện thoại người nhận
    - Chọn phương thức thanh toán: COD hoặc VNPAY
    - Nhập ghi chú (tùy chọn)
    - Chọn voucher (nếu có)
```

### B. Đặt Hàng (Create Order)

```
Frontend: POST /dat-hang
    ↓ DatHangDto {
        tenNguoiNhan, soDienThoai,
        diaChiCuThe, tenXa, tenHuyen, tenTinh,
        maTinhGHN, maHuyenGHN, maXaGHN,
        phuongThucThanhToan: "COD" hoặc "VNPAY",
        khuyenMaiId (optional),
        phiVanChuyen (BigDecimal),
        luuDiaChi: boolean,
        ghiChu: String
      }

DatHangController.xuLyDatHang()
    └─ DonHangService.datHangOnline(nguoiDungId, dto)

       [STEP 1: VALIDATE & CALCULATE]
       ├─ Load NguoiDung
       ├─ Load GioHang + danhSachChiTiet
       ├─ Check: gioHang not empty
       ├─ Tính tongTien = Σ GioHangChiTiet.thanhTien
       ├─ Apply voucher (nếu có):
       │  ├─ Load KhuyenMai by khuyenMaiId
       │  ├─ Check: KhuyenMai.laHopLe() == true (chưa hết hạn, còn số lần dùng)
       │  ├─ Check: tongTien >= KhuyenMai.giaTriDonHangToiThieu
       │  └─ soTienGiam = KhuyenMai.tinhSoTienGiam(tongTien)
       ├─ phiVanChuyen: Từ DTO (user tính sẵn via AJAX /tinh-phi-ship)
       ├─ tongThanhToan = tongTien - soTienGiam + phiVanChuyen
       │  (nếu < 0 → set = 0)
       
       [STEP 2: DETERMINE INITIAL STATUS]
       ├─ If phuongThucThanhToan == "VNPAY":
       │  └─ trangThaiDau = TrangThaiDonHang.CHO_THANH_TOAN
       │     (Chờ khách thanh toán qua VNPay)
       └─ Else (COD):
          └─ trangThaiDau = TrangThaiDonHang.CHO_XAC_NHAN
             (Chờ nhân viên xác nhận đơn)

       [STEP 3: RESOLVE DELIVERY ADDRESS]
       ├─ If diaChiId provided:
       │  └─ Load DiaChiNguoiDung → use saved info
       └─ Else:
          └─ Use DTO fields (tenNguoiNhan, soDienThoai, etc.)

       [STEP 4: CREATE DONHANG]
       ├─ Generate maDonHang: "DH-" + timestamp + random
       ├─ Create DonHang entity:
       │  ├─ nguoiDung: reference
       │  ├─ maDonHang: unique ID
       │  ├─ tongTien, soTienGiamGia, phiVanChuyen, tongTienThanhToan
       │  ├─ trangThaiDonHang: CHO_THANH_TOAN or CHO_XAC_NHAN
       │  ├─ phuongThucThanhToan: "COD" or "VNPAY"
       │  ├─ khuyenMai: reference (if selected)
       │  ├─ tenNguoiNhan, sdtNguoiNhan, diaChiGiaoHang
       │  ├─ maTinhGHN, maHuyenGHN, maXaGHN
       │  ├─ loaiDonHang: "ONLINE"
       │  ├─ daThanhToan: false (chưa thanh toán)
       │  ├─ ghiChu: from DTO
       │  └─ @PrePersist: thoiGianTao = now
       └─ Save DonHang → DB

       [STEP 5: CREATE ORDER DETAILS]
       ├─ For each GioHangChiTiet in gioHang:
       │  ├─ Load BienThe
       │  ├─ Validate: soLuong ≤ BienThe.soLuongTon
       │  │  (Lỗi này hiếm vì đã check khi thêm vào giỏ, nhưng kiểm tra lại)
       │  └─ Create ChiTietDonHang:
       │     ├─ donHang: reference
       │     ├─ bienThe: reference
       │     ├─ giaTaiThoiDiemMua: GioHangChiTiet.donGia
       │     └─ soLuong: from giỏ
       ├─ Batch save all ChiTietDonHang
       │  NOTE: Kho KHÔNG trừ ngay (trừ sau khi xác nhận)

       [STEP 6: RECORD STATUS HISTORY]
       ├─ Create LichSuTrangThaiDon:
       │  ├─ donHang: reference
       │  ├─ trangThaiCu: null
       │  ├─ trangThaiMoi: CHO_THANH_TOAN or CHO_XAC_NHAN
       │  ├─ moTa: "Đặt hàng thành công"
       │  ├─ nguoiThayDoi: current user
       │  └─ thoiGian: now

       [STEP 7: INCREASE VOUCHER USAGE]
       ├─ If khuyenMai exists:
       │  └─ KhuyenMaiService.tangSoLanSuDung(khuyenMaiId)

       [STEP 8: SAVE NEW ADDRESS (Optional)]
       ├─ If luuDiaChi == true AND diaChiId == null:
       │  └─ Create + save DiaChiNguoiDung:
       │     ├─ nguoiDung: reference
       │     ├─ hoTen, soDienThoai, diaChiDong1
       │     ├─ phuongXa, quanHuyen, tinhThanh
       │     ├─ maTinhGHN, maHuyenGHN, maXaGHN
       │     └─ laMacDinh: false

       [STEP 9: CLEAR CART (Important!)
       ├─ GioHang.danhSachChiTiet.clear()
       │  └─ Because: CascadeType.ALL + orphanRemoval=true
       │     → Will auto-delete all GioHangChiTiet
       └─ Save GioHang
          NOTE: This fixes bug where items remained after order

       [STEP 10: SEND EMAIL - ONLY FOR COD
       ├─ If phuongThucThanhToan != "VNPAY":
       │  └─ MailService.guiMailXacNhanDonHang()
       │     └─ @Async (non-blocking)
       │        ├─ Subject: "Xác nhận đơn hàng DH-xxx"
       │        ├─ Include: order ID, items, total, COD method
       │        └─ HTML template tiếng Việt
       └─ NOTA: VNPay orders email sent later after payment success

       [STEP 11: RETURN RESPONSE]
       ├─ If VNPAY:
       │  └─ Redirect to VNPay gateway
       │     (see vnPayUtil.taoUrlThanhToan below)
       └─ If COD:
          └─ Redirect to order detail page
             {
               thanhCong: "Đặt hàng thành công! Mã đơn: DH-xxx"
             }
```

### C. Calculate Shipping Fee (AJAX)

```
Frontend AJAX: GET /dat-hang/tinh-phi-ship
    ↓ { maHuyenGHN, maXaGHN }

DatHangController.tinhPhiShip()
    └─ GHNApiService.tinhPhiVanChuyen(maHuyen, maXa, weight=300)
       ├─ Call GHN API: https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee
       ├─ Send: shop_id, from_district_id, to_district_id, to_ward_code, weight
       └─ Return: phiVanChuyen (BigDecimal)

Response: { phiVanChuyen: 10000 }
Frontend update: tổng tiền += phiVanChuyen
```

### D. Apply Voucher (AJAX)

```
Frontend AJAX: POST /dat-hang/ap-voucher
    ↓ { maVoucher, tongTien }

DatHangController.apVoucher()
    ├─ KhuyenMaiService.timTheoMa(maVoucher)
    ├─ Validate:
    │  ├─ Found & laHopLe() == true
    │  └─ tongTien >= giaTriDonHangToiThieu
    ├─ soTienGiam = KhuyenMai.tinhSoTienGiam(tongTien)
    │  ├─ If type == "%" : giamGia = tongTien × (phanTramGiam / 100)
    │  └─ If type == "VND" : giamGia = soTienGiamToc
    └─ Return:
       {
         thanhCong: true,
         soTienGiam: 50000,
         khuyenMaiId: 5,
         tenKhuyenMai: "Summer Sale - 20%"
       }
```

---

## V. VNPAY PAYMENT INTEGRATION

### A. Create Payment URL

```
DatHangController.xuLyDatHang() → if VNPAY:
    └─ VNPayUtil.taoUrlThanhToan(maDonHang, soTien, moTa, ipAddr)

       ├─ Prepare VNPay parameters:
       │  ├─ vnp_Version: "2.1.0"
       │  ├─ vnp_Command: "pay"
       │  ├─ vnp_TmnCode: "DEMOVNPAY"
       │  ├─ vnp_Amount: soTien × 100 (in cents, VND)
       │  ├─ vnp_CurrCode: "VND"
       │  ├─ vnp_TxnRef: maDonHang (must be unique)
       │  ├─ vnp_OrderInfo: "Thanh toan don hang " + maDonHang
       │  ├─ vnp_ReturnUrl: "http://localhost:8080/thanh-toan/vnpay-return"
       │  ├─ vnp_IpAddr: client IP
       │  ├─ vnp_CreateDate: timestamp
       │  └─ vnp_ExpireDate: +15 minutes
       │
       ├─ Create HMAC SHA512 secure hash:
       │  ├─ hashSecret = "RAOEXHYVSDDIIENYWSLDIIZTANXUXZFJ"
       │  ├─ hashData = sorted params as string
       │  └─ vuKy = HMAC-SHA512(hashData, hashSecret)
       │
       └─ Return: https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?vnp_...&vnp_SecureHash=...
          → Redirect browser to VNPay gateway
```

### B. Customer Pays on VNPay Gateway

```
Customer at VNPay gateway:
    ├─ Select payment method (bank, e-wallet, etc.)
    ├─ Enter payment info
    ├─ VNPay processes payment
    └─ VNPay callback to server
```

### C. VNPay Returns to App (Success or Fail)

```
VNPay Callback: GET /thanh-toan/vnpay-return
    ↓ Parameters from VNPay:
    ├─ vnp_ResponseCode: "00" (success) or other code (fail)
    ├─ vnp_TxnRef: order ID (maDonHang)
    ├─ vnp_TransactionNo: VNPay transaction ID
    ├─ vnp_SecureHash: signature to verify
    └─ Other params...

DonHangKhachController.vnPayReturn()
    ├─ Collect all params from request
    ├─ VNPayUtil.xacThucChuKy(params):
    │  └─ Verify signature:
    │     ├─ Sort params by key
    │     ├─ Recreate hashData
    │     └─ Compare received vnp_SecureHash with calculated
    │        → Prevent tampering
    ├─ If signature invalid:
    │  └─ Log warning + return error
    ├─ If responseCode == "00": // Success
    │  └─ DonHangService.xacNhanThanhToanVNPay(maDonHang, maGiaoDich)
    │     
    │     ├─ Load DonHang by maDonHang
    │     ├─ Check: trangThaiDonHang == CHO_THANH_TOAN
    │     │  (if already processed, skip)
    │     ├─ Set: vnPayTransactionRef = maGiaoDich
    │     ├─ Set: trangThaiDonHang = DA_THANH_TOAN
    │     ├─ Save DonHang
    │     │
    │     ├─ TRỪ KHO ngay:
    │     │  └─ For each ChiTietDonHang:
    │     │     ├─ BienThe.soLuongTon -= soLuong
    │     │     └─ Save BienThe
    │     │
    │     ├─ Record LichSuTrangThaiDon:
    │     │  ├─ trangThaiCu: CHO_THANH_TOAN
    │     │  ├─ trangThaiMoi: DA_THANH_TOAN
    │     │  └─ moTa: "Thanh toán VNPay thành công - Mã GD: " + maGiaoDich
    │     │
    │     └─ Send email (bất đồng bộ):
    │        └─ MailService.guiMailXacNhanThanhToanVNPay()
    │           ├─ Subject: "Thanh toán VNPay thành công"
    │           ├─ Include: order ID, VNPay transaction ID, total
    │           └─ HTML template tiếng Việt
    │
    └─ Else: // Payment failed or cancelled
       └─ Record in logs + return error message
          (Order will auto-cancel after 15 minutes via scheduled job)

Response redirect: http://localhost:5173/don-hang-cua-toi
    ├─ Flash message: success or error
    └─ Frontend display order detail
```

### D. Auto-Cancel VNPay Orders if Not Paid

```
@Scheduled(fixedDelay = 120000)  // Every 2 minutes
DonHangService.tuDongHuyDonVNPayHetHan()
    ├─ Query: DonHang WHERE
    │  ├─ trangThaiDonHang = CHO_THANH_TOAN
    │  └─ thoiGianTao < now - 15 minutes
    ├─ For each expired order:
    │  ├─ Set: trangThaiDonHang = DA_HUY
    │  ├─ Record LichSuTrangThaiDon
    │  ├─ Increment khuyenMai.soLanSuDung (refund quota if used)
    │  └─ Log: "Tự động hủy đơn VNPay hết hạn: DH-xxx"
```

---

## VI. ORDER STATUS MANAGEMENT FLOW

### Order Status States

```
┌─────────────────────┐
│      CHO_THANH_TOAN │  (Chờ thanh toán - VNPay only)
└──────────┬──────────┘
           │
           ├──→ VNPAY callback success
           │
┌──────────▼──────────┐
│   DA_THANH_TOAN     │  (Đã thanh toán - VNPay only)
└──────────┬──────────┘
           │
           ├──→ Nhân viên bấm "Xác nhận"
           │
┌──────────▼──────────┐
│   CHO_XAC_NHAN      │  (Chờ xác nhận - initial for COD)
└──────────┬──────────┘
           │
           ├──→ Nhân viên bấm "Xác nhận"
           │
┌──────────▼──────────┐
│   DA_XAC_NHAN       │  (Đã xác nhận, kho đã trừ)
└──────────┬──────────┘
           │
           ├──→ Nhân viên bấm "Giao cho GHN"
           │
┌──────────▼──────────┐
│   DANG_XU_LY        │  (Đang xử lý / Đang giao - may set via GHN sync)
└──────────┬──────────┘
           │
           ├──→ GHN API update OR Nhân viên bấm "Đang giao"
           │
┌──────────▼──────────┐
│   DANG_GIAO         │  (Đang giao với khách)
└──────────┬──────────┘
           │
           ├──→ GHN API update OR Nhân viên bấm "Hoàn tất"
           │
┌──────────▼──────────┐
│   HOAN_TAT          │  (Hoàn tất - giao thành công)
└─────────────────────┘

OR at any state (except DA_HUY, HOAN_TAT):

        ┌─────────────┐
        │   DA_HUY    │  (Đã hủy - khách hủy hoặc nhân viên hủy)
        └─────────────┘
```

### A. Confirm Order (Xác Nhận Đơn)

```
Admin/Staff:
    ├─ At admin panel: Quản lý > Đơn hàng > Danh sách
    ├─ Find order with status CHO_XAC_NHAN (COD) or DA_THANH_TOAN (VNPay)
    ├─ Click "Xác nhận"
    └─ POST /api/quan-ly/don-hang/{id}/chuyen-trang-thai
       ↓ { trangThaiMoi: "DA_XAC_NHAN", ghiChu: "..." }

DonHangService.chuyenTrangThai(donHangId, trangThaiMoi, ghiChu, nguoiDungId)
    ├─ Load DonHang
    ├─ Validate state transition:
    │  ├─ CHO_XAC_NHAN → DA_XAC_NHAN: OK
    │  ├─ DA_THANH_TOAN → DA_XAC_NHAN: OK (VNPay case)
    │  ├─ etc.
    │  └─ Deny invalid transitions
    │
    ├─ If trangThaiMoi == DA_XAC_NHAN AND phuongThucThanhToan == "COD":
    │  └─ DonHangService.truKho()  // Deduct inventory
    │     ├─ For each ChiTietDonHang:
    │     │  └─ BienThe.soLuongTon -= soLuong
    │     └─ Save all BienThe
    │
    ├─ Update: DonHang.trangThaiDonHang = DA_XAC_NHAN
    ├─ Save DonHang
    │
    ├─ Record LichSuTrangThaiDon
    │
    └─ Send email (bất đồng bộ):
       └─ MailService.guiMailCapNhatTrangThai()
          ├─ Subject: "Đơn hàng DH-xxx đã được xác nhận"
          ├─ Body: include new status, expected delivery time
          └─ HTML template tiếng Việt
```

### B. Change Status to "DANG_XU_LY" (Processing)

```
Staff clicks "Bắt đầu xử lý":
    └─ POST .../chuyen-trang-thai
       ↓ { trangThaiMoi: "DANG_XU_LY", ghiChu: "Đang chuẩn bị hàng" }

Similar flow to above:
    ├─ Validate: DA_XAC_NHAN → DANG_XU_LY (OK)
    ├─ No inventory change (already deducted at DA_XAC_NHAN)
    ├─ Update status
    ├─ Record history
    └─ Send email update to customer
```

### C. Change Status to "DANG_GIAO" (Delivering)

```
Staff clicks "Giao cho GHN" or "Đang giao":
    ├─ Manual override via admin panel
    └─ OR auto-sync from GHN API webhook

Flow:
    ├─ POST .../chuyen-trang-thai
    │  ↓ { trangThaiMoi: "DANG_GIAO", ghiChu: "..." }
    ├─ Validate: DANG_XU_LY → DANG_GIAO (OK)
    ├─ No inventory change
    ├─ Update status
    ├─ Record history
    └─ Send email: "Đơn hàng của bạn đang được giao đến"
```

### D. Complete Order (Hoàn Tất)

```
Staff or GHN API:
    └─ POST .../chuyen-trang-thai
       ↓ { trangThaiMoi: "HOAN_TAT", ghiChu: "Giao thành công" }

Flow:
    ├─ Validate: DANG_GIAO → HOAN_TAT (OK)
    ├─ No inventory change
    ├─ Update status
    ├─ Record history
    └─ Send email: "Đơn hàng DH-xxx đã giao thành công"
       └─ Include: link to review/rating
```

### E. Cancel Order (Hủy Đơn)

#### 1. Customer Cancel

```
Customer at "Đơn hàng của tôi":
    ├─ View order detail
    ├─ Status is one of: CHO_XAC_NHAN, DA_XAC_NHAN, CHO_THANH_TOAN, DA_THANH_TOAN
    ├─ Click "Hủy đơn"
    └─ POST /don-hang/huy/{id}
       ↓ { lyDo: "Tôi không muốn mua nữa" }

DonHangService.khachHuyDon(donHangId, lyDo, nguoiDungId)
    ├─ Load DonHang
    ├─ Check: DonHang.nguoiDung.id == currentUser.id
    ├─ Validate allowed states:
    │  ├─ CHO_XAC_NHAN: OK
    │  ├─ DA_XAC_NHAN: OK
    │  ├─ CHO_THANH_TOAN: OK
    │  ├─ DA_THANH_TOAN: OK
    │  └─ Others: NOT ALLOWED
    │
    ├─ If status is DA_XAC_NHAN or DA_THANH_TOAN:
    │  └─ RESTORE inventory:
    │     ├─ For each ChiTietDonHang:
    │     │  └─ BienThe.soLuongTon += soLuong
    │     └─ Save all BienThe
    │
    ├─ If khuyenMai was used:
    │  └─ Decrement: KhuyenMai.soLanSuDung--
    │
    ├─ Set: DonHang.trangThaiDonHang = DA_HUY
    ├─ Save DonHang
    │
    ├─ Record LichSuTrangThaiDon: "Khách hủy: " + lyDo
    │
    └─ Send email:
       └─ MailService.guiMailHuyDon(email, hoTen, maDon, lyDo, doKhachHuy=true)
          ├─ Subject: "Đơn hàng DH-xxx đã bị hủy"
          ├─ Body: include cancellation reason, refund info
          └─ HTML template tiếng Việt
```

#### 2. Staff Cancel

```
Staff at admin panel:
    ├─ Quản lý > Đơn hàng > Danh sách
    ├─ Find order
    ├─ Status is one of: CHO_XAC_NHAN, DA_XAC_NHAN, DANG_XU_LY, CHO_THANH_TOAN, DA_THANH_TOAN
    ├─ Click "Hủy đơn" (Red button)
    └─ POST /api/quan-ly/don-hang/{id}/huy
       ↓ { lyDo: "Hết hàng" }

DonHangService.nhanVienHuyDon(donHangId, lyDo, nhanVienId)
    ├─ Load DonHang
    ├─ Validate allowed states (similar to khachHuyDon)
    │
    ├─ Restore inventory if deducted
    ├─ Decrement voucher usage if used
    ├─ Set status = DA_HUY
    ├─ Record history: "Nhân viên hủy: " + lyDo
    │
    └─ Send email:
       └─ MailService.guiMailHuyDon(email, hoTen, maDon, lyDo, doKhachHuy=false)
          ├─ Subject: "Đơn hàng DH-xxx đã bị hủy bởi cửa hàng"
          ├─ Body: reason, will try to process new order
          └─ HTML template tiếng Việt
```

---

## VII. POINT OF SALES (BÁN TẠI QUẦY) FLOW

### A. Create Pending Invoice at Counter

```
Staff at POS panel:
    ├─ Click "Tạo hóa đơn chờ"
    └─ POST /api/ban-hang/tao-hoa-don

DonHangService.taoHoaDonCho(nhanVien)
    ├─ Query: count DonHang WHERE trangThaiDonHang = HOA_DON_CHO
    ├─ Validate: count < ${app.hoadon.soLuongChoToiDa} (default: 5)
    │  (Max 5 pending invoices per staff at once)
    │
    ├─ Create DonHang:
    │  ├─ maDonHang: sinhMaDonHang()
    │  ├─ trangThaiDonHang: HOA_DON_CHO
    │  ├─ loaiDonHang: TAI_QUAY
    │  ├─ nhanVien: reference (staff who created)
    │  ├─ tongTien, soTienGiamGia, phiVanChuyen: 0
    │  ├─ tongTienThanhToan: 0
    │  ├─ daThanhToan: false
    │  └─ thoiGianTuHuy: now + 120 minutes (auto-delete if not finalized)
    │
    ├─ Save DonHang
    ├─ Record history: "Tạo hóa đơn chờ tại quầy"
    │
    └─ Return: { success: true, donHangId: X, maDonHang: "DH-..." }
```

### B. Add Items to POS Invoice

```
Staff searches product + selects variant:
    ├─ Click "Thêm vào hóa đơn"
    └─ POST /api/ban-hang/{hoaDonId}/them-chi-tiet
       ↓ { bienTheId, soLuong }

DonHangService.themChiTietVaoHoaDonCho(hoaDonId, bienTheId, soLuong, nhanVienId)
    ├─ Load DonHang (verify loaiDonHang = TAI_QUAY & status = HOA_DON_CHO)
    ├─ Load BienThe
    ├─ Validate: soLuong ≤ BienThe.soLuongTon
    │
    ├─ Check if item already in invoice:
    │  ├─ If yes: update soLuong
    │  └─ If no: create new ChiTietDonHang
    │
    ├─ Update DonHang.tongTien, tongTienThanhToan
    ├─ Save
    │
    └─ Return: { success: true, tongTien: X, tongThanhToan: Y }
```

### C. Remove Item from POS Invoice

```
Staff clicks "Xóa" next to item:
    └─ POST /api/ban-hang/{hoaDonId}/xoa-chi-tiet
       ↓ { chiTietId }

DonHangService.xoaChiTietKhoiHoaDonCho(...)
    ├─ Load ChiTietDonHang
    ├─ Verify ownership
    ├─ Delete
    ├─ Recalculate tongTien
    ├─ Save DonHang
    │
    └─ Return: { success: true, tongTien: X }
```

### D. Finalize & Charge

```
Staff clicks "Hoàn tất thanh toán":
    └─ POST /api/ban-hang/{hoaDonId}/hoan-tat-thanh-toan
       ↓ { phuongThucThanhToan: "COD" or "TIEN_MAT", soTienThanhToan, tienThua }

DonHangService.hoanTatHoaDonCho(hoaDonId, phuongThucThanhToan, soTienThanhToan, nhanVienId)
    ├─ Load DonHang
    ├─ Validate: danhSachChiTiet not empty
    ├─ Validate: tongTien > 0
    │
    ├─ DEDUCT INVENTORY:
    │  └─ truKho(donHang)
    │     ├─ For each ChiTietDonHang:
    │     │  └─ BienThe.soLuongTon -= soLuong
    │     └─ Save all BienThe
    │
    ├─ Update DonHang:
    │  ├─ trangThaiDonHang: DA_XAC_NHAN (skip CHO_XAC_NHAN)
    │  ├─ phuongThucThanhToan: "COD" or "TIEN_MAT"
    │  ├─ daThanhToan: true (if TIEN_MAT, false if COD)
    │  └─ nhanVien: reference
    │
    ├─ Record history
    ├─ Print invoice (optional)
    │
    └─ Return: { success: true, hoaDon: {...} }
```

### E. Auto-Cancel Pending Invoices (Scheduled Job)

```
@Scheduled(fixedDelay = 60000)  // Every minute
DonHangService.tuDongHuyHoaDonChoQuaHan()
    ├─ Query: DonHang WHERE
    │  ├─ trangThaiDonHang = HOA_DON_CHO
    │  └─ thoiGianTuHuy <= now
    ├─ For each expired:
    │  ├─ hubHoaDonCho(hoaDonId, nhanVien=null)
    │  │  ├─ RESTORE inventory
    │  │  ├─ Mark status = DA_HUY
    │  │  ├─ Record history
    │  │  └─ Log
    │  │
    │  └─ Return
```

---

## VIII. EMAIL SERVICE (ASYNC)

### Email Service Overview

```
MailService (@Service @RequiredArgsConstructor)
    ├─ Injected:
    │  ├─ JavaMailSender mailSender
    │  ├─ @Value("${spring.mail.username}") String fromEmail
    │  └─ @Value("${app.shop.ten:Certain Shop}") String shopName
    │
    ├─ Private helpers:
    │  ├─ hopLe(email): validate email format
    │  ├─ formatTien(so): format BigDecimal to "N,NNN ₫"
    │  ├─ tenTrangThai(code): map status code to Vietnamese name
    │  ├─ khuonHtml(tieuDe, noiDung): wrap HTML template
    │  └─ send(to, subject, html): send via JavaMailSender
    │
    └─ Public @Async methods (run on thread pool, non-blocking):

    1. guiMailChaoMung(toEmail, hoTen, tenDangNhap)
       ├─ Trigger: After successful registration
       ├─ Subject: "Chào mừng <hoTen> đến Certain Shop"
       ├─ Body:
       │  ├─ Welcome message
       │  ├─ Login credentials
       │  ├─ Shop info
       │  └─ HTML styled
       └─ @Async (non-blocking)

    2. guiMailXacNhanDonHang(toEmail, hoTen, maDonHang, tongTien, phuongThucThanhToan)
       ├─ Trigger: After creating COD order (NOT VNPay)
       ├─ Subject: "Xác nhận đơn hàng <maDonHang>"
       ├─ Body:
       │  ├─ Order ID
       │  ├─ Order total (formatted VND)
       │  ├─ Payment method: "Thanh toán khi nhận hàng"
       │  ├─ Expected delivery time: up to 3-5 days
       │  ├─ Shop contact info
       │  └─ HTML styled
       └─ @Async

    3. guiMailXacNhanThanhToanVNPay(toEmail, hoTen, maDonHang, tongTien, maGiaoDich)
       ├─ Trigger: After VNPay payment success (callback processed)
       ├─ Subject: "Thanh toán VNPay thành công - <maDonHang>"
       ├─ Body:
       │  ├─ Order ID
       │  ├─ VNPay transaction ID
       │  ├─ Amount (formatted VND)
       │  ├─ Status: "Đã thanh toán"
       │  ├─ Next steps: "Chúng tôi sẽ xác nhận và xử lý đơn hàng"
       │  └─ HTML styled
       └─ @Async

    4. guiMailCapNhatTrangThai(toEmail, hoTen, maDonHang, trangThaiMoi)
       ├─ Trigger: When staff changes status (via chuyenTrangThai)
       ├─ Only for: DA_XAC_NHAN, DANG_XU_LY, DANG_GIAO, HOAN_TAT
       │  (Not for CHO_THANH_TOAN, CHO_XAC_NHAN)
       ├─ Subject: "Đơn hàng <maDonHang> có cập nhật trạng thái"
       ├─ Body:
       │  ├─ Order ID
       │  ├─ Current status in Vietnamese
       │  ├─ Status-specific message:
       │  │  ├─ DA_XAC_NHAN → "Đơn hàng đã được xác nhận. Chúng tôi đang chuẩn bị hàng."
       │  │  ├─ DANG_XU_LY → "Đang chuẩn bị hàng để giao đến bạn"
       │  │  ├─ DANG_GIAO → "Đơn hàng đang được giao. Kiểm tra tin nhắn SMS từ shipper."
       │  │  └─ HOAN_TAT → "Đơn hàng đã giao thành công. Cảm ơn bạn đã mua sắm!"
       │  └─ HTML styled
       └─ @Async

    5. guiMailHuyDon(toEmail, hoTen, maDonHang, lyDo, doKhachHuy)
       ├─ Trigger: When order cancelled (khachHuyDon or nhanVienHuyDon)
       ├─ Subject: "Đơn hàng <maDonHang> đã bị hủy"
       ├─ Body:
       │  ├─ Order ID
       │  ├─ Cancellation reason
       │  ├─ If doKhachHuy=true:
       │  │  └─ "Bạn đã hủy đơn hàng này"
       │  └─ Else (staff cancelled):
       │     └─ "Cửa hàng đã hủy đơn hàng vì: <reason>"
       │        "Vui lòng liên hệ chúng tôi nếu bạn muốn đặt lại"
       ├─ Refund info (if COD - automatic after 3-5 days)
       └─ @Async

Thread Pool Configuration:
    ├─ @EnableAsync on CertainShopApplication
    ├─ Default: SimpleAsyncTaskExecutor (unbounded thread pool)
    ├─ Recommendation: Configure AsyncConfigurerSupport bean:
    │  ├─ corePoolSize: 2-5
    │  ├─ maxPoolSize: 10
    │  ├─ queueCapacity: 100
    │  └─ threadNamePrefix: "mail-"
    └─ Email sending runs off main thread → user gets response immediately
```

### Email Error Handling

```
Guard in every @Async method:
    ├─ Try {
    │  ├─ Validate: hopLe(toEmail)
    │  ├─ Create MimeMessage
    │  ├─ Set: from, to, subject, content (HTML)
    │  ├─ mailSender.send(mimeMessage)
    │  └─ Success log
    │
    └─ Catch (Exception e) {
       ├─ Log.warn("Email failed: " + e.getMessage())
       ├─ DO NOT throw exception (bất đồng bộ, không block)
       └─ Continue
    }
```

---

## IX. SECURITY & AUTHORIZATION

### JWT Token Details

```
Header: Authorization: Bearer eyJhbGciOiJIUzUxMiJ9...

Token payload (decoded):
    {
      "sub": "tenDangNhap",
      "iat": 1708900000,
      "exp": 1708986400  // 24h from now
    }

JwtUtil methods:
    ├─ taoToken(UserDetails) → String
    ├─ layTenDangNhap(token) → String
    ├─ chuKyHopLe(token) → boolean
    │  └─ Verify: signature + expiration
    └─ isTokenExpired(token) → boolean
```

### Security Filter Chain

```
Request → JwtAuthenticationFilter
    ├─ Extract token from Authorization header
    ├─ Validate token signature & expiration
    ├─ Load user from DB (UserDetailsService)
    ├─ Build Authentication object with role
    ├─ Set in SecurityContext
    └─ Request proceeds with authentication

Protected endpoints (@PreAuthorize):
    ├─ Admin panel: @PreAuthorize("hasRole('ADMIN')")
    ├─ Staff functions: @PreAuthorize("hasAnyRole('ADMIN', 'NHAN_VIEN')")
    └─ Customer endpoints: accessible to KHACH_HANG
```

### Role-Based Access Control

```
Roles (from VaiTro table):
    ├─ KHACH_HANG: customers
    │  ├─ Browse products
    │  ├─ Manage cart
    │  ├─ Place orders
    │  ├─ Cancel own orders
    │  └─ View own orders
    │
    ├─ NHAN_VIEN: staff
    │  ├─ View all customers & orders
    │  ├─ Confirm & cancel orders
    │  ├─ Change order statuses
    │  ├─ POS (bán tại quầy)
    │  └─ View sales dashboard
    │
    └─ ADMIN: administrator
       ├─ All staff permissions
       ├─ Manage users (create, lock, change role)
       ├─ Manage products, categories, variants
       ├─ Manage promotions
       ├─ View full reports
       └─ System configuration
```

---

## X. DATABASE ENTITIES & RELATIONSHIPS

### Core Entities

```
NguoiDung (Person/User)
    ├─ PK: Id
    ├─ FK: VaiTroId → VaiTro
    ├─ Fields:
    │  ├─ tenDangNhap (unique)
    │  ├─ matKhauMaHoa (BCrypt hashed)
    │  ├─ email (unique)
    │  ├─ hoTen, soDienThoai, ngaySinh, gioiTinh
    │  ├─ anhDaiDien (avatar path)
    │  ├─ dangHoatDong (active/locked)
    │  └─ timestamps: thoiGianTao, thoiGianCapNhat, lanDangNhapCuoi
    │
    └─ Relationships:
       ├─ 1:1 GioHang (shopping cart)
       ├─ 1:N DonHang (orders as customer)
       └─ 1:N DiaChiNguoiDung (saved addresses)

GioHang (Shopping Cart)
    ├─ PK: Id
    ├─ FK: NguoiDungId (1:1)
    ├─ Relationships:
    │  └─ 1:N GioHangChiTiet (cascade=ALL, orphanRemoval=true)
    │     └─ When clear(), all items auto-delete
    │
    └─ Fields: thoiGianTao, thoiGianCapNhat

GioHangChiTiet (Cart Item)
    ├─ PK: Id
    ├─ FK: GioHangId, BienTheId
    ├─ Fields:
    │  ├─ soLuong
    │  ├─ donGia (price at time of add)
    │  └─ thanhTien (computed: soLuong × donGia)
    │
    └─ Relationships:
       ├─ N:1 GioHang
       └─ N:1 BienThe

DonHang (Order)
    ├─ PK: Id
    ├─ FK: NguoiDungId, NhanVienId (optional), KhuyenMaiId (optional)
    ├─ Fields:
    │  ├─ maDonHang (unique, format: "DH-" + timestamp + random)
    │  ├─ tongTien (sum of products)
    │  ├─ soTienGiamGia (from voucher)
    │  ├─ phiVanChuyen (shipping fee)
    │  ├─ tongTienThanhToan (total = tongTien - giamGia + phiVanChuyen)
    │  ├─ trangThaiDonHang (CHO_XAC_NHAN, DA_XAC_NHAN, ..., DA_HUY, HOAN_TAT)
    │  ├─ loaiDonHang ("ONLINE" or "TAI_QUAY")
    │  ├─ phuongThucThanhToan ("COD" or "VNPAY")
    │  ├─ tenNguoiNhan, sdtNguoiNhan
    │  ├─ diaChiGiaoHang (full address)
    │  ├─ maTinhGHN, maHuyenGHN, maXaGHN
    │  ├─ vnPayTransactionRef (VNPay ID if paid via VNPay)
    │  ├─ daThanhToan (boolean: paid or not)
    │  ├─ ghiChu (customer notes)
    │  ├─ thoiGianTuHuy (for HOA_DON_CHO auto-cancel)
    │  └─ timestamps
    │
    └─ Relationships:
       ├─ N:1 NguoiDung (customer)
       ├─ N:1 NhanVien (staff who created/processed)
       ├─ N:1 KhuyenMai (voucher applied)
       ├─ 1:N ChiTietDonHang (order items)
       ├─ 1:N LichSuTrangThaiDon (status history)
       └─ 1:1 ThanhToan (payment details)

ChiTietDonHang (Order Item)
    ├─ PK: Id
    ├─ FK: DonHangId, BienTheId
    ├─ Fields:
    │  ├─ giaTaiThoiDiemMua (price snapshot)
    │  ├─ soLuong
    │  └─ thanhTien (computed)
    │
    └─ Relationships:
       ├─ N:1 DonHang
       └─ N:1 BienThe

BienThe (Product Variant)
    ├─ PK: Id
    ├─ FK: SanPhamId, KichThuocId, MauSacId, ChatLieuId
    ├─ Fields:
    │  ├─ gia (sale price)
    │  ├─ soLuongTon (inventory count)
    │  ├─ macDinh (default variant)
    │  ├─ trangThai (active/discontinued)
    │  └─ timestamps
    │
    └─ Relationships:
       ├─ N:1 SanPham
       ├─ N:1 KichThuoc (size)
       ├─ N:1 MauSac (color)
       ├─ N:1 ChatLieu (material)
       └─ 1:N HinhAnhBienThe (images)

SanPham (Product)
    ├─ PK: Id
    ├─ FK: DanhMucId, ThuongHieuId
    ├─ Fields:
    │  ├─ tenSanPham, moTa, giaMua (cost)
    │  ├─ trangThai (active/discontinued)
    │  └─ timestamps
    │
    └─ Relationships:
       ├─ N:1 DanhMuc (category)
       ├─ N:1 ThuongHieu (brand)
       └─ 1:N BienThe (variants)

LichSuTrangThaiDon (Status History)
    ├─ PK: Id
    ├─ FK: DonHangId, NguoiDungId (who changed)
    ├─ Fields:
    │  ├─ trangThaiCu (previous status)
    │  ├─ trangThaiMoi (new status)
    │  ├─ moTa (description/reason)
    │  └─ thoiGian (timestamp)
    │
    └─ Relationships:
       ├─ N:1 DonHang
       └─ N:1 NguoiDung (staff who made change)

KhuyenMai (Promotion/Voucher)
    ├─ PK: Id
    ├─ Fields:
    │  ├─ ma (unique code: "SUMMER20")
    │  ├─ tenKhuyenMai
    │  ├─ kieu ("%" or "VND")
    │  ├─ giaTriGiam
    │  ├─ giaTriDonHangToiThieu (min order to apply)
    │  ├─ ngayBatDau, ngayKetThuc
    │  ├─ soLanSuDungToiDa
    │  ├─ soLanSuDung (used count)
    │  ├─ daHoatDong (active)
    │  └─ timestamps
    │
    └─ Relationships:
       └─ 1:N DonHang (orders using this)

ThanhToan (Payment Details)
    ├─ PK: Id
    ├─ FK: DonHangId (1:1)
    ├─ Fields:
    │  ├─ soTienThanhToan
    │  ├─ ngayThanhToan
    │  ├─ phuongThucThanhToan
    │  ├─ trangThaiThanhToan
    │  └─ ghiChuThanhToan
    │
    └─ Relationships:
       └─ 1:1 DonHang
```

---

## XI. KEY BUSINESS LOGIC

### Inventory Management

```
1. When adding to cart:
   ├─ Check: soLuong ≤ BienThe.soLuongTon
   └─ NO deduction yet

2. When creating COD order:
   ├─ Check: soLuong ≤ BienThe.soLuongTon (final check)
   ├─ Create ChiTietDonHang
   └─ NO deduction yet (chuyên chờ xác nhận)

3. When confirming COD order (DA_XAC_NHAN):
   ├─ truKho() called
   ├─ For each ChiTietDonHang:
   │  └─ BienThe.soLuongTon -= soLuong
   └─ Save BienThe

4. When VNPay payment success:
   ├─ Set status = DA_THANH_TOAN
   ├─ truKho() called immediately
   └─ Inventory deducted

5. When cancelling order (khachHuyDon or nhanVienHuyDon):
   ├─ If status in [DA_XAC_NHAN, DA_THANH_TOAN, DANG_XU_LY]:
   │  └─ rollbackKho() called
   │     ├─ For each ChiTietDonHang:
   │     │  └─ BienThe.soLuongTon += soLuong
   │     └─ Save BienThe
   └─ Else: no inventory change needed
```

### Voucher (Promotion) Management

```
1. When applying voucher at checkout:
   ├─ Check: KhuyenMai.laHopLe() == true
   │  ├─ ngayBatDau ≤ today ≤ ngayKetThuc
   │  ├─ soLanSuDung < soLanSuDungToiDa
   │  └─ daHoatDong == true
   ├─ Check: tongTien >= giaTriDonHangToiThieu
   ├─ Calculate soTienGiam:
   │  ├─ If kieu == "%": giamGia = tongTien × (giaTriGiam / 100)
   │  └─ If kieu == "VND": giamGia = giaTriGiam
   └─ Apply to order

2. When order confirmed:
   ├─ Increment: KhuyenMai.soLanSuDung++
   └─ Cap at soLanSuDungToiDa

3. When order cancelled:
   ├─ Decrement: KhuyenMai.soLanSuDung--
   └─ Return quota to voucher
```

### Status State Machine

```
Valid transitions:
    CHO_THANH_TOAN → DA_THANH_TOAN (VNPay callback)
    CHO_THANH_TOAN → DA_HUY (auto-timeout or customer cancel)
    
    CHO_XAC_NHAN → DA_XAC_NHAN (staff confirm)
    CHO_XAC_NHAN → DA_HUY (customer cancel)
    
    DA_XAC_NHAN → DANG_XU_LY (staff start processing)
    DA_XAC_NHAN → DA_HUY (customer/staff cancel)
    
    DA_THANH_TOAN → DA_XAC_NHAN (staff confirm for VNPay)
    DA_THANH_TOAN → DA_HUY (staff cancel)
    
    DANG_XU_LY → DANG_GIAO (staff ship / GHN sync)
    DANG_XU_LY → DA_HUY (staff cancel)
    
    DANG_GIAO → HOAN_TAT (delivery complete)
    
    HOA_DON_CHO → DA_XAC_NHAN (staff finalize POS)
    HOA_DON_CHO → DA_HUY (auto-timeout or manual cancel)

Invalid:
    ├─ DA_HUY → any other (terminal state)
    ├─ HOAN_TAT → any other (terminal state)
    └─ Backwards transitions (DA_XAC_NHAN → CHO_XAC_NHAN NOT allowed)
```

---

## XII. SCHEDULED JOBS

```
1. Order Auto-Cancel (VNPay - unpaid over 15 min)
   @Scheduled(fixedDelay = 120000)  // Every 2 minutes
   tuDongHuyDonVNPayHetHan()
   ├─ Find: DonHang WHERE trangThaiDonHang = CHO_THANH_TOAN
   │        AND thoiGianTao < now - 15 minutes
   ├─ For each:
   │  ├─ Set status = DA_HUY
   │  ├─ Record history
   │  ├─ Decrement voucher usage (if used)
   │  └─ Log

2. Pending Invoice Auto-Cancel (POS)
   @Scheduled(fixedDelay = 60000)  // Every minute
   tuDongHuyHoaDonChoQuaHan()
   ├─ Find: DonHang WHERE trangThaiDonHang = HOA_DON_CHO
   │        AND thoiGianTuHuy <= now
   ├─ For each:
   │  ├─ Restore inventory
   │  ├─ Set status = DA_HUY
   │  ├─ Record history
   │  └─ Log
```

---

## XIII. API ENDPOINTS SUMMARY

### Authentication
```
POST   /api/auth/dang-nhap         Login
POST   /api/auth/dang-ky           Register
GET    /api/auth/toi               Get current user info
```

### Shopping Cart
```
GET    /gio-hang                   View cart (page)
POST   /gio-hang/them              Add to cart (AJAX)
POST   /gio-hang/cap-nhat          Update quantity (AJAX)
POST   /gio-hang/xoa               Remove item (AJAX)
```

### Checkout & Orders
```
GET    /dat-hang                   Checkout page
POST   /dat-hang                   Create order
GET    /dat-hang/tinh-phi-ship      Calculate shipping (AJAX)
POST   /dat-hang/ap-voucher         Apply voucher (AJAX)

GET    /don-hang/cua-toi            Customer's orders list
GET    /don-hang/cua-toi/{id}       Order details
POST   /don-hang/huy/{id}           Customer cancel order

GET    /thanh-toan/vnpay-return    VNPay callback (return URL)
```

### Products (Customer)
```
GET    /
GET    /trang-chu                  Homepage
GET    /san-pham/{id}              Product details
GET    /tim-kiem                   Search products
GET    /danh-muc/{duongDan}        Category page
```

### Admin/Staff APIs
```
GET    /api/quan-ly/don-hang                    Orders list (paginated)
GET    /api/quan-ly/don-hang/{id}               Order details
POST   /api/quan-ly/don-hang/{id}/chuyen-trang-thai   Change status
POST   /api/quan-ly/don-hang/{id}/huy          Cancel order

GET    /api/quan-ly/san-pham                    Products management
POST   /api/quan-ly/san-pham                    Create product
PUT    /api/quan-ly/san-pham/{id}               Update product

GET    /api/quan-ly/nguoi-dung                  Users list
POST   /api/quan-ly/nguoi-dung                  Create user
PUT    /api/quan-ly/nguoi-dung/{id}             Update user
PATCH  /api/quan-ly/nguoi-dung/{id}/trang-thai Activate/deactivate

GET    /api/quan-ly/thong-ke                    Dashboard stats

POST   /api/ban-hang/tao-hoa-don                Create POS invoice
POST   /api/ban-hang/{id}/them-chi-tiet        Add item to POS
POST   /api/ban-hang/{id}/xoa-chi-tiet         Remove item from POS
POST   /api/ban-hang/{id}/hoan-tat-thanh-toan  Finalize POS sale
```

---

This document provides a **complete, detailed workflow** of Certain Shop backend covering:
- ✅ Authentication (JWT-based)
- ✅ Shopping cart management
- ✅ Order placement (online)
- ✅ Payment integration (COD & VNPay)
- ✅ Order status management & transitions
- ✅ Inventory management
- ✅ Voucher/promotion system
- ✅ Async email notifications (5 types)
- ✅ POS (bán tại quầy) flow
- ✅ Database entities & relationships
- ✅ Security & authorization
- ✅ Scheduled background jobs
- ✅ API endpoints

All with **Vietnamese terminology, business logic, and implementation details**.
