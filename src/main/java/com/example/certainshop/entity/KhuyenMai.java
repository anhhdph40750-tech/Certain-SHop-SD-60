package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "KhuyenMai")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KhuyenMai {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "MaKhuyenMai", length = 50)
    private String maKhuyenMai;

    @Column(name = "TenKhuyenMai", length = 150)
    private String tenKhuyenMai;

    @Column(name = "MoTa", length = 255)
    private String moTa;

    @Column(name = "LoaiGiamGia", length = 50)
    private String loaiGiamGia;

    @Column(name = "GiaTriGiam", precision = 18, scale = 2)
    private BigDecimal giaTriGiam;

    @Column(name = "GiaTriDonHangToiThieu", precision = 18, scale = 2)
    private BigDecimal giaTriDonHangToiThieu;

    @Column(name = "GiaTriDonHangToiDa", precision = 18, scale = 2)
    private BigDecimal giaTriDonHangToiDa;

    @Column(name = "NgayBatDau")
    private LocalDateTime ngayBatDau;

    @Column(name = "NgayKetThuc")
    private LocalDateTime ngayKetThuc;

    @Column(name = "SoLanSuDungToiDa")
    private Integer soLanSuDungToiDa;

    @Column(name = "TrangThaiHoatDong")
    private Boolean trangThaiHoatDong = true;

    @Column(name = "NgayTao")
    private LocalDateTime ngayTao;

    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;
}