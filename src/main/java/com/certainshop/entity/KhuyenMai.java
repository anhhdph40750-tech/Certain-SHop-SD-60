package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "KhuyenMai")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KhuyenMai {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Column(name = "MaKhuyenMai", length = 50)
    private String maKhuyenMai;

    @Column(name = "TenKhuyenMai", length = 150)
    private String tenKhuyenMai;

    @Column(name = "MoTa", length = 255)
    private String moTa;

    // PERCENT hoặc FIXED
    @Column(name = "LoaiGiam", length = 50)
    private String loaiGiamGia;

    @Column(name = "GiaTriGiam", precision = 18, scale = 2)
    private BigDecimal giaTriGiam;

    // Giá trị đơn hàng tối thiểu để áp dụng
    @Column(name = "DonHangToiThieu", precision = 18, scale = 2)
    private BigDecimal giaTriDonHangToiThieu;

    // Giá trị giảm tối đa (chỉ áp dụng cho PERCENT)
    @Column(name = "GiaTriToiDa", precision = 18, scale = 2)
    private BigDecimal giaTriGiamToiDa;

    @Column(name = "NgayBatDau")
    private LocalDateTime ngayBatDau;

    @Column(name = "NgayKetThuc")
    private LocalDateTime ngayKetThuc;

    @Column(name = "SoLuongToiDa")
    private Integer soLanSuDungToiDa;

    @Column(name = "SoLuongDaDung")
    private Integer soLanDaSuDung = 0;

    @Column(name = "TrangThaiKhuyenMai", length = 30)
    private String trangThaiKhuyenMai = "HOAT_DONG";

    @Column(name = "ThoiGianTao")
    private LocalDateTime ngayTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime ngayCapNhat;

    @PrePersist
    protected void truocKhiTao() {
        setNgayTao(LocalDateTime.now());
        setSoLanDaSuDung((Integer) 0);
    }

    @PreUpdate
    protected void truocKhiCapNhat() {
        setNgayCapNhat(LocalDateTime.now());
    }

    /**
     * Kiểm tra voucher có còn hợp lệ không
     */
    public boolean laHopLe() {
        LocalDateTime now = LocalDateTime.now();
        if (!"HOAT_DONG".equals(trangThaiKhuyenMai))
            return false;
        if (getNgayBatDau() != null && now.isBefore(getNgayBatDau()))
            return false;
        if (getNgayKetThuc() != null && now.isAfter(getNgayKetThuc()))
            return false;
        if (getSoLanSuDungToiDa() != null && getSoLanDaSuDung() != null && getSoLanDaSuDung() >= getSoLanSuDungToiDa())
            return false;
        return true;
    }

    /**
     * Tính số tiền giảm
     */
    public BigDecimal tinhSoTienGiam(BigDecimal tongTienGoc) {
        if (!laHopLe())
            return BigDecimal.ZERO;
        if (getGiaTriDonHangToiThieu() != null && tongTienGoc.compareTo(getGiaTriDonHangToiThieu()) < 0)
            return BigDecimal.ZERO;

        BigDecimal soTienGiam;
        if ("PERCENT".equalsIgnoreCase(getLoaiGiamGia())) {
            soTienGiam = tongTienGoc.multiply(getGiaTriGiam()).divide(BigDecimal.valueOf(100));
            if (getGiaTriGiamToiDa() != null && soTienGiam.compareTo(getGiaTriGiamToiDa()) > 0) {
                soTienGiam = getGiaTriGiamToiDa();
            }
        } else {
            soTienGiam = getGiaTriGiam();
        }
        if (soTienGiam.compareTo(tongTienGoc) > 0)
            soTienGiam = tongTienGoc;
        return soTienGiam;
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
     * @return the maKhuyenMai
     */
    public String getMaKhuyenMai() {
        return maKhuyenMai;
    }

    /**
     * @param maKhuyenMai the maKhuyenMai to set
     */
    public void setMaKhuyenMai(String maKhuyenMai) {
        this.maKhuyenMai = maKhuyenMai;
    }

    /**
     * @return the tenKhuyenMai
     */
    public String getTenKhuyenMai() {
        return tenKhuyenMai;
    }

    /**
     * @param tenKhuyenMai the tenKhuyenMai to set
     */
    public void setTenKhuyenMai(String tenKhuyenMai) {
        this.tenKhuyenMai = tenKhuyenMai;
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
     * @return the loaiGiamGia
     */
    public String getLoaiGiamGia() {
        return loaiGiamGia;
    }

    /**
     * @param loaiGiamGia the loaiGiamGia to set
     */
    public void setLoaiGiamGia(String loaiGiamGia) {
        this.loaiGiamGia = loaiGiamGia;
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
     * @return the giaTriDonHangToiThieu
     */
    public BigDecimal getGiaTriDonHangToiThieu() {
        return giaTriDonHangToiThieu;
    }

    /**
     * @param giaTriDonHangToiThieu the giaTriDonHangToiThieu to set
     */
    public void setGiaTriDonHangToiThieu(BigDecimal giaTriDonHangToiThieu) {
        this.giaTriDonHangToiThieu = giaTriDonHangToiThieu;
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
     * @return the soLanSuDungToiDa
     */
    public Integer getSoLanSuDungToiDa() {
        return soLanSuDungToiDa;
    }

    /**
     * @param soLanSuDungToiDa the soLanSuDungToiDa to set
     */
    public void setSoLanSuDungToiDa(Integer soLanSuDungToiDa) {
        this.soLanSuDungToiDa = soLanSuDungToiDa;
    }

    /**
     * @return the soLanDaSuDung
     */
    public Integer getSoLanDaSuDung() {
        return soLanDaSuDung;
    }

    /**
     * @param soLanDaSuDung the soLanDaSuDung to set
     */
    public void setSoLanDaSuDung(Integer soLanDaSuDung) {
        this.soLanDaSuDung = soLanDaSuDung;
    }

    /**
     * @return the trangThaiKhuyenMai
     */
    public String getTrangThaiKhuyenMai() {
        return trangThaiKhuyenMai;
    }

    /**
     * @param trangThaiKhuyenMai the trangThaiKhuyenMai to set
     */
    public void setTrangThaiKhuyenMai(String trangThaiKhuyenMai) {
        this.trangThaiKhuyenMai = trangThaiKhuyenMai;
    }

    /**
     * @return the ngayTao
     */
    public LocalDateTime getNgayTao() {
        return ngayTao;
    }

    /**
     * @param ngayTao the ngayTao to set
     */
    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }

    /**
     * @return the ngayCapNhat
     */
    public LocalDateTime getNgayCapNhat() {
        return ngayCapNhat;
    }

    /**
     * @param ngayCapNhat the ngayCapNhat to set
     */
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }
}
