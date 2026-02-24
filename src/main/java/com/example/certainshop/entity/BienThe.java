package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "BienThe")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BienThe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "SanPhamId", nullable = false)
    private SanPham sanPham;

    @ManyToOne
    @JoinColumn(name = "KichThuocId")
    private KichThuoc kichThuoc;

    @ManyToOne
    @JoinColumn(name = "MauSacId")
    private MauSac mauSac;

    @ManyToOne
    @JoinColumn(name = "ChatLieuId")
    private ChatLieu chatLieu;

    @Column(name = "Gia", precision = 18, scale = 2)
    private BigDecimal gia;

    @Column(name = "SoLuongTon")
    private Integer soLuongTon;

    @Column(name = "MacDinh")
    private Boolean macDinh = false;

    @Column(name = "TrangThai")
    private Boolean trangThai = true;

    @Column(name = "NgayTao")
    private LocalDateTime ngayTao;

    @Column(name = "NgayCapNhat")
    private LocalDateTime ngayCapNhat;
    @OneToMany(mappedBy = "bienThe", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<HinhAnhBienThe> hinhAnhList = new ArrayList<>();
}