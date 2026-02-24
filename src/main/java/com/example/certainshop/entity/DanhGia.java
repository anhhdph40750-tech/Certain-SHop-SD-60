package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "DanhGia")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DanhGia {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "SanPhamId")
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "UserId")
    private NguoiDung nguoiDung;

    @ManyToOne
    @JoinColumn(name = "ChiTietDonHangId")
    private ChiTietDonHang chiTietDonHang;

    @Column(name = "DiemDanhGia")
    private Integer diemDanhGia;

    @Column(name = "TieuDe", length = 255)
    private String tieuDe;

    @Column(name = "NoiDung", columnDefinition = "VARCHAR(MAX)")
    private String noiDung;

    @Column(name = "HinhAnh", length = 255)
    private String hinhAnh;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;
}