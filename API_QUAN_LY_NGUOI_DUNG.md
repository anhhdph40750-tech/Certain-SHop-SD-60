# API Quản Lý Người Dùng - Certain Shop

## Base URL
```
/api/quan-ly/nguoi-dung
```

## Quyền truy cập
- Tất cả các endpoint yêu cầu đăng nhập với ít nhất một trong các vai trò: `ADMIN`, `NHAN_VIEN`, hoặc `SUPER_ADMIN`

---

## 1. Danh sách người dùng
**GET** `/api/quan-ly/nguoi-dung`

### Mô tả
Lấy danh sách tất cả người dùng với hỗ trợ tìm kiếm, phân trang và lọc theo vai trò.

### Tham số query
| Tham số | Kiểu | Bắt buộc | Mô tả | Mặc định |
|---------|------|---------|-------|---------|
| tuKhoa | String | Không | Từ khóa tìm kiếm (tên đăng nhập, email, họ tên, SĐT) | "" |
| trang | Integer | Không | Số trang (0-indexed) | 0 |
| kichThuocTrang | Integer | Không | Số bản ghi trên một trang | 20 |
| tenVaiTro | String | Không | Lọc theo vai trò (VD: ADMIN, NHAN_VIEN, SUPER_ADMIN) | Không có |

### Response (200 OK)
```json
{
  "data": {
    "nguoiDung": [
      {
        "id": 1,
        "tenDangNhap": "admin@shop.com",
        "hoTen": "Nguyễn Văn A",
        "email": "admin@shop.com",
        "soDienThoai": "0123456789",
        "cccd": "123456789",
        "anhDaiDien": "url_anh",
        "ngaySinh": "1990-01-01",
        "gioiTinh": true,
        "dangHoatDong": true,
        "vaiTro": {
          "id": 1,
          "tenVaiTro": "ADMIN"
        }
      }
    ],
    "tongSo": 50,
    "tongTrang": 3,
    "trang": 0
  },
  "success": true,
  "message": null
}
```

### Ví dụ request
```
GET /api/quan-ly/nguoi-dung?tuKhoa=admin&trang=0&kichThuocTrang=10&tenVaiTro=ADMIN
```

---

## 2. Chi tiết người dùng
**GET** `/api/quan-ly/nguoi-dung/{id}`

### Mô tả
Lấy thông tin chi tiết của một người dùng cụ thể.

### Tham số đường dẫn
| Tham số | Kiểu | Mô tả |
|---------|------|-------|
| id | Long | ID của người dùng |

### Response (200 OK)
```json
{
  "data": {
    "id": 1,
    "tenDangNhap": "admin@shop.com",
    "hoTen": "Nguyễn Văn A",
    "email": "admin@shop.com",
    "soDienThoai": "0123456789",
    "cccd": "123456789",
    "anhDaiDien": "url_anh",
    "ngaySinh": "1990-01-01",
    "gioiTinh": true,
    "dangHoatDong": true,
    "vaiTro": {
      "id": 1,
      "tenVaiTro": "ADMIN"
    },
    "diaChi": {
      "id": 1,
      "tinhThanh": "TP Hồ Chí Minh",
      "quanHuyen": "Quận 1",
      "phuongXa": "Phường 1",
      "diaChiDong1": "123 Nguyễn Huệ",
      "maTinhGHN": 1,
      "maHuyenGHN": 1,
      "maXaGHN": "1001"
    }
  },
  "success": true,
  "message": null
}
```

### Error Response
- **404 Not Found**: Người dùng không tồn tại

---

## 3. Đổi trạng thái tài khoản (Kích hoạt/Khóa)
**PUT** `/api/quan-ly/nguoi-dung/{id}/trang-thai`

### Mô tả
Kích hoạt hoặc khóa tài khoản của một người dùng.

### Quyền yêu cầu
- `ADMIN` hoặc `SUPER_ADMIN`

