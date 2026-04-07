package com.certainshop.controller.api;

import com.certainshop.dto.ApiResponse;
import com.certainshop.entity.DiaChiNguoiDung;
import com.certainshop.entity.NguoiDung;
import com.certainshop.service.NguoiDungService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.Map;

@RestController
@RequestMapping("/api/quan-ly/nguoi-dung")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('ADMIN','NHAN_VIEN')")
public class QuanLyNguoiDungApiController {

    private final NguoiDungService nguoiDungService;

    @GetMapping
    public ResponseEntity<ApiResponse<Map<String, Object>>> danhSach(
            @RequestParam(value = "tuKhoa", defaultValue = "") String tuKhoa,
            @RequestParam(value = "trang", defaultValue = "0") int trang,
            @RequestParam(value = "kichThuocTrang", defaultValue = "20") int kichThuocTrang,
            @RequestParam(value = "tenVaiTro", required = false) String tenVaiTro) {
        Pageable pageable = PageRequest.of(trang, kichThuocTrang);
        String tuKhoaFilter = tuKhoa.isEmpty() ? null : tuKhoa;
        Page<NguoiDung> page = (tenVaiTro != null && !tenVaiTro.isBlank())
                ? nguoiDungService.timKiem(tuKhoaFilter, tenVaiTro, pageable)
                : nguoiDungService.timKiem(tuKhoaFilter, pageable);
        Map<String, Object> result = Map.of(
                "nguoiDung", page.getContent(),
                "tongSo", page.getTotalElements(),
                "tongTrang", page.getTotalPages(),
                "trang", trang
        );
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<NguoiDung>> chiTiet(@PathVariable("id") Long id) {
        return nguoiDungService.timTheoId(id)
                .map(nd -> ResponseEntity.ok(ApiResponse.ok(nd)))
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}/trang-thai")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> doiTrangThai(
            @PathVariable("id") Long id,
            @RequestBody Map<String, Boolean> body) {
        Boolean dangHoatDong = body.get("dangHoatDong");
        if (dangHoatDong == null) {
            return ResponseEntity.badRequest().body(ApiResponse.loi("Thiếu trạng thái"));
        }
        try {
            nguoiDungService.doiTrangThaiTaiKhoan(id, dangHoatDong);
            String msg = dangHoatDong ? "Đã kích hoạt tài khoản" : "Đã khóa tài khoản";
            return ResponseEntity.ok(ApiResponse.ok(msg, null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PutMapping("/{id}/vai-tro")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> doiVaiTro(
            @PathVariable("id") Long id,
            @RequestBody Map<String, Integer> body) {
        Integer vaiTroId = body.get("vaiTroId");
        if (vaiTroId == null) {
            return ResponseEntity.badRequest().body(ApiResponse.loi("Thiếu vaiTroId"));
        }
        try {
            nguoiDungService.doiVaiTro(id, vaiTroId);
            return ResponseEntity.ok(ApiResponse.ok("Đổi vai trò thành công", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PostMapping("/nhan-vien")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<NguoiDung>> taoNhanVien(
            @RequestBody Map<String, Object> body) {
        try {
            NguoiDung nv = new NguoiDung();
            nv.setTenDangNhap((String) body.get("tenDangNhap"));
            nv.setEmail((String) body.get("email"));
            nv.setHoTen((String) body.get("hoTen"));
            nv.setSoDienThoai((String) body.get("soDienThoai"));
            nv.setCccd((String) body.get("cccd"));
            nv.setAnhDaiDien((String) body.get("anhDaiDien"));

            // Ngày sinh
            String ngaySinhStr = (String) body.get("ngaySinh");
            if (ngaySinhStr != null && !ngaySinhStr.isBlank()) {
                nv.setNgaySinh(LocalDate.parse(ngaySinhStr));
            }

            // Giới tính  (null = Khác)
            Object gioiTinhRaw = body.get("gioiTinh");
            if (gioiTinhRaw instanceof Boolean b) {
                nv.setGioiTinh(b);
            } else if (gioiTinhRaw instanceof String s) {
                if ("true".equalsIgnoreCase(s)) nv.setGioiTinh(Boolean.TRUE);
                else if ("false".equalsIgnoreCase(s)) nv.setGioiTinh(Boolean.FALSE);
                // null → Khác
            }

            String matKhau = (String) body.get("matKhau");
            Integer vaiTroId = body.get("vaiTroId") instanceof Integer i ? i : 2;

            // Địa chỉ
            DiaChiNguoiDung diaChi = null;
            String tinhThanh = (String) body.get("tinhThanh");
            if (tinhThanh != null && !tinhThanh.isBlank()) {
                diaChi = new DiaChiNguoiDung();
                diaChi.setTinhThanh(tinhThanh);
                diaChi.setQuanHuyen((String) body.get("quanHuyen"));
                diaChi.setPhuongXa((String) body.get("phuongXa"));
                diaChi.setDiaChiDong1((String) body.get("diaChiCuThe"));
                Object maTinh = body.get("maTinhGHN");
                Object maHuyen = body.get("maHuyenGHN");
                if (maTinh instanceof Integer mt) diaChi.setMaTinhGHN(mt);
                if (maHuyen instanceof Integer mh) diaChi.setMaHuyenGHN(mh);
                diaChi.setMaXaGHN((String) body.get("maXaGHN"));
                diaChi.setHoTen(nv.getHoTen());
                diaChi.setSoDienThoai(nv.getSoDienThoai());
            }

            NguoiDung saved = nguoiDungService.taoNhanVien(nv, matKhau, vaiTroId, diaChi);
            return ResponseEntity.ok(ApiResponse.ok("Tạo nhân viên thành công", saved));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<NguoiDung>> capNhatNhanVien(
            @PathVariable("id") Long id,
            @RequestBody Map<String, Object> body) {
        try {
            NguoiDung thongTinMoi = new NguoiDung();
            thongTinMoi.setHoTen((String) body.get("hoTen"));
            thongTinMoi.setEmail((String) body.get("email"));
            thongTinMoi.setSoDienThoai((String) body.get("soDienThoai"));
            thongTinMoi.setCccd((String) body.get("cccd"));
            thongTinMoi.setAnhDaiDien((String) body.get("anhDaiDien"));

            String ngaySinhStr = (String) body.get("ngaySinh");
            if (ngaySinhStr != null && !ngaySinhStr.isBlank()) {
                thongTinMoi.setNgaySinh(LocalDate.parse(ngaySinhStr));
            }
            Object gioiTinhRaw = body.get("gioiTinh");
            if (gioiTinhRaw instanceof Boolean b) thongTinMoi.setGioiTinh(b);
            else if (gioiTinhRaw instanceof String s) {
                if ("true".equalsIgnoreCase(s)) thongTinMoi.setGioiTinh(Boolean.TRUE);
                else if ("false".equalsIgnoreCase(s)) thongTinMoi.setGioiTinh(Boolean.FALSE);
            }

            DiaChiNguoiDung diaChi = null;
            String tinhThanh = (String) body.get("tinhThanh");
            if (tinhThanh != null && !tinhThanh.isBlank()) {
                diaChi = new DiaChiNguoiDung();
                diaChi.setTinhThanh(tinhThanh);
                diaChi.setQuanHuyen((String) body.get("quanHuyen"));
                diaChi.setPhuongXa((String) body.get("phuongXa"));
                diaChi.setDiaChiDong1((String) body.get("diaChiCuThe"));
                Object maTinh = body.get("maTinhGHN");
                Object maHuyen = body.get("maHuyenGHN");
                if (maTinh instanceof Integer mt) diaChi.setMaTinhGHN(mt);
                if (maHuyen instanceof Integer mh) diaChi.setMaHuyenGHN(mh);
                diaChi.setMaXaGHN((String) body.get("maXaGHN"));
                diaChi.setHoTen(thongTinMoi.getHoTen());
                diaChi.setSoDienThoai(thongTinMoi.getSoDienThoai());
            }

            NguoiDung saved = nguoiDungService.capNhatNhanVien(id, thongTinMoi, diaChi);
            return ResponseEntity.ok(ApiResponse.ok("Cập nhật thành công", saved));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<ApiResponse<Void>> xoaNguoiDung(@PathVariable("id") Long id) {
        try {
            nguoiDungService.xoaNguoiDung(id);
            return ResponseEntity.ok(ApiResponse.ok("Đã xóa tài khoản", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }
}
