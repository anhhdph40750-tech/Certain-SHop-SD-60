package com.certainshop.controller.api;

import com.certainshop.entity.CaBanHang;
import com.certainshop.entity.NguoiDung;
import com.certainshop.service.CaBanHangService;
import com.certainshop.util.NguoiDungHienTai;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.Map;

@RestController
@RequestMapping("/api/quan-ly/ca-ban-hang")
@RequiredArgsConstructor
public class CaBanHangApiController {

    private final CaBanHangService caBanHangService;
    private final NguoiDungHienTai nguoiDungHienTai;

    @GetMapping("/hien-tai")
    public ResponseEntity<?> layCaHienTai() {
        NguoiDung nv = nguoiDungHienTai.layBatBuoc();
        return caBanHangService.layCaHienTai(nv.getId())
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.noContent().build());
    }

    @PostMapping("/bat-dau")
    public ResponseEntity<?> batDauCa(@RequestBody Map<String, BigDecimal> body) {
        try {
            NguoiDung nv = nguoiDungHienTai.layBatBuoc();
            BigDecimal tienDauCa = body.get("tienDauCa");
            CaBanHang ca = caBanHangService.batDauCa(nv, tienDauCa);
            return ResponseEntity.ok(ca);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
        }
    }

    @PostMapping("/{id}/ket-thuc")
    public ResponseEntity<?> ketThucCa(@PathVariable Long id, @RequestBody Map<String, Object> body) {
        try {
            BigDecimal tienThucTe = new BigDecimal(body.get("tienThucTe").toString());
            String ghiChu = (String) body.get("ghiChu");
            CaBanHang ca = caBanHangService.ketThucCa(id, tienThucTe, ghiChu);
            return ResponseEntity.ok(ca);
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(Map.of("message", e.getMessage()));
        }
    }
}
