package com.certainshop.controller.api;

import com.certainshop.dto.ApiResponse;
import com.certainshop.entity.GioHang;
import com.certainshop.entity.GioHangChiTiet;
import com.certainshop.entity.NguoiDung;
import com.certainshop.repository.NguoiDungRepository;
import com.certainshop.service.GioHangService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/gio-hang")
@RequiredArgsConstructor
public class GioHangApiController {

    private final GioHangService gioHangService;
    private final NguoiDungRepository nguoiDungRepository;

    @GetMapping
    public ResponseEntity<?> layGioHang(Authentication auth) {
        NguoiDung nd = layNguoiDung(auth);
        GioHang gioHang = gioHangService.layHoacTaoGioHang(nd);
        return ResponseEntity.ok(ApiResponse.ok(toGioHangResponse(gioHang)));
    }

    @PostMapping("/them")
    public ResponseEntity<?> themVaoGioHang(
            @RequestBody Map<String, Object> body,
            Authentication auth) {
        try {
            NguoiDung nd = layNguoiDung(auth);
            // Quản lý/Nhân viên không dùng giỏ hàng - họp lệ truy cập qua ban hang tại quầy
            String vaiTro = nd.getVaiTro() != null ? nd.getVaiTro().getTenVaiTro() : "";
            boolean isKhachHang = vaiTro.toLowerCase().contains("khach") || vaiTro.toLowerCase().contains("khách");
            if (!isKhachHang) {
                return ResponseEntity.badRequest().body(ApiResponse.loi(
                        "Quản lý/Nhân viên không sử dụng giỏ hàng."));
            }
            Long bienTheId = Long.valueOf(body.get("bienTheId").toString());
            int soLuong = Integer.parseInt(body.getOrDefault("soLuong", 1).toString());
            gioHangService.themVaoGioHang(nd, bienTheId, soLuong);
            GioHang gioHang = gioHangService.layHoacTaoGioHang(nd);
            return ResponseEntity.ok(ApiResponse.ok("Đã thêm vào giỏ hàng", toGioHangResponse(gioHang)));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @PutMapping("/cap-nhat/{chiTietId}")
    public ResponseEntity<?> capNhatSoLuong(
            @PathVariable Long chiTietId,
            @RequestBody Map<String, Object> body,
            Authentication auth) {
        try {
            int soLuong = Integer.parseInt(body.get("soLuong").toString());
            gioHangService.capNhatSoLuong(chiTietId, soLuong);
            NguoiDung nd = layNguoiDung(auth);
            GioHang gioHang = gioHangService.layHoacTaoGioHang(nd);
            return ResponseEntity.ok(ApiResponse.ok("Đã cập nhật", toGioHangResponse(gioHang)));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @DeleteMapping("/xoa/{chiTietId}")
    public ResponseEntity<?> xoaKhoiGioHang(@PathVariable Long chiTietId, Authentication auth) {
        try {
            gioHangService.xoaKhoiGioHang(chiTietId);
            NguoiDung nd = layNguoiDung(auth);
            GioHang gioHang = gioHangService.layHoacTaoGioHang(nd);
            return ResponseEntity.ok(ApiResponse.ok("Đã xóa", toGioHangResponse(gioHang)));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        }
    }

    @DeleteMapping("/xoa-het")
    public ResponseEntity<?> xoaHetGioHang(Authentication auth) {
        NguoiDung nd = layNguoiDung(auth);
        GioHang gioHang = gioHangService.layHoacTaoGioHang(nd);
        gioHangService.xoaHetGioHang(gioHang.getId());
        return ResponseEntity.ok(ApiResponse.ok("Đã xóa giỏ hàng"));
    }

    private NguoiDung layNguoiDung(Authentication auth) {
        return nguoiDungRepository.findByTenDangNhap(auth.getName())
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
    }

    private Map<String, Object> toGioHangResponse(GioHang gioHang) {
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("id", gioHang.getId());

        List<Map<String, Object>> items = gioHang.getDanhSachChiTiet() != null ?
                gioHang.getDanhSachChiTiet().stream().map(this::toChiTietResponse).collect(Collectors.toList()) :
                List.of();

        result.put("danhSachChiTiet", items);
        result.put("soLuongSanPham", items.size());

        BigDecimal tongTien = items.stream()
                .map(i -> (BigDecimal) i.get("thanhTien"))
                .reduce(BigDecimal.ZERO, BigDecimal::add);
        result.put("tongTien", tongTien);

        return result;
    }

    private Map<String, Object> toChiTietResponse(GioHangChiTiet ct) {
        Map<String, Object> m = new LinkedHashMap<>();
        m.put("id", ct.getId());
        m.put("soLuong", ct.getSoLuong());
        m.put("donGia", ct.getDonGia());
        m.put("thanhTien", ct.getThanhTien());

        if (ct.getBienThe() != null) {
            var bt = ct.getBienThe();
            Map<String, Object> btMap = new LinkedHashMap<>();
            btMap.put("id", bt.getId());
            btMap.put("soLuongTon", bt.getSoLuongTon());
            btMap.put("anhChinh", bt.getAnhChinh());
            if (bt.getSanPham() != null) {
                btMap.put("tenSanPham", bt.getSanPham().getTenSanPham());
                btMap.put("duongDanSanPham", bt.getSanPham().getDuongDan());
            }
            if (bt.getKichThuoc() != null) btMap.put("kichThuoc", bt.getKichThuoc().getKichCo());
            if (bt.getMauSac() != null) {
                btMap.put("tenMauSac", bt.getMauSac().getTenMau());
                btMap.put("maHexMauSac", bt.getMauSac().getMaHex());
            }
            m.put("bienThe", btMap);
        }
        return m;
    }
}
