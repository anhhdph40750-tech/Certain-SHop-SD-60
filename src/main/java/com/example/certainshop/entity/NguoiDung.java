package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "NguoiDung")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NguoiDung {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TenDangNhap", unique = true, nullable = false, length = 100)
    private String tenDangNhap;

    @Column(name = "Email", unique = true, length = 150)
    private String email;

    @Column(name = "MatKhauMaHoa", nullable = false, length = 255)
    private String matKhauMaHoa;

    @Column(name = "HoTen", length = 150)
    private String hoTen;

    @Column(name = "SoDienThoai", length = 20)
    private String soDienThoai;

    @Column(name = "NgaySinh")
    private LocalDate ngaySinh;

    @Column(name = "GioiTinh", length = 10)
    private String gioiTinh;

    @Column(name = "AnhDaiDien", length = 255)
    private String anhDaiDien;

    @ManyToOne
    @JoinColumn(name = "VaiTroId")
    private VaiTro vaiTro;

    @Column(name = "DangHoatDong")
    private Boolean dangHoatDong = true;

    @Column(name = "LanDangNhapCuoi")
    private LocalDateTime lanDangNhapCuoi;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;

    @Column(name = "MaDatLaiMatKhau", length = 255)
    private String maDatLaiMatKhau;

    @Column(name = "LanDoiMatKhauCuoi")
    private LocalDateTime lanDoiMatKhauCuoi;
}