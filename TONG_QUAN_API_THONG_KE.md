# TỔNG QUAN API THỐNG KÊ NGƯỜI DÙNG

## 📋 Giới Thiệu

API Thống Kê Người Dùng là một tập hợp các endpoint giúp quản trị viên theo dõi và phân tích hành vi mua sắm của khách hàng. Cung cấp dữ liệu chi tiết về số lượng sản phẩm đã mua, tổng tiền chi tiêu và các chỉ số liên quan.

---

## 🔗 DANH SÁCH ENDPOINT

### 1️⃣ API Thống Kê Chi Tiết Một Người Dùng

**Đường Dẫn (Endpoint):**
```
GET /api/quan-ly/nguoi-dung/{id}/thong-ke
```

**Tham Số Cần Truyền Lên:**
```
URL Path Parameter:
  - id (Long): ID của người dùng cần thống kê
  
Header:
  - Authorization: Bearer {TOKEN}
  - Content-Type: application/json
```

**Ví Dụ:**
```
GET /api/quan-ly/nguoi-dung/1/thong-ke
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**API Trả Về:**
```json
{
  "data": {
    "thongTinNguoiDung": {
      "id": 1,
      "hoTen": "Nguyễn Văn A",
      "email": "nguyenvana@example.com",
      "soDienThoai": "0123456789",
      "vaiTro": "KHACH_HANG",
      "dangHoatDong": true,
      "thoiGianTao": "2025-01-15T10:30:00"
    },
    "thongKemuaHang": {
      "soDonHangHoanTat": 5,
      "soSanPhamDaMua": 12,
      "tongSoTienSanPham": 2500000,
      "tongTienGiamGia": 250000,
      "tongTienDaChi": 2250000,
      "trungBinhMoiDonHang": 450000
    }
  },
  "success": true,
  "message": "Thống kê người dùng"
}
```

**Giải Thích Dữ Liệu Trả Về:**

| Mục | Trường | Kiểu | Ý Nghĩa |
|-----|--------|------|---------|
| Thông Tin Người Dùng | id | Long | ID của người dùng |
| | hoTen | String | Họ và tên |
| | email | String | Email đăng ký |
| | soDienThoai | String | Số điện thoại liên hệ |
| | vaiTro | String | Vai trò (KHACH_HANG, NHAN_VIEN, ADMIN, SUPER_ADMIN) |
| | dangHoatDong | Boolean | Tài khoản hoạt động hay bị khóa |
| | thoiGianTao | LocalDateTime | Ngày tạo tài khoản |
| Thống Kê Mua Hàng | soDonHangHoanTat | Long | Tổng số đơn hàng đã hoàn thành |
| | soSanPhamDaMua | Long | Tổng số lượng sản phẩm đã mua |
| | tongSoTienSanPham | BigDecimal | Tổng giá sản phẩm (trước giảm giá) |
| | tongTienGiamGia | BigDecimal | Tổng tiền được giảm (voucher, khuyến mãi) |
| | tongTienDaChi | BigDecimal | Tổng tiền thực tế thanh toán |
| | trungBinhMoiDonHang | BigDecimal | Trung bình giá trị mỗi đơn hàng |

**Quyền Yêu Cầu:**
- ✅ ADMIN
- ✅ SUPER_ADMIN
- ❌ NHAN_VIEN
- ❌ KHACH_HANG

---

### 2️⃣ API Thống Kê Danh Sách Người Dùng

**Đường Dẫn (Endpoint):**
```
GET /api/quan-ly/nguoi-dung/thong-ke/danh-sach
```

**Tham Số Cần Truyền Lên:**
```
Query Parameters:
  - vaiTro (String, tùy chọn): Lọc theo vai trò
    Giá trị: KHACH_HANG, NHAN_VIEN, ADMIN, SUPER_ADMIN
  - trang (Integer, tùy chọn): Số trang (0-indexed)
    Giá trị mặc định: 0
  - kichThuocTrang (Integer, tùy chọn): Số bản ghi trên một trang
    Giá trị mặc định: 20

Header:
  - Authorization: Bearer {TOKEN}
  - Content-Type: application/json
```

**Ví Dụ:**
```
GET /api/quan-ly/nguoi-dung/thong-ke/danh-sach?vaiTro=KHACH_HANG&trang=0&kichThuocTrang=10
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