### Tham số đường dẫn
| Tham số | Kiểu | Mô tả |
|---------|------|-------|
| id | Long | ID của người dùng |

### Request body
```json
{
  "dangHoatDong": true
}
```

### Tham số body
| Tham số | Kiểu | Bắt buộc | Mô tả |
|---------|------|---------|-------|
| dangHoatDong | Boolean | Có | true: kích hoạt, false: khóa |

### Response (200 OK)
```json
{
  "data": null,
  "success": true,
  "message": "Đã kích hoạt tài khoản"
}
```

### Error Response
- **400 Bad Request**: 
  - Thiếu tham số `dangHoatDong`
  - "Không thể thay đổi trạng thái của Super Admin"
- **404 Not Found**: Người dùng không tồn tại
- **403 Forbidden**: Không có quyền (NHAN_VIEN)

---

## 4. Đổi vai trò người dùng
**PUT** `/api/quan-ly/nguoi-dung/{id}/vai-tro`

### Mô tả
Thay đổi vai trò của một người dùng.

### Quyền yêu cầu
- `ADMIN` hoặc `SUPER_ADMIN`

### Giới hạn quyền
- **SUPER_ADMIN**: Có thể thay đổi vai trò của bất kỳ ai (trừ SUPER_ADMIN khác)
- **ADMIN**: Có thể thay đổi vai trò của NHAN_VIEN, nhưng KHÔNG thể thay đổi vai trò của ADMIN khác

### Tham số đường dẫn
| Tham số | Kiểu | Mô tả |
|---------|------|-------|
| id | Long | ID của người dùng |

### Request body
```json
{
  "vaiTroId": 2
}
```

### Tham số body
| Tham số | Kiểu | Bắt buộc | Mô tả |
|---------|------|---------|-------|
| vaiTroId | Integer | Có | ID của vai trò (1: SUPER_ADMIN, 2: ADMIN, 3: NHAN_VIEN, 4: KHACH_HANG) |

### Response (200 OK)
```json
{
  "data": null,
  "success": true,
  "message": "Đổi vai trò thành công"
}
```

### Error Response
- **400 Bad Request**:
  - Thiếu tham số `vaiTroId`
  - "Không thể thay đổi vai trò của Super Admin"
  - "Admin không thể thay đổi vai trò của Admin khác. Chỉ Super Admin mới có quyền này"
- **404 Not Found**: Người dùng không tồn tại
- **403 Forbidden**: Không có quyền

---

## 5. Tạo nhân viên (người dùng mới)
**POST** `/api/quan-ly/nguoi-dung/nhan-vien`

### Mô tả
Tạo một người dùng mới với vai trò nhân viên hoặc admin.

### Quyền yêu cầu
- `ADMIN` hoặc `SUPER_ADMIN`

### Request body
```json
{
  "tenDangNhap": "nhan_vien@shop.com",
  "email": "nhan_vien@shop.com",
  "hoTen": "Nguyễn Văn B",
  "soDienThoai": "0987654321",
  "cccd": "987654321",
  "anhDaiDien": "url_anh",
  "ngaySinh": "1995-05-15",
  "gioiTinh": true,
  "matKhau": "123456",
  "vaiTroId": 3,
  "tinhThanh": "TP Hồ Chí Minh",
  "quanHuyen": "Quận 1",
  "phuongXa": "Phường 1",
  "diaChiCuThe": "456 Lê Lợi",
  "maTinhGHN": 1,
  "maHuyenGHN": 1,
  "maXaGHN": "1001"
}
```

