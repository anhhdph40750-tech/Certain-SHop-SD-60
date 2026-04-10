package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "SanPham")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SanPham {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Column(name = "MaSanPham", length = 50)
    private String maSanPham;

    @Column(name = "TenSanPham", length = 255)
    private String tenSanPham;

    @Column(name = "MoTa", columnDefinition = "NVARCHAR(MAX)")
    private String moTa;

    @Column(name = "GiaGoc", precision = 18, scale = 2)
    private BigDecimal giaGoc;

    @Column(name = "GiaBan", precision = 18, scale = 2)
    private BigDecimal giaBan;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "DanhMucId")
    private DanhMuc danhMuc;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ThuongHieuId")
    private ThuongHieu thuongHieu;

    @Column(name = "AnhChinh", length = 500)
    private String anhChinh;

    @Column(name = "DuongDan", length = 255)
    private String duongDan;

    @Column(name = "TrangThaiSanPham", length = 30)
    private String trangThaiSanPham = "DANG_BAN"; // DANG_BAN | NGUNG_BAN | HET_HANG

    @Column(name = "TrangThai", nullable = false)
    private Boolean trangThai = true; // true = active, false = deleted (soft delete)

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;

    @OneToMany(mappedBy = "sanPham", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<BienThe> danhSachBienThe;

    // Helper for backward compatibility
    public boolean isTrangThai() {
        return "DANG_BAN".equals(getTrangThaiSanPham());
    }

    public void setTrangThai(boolean active) {
        // Update BOTH the Boolean flag AND the status string
        this.setTrangThai((Boolean) active); // Set soft-delete flag
        this.setTrangThaiSanPham(active ? "DANG_BAN" : "NGUNG_BAN"); // Set status
    }

    @PrePersist
    protected void truocKhiTao() {
        LocalDateTime now = LocalDateTime.now();
        setThoiGianTao(now);
        setThoiGianCapNhat(now); // Set on creation too
        if (getTrangThaiSanPham() == null)
            setTrangThaiSanPham("DANG_BAN");
        if (getTrangThai() == null)
            setTrangThai((Boolean) true);
    }

    @PreUpdate
    protected void truocKhiCapNhat() {
        setThoiGianCapNhat(LocalDateTime.now());
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
     * @return the maSanPham
     */
    public String getMaSanPham() {
        return maSanPham;
    }

    /**
     * @param maSanPham the maSanPham to set
     */
    public void setMaSanPham(String maSanPham) {
        this.maSanPham = maSanPham;
    }

    /**
     * @return the tenSanPham
     */
    public String getTenSanPham() {
        return tenSanPham;
    }

    /**
     * @param tenSanPham the tenSanPham to set
     */
    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
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
     * @return the giaGoc
     */
    public BigDecimal getGiaGoc() {
        return giaGoc;
    }

    /**
     * @param giaGoc the giaGoc to set
     */
    public void setGiaGoc(BigDecimal giaGoc) {
        this.giaGoc = giaGoc;
    }

    /**
     * @return the giaBan
     */
    public BigDecimal getGiaBan() {
        return giaBan;
    }

    /**
     * @param giaBan the giaBan to set
     */
    public void setGiaBan(BigDecimal giaBan) {
        this.giaBan = giaBan;
    }

    /**
     * @return the danhMuc
     */
    public DanhMuc getDanhMuc() {
        return danhMuc;
    }

    /**
     * @param danhMuc the danhMuc to set
     */
    public void setDanhMuc(DanhMuc danhMuc) {
        this.danhMuc = danhMuc;
    }

    /**
     * @return the thuongHieu
     */
    public ThuongHieu getThuongHieu() {
        return thuongHieu;
    }

    /**
     * @param thuongHieu the thuongHieu to set
     */
    public void setThuongHieu(ThuongHieu thuongHieu) {
        this.thuongHieu = thuongHieu;
    }

    /**
     * @return the anhChinh
     */
    public String getAnhChinh() {
        return anhChinh;
    }

    /**
     * @param anhChinh the anhChinh to set
     */
    public void setAnhChinh(String anhChinh) {
        this.anhChinh = anhChinh;
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
     * @return the trangThaiSanPham
     */
    public String getTrangThaiSanPham() {
        return trangThaiSanPham;
    }

    /**
     * @param trangThaiSanPham the trangThaiSanPham to set
     */
    public void setTrangThaiSanPham(String trangThaiSanPham) {
        this.trangThaiSanPham = trangThaiSanPham;
    }

    /**
     * @return the trangThai
     */
    public Boolean getTrangThai() {
        return trangThai;
    }

    /**
     * @param trangThai the trangThai to set
     */
    public void setTrangThai(Boolean trangThai) {
        this.trangThai = trangThai;
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
     * @return the thoiGianCapNhat
     */
    public LocalDateTime getThoiGianCapNhat() {
        return thoiGianCapNhat;
    }

    /**
     * @param thoiGianCapNhat the thoiGianCapNhat to set
     */
    public void setThoiGianCapNhat(LocalDateTime thoiGianCapNhat) {
        this.thoiGianCapNhat = thoiGianCapNhat;
    }

    /**
     * @return the danhSachBienThe
     */
    public List<BienThe> getDanhSachBienThe() {
        return danhSachBienThe;
    }

    /**
     * @param danhSachBienThe the danhSachBienThe to set
     */
    public void setDanhSachBienThe(List<BienThe> danhSachBienThe) {
        this.danhSachBienThe = danhSachBienThe;
    }

    @Transient
    @com.fasterxml.jackson.annotation.JsonProperty("soLuong")
    public Integer getSoLuong() {
        if (this.danhSachBienThe != null) {
            return this.danhSachBienThe.stream()
                    .filter(bt -> Boolean.TRUE.equals(bt.getTrangThai()))
                    .mapToInt(bt -> bt.getSoLuongTon() != null ? bt.getSoLuongTon() : 0)
                    .sum();
        }
        return 0;
    }
}
