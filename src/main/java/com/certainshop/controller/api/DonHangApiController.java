package com.certainshop.controller.api;

import com.certainshop.constant.TrangThaiDonHang;
import com.certainshop.dto.ApiResponse;
import com.certainshop.dto.DatHangDto;
import com.certainshop.entity.DonHang;
import com.certainshop.entity.NguoiDung;
import com.certainshop.repository.DonHangRepository;
import com.certainshop.repository.NguoiDungRepository;
import com.certainshop.service.DonHangService;
import com.certainshop.service.KhuyenMaiService;
import com.certainshop.util.VNPayUtil;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
public class DonHangApiController {

    private final DonHangService donHangService;
    private final DonHangRepository donHangRepository;
    private final NguoiDungRepository nguoiDungRepository;
    private final KhuyenMaiService khuyenMaiService;
    private final VNPayUtil vnPayUtil;

    // === KHÁCH HÀNG ===

    @PostMapping("/dat-hang")
    public ResponseEntity<?> datHang(@RequestBody DatHangDto dto, Authentication auth, HttpServletRequest request) {
        try {
            NguoiDung nd = layNguoiDung(auth);
            DonHang donHang = donHangService.datHangOnline(nd.getId(), dto);
            Map<String, Object> result = new LinkedHashMap<>(toDonHangSummary(donHang));
            // Nếu thanh toán VNPay, tạo URL và trả về cho FE redirect
            if ("VNPAY".equalsIgnoreCase(dto.getPhuongThucThanhToan())) {
                try {
                    String ip = VNPayUtil.layIpKhachHang(request);
                    String moTa = "Thanh toan don hang " + donHang.getMaDonHang();
                    long soTien = donHang.getTongTienThanhToan().longValue();
                    String urlThanhToan = vnPayUtil.taoUrlThanhToan(donHang.getMaDonHang(), soTien, moTa, ip);
                    result.put("urlThanhToan", urlThanhToan);
                } catch (Exception e) {
                    // VNPay URL generation failed but order is created - still return success
                    result.put("vnpayLoi", "Không tạo được link thanh toán: " + e.getMessage());
                }
            }
            return ResponseEntity.ok(ApiResponse.ok("Đặt hàng thành công", result));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(ApiResponse.loi("Lỗi hệ thống: " + e.getMessage()));
        }
    }

