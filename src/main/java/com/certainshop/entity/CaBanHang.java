package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "CaBanHang")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class CaBanHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NhanVienId", nullable = false)
    private NguoiDung nhanVien;

    @Column(name = "ThoiGianBatDau")
    private LocalDateTime thoiGianBatDau;

    @Column(name = "ThoiGianKetThuc")
    private LocalDateTime thoiGianKetThuc;

    @Builder.Default
    @Column(name = "TienDauCa", precision = 18, scale = 2)
    private BigDecimal tienDauCa = BigDecimal.ZERO;

    @Builder.Default
    @Column(name = "TienMatTrongCa", precision = 18, scale = 2)
    private BigDecimal tienMatTrongCa = BigDecimal.ZERO;

    @Builder.Default
    @Column(name = "TienChuyenKhoanTrongCa", precision = 18, scale = 2)
    private BigDecimal tienChuyenKhoanTrongCa = BigDecimal.ZERO;

    @Builder.Default
    @Column(name = "TongDoanhThu", precision = 18, scale = 2)
    private BigDecimal tongDoanhThu = BigDecimal.ZERO;

    @Builder.Default
    @Column(name = "TienThucTe", precision = 18, scale = 2)
    private BigDecimal tienThucTe = BigDecimal.ZERO;

    @Builder.Default
    @Column(name = "ChenhLech", precision = 18, scale = 2)
    private BigDecimal chenhLech = BigDecimal.ZERO;

    @Column(name = "GhiChu", columnDefinition = "NVARCHAR(MAX)")
    private String ghiChu;

    @Column(name = "TrangThai", length = 30)
    private String trangThai; // DANG_MO | DA_KET_THUC

    @PrePersist
    protected void truocKhiTao() {
        if (thoiGianBatDau == null) thoiGianBatDau = LocalDateTime.now();
        if (trangThai == null) trangThai = "DANG_MO";
    }
}
