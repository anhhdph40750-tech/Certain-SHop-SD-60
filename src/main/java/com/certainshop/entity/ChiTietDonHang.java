package com.certainshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;

@Entity
@Table(name = "ChiTietDonHang")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ChiTietDonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "DonHangId", nullable = false)
    @JsonIgnore
    private DonHang donHang;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "BienTheId", nullable = false)
    private BienThe bienThe;

    @Column(name = "GiaTaiThoiDiemMua", precision = 18, scale = 2)
    private BigDecimal giaTaiThoiDiemMua;

    @Column(name = "SoLuong")
    private Integer soLuong;

    // ThanhTien computed: not stored in DB
    public java.math.BigDecimal getThanhTien() {
        if (getGiaTaiThoiDiemMua() != null && getSoLuong() != null) {
            return getGiaTaiThoiDiemMua().multiply(java.math.BigDecimal.valueOf(getSoLuong()));
        }
        return java.math.BigDecimal.ZERO;
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
     * @return the giaTaiThoiDiemMua
     */
    public BigDecimal getGiaTaiThoiDiemMua() {
        return giaTaiThoiDiemMua;
    }

    /**
     * @param giaTaiThoiDiemMua the giaTaiThoiDiemMua to set
     */
    public void setGiaTaiThoiDiemMua(BigDecimal giaTaiThoiDiemMua) {
        this.giaTaiThoiDiemMua = giaTaiThoiDiemMua;
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
}
