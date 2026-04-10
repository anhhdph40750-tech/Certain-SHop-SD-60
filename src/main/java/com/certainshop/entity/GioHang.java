package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "GioHang")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GioHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiDungId", nullable = false)
    private NguoiDung nguoiDung;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;

    @OneToMany(mappedBy = "gioHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<GioHangChiTiet> danhSachChiTiet;

    @PrePersist
    protected void truocKhiTao() {
        setThoiGianTao(LocalDateTime.now());
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
     * @return the nguoiDung
     */
    public NguoiDung getNguoiDung() {
        return nguoiDung;
    }

    /**
     * @param nguoiDung the nguoiDung to set
     */
    public void setNguoiDung(NguoiDung nguoiDung) {
        this.nguoiDung = nguoiDung;
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
     * @return the danhSachChiTiet
     */
    public List<GioHangChiTiet> getDanhSachChiTiet() {
        return danhSachChiTiet;
    }

    /**
     * @param danhSachChiTiet the danhSachChiTiet to set
     */
    public void setDanhSachChiTiet(List<GioHangChiTiet> danhSachChiTiet) {
        this.danhSachChiTiet = danhSachChiTiet;
    }
}
