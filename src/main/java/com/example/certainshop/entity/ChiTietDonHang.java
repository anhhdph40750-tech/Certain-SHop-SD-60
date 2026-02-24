package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;

@Entity
@Table(name = "ChiTietDonHang")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChiTietDonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "DonHangId", nullable = false)
    private DonHang donHang;

    @ManyToOne
    @JoinColumn(name = "BienTheId", nullable = false)
    private BienThe bienThe;

    @Column(name = "GiaTaiThoiDiemMua", precision = 18, scale = 2)
    private BigDecimal giaTaiThoiDiemMua;

    @Column(name = "SoLuong")
    private Integer soLuong;

    @Column(name = "ThanhTien", precision = 18, scale = 2)
    private BigDecimal thanhTien;
}