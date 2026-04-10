package com.certainshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "GioHangChiTiet",
       uniqueConstraints = @UniqueConstraint(columnNames = {"GioHangId", "BienTheId"}))
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GioHangChiTiet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "GioHangId", nullable = false)
    @JsonIgnore
    private GioHang gioHang;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "BienTheId", nullable = false)
    private BienThe bienThe;

    @Column(name = "SoLuong")
    private Integer soLuong;

    @Column(name = "DonGia", precision = 18, scale = 2)
    private BigDecimal donGia;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;

    @PrePersist
    protected void truocKhiTao() {
        setThoiGianTao(LocalDateTime.now());
    }

    @PreUpdate
    protected void truocKhiCapNhat() {
        setThoiGianCapNhat(LocalDateTime.now());
    }

    public BigDecimal getThanhTien() {
        BigDecimal gia = getDonGia();
        // Fallback to BienThe.gia if donGia is null or zero
        if ((gia == null || gia.signum() == 0) && getBienThe() != null) {
            gia = getBienThe().getGia();
        }
        if (gia != null && getSoLuong() != null) {
            return gia.multiply(BigDecimal.valueOf(getSoLuong()));
        }
        return BigDecimal.ZERO;
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
     * @return the gioHang
     */
    public GioHang getGioHang() {
        return gioHang;
    }

    /**
     * @param gioHang the gioHang to set
     */
    public void setGioHang(GioHang gioHang) {
        this.gioHang = gioHang;
    }

    /**
     * @return the bienThe
     */
    public BienThe getBienThe() {
        return bienThe;
    }

    /**
     * @param bienThe the bienThe to set
     */
    public void setBienThe(BienThe bienThe) {
        this.bienThe = bienThe;
    }

    /**
     * @return the soLuong
     */
    public Integer getSoLuong() {
        return soLuong;
    }

    /**
     * @param soLuong the soLuong to set
     */
    public void setSoLuong(Integer soLuong) {
        this.soLuong = soLuong;
    }

    /**
     * @return the donGia
     */
    public BigDecimal getDonGia() {
        return donGia;
    }

    /**
     * @param donGia the donGia to set
     */
    public void setDonGia(BigDecimal donGia) {
        this.donGia = donGia;
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
