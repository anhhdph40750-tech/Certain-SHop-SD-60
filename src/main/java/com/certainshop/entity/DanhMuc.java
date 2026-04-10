package com.certainshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "DanhMuc")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DanhMuc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
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

    @OneToMany(mappedBy = "danhMuc", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<SanPham> danhSachSanPham;

    @PrePersist
    protected void truocKhiTao() {
        setThoiGianTao(LocalDateTime.now());
    }

    /**
     * @return the id
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the tenDanhMuc
     */
    public String getTenDanhMuc() {
        return tenDanhMuc;
    }

    /**
     * @param tenDanhMuc the tenDanhMuc to set
     */
    public void setTenDanhMuc(String tenDanhMuc) {
        this.tenDanhMuc = tenDanhMuc;
    }

    /**
     * @return the duongDan
     */
    public String getDuongDan() {
        return duongDan;
    }

    /**
     * @param duongDan the duongDan to set
     */
    public void setDuongDan(String duongDan) {
        this.duongDan = duongDan;
    }

    /**
     * @return the moTa
     */
    public String getMoTa() {
        return moTa;
    }

    /**
     * @param moTa the moTa to set
     */
    public void setMoTa(String moTa) {
        this.moTa = moTa;
    }

    /**
     * @return the thuTuHienThi
     */
    public Integer getThuTuHienThi() {
        return thuTuHienThi;
    }

    /**
     * @param thuTuHienThi the thuTuHienThi to set
     */
    public void setThuTuHienThi(Integer thuTuHienThi) {
        this.thuTuHienThi = thuTuHienThi;
    }

    /**
     * @return the dangHoatDong
     */
    public Boolean getDangHoatDong() {
        return dangHoatDong;
    }

    /**
     * @param dangHoatDong the dangHoatDong to set
     */
    public void setDangHoatDong(Boolean dangHoatDong) {
        this.dangHoatDong = dangHoatDong;
    }

    /**
     * @return the thoiGianTao
     */
    public LocalDateTime getThoiGianTao() {
        return thoiGianTao;
    }

    /**
     * @param thoiGianTao the thoiGianTao to set
     */
    public void setThoiGianTao(LocalDateTime thoiGianTao) {
        this.thoiGianTao = thoiGianTao;
    }

    /**
     * @return the danhSachSanPham
     */
    public List<SanPham> getDanhSachSanPham() {
        return danhSachSanPham;
    }

    /**
     * @param danhSachSanPham the danhSachSanPham to set
     */
    public void setDanhSachSanPham(List<SanPham> danhSachSanPham) {
        this.danhSachSanPham = danhSachSanPham;
    }
}
