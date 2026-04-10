package com.certainshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "LichSuTrangThaiDon")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class LichSuTrangThaiDon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DonHangId")
    @JsonIgnore
    private DonHang donHang;

    @Column(name = "TrangThaiCu", length = 50)
    private String trangThaiCu;

    @Column(name = "TrangThaiMoi", length = 50)
    private String trangThaiMoi;

    @Column(name = "GhiChu", length = 255)
    private String ghiChu;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiThayDoiId")
    private NguoiDung nguoiThayDoi;

    @Column(name = "ThoiGian")
    private LocalDateTime thoiGian;

    @PrePersist
    protected void truocKhiTao() {
        setThoiGian(LocalDateTime.now());
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
     * @return the donHang
     */
    public DonHang getDonHang() {
        return donHang;
    }

    /**
     * @param donHang the donHang to set
     */
    public void setDonHang(DonHang donHang) {
        this.donHang = donHang;
    }

    /**
     * @return the trangThaiCu
     */
    public String getTrangThaiCu() {
        return trangThaiCu;
    }

    /**
     * @param trangThaiCu the trangThaiCu to set
     */
    public void setTrangThaiCu(String trangThaiCu) {
        this.trangThaiCu = trangThaiCu;
    }

    /**
     * @return the trangThaiMoi
     */
    public String getTrangThaiMoi() {
        return trangThaiMoi;
    }

    /**
     * @param trangThaiMoi the trangThaiMoi to set
     */
    public void setTrangThaiMoi(String trangThaiMoi) {
        this.trangThaiMoi = trangThaiMoi;
    }

    /**
     * @return the ghiChu
     */
    public String getGhiChu() {
        return ghiChu;
    }

    /**
     * @param ghiChu the ghiChu to set
     */
    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    /**
     * @return the nguoiThayDoi
     */
    public NguoiDung getNguoiThayDoi() {
        return nguoiThayDoi;
    }

    /**
     * @param nguoiThayDoi the nguoiThayDoi to set
     */
    public void setNguoiThayDoi(NguoiDung nguoiThayDoi) {
        this.nguoiThayDoi = nguoiThayDoi;
    }

    /**
     * @return the thoiGian
     */
    public LocalDateTime getThoiGian() {
        return thoiGian;
    }

    /**
     * @param thoiGian the thoiGian to set
     */
    public void setThoiGian(LocalDateTime thoiGian) {
        this.thoiGian = thoiGian;
    }
}
