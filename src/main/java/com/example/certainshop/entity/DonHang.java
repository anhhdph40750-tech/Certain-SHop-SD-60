package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "DonHang")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "NguoiDungId")
    private NguoiDung nguoiDung;

    @Column(name = "MaDonHang", length = 50)
    private String maDonHang;

    @Column(name = "TongTien", precision = 18, scale = 2)
    private BigDecimal tongTien;

    @Column(name = "SoTienGiamGia", precision = 18, scale = 2)
    private BigDecimal soTienGiamGia;

    @Column(name = "PhiVanChuyen", precision = 18, scale = 2)
    private BigDecimal phiVanChuyen;

    @Column(name = "TongTienThanhToan", precision = 18, scale = 2)
    private BigDecimal tongTienThanhToan;

    @Column(name = "TrangThaiDonHang", length = 50)
    private String trangThaiDonHang;

    @Column(name = "LoaiDonHang", length = 50)
    private String loaiDonHang;

    @ManyToOne
    @JoinColumn(name = "KhuyenMaiId")
    private KhuyenMai khuyenMai;

    @Column(name = "GhiChu", length = 255)
    private String ghiChu;

    @Column(name = "GhiChuThuNgan", length = 255)
    private String ghiChuThuNgan;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;
}