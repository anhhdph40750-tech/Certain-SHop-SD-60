# API Thống Kê Người Dùng - Certain Shop

## Tổng Quan
API thống kê người dùng giúp quản trị viên và nhân viên kế toán có thể xem được:
- Thông tin chi tiết khách hàng
- Số lượng sản phẩm đã mua
- Tổng số tiền đã chi  
- Tổng giá trị sản phẩm mua
- Tổng tiền giảm giá nhận được
- Trung bình giá trị mỗi đơn hàng

---

## 1. Thống Kê Chi Tiết Một Người Dùng

**Endpoint:** `GET /api/quan-ly/nguoi-dung/{id}/thong-ke`

**Quyền yêu cầu:** `ADMIN` hoặc `SUPER_ADMIN`

**Mô tả:** Lấy thông tin thống kê chi tiết về một người dùng cụ thể, bao gồm thông tin cá nhân và lịch sử mua hàng.

### Tham Số Đường Dẫn
| Tham Số | Kiểu | Bắt Buộc | Mô Tả |
|---------|------|---------|-------|
| id | Long | Có | ID của người dùng cần thống kê |

### Response (200 OK)
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

### Giải Thích Các Trường Dữ Liệu

#### Thông Tin Người Dùng
| Trường | Mô Tả |
|--------|-------|
| id | ID người dùng |
| hoTen | Họ tên người dùng |
| email | Email đăng ký |
| soDienThoai | Số điện thoại liên hệ |
| vaiTro | Vai trò trong hệ thống (KHACH_HANG, NHAN_VIEN, ADMIN, SUPER_ADMIN) |
| dangHoatDong | Trạng thái hoạt động của tài khoản |
| thoiGianTao | Thời gian tài khoản được tạo |

#### Thống Kê Mua Hàng
| Trường | Mô Tả |
|--------|-------|
| soDonHangHoanTat | Tổng số đơn hàng đã hoàn thành |
| soSanPhamDaMua | Tổng số lượng sản phẩm đã mua |
| tongSoTienSanPham | Tổng giá trị các sản phẩm (trước khi giảm) |
| tongTienGiamGia | Tổng tiền được giảm (voucher, khuyến mãi) |
| tongTienDaChi | Tổng tiền thực tế đã thanh toán |
| trungBinhMoiDonHang | Trung bình giá trị mỗi đơn hàng |

### Ví Dụ Request
```bash
curl -X GET "http://localhost:8080/api/quan-ly/nguoi-dung/1/thong-ke" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

### Error Response
- **404 Not Found**: Người dùng không tồn tại
- **403 Forbidden**: Không có quyền (chỉ ADMIN hoặc SUPER_ADMIN)

---

## 2. Thống Kê Danh Sách Người Dùng

**Endpoint:** `GET /api/quan-ly/nguoi-dung/thong-ke/danh-sach`

**Quyền yêu cầu:** `ADMIN` hoặc `SUPER_ADMIN`

**Mô tả:** Lấy danh sách thống kê tất cả người dùng với thông tin mua hàng, hỗ trợ lọc theo vai trò và phân trang.

### Tham Số Query
| Tham Số | Kiểu | Bắt Buộc | Mô Tả | Mặc Định |
|---------|------|---------|-------|---------|
| vaiTro | String | Không | Lọc theo vai trò (KHACH_HANG, NHAN_VIEN, ADMIN, SUPER_ADMIN) | Không lọc |
| trang | Integer | Không | Số trang (0-indexed) | 0 |
| kichThuocTrang | Integer | Không | Số bản ghi trên một trang | 20 |

### Response (200 OK)
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
      }
    ],
    "tongSo": 2,
    "tongTrang": 1,
    "trang": 0
  },
  "success": true,
  "message": "Danh sách thống kê người dùng"
}
```

### Giải Thích Các Trường Dữ Liệu

| Trường | Mô Tả |
|--------|-------|
| id | ID người dùng |
| hoTen | Họ tên người dùng |
| email | Email đăng ký |
| soDienThoai | Số điện thoại liên hệ |
| vaiTro | Vai trò trong hệ thống |
| dangHoatDong | Trạng thái hoạt động của tài khoản |
| soDonHang | Tổng số đơn hàng đã hoàn thành |
| soSanPhamDaMua | Tổng số lượng sản phẩm đã mua |
| tongTienDaChi | Tổng tiền thực tế đã thanh toán |
| tongSo | Tổng số người dùng |
| tongTrang | Tổng số trang |
| trang | Trang hiện tại |

