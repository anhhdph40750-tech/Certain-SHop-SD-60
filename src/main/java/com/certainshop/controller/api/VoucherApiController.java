package com.certainshop.controller.api;

import com.certainshop.dto.ApiResponse;
import com.certainshop.entity.Voucher;
import com.certainshop.service.VoucherService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/voucher")
@RequiredArgsConstructor
public class VoucherApiController {

    private final VoucherService voucherService;

    /**
     * Danh sách voucher hoạt động (public - for customers to see active vouchers only)
     */
    @GetMapping("/hoat-dong")
    public ResponseEntity<ApiResponse<List<Voucher>>> danhSachVoucher() {
        List<Voucher> vouchers = voucherService.danhSachVoucherHoatDong();
        return ResponseEntity.ok(ApiResponse.ok("Danh sách voucher", vouchers));
    }

    /**
     * Admin/Staff: Danh sách TẤT CẢ vouchers (bao gồm hết hạn, inactive)
     */
    @GetMapping("/all")
    @PreAuthorize("hasAnyRole('ADMIN', 'NHAN_VIEN')")
    public ResponseEntity<ApiResponse<List<Voucher>>> danhSachTatCa() {
        List<Voucher> vouchers = voucherService.danhSachChoAdmin();
        return ResponseEntity.ok(ApiResponse.ok("Danh sách tất cả vouchers", vouchers));
    }

    /**
     * Admin/Staff: Tạo voucher mới
     */
    @PostMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'NHAN_VIEN')")
    public ResponseEntity<ApiResponse<Voucher>> taoVoucher(@RequestBody Voucher voucher) {
        try {
            Voucher created = voucherService.taoVoucher(voucher);
            return ResponseEntity.ok(ApiResponse.ok("Tạo voucher thành công", created));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Admin/Staff: Cập nhật voucher
     */
    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'NHAN_VIEN')")
    public ResponseEntity<ApiResponse<Voucher>> capNhatVoucher(
            @PathVariable("id") Long id, @RequestBody Voucher updates) {
        try {
            Voucher updated = voucherService.capNhatVoucher(id, updates);
            return ResponseEntity.ok(ApiResponse.ok("Cập nhật voucher thành công", updated));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Admin/Staff: Xóa voucher (soft delete)
     */
    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'NHAN_VIEN')")
    public ResponseEntity<ApiResponse<Void>> xoaVoucher(@PathVariable("id") Long id) {
        try {
            voucherService.xoaVoucher(id);
            return ResponseEntity.ok(ApiResponse.ok("Xóa voucher thành công", null));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    /**
     * Tính giá trị giảm cho voucher (validate & calculate)
     * @param maVoucher Mã voucher
     * @param giaTriDonHang Giá trị đơn hàng
     */
    @GetMapping("/tinh-giam")
    public ResponseEntity<ApiResponse<Map<String, Object>>> tinhGiaTriGiam(
            @RequestParam("maVoucher") String maVoucher,
            @RequestParam("giaTriDonHang") BigDecimal giaTriDonHang) {
        BigDecimal giaTriGiam = voucherService.tinhGiaTriGiam(maVoucher, giaTriDonHang);
        
        Map<String, Object> result = new HashMap<>();
        result.put("maVoucher", maVoucher);
        result.put("giaTriGiam", giaTriGiam);
        result.put("giaTriSauGiam", giaTriDonHang.subtract(giaTriGiam));
        result.put("hopLe", giaTriGiam.compareTo(BigDecimal.ZERO) > 0);
        
        return ResponseEntity.ok(ApiResponse.ok(result));
    }

    /**
     * Lấy danh sách TẤT CẢ voucher (kèm thông tin đủ điều kiện) cho giá trị đơn hàng
     * Hiển thị tất cả nhưng chỉ cho chọn các voucher đủ điều kiện
     */
    @GetMapping("/danh-sach-cho-don-hang")
    public ResponseEntity<ApiResponse<List<Map<String, Object>>>> danhSachVoucherChoDonHang(
            @RequestParam(value = "tongTienHang", defaultValue = "0") BigDecimal tongTienHang) {
        // Lấy TẤT CẢ voucher có trangThai=true (kể cả hết hạn, hết lượt)
        List<Voucher> allVouchers = voucherService.danhSachTatCaVoucher();

        List<Map<String, Object>> result = new ArrayList<>();
        for (Voucher v : allVouchers) {
            Map<String, Object> item = new HashMap<>();
            item.put("id", v.getId());
            item.put("maVoucher", v.getMaVoucher());
            item.put("moTa", v.getMoTa());
            item.put("loaiGiam", v.getLoaiGiam());
            item.put("giaTriGiam", v.getGiaTriGiam());
            item.put("giaTriGiamToiDa", v.getGiaTriGiamToiDa());
            item.put("giaTriToiThieu", v.getGiaTriToiThieu());
            item.put("ngayBatDau", v.getNgayBatDau());
            item.put("ngayKetThuc", v.getNgayKetThuc());
            item.put("soLuongSuDung", v.getSoLuongSuDung());
            item.put("soLuongToiDa", v.getSoLuongToiDa());

            // Check đủ điều kiện
            boolean duDieuKien = v.isValid();
            String lyDoKhongDuDieuKien = null;
            BigDecimal soTienGiam = BigDecimal.ZERO;

            if (duDieuKien) {
                // Kiểm tra giá trị đơn hàng tối thiểu
                if (v.getGiaTriToiThieu() != null && tongTienHang.compareTo(v.getGiaTriToiThieu()) < 0) {
                    duDieuKien = false;
                    lyDoKhongDuDieuKien = "Đơn hàng tối thiểu " + v.getGiaTriToiThieu().longValue() + "đ";
                } else {
                    soTienGiam = v.tinhGiaTriGiam(tongTienHang);
                }
            } else {
                if (v.getSoLuongToiDa() != null && v.getSoLuongSuDung() >= v.getSoLuongToiDa()) {
                    lyDoKhongDuDieuKien = "Đã hết lượt sử dụng";
                } else {
                    lyDoKhongDuDieuKien = "Voucher đã hết hạn hoặc không hoạt động";
                }
            }

            item.put("duDieuKien", duDieuKien);
            item.put("lyDoKhongDuDieuKien", lyDoKhongDuDieuKien);
            item.put("soTienGiam", soTienGiam);
            result.add(item);
        }

        return ResponseEntity.ok(ApiResponse.ok(result));
    }
}