### Tham số body
| Tham số | Kiểu | Bắt buộc | Mô tả |
|---------|------|---------|-------|
| tenDangNhap | String | Có | Tên đăng nhập (email) |
| email | String | Có | Email |
| hoTen | String | Có | Họ tên |
| soDienThoai | String | Không | Số điện thoại |
| cccd | String | Không | Số CCCD |
| anhDaiDien | String | Không | URL ảnh đại diện |
| ngaySinh | String | Không | Ngày sinh (YYYY-MM-DD) |
| gioiTinh | Boolean | Không | Giới tính (true: Nam, false: Nữ, null: Khác) |
| matKhau | String | Có | Mật khẩu |
| vaiTroId | Integer | Không | ID vai trò (mặc định: 3 = NHAN_VIEN) |
| tinhThanh | String | Không | Tỉnh/Thành phố |
| quanHuyen | String | Không | Quận/Huyện |
| phuongXa | String | Không | Phường/Xã |
| diaChiCuThe | String | Không | Địa chỉ cụ thể |
| maTinhGHN | Integer | Không | Mã tỉnh GHN |
| maHuyenGHN | Integer | Không | Mã huyện GHN |
| maXaGHN | String | Không | Mã xã GHN |

### Response (200 OK)
```json
{
  "data": {
    "id": 5,
    "tenDangNhap": "nhan_vien@shop.com",
    "hoTen": "Nguyễn Văn B",
    "email": "nhan_vien@shop.com",
    "soDienThoai": "0987654321",
    "cccd": "987654321",
    "anhDaiDien": "url_anh",
    "ngaySinh": "1995-05-15",
    "gioiTinh": true,
    "dangHoatDong": true,
    "vaiTro": {
      "id": 3,
      "tenVaiTro": "NHAN_VIEN"
    }
  },
  "success": true,
  "message": "Tạo nhân viên thành công"
}
```

### Error Response
- **400 Bad Request**: Lỗi validation hoặc duplicate tên đăng nhập
- **403 Forbidden**: Không có quyền

---

## 6. Cập nhật thông tin người dùng
**PUT** `/api/quan-ly/nguoi-dung/{id}`

### Mô tả
Cập nhật thông tin cá nhân của một người dùng.

### Quyền yêu cầu
- `ADMIN` hoặc `SUPER_ADMIN`

### Tham số đường dẫn
| Tham số | Kiểu | Mô tả |
|---------|------|-------|
| id | Long | ID của người dùng |

### Request body
```json
{
  "hoTen": "Nguyễn Văn B Updated",
  "email": "nhan_vien_new@shop.com",
  "soDienThoai": "0987654322",
  "cccd": "987654322",
  "anhDaiDien": "url_anh_new",
  "ngaySinh": "1995-05-20",
  "gioiTinh": false,
  "tinhThanh": "Hà Nội",
  "quanHuyen": "Quận Ba Đình",
  "phuongXa": "Phường Trúc Bạch",
  "diaChiCuThe": "789 Trần Phú",
  "maTinhGHN": 2,
  "maHuyenGHN": 2,
  "maXaGHN": "2001"
}
```

### Response (200 OK)
```json
{
  "data": {
    "id": 5,
    "tenDangNhap": "nhan_vien@shop.com",
    "hoTen": "Nguyễn Văn B Updated",
    "email": "nhan_vien_new@shop.com",
    "soDienThoai": "0987654322",
    "cccd": "987654322",
    "anhDaiDien": "url_anh_new",
    "ngaySinh": "1995-05-20",
    "gioiTinh": false,
    "dangHoatDong": true,
    "vaiTro": {
      "id": 3,
      "tenVaiTro": "NHAN_VIEN"
    },
    "diaChi": {
      "tinhThanh": "Hà Nội",
      "quanHuyen": "Quận Ba Đình",
      "phuongXa": "Phường Trúc Bạch",
      "diaChiDong1": "789 Trần Phú",
      "maTinhGHN": 2,
      "maHuyenGHN": 2,
      "maXaGHN": "2001"
    }
  },
  "success": true,
  "message": "Cập nhật thành công"
}
```

### Error Response
- **400 Bad Request**: Lỗi validation
- **404 Not Found**: Người dùng không tồn tại
- **403 Forbidden**: Không có quyền

---

