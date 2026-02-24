package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "DanhMuc")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DanhMuc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TenDanhMuc", length = 150)
    private String tenDanhMuc;

    @Column(name = "DuongDan", length = 255)
    private String duongDan;

    @Column(name = "MoTa", length = 255)
    private String moTa;

    @Column(name = "ThuTuHienThi")
    private Integer thuTuHienThi;

    @Column(name = "DangHoatDong")
    private Boolean dangHoatDong = true;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;
}