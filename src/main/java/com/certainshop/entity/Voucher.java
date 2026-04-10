package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "Voucher")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Voucher {
    // out tai khoan lam
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Column(name = "MaVoucher", length = 50, unique = true, nullable = false)
    private String maVoucher; // e.g., "SUMMER2026", "NEWYEAR"

    @Column(name = "MoTa", columnDefinition = "NVARCHAR(MAX)")
    private String moTa; // Description

    @Column(name = "TrangThai", nullable = false)
    private Boolean trangThai = true; // true = active, false = deleted

    // Validity period
    @Column(name = "NgayBatDau", nullable = false)
    private LocalDateTime ngayBatDau;

    @Column(name = "NgayKetThuc", nullable = false)
    private LocalDateTime ngayKetThuc;

    // Conditions
    @Column(name = "GiaTriToiThieu", precision = 18, scale = 2)
    private BigDecimal giaTriToiThieu; // Minimum order value to apply voucher

    @Column(name = "GiaTriGiamToiDa", precision = 18, scale = 2, nullable = false)
    private BigDecimal giaTriGiamToiDa; // Max discount amount

    // Discount type and value
    @Column(name = "LoaiGiam", length = 20, nullable = false)
    private String loaiGiam; // "PERCENT" (%) or "FIXED" (đ)

    @Column(name = "GiaTriGiam", precision = 18, scale = 2, nullable = false)
    private BigDecimal giaTriGiam; // Discount value (% for PERCENT, đ for FIXED)

    // Usage tracking
    @Column(name = "SoLuongSuDung")
    private Integer soLuongSuDung = 0; // Number of times used

    @Column(name = "SoLuongToiDa")
    private Integer soLuongToiDa; // Max uses allowed (null = unlimited)

    // Metadata
    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;

    @PrePersist
    protected void onCreate() {
        LocalDateTime now = LocalDateTime.now();
        setThoiGianTao(now);
        setThoiGianCapNhat(now); // Set on creation too, not just on update
        if (getTrangThai() == null)
            setTrangThai((Boolean) true);
    }

    @PreUpdate
    protected void onUpdate() {
        setThoiGianCapNhat(LocalDateTime.now());
    }

    /**
     * Kiểm tra voucher có được áp dụng được không (bỏ qua điều kiện giá trị đơn
     * hàng)
     */
    public boolean isValid() {
        if (!getTrangThai())
            return false;
        LocalDateTime now = LocalDateTime.now();
        if (now.isBefore(getNgayBatDau()) || now.isAfter(getNgayKetThuc()))
            return false;
        if (getSoLuongToiDa() != null && getSoLuongSuDung() >= getSoLuongToiDa())
            return false;
        return true;
    }

    /**
     * Tính tiền giảm dựa vào giá trị đơn hàng
     */
    public BigDecimal tinhGiaTriGiam(BigDecimal giaTriDonHang) {
        if (!isValid())
            return BigDecimal.ZERO;
        if (getGiaTriToiThieu() != null && giaTriDonHang.compareTo(getGiaTriToiThieu()) < 0) {
            return BigDecimal.ZERO; // Không đủ giá trị tối thiểu
        }

        BigDecimal giaTriGiamThuc;
        if ("PERCENT".equals(getLoaiGiam())) {
            giaTriGiamThuc = giaTriDonHang.multiply(getGiaTriGiam()).divide(new BigDecimal("100"));
        } else {
            giaTriGiamThuc = getGiaTriGiam();
        }

        // Không vượt quá giá trị giảm tối đa (nếu có)
        if (getGiaTriGiamToiDa() != null && giaTriGiamThuc.compareTo(getGiaTriGiamToiDa()) > 0) {
            giaTriGiamThuc = getGiaTriGiamToiDa();
        }

        // Không vượt quá tổng tiền sản phẩm (để phí ship không bị trừ)
        if (giaTriGiamThuc.compareTo(giaTriDonHang) > 0) {
            giaTriGiamThuc = giaTriDonHang;
        }

        return giaTriGiamThuc;
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
     * @return the maVoucher
     */
    public String getMaVoucher() {
        return maVoucher;
    }

    /**
     * @param maVoucher the maVoucher to set
     */
    public void setMaVoucher(String maVoucher) {
        this.maVoucher = maVoucher;
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
     * @return the ngayBatDau
     */
    public LocalDateTime getNgayBatDau() {
        return ngayBatDau;
    }

    /**
     * @param ngayBatDau the ngayBatDau to set
     */
    public void setNgayBatDau(LocalDateTime ngayBatDau) {
        this.ngayBatDau = ngayBatDau;
    }

    /**
     * @return the ngayKetThuc
     */
    public LocalDateTime getNgayKetThuc() {
        return ngayKetThuc;
    }

    /**
     * @param ngayKetThuc the ngayKetThuc to set
     */
    public void setNgayKetThuc(LocalDateTime ngayKetThuc) {
        this.ngayKetThuc = ngayKetThuc;
    }

    /**
     * @return the giaTriToiThieu
     */
    public BigDecimal getGiaTriToiThieu() {
        return giaTriToiThieu;
    }

    /**
     * @param giaTriToiThieu the giaTriToiThieu to set
     */
    public void setGiaTriToiThieu(BigDecimal giaTriToiThieu) {
        this.giaTriToiThieu = giaTriToiThieu;
    }

    /**
     * @return the giaTriGiamToiDa
     */
    public BigDecimal getGiaTriGiamToiDa() {
        return giaTriGiamToiDa;
    }

    /**
     * @param giaTriGiamToiDa the giaTriGiamToiDa to set
     */
    public void setGiaTriGiamToiDa(BigDecimal giaTriGiamToiDa) {
        this.giaTriGiamToiDa = giaTriGiamToiDa;
    }

    /**
     * @return the loaiGiam
     */
    public String getLoaiGiam() {
        return loaiGiam;
    }

    /**
     * @param loaiGiam the loaiGiam to set
     */
    public void setLoaiGiam(String loaiGiam) {
        this.loaiGiam = loaiGiam;
    }

    /**
     * @return the giaTriGiam
     */
    public BigDecimal getGiaTriGiam() {
        return giaTriGiam;
    }

    /**
     * @param giaTriGiam the giaTriGiam to set
     */
    public void setGiaTriGiam(BigDecimal giaTriGiam) {
        this.giaTriGiam = giaTriGiam;
    }

    /**
     * @return the soLuongSuDung
     */
    public Integer getSoLuongSuDung() {
        return soLuongSuDung;
    }

    /**
     * @param soLuongSuDung the soLuongSuDung to set
     */
    public void setSoLuongSuDung(Integer soLuongSuDung) {
        this.soLuongSuDung = soLuongSuDung;
    }

    /**
     * @return the soLuongToiDa
     */
    public Integer getSoLuongToiDa() {
        return soLuongToiDa;
    }

    /**
     * @param soLuongToiDa the soLuongToiDa to set
     */
    public void setSoLuongToiDa(Integer soLuongToiDa) {
        this.soLuongToiDa = soLuongToiDa;
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
}
