package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "DiaChiNguoiDung")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DiaChiNguoiDung {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "UserId", nullable = false)
    private NguoiDung nguoiDung;

    @Column(name = "HoTen", length = 150)
    private String hoTen;

    @Column(name = "SoDienThoai", length = 20)
    private String soDienThoai;

    @Column(name = "DiaChiDong1", length = 255)
    private String diaChiDong1;

    @Column(name = "DiaChiDong2", length = 255)
    private String diaChiDong2;

    @Column(name = "PhuongXa", length = 100)
    private String phuongXa;

    @Column(name = "TinhThanh", length = 100)
    private String tinhThanh;

    @Column(name = "QuocGia", length = 100)
    private String quocGia;

    @Column(name = "MaBuuChinh", length = 20)
    private String maBuuChinh;

    @Column(name = "LaMacDinh")
    private Boolean laMacDinh = false;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;
}