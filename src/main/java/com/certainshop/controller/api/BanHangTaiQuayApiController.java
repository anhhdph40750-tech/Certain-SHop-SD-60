package com.certainshop.controller.api;

import com.certainshop.constant.TrangThaiDonHang;
import com.certainshop.dto.ApiResponse;
import com.certainshop.entity.*;
import com.certainshop.repository.*;
import com.certainshop.service.DonHangService;
import com.certainshop.service.KhuyenMaiService;
import com.certainshop.service.MailService;
import com.certainshop.service.VoucherService;
import com.certainshop.util.NguoiDungHienTai;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;

@RestController
@RequestMapping("/api/quan-ly/ban-hang")
@RequiredArgsConstructor
@PreAuthorize("hasAnyRole('ADMIN', 'NHAN_VIEN', 'SUPER_ADMIN')")
public class BanHangTaiQuayApiController {

    @Autowired
    private DonHangService donHangService;
    @Autowired
    private DonHangRepository donHangRepository;
    @Autowired
    private BienTheRepository bienTheRepository;
    @Autowired
    private NguoiDungHienTai nguoiDungHienTai;
    @Autowired
    private NguoiDungRepository nguoiDungRepository;
    @Autowired
    private KhuyenMaiRepository khuyenMaiRepository;
    @Autowired
    private VoucherService voucherService;
    @Autowired
    private MailService mailService;