    @GetMapping("/don-hang/cua-toi")
    public ResponseEntity<?> donHangCuaToi(
            @RequestParam(defaultValue = "0") int trang,
            @RequestParam(defaultValue = "10") int kichThuocTrang,
            Authentication auth) {
        NguoiDung nd = layNguoiDung(auth);
        Pageable pageable = PageRequest.of(trang, kichThuocTrang);
        Page<DonHang> page = donHangRepository.findByNguoiDungIdOrderByThoiGianTaoDesc(nd.getId(), pageable);
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("danhSach", page.getContent().stream().map(this::toDonHangSummary).collect(Collectors.toList()));
        result.put("tongSoTrang", page.getTotalPages());
        result.put("tongSoBan", page.getTotalElements());
        result.put("trangHienTai", page.getNumber());
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/don-hang/cua-toi/{maDonHang}")
    public ResponseEntity<?> chiTietDonHangCuaToi(@PathVariable String maDonHang, Authentication auth) {
        NguoiDung nd = layNguoiDung(auth);
        return donHangRepository.findByMaDonHang(maDonHang)
                .filter(dh -> dh.getNguoiDung() != null && dh.getNguoiDung().getId().equals(nd.getId()))
                .map(dh -> ResponseEntity.ok(ApiResponse.ok(toDonHangDetail(dh))))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/don-hang/huy/{maDonHang}")
    public ResponseEntity<?> huyDonHang(@PathVariable String maDonHang, Authentication auth) {
        try {
            NguoiDung nd = layNguoiDung(auth);
            DonHang donHang = donHangRepository.findByMaDonHang(maDonHang)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
            if (donHang.getNguoiDung() == null || !donHang.getNguoiDung().getId().equals(nd.getId())) {
                return ResponseEntity.status(403).body(ApiResponse.loi("Không có quyền hủy đơn hàng này"));
            }
            if (!TrangThaiDonHang.CHO_XAC_NHAN.equals(donHang.getTrangThaiDonHang())) {
                return ResponseEntity.badRequest().body(ApiResponse.loi("Chỉ có thể hủy đơn hàng đang chờ xác nhận"));
            }
            donHangService.khachHuyDon(donHang.getId(), "Khách hàng tự hủy", nd.getId());
            return ResponseEntity.ok(ApiResponse.ok("Đã hủy đơn hàng thành công", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PostMapping("/don-hang/xac-nhan-nhan-hang/{maDonHang}")
    public ResponseEntity<?> xacNhanNhanHang(@PathVariable String maDonHang, Authentication auth) {
        try {
            NguoiDung nd = layNguoiDung(auth);
            DonHang donHang = donHangRepository.findByMaDonHang(maDonHang)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
            if (donHang.getNguoiDung() == null || !donHang.getNguoiDung().getId().equals(nd.getId())) {
                return ResponseEntity.status(403).body(ApiResponse.loi("Không có quyền"));
            }
            if (!TrangThaiDonHang.DANG_GIAO.equals(donHang.getTrangThaiDonHang())
                    && !TrangThaiDonHang.DA_XAC_NHAN.equals(donHang.getTrangThaiDonHang())) {
                return ResponseEntity.badRequest().body(ApiResponse.loi("Không thể xác nhận nhận hàng ở trạng thái này"));
            }
            donHangService.chuyenTrangThai(donHang.getId(), TrangThaiDonHang.HOAN_TAT, "Khách xác nhận đã nhận hàng", nd.getId());
            return ResponseEntity.ok(ApiResponse.ok("Xác nhận nhận hàng thành công", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    // === ADMIN/NHÂN VIÊN ===

    @GetMapping("/quan-ly/don-hang")
    public ResponseEntity<?> danhSachDonHangAdmin(
            @RequestParam(defaultValue = "0") int trang,
            @RequestParam(defaultValue = "15") int kichThuocTrang,
            @RequestParam(required = false) String trangThai,
            @RequestParam(required = false) String tuKhoa) {
        Pageable pageable = PageRequest.of(trang, kichThuocTrang, Sort.by("thoiGianTao").descending());
        Page<DonHang> page = donHangRepository.findDonHangAdmin(trangThai, tuKhoa, pageable);
        // NOTE: Removed ORDER BY from JPQL query to avoid duplication with Pageable sort
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("danhSach", page.getContent().stream().map(this::toDonHangSummary).collect(Collectors.toList()));
        result.put("tongSoTrang", page.getTotalPages());
        result.put("tongSoBan", page.getTotalElements());
        result.put("trangHienTai", page.getNumber());
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    @GetMapping("/quan-ly/don-hang/{maDonHang}")
    public ResponseEntity<?> chiTietDonHangAdmin(@PathVariable String maDonHang) {
        return donHangRepository.findByMaDonHang(maDonHang)
                .map(dh -> ResponseEntity.ok(ApiResponse.ok(toDonHangDetail(dh))))
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping("/quan-ly/don-hang/{maDonHang}/cap-nhat-trang-thai")
    public ResponseEntity<?> capNhatTrangThai(
            @PathVariable String maDonHang,
            @RequestBody Map<String, String> body,
            Authentication auth) {
        try {
            String trangThaiMoi = body.get("trangThai");
            String ghiChu = body.getOrDefault("ghiChu", "");
            NguoiDung nd = layNguoiDung(auth);
            DonHang donHang = donHangRepository.findByMaDonHang(maDonHang)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));
            donHangService.chuyenTrangThai(donHang.getId(), trangThaiMoi, ghiChu, nd.getId());
            return ResponseEntity.ok(ApiResponse.ok("Đã cập nhật trạng thái", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PostMapping("/khuyen-mai/kiem-tra")
    public ResponseEntity<?> kiemTraKhuyenMai(
            @RequestBody Map<String, Object> body) {
        try {
            String maKhuyenMai = body.get("maKhuyenMai").toString();
            BigDecimal tongTienHang = new BigDecimal(body.get("tongTienHang").toString());
            var km = khuyenMaiService.timTheoMa(maKhuyenMai)
                    .orElseThrow(() -> new RuntimeException("Mã khuyến mãi không tồn tại"));
            if (!km.laHopLe()) {
                return ResponseEntity.badRequest().body(ApiResponse.loi("Mã khuyến mãi không còn hiệu lực"));
            }
            if (km.getGiaTriDonHangToiThieu() != null && tongTienHang.compareTo(km.getGiaTriDonHangToiThieu()) < 0) {
                return ResponseEntity.badRequest().body(ApiResponse.loi(
                        "Đơn hàng cần tối thiểu " + km.getGiaTriDonHangToiThieu() + "đ để dùng mã này"));
            }
            BigDecimal soTienGiam = km.tinhSoTienGiam(tongTienHang);
            Map<String, Object> result = Map.of(
                    "id", km.getId(),
                    "maKhuyenMai", km.getMaKhuyenMai(),
                    "tenKhuyenMai", km.getTenKhuyenMai(),
                    "soTienGiam", soTienGiam
            );
            return ResponseEntity.ok(ApiResponse.ok("Mã hợp lệ", result));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    private NguoiDung layNguoiDung(Authentication auth) {
        return nguoiDungRepository.findByTenDangNhap(auth.getName())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
    }

    private Map<String, Object> toDonHangSummary(DonHang dh) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("id", dh.getId());
        m.put("maDonHang", dh.getMaDonHang());
        m.put("trangThaiDonHang", dh.getTrangThaiDonHang());
        m.put("loaiDonHang", dh.getLoaiDonHang());
        m.put("tongTienHang", dh.getTongTien());
        m.put("soTienGiamGia", dh.getSoTienGiamGia());
        m.put("phiVanChuyen", dh.getPhiVanChuyen());
        m.put("tongTienThanhToan", dh.getTongTienThanhToan());
        m.put("phuongThucThanhToan", dh.getPhuongThucThanhToan());
        m.put("daThanhToan", dh.getDaThanhToan());
        m.put("tenNguoiNhan", dh.getTenNguoiNhan());
        m.put("sdtNguoiNhan", dh.getSdtNguoiNhan());
        m.put("diaChiGiaoHang", dh.getDiaChiGiaoHang());
        m.put("thoiGianTao", dh.getThoiGianTao());
        m.put("soMatHang", dh.getDanhSachChiTiet() != null ? dh.getDanhSachChiTiet().size() : 0);
        if (dh.getNguoiDung() != null) {
            m.put("nguoiDung", Map.of("id", dh.getNguoiDung().getId(), "tenDangNhap", dh.getNguoiDung().getTenDangNhap(), "hoTen", dh.getNguoiDung().getHoTen() != null ? dh.getNguoiDung().getHoTen() : ""));
        }
        return m;
    }

    private Map<String, Object> toDonHangDetail(DonHang dh) {
        Map<String, Object> m = toDonHangSummary(dh);
        if (dh.getDanhSachChiTiet() != null) {
            m.put("danhSachChiTiet", dh.getDanhSachChiTiet().stream().map(ct -> {
                Map<String, Object> ctMap = new LinkedHashMap<>();
                ctMap.put("id", ct.getId());
                ctMap.put("soLuong", ct.getSoLuong());
                ctMap.put("giaTaiThoiDiemMua", ct.getGiaTaiThoiDiemMua());
                ctMap.put("thanhTien", ct.getThanhTien());
                if (ct.getBienThe() != null) {
                    var bt = ct.getBienThe();
                    Map<String, Object> btMap = new LinkedHashMap<>();
                    btMap.put("id", bt.getId());
                    btMap.put("anhChinh", bt.getAnhChinh());
                    if (bt.getSanPham() != null) {
                        btMap.put("tenSanPham", bt.getSanPham().getTenSanPham());
                        btMap.put("duongDanSanPham", bt.getSanPham().getDuongDan());
                    }
                    if (bt.getKichThuoc() != null) btMap.put("kichThuoc", bt.getKichThuoc().getKichCo());
                    if (bt.getMauSac() != null) btMap.put("tenMauSac", bt.getMauSac().getTenMau());
                    ctMap.put("bienThe", btMap);
                }
                return ctMap;
            }).collect(Collectors.toList()));
        }
        if (dh.getLichSuTrangThai() != null) {
            m.put("lichSuTrangThai", dh.getLichSuTrangThai().stream().map(ls -> {
                Map<String, Object> lsMap = new LinkedHashMap<>();
                lsMap.put("trangThaiCu", ls.getTrangThaiCu() != null ? ls.getTrangThaiCu() : "");
                lsMap.put("trangThaiMoi", ls.getTrangThaiMoi() != null ? ls.getTrangThaiMoi() : "");
                lsMap.put("trangThai", ls.getTrangThaiMoi() != null ? ls.getTrangThaiMoi() : "");
                lsMap.put("ghiChu", ls.getGhiChu() != null ? ls.getGhiChu() : "");
                lsMap.put("thoiGian", ls.getThoiGian() != null ? ls.getThoiGian().toString() : "");
                lsMap.put("thoiGianTao", ls.getThoiGian() != null ? ls.getThoiGian().toString() : "");
                return lsMap;
            }).collect(Collectors.toList()));
        }
        return m;
    }
}
