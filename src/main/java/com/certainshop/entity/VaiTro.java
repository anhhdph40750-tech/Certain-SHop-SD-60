package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "VaiTro")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class VaiTro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Integer id;

    @Column(name = "TenVaiTro", nullable = false, length = 50)
    private String tenVaiTro;

    @Column(name = "QuyenHan", length = 255)
    private String quyenHan;

    /**
     * @return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return the tenVaiTro
     */
    public String getTenVaiTro() {
        return tenVaiTro;
    }

    /**
     * @param tenVaiTro the tenVaiTro to set
     */
    public void setTenVaiTro(String tenVaiTro) {
        this.tenVaiTro = tenVaiTro;
    }

    /**
     * @return the quyenHan
     */
    public String getQuyenHan() {
        return quyenHan;
    }

    /**
     * @param quyenHan the quyenHan to set
     */
    public void setQuyenHan(String quyenHan) {
        this.quyenHan = quyenHan;
    }
}