    /**
     * Lấy danh sách hóa đơn chờ (tất cả nhân viên)
     */
    @GetMapping("/hoa-don-cho")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> danhSachHoaDonCho() {
        List<DonHang> ds = donHangRepository.findHoaDonCho();
        List<Map<String, Object>> result = new ArrayList<>();
        for (DonHang dh : ds) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", dh.getId());
            item.put("maDonHang", dh.getMaDonHang());
            item.put("tongTien", dh.getTongTien());
            item.put("tongTienThanhToan", dh.getTongTienThanhToan());
            item.put("soTienGiamGia", dh.getSoTienGiamGia());
            item.put("soMatHang", dh.getDanhSachChiTiet() != null ? dh.getDanhSachChiTiet().size() : 0);
            item.put("thoiGianTao", dh.getThoiGianTao());
            item.put("tenNguoiNhan", dh.getTenNguoiNhan());
            result.add(item);
        }
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    /**
     * Tạo hóa đơn chờ mới
     */
    @PostMapping("/tao-hoa-don")
    public ResponseEntity<ApiResponse<Map<String, Object>>> taoHoaDon() {
        try {
            NguoiDung nv = nguoiDungHienTai.layBatBuoc();
            DonHang hoaDon = donHangService.taoHoaDonCho(nv);
            Map<String, Object> res = new HashMap<>();
            res.put("id", hoaDon.getId());
            res.put("maDonHang", hoaDon.getMaDonHang());
            return ResponseEntity.ok(ApiResponse.ok("Đã tạo hóa đơn mới", res));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Lấy chi tiết hóa đơn chờ
     */
    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<Map<String, Object>>> chiTietHoaDon(@PathVariable("id") Long id) {
        try {
            DonHang hoaDon = donHangRepository.findById(id)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy hóa đơn"));

            Map<String, Object> res = new HashMap<>();
            res.put("id", hoaDon.getId());
            res.put("maDonHang", hoaDon.getMaDonHang());
            res.put("trangThai", hoaDon.getTrangThaiDonHang());
            res.put("tongTien", hoaDon.getTongTien());
            res.put("soTienGiamGia", hoaDon.getSoTienGiamGia());
            res.put("tongTienThanhToan", hoaDon.getTongTienThanhToan());
            res.put("tenNguoiNhan", hoaDon.getTenNguoiNhan());
            res.put("sdtNguoiNhan", hoaDon.getSdtNguoiNhan());

            // Khuyến mãi đang áp dụng
            if (hoaDon.getKhuyenMai() != null) {
                Map<String, Object> km = new HashMap<>();
                km.put("id", hoaDon.getKhuyenMai().getId());
                km.put("maKhuyenMai", hoaDon.getKhuyenMai().getMaKhuyenMai());
                km.put("tenKhuyenMai", hoaDon.getKhuyenMai().getTenKhuyenMai());
                res.put("khuyenMai", km);
            }

            // Khách hàng
            if (hoaDon.getNguoiDung() != null) {
                Map<String, Object> kh = new HashMap<>();
                kh.put("id", hoaDon.getNguoiDung().getId());
                kh.put("hoTen", hoaDon.getNguoiDung().getHoTen());
                kh.put("soDienThoai", hoaDon.getNguoiDung().getSoDienThoai());
                res.put("khachHang", kh);
            }

            List<Map<String, Object>> chiTietList = new ArrayList<>();
            if (hoaDon.getDanhSachChiTiet() != null) {
                for (ChiTietDonHang ct : hoaDon.getDanhSachChiTiet()) {
                    Map<String, Object> item = new HashMap<>();
                    item.put("id", ct.getId());
                    item.put("bienTheId", ct.getBienThe().getId());
                    item.put("tenSanPham", ct.getBienThe().getSanPham().getTenSanPham());
                    item.put("kichThuoc", ct.getBienThe().getKichThuoc() != null ? ct.getBienThe().getKichThuoc().getKichCo() : "");
                    item.put("mauSac", ct.getBienThe().getMauSac() != null ? ct.getBienThe().getMauSac().getTenMau() : "");
                    item.put("soLuong", ct.getSoLuong());
                    item.put("donGia", ct.getGiaTaiThoiDiemMua());
                    item.put("thanhTien", ct.getThanhTien());
                    item.put("anhUrl", ct.getBienThe().getAnhChinh());
                    item.put("soLuongTon", ct.getBienThe().getSoLuongTon());
                    chiTietList.add(item);
                }
            }
            res.put("chiTiet", chiTietList);

            return ResponseEntity.ok(ApiResponse.ok(res));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Tìm sản phẩm cho quầy bán
     */
    @GetMapping("/tim-san-pham")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> timSanPham(@RequestParam("q") String q) {
        List<BienThe> bienTheList = bienTheRepository.timKiemChoQuay(q);
        List<Map<String, Object>> result = new ArrayList<>();
        for (BienThe bt : bienTheList) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", bt.getId());
            item.put("tenSanPham", bt.getSanPham().getTenSanPham());
            item.put("kichThuoc", bt.getKichThuoc() != null ? bt.getKichThuoc().getKichCo() : "");
            item.put("mauSac", bt.getMauSac() != null ? bt.getMauSac().getTenMau() : "");
            item.put("maHex", bt.getMauSac() != null ? bt.getMauSac().getMaHex() : "");
            item.put("giaBan", bt.getGia());
            item.put("soLuongTon", bt.getSoLuongTon());
            item.put("anhUrl", bt.getAnhChinh());
            result.add(item);
        }
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    /**
     * Thêm sản phẩm vào hóa đơn
     */
    @PostMapping("/{hoaDonId}/them-san-pham")
    public ResponseEntity<ApiResponse<Void>> themSanPham(
            @PathVariable("hoaDonId") Long hoaDonId,
            @RequestParam("bienTheId") Long bienTheId,
            @RequestParam(value = "soLuong", defaultValue = "1") int soLuong) {
        try {
            donHangService.themSanPhamVaoHoaDonTaiQuay(hoaDonId, bienTheId, soLuong);
            return ResponseEntity.ok(ApiResponse.ok("Đã thêm sản phẩm", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Cập nhật số lượng trong hóa đơn
     */
    @PostMapping("/chi-tiet/{chiTietId}/cap-nhat")
    public ResponseEntity<ApiResponse<Void>> capNhatSoLuong(
            @PathVariable("chiTietId") Long chiTietId,
            @RequestParam("soLuong") int soLuong) {
        try {
            NguoiDung nv = nguoiDungHienTai.layBatBuoc();
            donHangService.capNhatSoLuongTaiQuay(chiTietId, soLuong, nv.getId());
            return ResponseEntity.ok(ApiResponse.ok("Đã cập nhật", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Xóa sản phẩm khỏi hóa đơn
     */
    @PostMapping("/chi-tiet/{chiTietId}/xoa")
    public ResponseEntity<ApiResponse<Void>> xoaSanPham(@PathVariable("chiTietId") Long chiTietId) {
        try {
            NguoiDung nv = nguoiDungHienTai.layBatBuoc();
            donHangService.xoaChiTietTaiQuay(chiTietId, nv.getId());
            return ResponseEntity.ok(ApiResponse.ok("Đã xóa", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Áp dụng voucher cho hóa đơn
     */
    @PostMapping("/{hoaDonId}/ap-voucher")
    public ResponseEntity<ApiResponse<Map<String, Object>>> apVoucher(
            @PathVariable("hoaDonId") Long hoaDonId,
            @RequestParam("maVoucher") String maVoucher) {
        try {
            DonHang hoaDon = donHangRepository.findById(hoaDonId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy hóa đơn"));

            // Ưu tiên tìm trong bảng Voucher (hệ thống mới)
            BigDecimal tongTruocGiam = hoaDon.getDanhSachChiTiet().stream()
                    .map(ct -> ct.getGiaTaiThoiDiemMua().multiply(BigDecimal.valueOf(ct.getSoLuong())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            BigDecimal soTienGiam = voucherService.tinhGiaTriGiam(maVoucher, tongTruocGiam);
            if (soTienGiam.compareTo(BigDecimal.ZERO) > 0) {
                // Áp dụng Voucher qua VoucherService
                Voucher voucher = voucherService.timTheoMa(maVoucher).orElse(null);
                hoaDon.setVoucher(voucher);
                hoaDon.setKhuyenMai(null); // xóa KhuyenMai cũ nếu có
                hoaDon.setSoTienGiamGia(soTienGiam);
                BigDecimal tongThanhToan = tongTruocGiam.subtract(soTienGiam);
                if (tongThanhToan.compareTo(BigDecimal.ZERO) < 0) tongThanhToan = BigDecimal.ZERO;
                hoaDon.setTongTienThanhToan(tongThanhToan);
                donHangRepository.save(hoaDon);

                // Tăng số lần sử dụng voucher
                voucherService.tangSoLanSuDung(maVoucher);

                Map<String, Object> result = new HashMap<>();
                result.put("soTienGiam", soTienGiam);
                result.put("tongSauGiam", tongThanhToan);
                return ResponseEntity.ok(ApiResponse.ok("Áp dụng voucher thành công", result));
            }

            // Fallback: tìm trong KhuyenMai
            KhuyenMai km = khuyenMaiRepository.findByMaKhuyenMai(maVoucher)
                    .orElseThrow(() -> new RuntimeException("Mã voucher không tồn tại"));

            if (!km.laHopLe()) {
                return ResponseEntity.badRequest().body(ApiResponse.loi("Voucher không hợp lệ hoặc đã hết hạn"));
            }

            BigDecimal kmGiam = km.tinhSoTienGiam(tongTruocGiam);
            donHangService.apVoucherVaoHoaDonTaiQuay(hoaDonId, km.getId(), kmGiam);

            Map<String, Object> result = new HashMap<>();
            result.put("soTienGiam", kmGiam);
            result.put("tongSauGiam", tongTruocGiam.subtract(kmGiam));
            return ResponseEntity.ok(ApiResponse.ok("Áp dụng voucher thành công", result));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Xóa voucher khỏi hóa đơn
     */
    @PostMapping("/{hoaDonId}/xoa-voucher")
    public ResponseEntity<ApiResponse<Void>> xoaVoucher(@PathVariable("hoaDonId") Long hoaDonId) {
        try {
            donHangService.xoaVoucherKhoiHoaDonTaiQuay(hoaDonId);
            return ResponseEntity.ok(ApiResponse.ok("Đã xóa voucher", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Thanh toán hóa đơn tại quầy
     */
    @PostMapping("/{hoaDonId}/thanh-toan")
    public ResponseEntity<ApiResponse<Map<String, Object>>> thanhToan(
            @PathVariable("hoaDonId") Long hoaDonId,
            @RequestBody Map<String, Object> body) {
        try {
            NguoiDung nv = nguoiDungHienTai.layBatBuoc();

            String phuongThucThanhToan = (String) body.getOrDefault("phuongThucThanhToan", "TIEN_MAT");
            Long khachHangId = body.get("khachHangId") != null
                    ? Long.valueOf(body.get("khachHangId").toString()) : null;
            String tenKhach = (String) body.getOrDefault("tenKhach", "Khách lẻ");
            String sdtKhach = (String) body.getOrDefault("sdtKhach", "");

            NguoiDung khachHang = null;
            if (khachHangId != null) {
                khachHang = nguoiDungRepository.findById(khachHangId).orElse(null);
            }

            DonHang donHang = donHangService.thanhToanTaiQuay(
                    hoaDonId, phuongThucThanhToan, null, nv,
                    khachHang, tenKhach, sdtKhach, null);

            // Gửi biên lai qua email nếu có
            String emailBienlai = (String) body.get("emailBienlai");
            String emailGui = (emailBienlai != null && !emailBienlai.isBlank())
                    ? emailBienlai
                    : (khachHang != null ? khachHang.getEmail() : null);
            if (emailGui != null && !emailGui.isBlank()) {
                String tenGui = (khachHang != null) ? khachHang.getHoTen() : tenKhach;
                mailService.guiMailBienlaiTaiQuay(
                        emailGui, tenGui, donHang.getMaDonHang(),
                        donHang.getTongTienThanhToan(),
                        donHang.getSoTienGiamGia(),
                        donHang.getPhuongThucThanhToan());
            }

            Map<String, Object> res = new HashMap<>();
            res.put("id", donHang.getId());
            res.put("maDonHang", donHang.getMaDonHang());
            res.put("tongTienThanhToan", donHang.getTongTienThanhToan());
            res.put("phuongThucThanhToan", donHang.getPhuongThucThanhToan());

            return ResponseEntity.ok(ApiResponse.ok("Thanh toán thành công", res));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Hủy hóa đơn chờ
     */
    @PostMapping("/{hoaDonId}/huy")
    public ResponseEntity<ApiResponse<Void>> huyHoaDon(@PathVariable("hoaDonId") Long hoaDonId) {
        try {
            NguoiDung nv = nguoiDungHienTai.layBatBuoc();
            donHangService.huyHoaDonCho(hoaDonId, nv);
            return ResponseEntity.ok(ApiResponse.ok("Đã hủy hóa đơn", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Tìm kiếm khách hàng
     */
    @GetMapping("/tim-khach-hang")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> timKhachHang(@RequestParam("q") String q) {
        List<NguoiDung> danhSach = nguoiDungRepository.findByVaiTro("KHACH_HANG");
        List<Map<String, Object>> result = new ArrayList<>();
        String qLower = q.toLowerCase();
        for (NguoiDung nd : danhSach) {
            boolean match = (nd.getHoTen() != null && nd.getHoTen().toLowerCase().contains(qLower))
                    || (nd.getSoDienThoai() != null && nd.getSoDienThoai().contains(q))
                    || (nd.getEmail() != null && nd.getEmail().toLowerCase().contains(qLower));
            if (match) {
                Map<String, Object> item = new HashMap<>();
                item.put("id", nd.getId());
                item.put("hoTen", nd.getHoTen());
                item.put("soDienThoai", nd.getSoDienThoai());
                item.put("email", nd.getEmail());
                result.add(item);
                if (result.size() >= 10) break; // Limit results
            }
        }
        return ResponseEntity.ok(ApiResponse.ok(result));
    }
}