## 7. Xóa người dùng
**DELETE** `/api/quan-ly/nguoi-dung/{id}`

### Mô tả
Xóa (vô hiệu hóa) một người dùng.

### Quyền yêu cầu
- `ADMIN` hoặc `SUPER_ADMIN`

### Giới hạn
- Không thể xóa SUPER_ADMIN

### Tham số đường dẫn
| Tham số | Kiểu | Mô tả |
|---------|------|-------|
| id | Long | ID của người dùng |

### Response (200 OK)
```json
{
  "data": null,
  "success": true,
  "message": "Đã xóa tài khoản"
}
```

### Error Response
- **400 Bad Request**: "Không thể xóa Super Admin"
- **404 Not Found**: Người dùng không tồn tại
- **403 Forbidden**: Không có quyền

---

## Bảng Vai Trò (VaiTroConst)
| ID | Tên | Mô tả | Quyền |
|----|-----|-------|-------|
| 1 | SUPER_ADMIN | Admin cấp cao | ALL_PRIVILEGES |
| 2 | ADMIN | Admin | MANAGE_USERS, MANAGE_PRODUCTS |
| 3 | NHAN_VIEN | Nhân viên | BAN_HANG |
| 4 | KHACH_HANG | Khách hàng | MUA_HANG |

---

## Quy tắc phân quyền

### SUPER_ADMIN
- Có thể thực hiện tất cả các thao tác
- Có thể thay đổi vai trò của bất kỳ ai (trừ SUPER_ADMIN khác)
- Không thể bị thay đổi vai trò hoặc bị xóa

### ADMIN
- Có thể xem danh sách người dùng
- Có thể tạo và cập nhật nhân viên (NHAN_VIEN)
- Có thể thay đổi vai trò của NHAN_VIEN
- **KHÔNG thể** thay đổi vai trò của ADMIN khác hoặc SUPER_ADMIN
- **KHÔNG thể** thay đổi trạng thái của SUPER_ADMIN

### NHAN_VIEN
- **KHÔNG thể** truy cập các endpoint này (401 Unauthorized)

### KHACH_HANG
- **KHÔNG thể** truy cập các endpoint này (401 Unauthorized)

---

## Ví dụ request curl

### 1. Lấy danh sách admin
```bash
curl -X GET "http://localhost:8080/api/quan-ly/nguoi-dung?tenVaiTro=ADMIN" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json"
```

### 2. Tạo admin mới (SUPER_ADMIN thực hiện)
```bash
curl -X POST "http://localhost:8080/api/quan-ly/nguoi-dung/nhan-vien" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "tenDangNhap": "admin2@shop.com",
    "email": "admin2@shop.com",
    "hoTen": "Nguyễn Văn C",
    "matKhau": "123456",
    "vaiTroId": 2
  }'
```

### 3. Đổi vai trò (SUPER_ADMIN thực hiện)
```bash
curl -X PUT "http://localhost:8080/api/quan-ly/nguoi-dung/5/vai-tro" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"vaiTroId": 3}'
```

### 4. Khóa tài khoản (ADMIN thực hiện)
```bash
curl -X PUT "http://localhost:8080/api/quan-ly/nguoi-dung/5/trang-thai" \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"dangHoatDong": false}'
```

---

## HTTP Status Codes
| Code | Ý nghĩa |
|------|---------|
| 200 | OK - Thành công |
| 400 | Bad Request - Lỗi dữ liệu đầu vào |
| 401 | Unauthorized - Chưa đăng nhập |
| 403 | Forbidden - Không có quyền |
| 404 | Not Found - Tài nguyên không tồn tại |
| 500 | Internal Server Error - Lỗi server |

---

## Ghi chú
- Tất cả timestamp được lưu theo UTC
- Email được sử dụng làm unique key cho tên đăng nhập
- Mật khẩu được hash bằng bcrypt trước khi lưu
- Địa chỉ là tùy chọn khi tạo người dùng

