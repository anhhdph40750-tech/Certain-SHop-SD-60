package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "LichSuTrangThaiDon")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LichSuTrangThaiDon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "DonHangId")
    private DonHang donHang;

    @Column(name = "TrangThai", length = 50)
    private String trangThai;

    @Column(name = "GhiChu", length = 255)
    private String ghiChu;

    @ManyToOne
    @JoinColumn(name = "NguoiThayDoi")
    private NguoiDung nguoiThayDoi;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;
}