### Ví Dụ Request

#### Lấy danh sách khách hàng
```bash
curl -X GET "http://localhost:8080/api/quan-ly/nguoi-dung/thong-ke/danh-sach?vaiTro=KHACH_HANG&trang=0&kichThuocTrang=10" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

#### Lấy danh sách nhân viên
```bash
curl -X GET "http://localhost:8080/api/quan-ly/nguoi-dung/thong-ke/danh-sach?vaiTro=NHAN_VIEN" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

### Error Response
- **403 Forbidden**: Không có quyền (chỉ ADMIN hoặc SUPER_ADMIN)

---

## Các Trạng Thái Đơn Hàng Được Tính Vào Thống Kê

Chỉ các đơn hàng có trạng thái **`HOAN_TAT`** (Hoàn thất) mới được tính vào thống kê.

### Danh Sách Trạng Thái Đơn Hàng Toàn Bộ
- `HOA_DON_CHO` - Hóa đơn chờ (tại quầy)
- `CHO_THANH_TOAN` - Chờ thanh toán
- `CHO_XAC_NHAN` - Chờ xác nhận
- `CHO_LAY_HANG` - Chờ lấy hàng
- `DANG_VAN_CHUYEN` - Đang vận chuyển
- `HOAN_TAT` - Hoàn thất ✅ (Được tính)
- `HUY` - Hủy

---

## Trường Hợp Sử Dụng

### 1. Xem Thống Kê Khách Hàng Thân Thiết
Admin/Quản lý có thể xem số tiền mà một khách hàng đã chi tiêu để quyết định cho những khuyến mãi đặc biệt.

### 2. Phân Tích Hành Vi Mua Hàng
Dùng API danh sách để phân tích:
- Khách nào mua nhiều nhất
- Khách nào có giá trị đơn hàng cao nhất
- Tỷ lệ sử dụng voucher của từng khách

### 3. Báo Cáo Quản Lý
Tạo báo cáo hàng tuần/tháng về tổng doanh thu từ từng khách hàng.

---

## Lưu Ý Quan Trọng

1. **Chỉ Tính Đơn Hàng Hoàn Thất**: Các đơn hàng bị hủy hoặc chưa hoàn thành sẽ không được tính vào thống kê.

2. **Hiệu Suất**: Nếu một khách hàng có hàng ngàn đơn hàng, lệnh gọi API có thể chậm. Nên sử dụng phân trang cho danh sách.

3. **Quyền Truy Cập**: Chỉ ADMIN hoặc SUPER_ADMIN mới có thể xem thống kê người dùng.

4. **Dữ Liệu Thực Thời**: Dữ liệu được lấy trực tiếp từ database mỗi khi gọi API, vì vậy nó luôn cập nhật.

---

## HTTP Status Codes

| Code | Ý Nghĩa |
|------|---------|
| 200 | OK - Thành công |
| 400 | Bad Request - Lỗi dữ liệu đầu vào |
| 403 | Forbidden - Không có quyền |
| 404 | Not Found - Người dùng không tồn tại |
| 500 | Internal Server Error - Lỗi server |

---

## Ví Dụ JavaScript/TypeScript

### Lấy thống kê một người dùng
```javascript
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
  
  const data = await response.json();
  if (response.ok) {
    const stats = data.data.thongKemuaHang;
    console.log(`
      Số đơn hàng: ${stats.soDonHangHoanTat}
      Số sản phẩm mua: ${stats.soSanPhamDaMua}
      Tổng tiền chi: ${stats.tongTienDaChi}
      Trung bình/đơn: ${stats.trungBinhMoiDonHang}
    `);
  }
}

// Sử dụng
getThongKeNguoiDung(1, 'YOUR_JWT_TOKEN');
```

### Lấy danh sách thống kê
```javascript
async function getDanhSachThongKe(vaiTro, token, page = 0) {
  const params = new URLSearchParams();
  if (vaiTro) params.append('vaiTro', vaiTro);
  params.append('trang', page);
  params.append('kichThuocTrang', 20);
  
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
  
  const data = await response.json();
  if (response.ok) {
    data.data.danhSach.forEach(user => {
      console.log(`${user.hoTen}: ${user.tongTienDaChi} đ`);
    });
  }
}

// Sử dụng
getDanhSachThongKe('KHACH_HANG', 'YOUR_JWT_TOKEN');
```

