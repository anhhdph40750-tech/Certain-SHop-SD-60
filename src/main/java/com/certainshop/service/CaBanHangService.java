package com.certainshop.service;

import com.certainshop.entity.CaBanHang;
import com.certainshop.entity.NguoiDung;
import com.certainshop.repository.CaBanHangRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class CaBanHangService {

    private final CaBanHangRepository caBanHangRepository;

    public CaBanHang batDauCa(NguoiDung nhanVien, BigDecimal tienDauCa) {
        Optional<CaBanHang> caHienTai = caBanHangRepository.findCaDangMo(nhanVien.getId());
        if (caHienTai.isPresent()) {
            throw new RuntimeException("Nhân viên này đang có một ca làm việc chưa kết thúc");
        }

        CaBanHang caNew = CaBanHang.builder()
                .nhanVien(nhanVien)
                .tienDauCa(tienDauCa != null ? tienDauCa : BigDecimal.ZERO)
                .thoiGianBatDau(LocalDateTime.now())
                .trangThai("DANG_MO")
                .build();

        return caBanHangRepository.save(caNew);
    }

    public CaBanHang ketThucCa(Long caId, BigDecimal tienThucTe, String ghiChu) {
        CaBanHang ca = caBanHangRepository.findById(caId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy ca làm việc"));

        if (!"DANG_MO".equals(ca.getTrangThai())) {
            throw new RuntimeException("Ca làm việc đã kết thúc trước đó");
        }

        // Tính toán doanh thu trong ca từ đơn hàng
        // Trong thực tế, bạn có thể link DonHang với CaBanHangId, hoặc query theo NhanVien + Time
        // Ở đây giả sử query theo NhanVien và Thời gian
        
        // Cập nhật thông tin và kết thúc
        ca.setThoiGianKetThuc(LocalDateTime.now());
        ca.setTienThucTe(tienThucTe != null ? tienThucTe : BigDecimal.ZERO);
        ca.setGhiChu(ghiChu);
        
        BigDecimal tienDuKien = ca.getTienDauCa().add(ca.getTienMatTrongCa());
        ca.setChenhLech(ca.getTienThucTe().subtract(tienDuKien));
        ca.setTrangThai("DA_KET_THUC");

        return caBanHangRepository.save(ca);
    }

    public void capNhatDoanhThuCa(NguoiDung nhanVien, BigDecimal tienMat, BigDecimal tienChuyenKhoan) {
        caBanHangRepository.findCaDangMo(nhanVien.getId()).ifPresent(ca -> {
            ca.setTienMatTrongCa(ca.getTienMatTrongCa().add(tienMat));
            ca.setTienChuyenKhoanTrongCa(ca.getTienChuyenKhoanTrongCa().add(tienChuyenKhoan));
            ca.setTongDoanhThu(ca.getTongDoanhThu().add(tienMat).add(tienChuyenKhoan));
            caBanHangRepository.save(ca);
        });
    }

    public Optional<CaBanHang> layCaHienTai(Long nhanVienId) {
        return caBanHangRepository.findCaDangMo(nhanVienId);
    }
}