**API Trả Về:**
```json
{
  "data": {
    "danhSach": [
      {
        "id": 1,
        "hoTen": "Nguyễn Văn A",
        "email": "nguyenvana@example.com",
        "soDienThoai": "0123456789",
        "vaiTro": "KHACH_HANG",
        "dangHoatDong": true,
        "soDonHang": 5,
        "soSanPhamDaMua": 12,
        "tongTienDaChi": 2250000
      },
      {
        "id": 2,
        "hoTen": "Trần Thị B",
        "email": "tranthib@example.com",
        "soDienThoai": "0987654321",
        "vaiTro": "KHACH_HANG",
        "dangHoatDong": true,
        "soDonHang": 3,
        "soSanPhamDaMua": 8,
        "tongTienDaChi": 1500000
      },
      {
        "id": 3,
        "hoTen": "Lê Văn C",
        "email": "levanc@example.com",
        "soDienThoai": "0912345678",
        "vaiTro": "KHACH_HANG",
        "dangHoatDong": false,
        "soDonHang": 2,
        "soSanPhamDaMua": 5,
        "tongTienDaChi": 800000
      }
    ],
    "tongSo": 50,
    "tongTrang": 5,
    "trang": 0
  },
  "success": true,
  "message": "Danh sách thống kê người dùng"
}
```

**Giải Thích Dữ Liệu Trả Về:**

| Mục | Trường | Kiểu | Ý Nghĩa |
|-----|--------|------|---------|
| Mỗi Người Dùng | id | Long | ID người dùng |
| | hoTen | String | Họ và tên |
| | email | String | Email đăng ký |
| | soDienThoai | String | Số điện thoại |
| | vaiTro | String | Vai trò (KHACH_HANG, NHAN_VIEN, ADMIN, SUPER_ADMIN) |
| | dangHoatDong | Boolean | Tài khoản hoạt động hay bị khóa |
| | soDonHang | Long | Tổng số đơn hàng đã hoàn thành |
| | soSanPhamDaMua | Long | Tổng số lượng sản phẩm đã mua |
| | tongTienDaChi | BigDecimal | Tổng tiền thực tế thanh toán |
| Phân Trang | tongSo | Long | Tổng số người dùng trong cơ sở dữ liệu |
| | tongTrang | Integer | Tổng số trang |
| | trang | Integer | Trang hiện tại |

**Quyền Yêu Cầu:**
- ✅ ADMIN
- ✅ SUPER_ADMIN
- ❌ NHAN_VIEN
- ❌ KHACH_HANG

---

## 📊 BẢNG SO SÁNH 2 API

| Tiêu Chí | Chi Tiết (ID) | Danh Sách |
|----------|-------|-----------|
| **Endpoint** | `/api/quan-ly/nguoi-dung/{id}/thong-ke` | `/api/quan-ly/nguoi-dung/thong-ke/danh-sach` |
| **Phương Thức** | GET | GET |
| **Mục Đích** | Xem chi tiết 1 người dùng | Xem danh sách nhiều người dùng |
| **Tham Số** | ID trong URL | Query: vaiTro, trang, kichThuocTrang |
| **Kết Quả** | 1 người dùng + thống kê chi tiết | Danh sách người dùng + phân trang |
| **Phân Trang** | Không | Có |
| **Lọc** | Không | Có (theo vaiTro) |

---

## 🔐 YÊU CẦU XÁC THỰC

### 1. JWT Token
Tất cả request cần phải gửi JWT token trong header:
```
Authorization: Bearer {JWT_TOKEN}
```

### 2. Vai Trò Được Phép
- ✅ **SUPER_ADMIN** - Toàn quyền
- ✅ **ADMIN** - Có quyền truy cập
- ❌ **NHAN_VIEN** - Bị từ chối (403 Forbidden)
- ❌ **KHACH_HANG** - Bị từ chối (403 Forbidden)

### 3. Error Response Khi Không Có Quyền
```json
{
  "timestamp": "2026-04-08T10:30:00.123+07:00",
  "status": 403,
  "error": "Forbidden",
  "message": "Access Denied"
}
```

---

## 💾 DỮ LIỆU ĐƯỢC TÍNH VÀO THỐNG KÊ

Chỉ các **đơn hàng có trạng thái `HOAN_TAT`** mới được tính vào thống kê.

**Danh Sách Các Trạng Thái Đơn Hàng:**
- ❌ `HOA_DON_CHO` - Hóa đơn chờ (tại quầy)
- ❌ `CHO_THANH_TOAN` - Chờ thanh toán
- ❌ `CHO_XAC_NHAN` - Chờ xác nhận
- ❌ `CHO_LAY_HANG` - Chờ lấy hàng
- ❌ `DANG_VAN_CHUYEN` - Đang vận chuyển
- ✅ `HOAN_TAT` - Hoàn thất (được tính)
- ❌ `HUY` - Hủy

---

## 📱 CÁCH SỬ DỤNG TRONG MỘT SỐ NGÔN NGỮ

### JavaScript/TypeScript (Fetch API)
```javascript
// Lấy thống kê chi tiết một người dùng
async function getThongKeNguoiDung(userId, token) {
  const response = await fetch(
    `http://localhost:8080/api/quan-ly/nguoi-dung/${userId}/thong-ke`,
    {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    }
  );
  return await response.json();
}

