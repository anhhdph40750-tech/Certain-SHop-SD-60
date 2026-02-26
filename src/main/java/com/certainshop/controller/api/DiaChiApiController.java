package com.certainshop.controller.api;

import com.certainshop.service.GHNApiService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Map;

@RestController
@RequestMapping("/api/dia-chi")
@RequiredArgsConstructor
public class DiaChiApiController {

    private final GHNApiService ghnApiService;

    @GetMapping("/tinh-thanh")
    public ResponseEntity<?> layDanhSachTinhThanh() {
        try {
            return ResponseEntity.ok(ghnApiService.layDanhSachTinh());
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("loi", e.getMessage()));
        }
    }

    @GetMapping("/quan-huyen")
    public ResponseEntity<?> layDanhSachQuanHuyen(@RequestParam int maTinh) {
        try {
            return ResponseEntity.ok(ghnApiService.layDanhSachHuyen(maTinh));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("loi", e.getMessage()));
        }
    }

    @GetMapping("/phuong-xa")
    public ResponseEntity<?> layDanhSachPhuongXa(@RequestParam int maHuyen) {
        try {
            return ResponseEntity.ok(ghnApiService.layDanhSachXa(maHuyen));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("loi", e.getMessage()));
        }
    }

    @PostMapping("/tinh-phi-ship")
    public ResponseEntity<?> tinhPhiVanChuyen(
            @RequestParam int maHuyen,
            @RequestParam String maXa,
            @RequestParam(defaultValue = "0") int trongLuong) {
        try {
            BigDecimal phi = ghnApiService.tinhPhiVanChuyen(maHuyen, maXa, trongLuong);
            return ResponseEntity.ok(Map.of("phiVanChuyen", phi));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("loi", e.getMessage()));
        }
    }
}
