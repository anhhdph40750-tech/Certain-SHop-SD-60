package com.certainshop.controller.api;

import com.certainshop.constant.VaiTroConst;
import com.certainshop.dto.ApiResponse;
import com.certainshop.entity.DiaChiNguoiDung;
import com.certainshop.entity.NguoiDung;
import com.certainshop.repository.DonHangRepository;
import com.certainshop.service.NguoiDungService;
import com.certainshop.util.NguoiDungHienTai;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import org.springframework.data.domain.Sort;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
@RequestMapping("/api/quan-ly/nguoi-dung")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('ADMIN','NHAN_VIEN','SUPER_ADMIN')")
public class QuanLyNguoiDungApiController {

    @Autowired
    private NguoiDungService nguoiDungService;

    @Autowired
    private NguoiDungHienTai nguoiDungHienTai;

    @Autowired
    private DonHangRepository donHangRepository;

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
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<Void>> doiTrangThai(
            @PathVariable("id") Long id,
            @RequestBody Map<String, Boolean> body) {
        Boolean dangHoatDong = body.get("dangHoatDong");
        if (dangHoatDong == null) {
            return ResponseEntity.badRequest().body(ApiResponse.loi("Thiếu trạng thái"));
        }
        try {
            // Kiểm tra nếu user đang được đổi là SUPER_ADMIN thì không cho phép
            NguoiDung nguoiDung = nguoiDungService.timTheoId(id).orElse(null);
            if (nguoiDung == null) {
                return ResponseEntity.notFound().build();
            }
            if (VaiTroConst.SUPER_ADMIN.equals(nguoiDung.getVaiTro().getTenVaiTro())) {
                return ResponseEntity.badRequest().body(ApiResponse.loi("Không thể thay đổi trạng thái của Super Admin"));
            }
            nguoiDungService.doiTrangThaiTaiKhoan(id, dangHoatDong);
            String msg = dangHoatDong ? "Đã kích hoạt tài khoản" : "Đã khóa tài khoản";
            return ResponseEntity.ok(ApiResponse.ok(msg, null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PutMapping("/{id}/vai-tro")
    @PreAuthorize("hasAnyRole('SUPER_ADMIN', 'ADMIN')")
    public ResponseEntity<ApiResponse<Void>> doiVaiTro(
            @PathVariable("id") Long id,
            @RequestBody Map<String, Integer> body) {
        Integer vaiTroId = body.get("vaiTroId");
        if (vaiTroId == null) {
            return ResponseEntity.badRequest().body(ApiResponse.loi("Thiếu vaiTroId"));
        }
        try {
            // Lấy thông tin user hiện tại
            NguoiDung userHienTai = nguoiDungHienTai.layBatBuoc();

            // Kiểm tra nếu user đang được đổi là SUPER_ADMIN thì không cho phép
            NguoiDung nguoiDung = nguoiDungService.timTheoId(id).orElse(null);
            if (nguoiDung == null) {
                return ResponseEntity.notFound().build();
            }
            if (VaiTroConst.SUPER_ADMIN.equals(nguoiDung.getVaiTro().getTenVaiTro())) {
                return ResponseEntity.badRequest().body(ApiResponse.loi("Không thể thay đổi vai trò của Super Admin"));
            }

            nguoiDungService.doiVaiTro(id, vaiTroId);
            return ResponseEntity.ok(ApiResponse.ok("Đổi vai trò thành công", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PostMapping("/nhan-vien")
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
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
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
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
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<Void>> xoaNguoiDung(@PathVariable("id") Long id) {
        try {
            // Kiểm tra nếu user đang được xóa là SUPER_ADMIN thì không cho phép
            NguoiDung nguoiDung = nguoiDungService.timTheoId(id).orElse(null);
            if (nguoiDung == null) {
                return ResponseEntity.notFound().build();
            }
            if (VaiTroConst.SUPER_ADMIN.equals(nguoiDung.getVaiTro().getTenVaiTro())) {
                return ResponseEntity.badRequest().body(ApiResponse.loi("Không thể xóa Super Admin"));
            }
            nguoiDungService.xoaNguoiDung(id);
            return ResponseEntity.ok(ApiResponse.ok("Đã xóa tài khoản", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Thống kê chi tiết về một người dùng
     * Hiển thị: thông tin khách hàng, số sản phẩm đã mua, tổng số tiền đã chi
     */
    @GetMapping("/{id}/thong-ke")
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<Map<String, Object>>> thongKeNguoiDung(@PathVariable("id") Long id) {
        try {
            // Lấy thông tin người dùng
            NguoiDung nguoiDung = nguoiDungService.timTheoId(id)
                    .orElseThrow(() -> new RuntimeException("Người dùng không tồn tại"));

            // Lấy danh sách đơn hàng đã hoàn thành của người dùng
            List<com.certainshop.entity.DonHang> donHangList = donHangRepository.findByNguoiDungId(id, Sort.by(Sort.Direction.DESC, "thoiGianTao"));

            // Lọc chỉ các đơn hàng đã hoàn thành
            List<com.certainshop.entity.DonHang> donHangHoanTat = donHangList.stream()
                    .filter(dh -> "HOAN_TAT".equals(dh.getTrangThaiDonHang()))
                    .toList();

            // Tính toán các thống kê
            long soSanPhamDaMua = donHangHoanTat.stream()
                    .flatMap(dh -> dh.getDanhSachChiTiet().stream())
                    .mapToLong(ct -> ct.getSoLuong() != null ? ct.getSoLuong() : 0)
                    .sum();

            java.math.BigDecimal tongTienDaChi = donHangHoanTat.stream()
                    .map(dh -> dh.getTongTienThanhToan() != null ? dh.getTongTienThanhToan() : java.math.BigDecimal.ZERO)
                    .reduce(java.math.BigDecimal.ZERO, (a, b) -> a.add(b));

            java.math.BigDecimal tongSoTienSanPham = donHangHoanTat.stream()
                    .map(dh -> dh.getTongTien() != null ? dh.getTongTien() : java.math.BigDecimal.ZERO)
                    .reduce(java.math.BigDecimal.ZERO, (a, b) -> a.add(b));

            java.math.BigDecimal tongTienGiamGia = donHangHoanTat.stream()
                    .map(dh -> dh.getSoTienGiamGia() != null ? dh.getSoTienGiamGia() : java.math.BigDecimal.ZERO)
                    .reduce(java.math.BigDecimal.ZERO, (a, b) -> a.add(b));

            long soDonHang = donHangHoanTat.size();

            // Xây dựng response
            Map<String, Object> result = new java.util.HashMap<>();

            // Thông tin người dùng
            Map<String, Object> thongTinNguoiDung = new java.util.HashMap<>();
            thongTinNguoiDung.put("id", nguoiDung.getId());
            thongTinNguoiDung.put("hoTen", nguoiDung.getHoTen());
            thongTinNguoiDung.put("email", nguoiDung.getEmail());
            thongTinNguoiDung.put("soDienThoai", nguoiDung.getSoDienThoai());
            thongTinNguoiDung.put("vaiTro", nguoiDung.getVaiTro() != null ? nguoiDung.getVaiTro().getTenVaiTro() : null);
            thongTinNguoiDung.put("dangHoatDong", nguoiDung.getDangHoatDong());
            thongTinNguoiDung.put("thoiGianTao", nguoiDung.getThoiGianTao());

            result.put("thongTinNguoiDung", thongTinNguoiDung);

            // Thống kê mua hàng
            Map<String, Object> thongKemuaHang = new java.util.HashMap<>();
            thongKemuaHang.put("soDonHangHoanTat", soDonHang);
            thongKemuaHang.put("soSanPhamDaMua", soSanPhamDaMua);
            thongKemuaHang.put("tongSoTienSanPham", tongSoTienSanPham);
            thongKemuaHang.put("tongTienGiamGia", tongTienGiamGia);
            thongKemuaHang.put("tongTienDaChi", tongTienDaChi);

            // Tính trung bình mỗi đơn hàng
            if (soDonHang > 0) {
                java.math.BigDecimal trungBinhMoiDonHang = tongTienDaChi.divide(java.math.BigDecimal.valueOf(soDonHang), 2, java.math.RoundingMode.HALF_UP);
                thongKemuaHang.put("trungBinhMoiDonHang", trungBinhMoiDonHang);
            }

            result.put("thongKemuaHang", thongKemuaHang);

            return ResponseEntity.ok(ApiResponse.ok("Thống kê người dùng", result));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Thống kê danh sách người dùng (khách hàng)
     * Hiển thị danh sách khách hàng với thông tin mua hàng
     */
    @GetMapping("/thong-ke/danh-sach")
    @PreAuthorize("hasAnyRole('ADMIN', 'SUPER_ADMIN')")
    public ResponseEntity<ApiResponse<Map<String, Object>>> thongKeDanhSachNguoiDung(
            @RequestParam(value = "vaiTro", required = false) String vaiTro,
            @RequestParam(value = "trang", defaultValue = "0") int trang,
            @RequestParam(value = "kichThuocTrang", defaultValue = "20") int kichThuocTrang) {
        try {
            Pageable pageable = PageRequest.of(trang, kichThuocTrang);

            // Lấy danh sách người dùng
            Page<NguoiDung> page = (vaiTro != null && !vaiTro.isBlank())
                    ? nguoiDungService.timKiem(null, vaiTro, pageable)
                    : nguoiDungService.timKiem(null, pageable);

            // Xây dựng danh sách thống kê
            var danhSachThongKe = page.getContent().stream()
                    .map(nguoiDung -> {
                        Map<String, Object> item = new java.util.HashMap<>();
                        item.put("id", nguoiDung.getId());
                        item.put("hoTen", nguoiDung.getHoTen());
                        item.put("email", nguoiDung.getEmail());
                        item.put("soDienThoai", nguoiDung.getSoDienThoai());
                        item.put("vaiTro", nguoiDung.getVaiTro() != null ? nguoiDung.getVaiTro().getTenVaiTro() : null);
                        item.put("dangHoatDong", nguoiDung.getDangHoatDong());

                        // Tính toán thống kê mua hàng
                        List<com.certainshop.entity.DonHang> donHangList = donHangRepository.findByNguoiDungId(nguoiDung.getId(), Sort.by(Sort.Direction.DESC, "thoiGianTao"));
                        List<com.certainshop.entity.DonHang> donHangHoanTat = donHangList.stream()
                                .filter(dh -> "HOAN_TAT".equals(dh.getTrangThaiDonHang()))
                                .toList();

                        long soSanPhamDaMua = donHangHoanTat.stream()
                                .flatMap(dh -> dh.getDanhSachChiTiet().stream())
                                .mapToLong(ct -> ct.getSoLuong() != null ? ct.getSoLuong() : 0)
                                .sum();

                        java.math.BigDecimal tongTienDaChi = donHangHoanTat.stream()
                                .map(dh -> dh.getTongTienThanhToan() != null ? dh.getTongTienThanhToan() : java.math.BigDecimal.ZERO)
                                .reduce(java.math.BigDecimal.ZERO, (a, b) -> a.add(b));

                        item.put("soDonHang", donHangHoanTat.size());
                        item.put("soSanPhamDaMua", soSanPhamDaMua);
                        item.put("tongTienDaChi", tongTienDaChi);

                        return item;
                    })
                    .toList();

            Map<String, Object> result = new java.util.HashMap<>();
            result.put("danhSach", danhSachThongKe);
            result.put("tongSo", page.getTotalElements());
            result.put("tongTrang", page.getTotalPages());
            result.put("trang", trang);

            return ResponseEntity.ok(ApiResponse.ok("Danh sách thống kê người dùng", result));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }
}