// Lấy danh sách thống kê
async function getDanhSachThongKe(vaiTro, token, page = 0, size = 20) {
  const params = new URLSearchParams();
  if (vaiTro) params.append('vaiTro', vaiTro);
  params.append('trang', page);
  params.append('kichThuocTrang', size);
  
  const response = await fetch(
    `http://localhost:8080/api/quan-ly/nguoi-dung/thong-ke/danh-sach?${params}`,
    {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json'
      }
    }
  );
  return await response.json();
}

// Sử dụng
const token = 'YOUR_JWT_TOKEN';
const stats = await getThongKeNguoiDung(1, token);
console.log(stats.data.thongKemuaHang);

const danhSach = await getDanhSachThongKe('KHACH_HANG', token, 0, 10);
console.log(danhSach.data.danhSach);
```

### cURL
```bash
# Lấy thống kê chi tiết người dùng ID 1
curl -X GET "http://localhost:8080/api/quan-ly/nguoi-dung/1/thong-ke" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json"

# Lấy danh sách khách hàng, trang 1, 10 bản ghi
curl -X GET "http://localhost:8080/api/quan-ly/nguoi-dung/thong-ke/danh-sach?vaiTro=KHACH_HANG&trang=0&kichThuocTrang=10" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN" \
  -H "Content-Type: application/json"
```

### Python (requests)
```python
import requests

token = "YOUR_JWT_TOKEN"
headers = {
    "Authorization": f"Bearer {token}",
    "Content-Type": "application/json"
}

# Lấy thống kê chi tiết
user_id = 1
response = requests.get(
    f"http://localhost:8080/api/quan-ly/nguoi-dung/{user_id}/thong-ke",
    headers=headers
)
print(response.json())

# Lấy danh sách
params = {
    "vaiTro": "KHACH_HANG",
    "trang": 0,
    "kichThuocTrang": 10
}
response = requests.get(
    "http://localhost:8080/api/quan-ly/nguoi-dung/thong-ke/danh-sach",
    headers=headers,
    params=params
)
print(response.json())
```

---

## ⚡ TRƯỜNG HỢP SỬ DỤNG THỰC TẾ

### 1. Dashboard Admin
Hiển thị danh sách khách hàng top mua hàng nhất:
```javascript
// Lấy tất cả khách hàng và sắp xếp theo tongTienDaChi
const response = await getDanhSachThongKe('KHACH_HANG', token, 0, 100);
const topCustomers = response.data.danhSach
  .sort((a, b) => b.tongTienDaChi - a.tongTienDaChi)
  .slice(0, 10);
```

### 2. Báo Cáo Hàng Tháng
Xuất dữ liệu thống kê cho mỗi khách hàng:
```javascript
for (let customer of response.data.danhSach) {
  console.log(`
    ${customer.hoTen}: ${customer.soDonHang} đơn hàng, ${customer.tongTienDaChi}đ
  `);
}
```

### 3. Xác Định Khách Hàng VIP
Những khách mua nhiều sẽ được cấp ưu đãi:
```javascript
const vipCustomers = response.data.danhSach.filter(c => c.tongTienDaChi > 10000000);
```

---

## 🔍 HTTP STATUS CODES

| Code | Ý Nghĩa |
|------|---------|
| **200** | ✅ Thành công |
| **400** | ❌ Bad Request - Dữ liệu không hợp lệ |
| **403** | ❌ Forbidden - Không có quyền truy cập |
| **404** | ❌ Not Found - Người dùng không tồn tại |
| **500** | ❌ Internal Server Error - Lỗi server |

---

## 📝 NOTES QUAN TRỌNG

1. **Dữ Liệu Thực Thời**: Dữ liệu được tính toán từ database mỗi lần gọi API, vậy nó luôn cập nhật.

2. **Hiệu Suất**: Nếu khách hàng có hàng ngàn đơn hàng, lệnh gọi API có thể chậm. Nên sử dụng phân trang.

3. **Chỉ Tính Đơn Hoàn Thất**: Các đơn hàng chưa hoàn thành hoặc bị hủy không được tính.

4. **Định Dạng Tiền Tệ**: Tất cả giá trị tiền đều là số nguyên (đơn vị: VND, không có dấu phân cách).

5. **Quyền Truy Cập**: Chỉ ADMIN và SUPER_ADMIN mới có quyền xem thống kê.

---

## ✨ TÓMSẮT NHANH

| Yếu Tố | Chi Tiết |
|--------|---------|
| **API 1** | GET `/api/quan-ly/nguoi-dung/{id}/thong-ke` |
| **API 2** | GET `/api/quan-ly/nguoi-dung/thong-ke/danh-sach` |
| **Cần Truyền** | JWT Token + Parameters |
| **Quyền** | ADMIN, SUPER_ADMIN |
| **Trả Về** | JSON với thông tin thống kê |
| **Tính Toán** | Chỉ đơn hàng hoàn thành (HOAN_TAT) |

