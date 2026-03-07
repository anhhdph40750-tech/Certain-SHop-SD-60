package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "ThanhToan")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ThanhToan {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "DonHangId", nullable = false, unique = true)
    private DonHang donHang;

    @Column(name = "PhuongThucThanhToan", length = 50)
    private String phuongThucThanhToan;

    @Column(name = "TrangThaiThanhToan", length = 50)
    private String trangThaiThanhToan;

    @Column(name = "SoTienThanhToan", precision = 18, scale = 2)
    private BigDecimal soTienThanhToan;

    @Column(name = "ThoiDiemThanhToan")
    private LocalDateTime thoiDiemThanhToan;
}
