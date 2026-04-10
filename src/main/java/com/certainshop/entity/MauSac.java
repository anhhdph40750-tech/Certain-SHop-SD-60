package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "MauSac")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class MauSac {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Column(name = "TenMauSac", length = 100)
    private String tenMau;

    @Column(name = "MaHex", length = 10)
    private String maHex;

    @Column(name = "MoTa", length = 255)
    private String moTa;

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
     * @return the tenMau
     */
    public String getTenMau() {
        return tenMau;
    }

    /**
     * @param tenMau the tenMau to set
     */
    public void setTenMau(String tenMau) {
        this.tenMau = tenMau;
    }

    /**
     * @return the maHex
     */
    public String getMaHex() {
        return maHex;
    }

    /**
     * @param maHex the maHex to set
     */
    public void setMaHex(String maHex) {
        this.maHex = maHex;
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
}
