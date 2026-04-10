package com.certainshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "HinhAnhBienThe")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HinhAnhBienThe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "BienTheId", nullable = false)
    @JsonIgnore
    private BienThe bienThe;

    @Column(name = "DuongDan", nullable = false, length = 255)
    private String duongDan;

    @Column(name = "LaAnhChinh")
    private Boolean laAnhChinh = false;

    @Column(name = "ThuTu")
    private Integer thuTu = 0;

    @Column(name = "MoTa", length = 255)
    private String moTa;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

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
     * @return the laAnhChinh
     */
    public Boolean getLaAnhChinh() {
        return laAnhChinh;
    }

    /**
     * @param laAnhChinh the laAnhChinh to set
     */
    public void setLaAnhChinh(Boolean laAnhChinh) {
        this.laAnhChinh = laAnhChinh;
    }

    /**
     * @return the thuTu
     */
    public Integer getThuTu() {
        return thuTu;
    }

    /**
     * @param thuTu the thuTu to set
     */
    public void setThuTu(Integer thuTu) {
        this.thuTu = thuTu;
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
}
