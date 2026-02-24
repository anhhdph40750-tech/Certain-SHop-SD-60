package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "SanPham")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Getter
@Setter
public class SanPham {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TenSanPham", length = 255)
    private String tenSanPham;

    @Column(name = "MoTaChiTiet", columnDefinition = "VARCHAR(MAX)")
    private String moTaChiTiet;

    @Column(name = "GiaGoc", precision = 18, scale = 2)
    private BigDecimal giaGoc;

    @ManyToOne
    @JoinColumn(name = "DanhMucId")
    private DanhMuc danhMuc;

    @ManyToOne
    @JoinColumn(name = "ThuongHieuId")
    private ThuongHieu thuongHieu;

    @Column(name = "TrangThai")
    private Boolean trangThai = true;

    @Column(name = "NgayTao")
    private LocalDateTime ngayTao;

    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;
    @OneToMany(mappedBy = "sanPham", fetch = FetchType.LAZY)
    private List<BienThe> bienTheList = new ArrayList<>();
}