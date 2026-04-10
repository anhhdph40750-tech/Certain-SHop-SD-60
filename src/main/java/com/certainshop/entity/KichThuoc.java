package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "KichThuoc")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KichThuoc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Column(name = "TenKichThuoc", length = 50)
    private String kichCo; // kept as kichCo for backward compat

    @Column(name = "ThuTu")
    private Integer thuTu = 0;

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
     * @return the kichCo
     */
    public String getKichCo() {
        return kichCo;
    }

    /**
     * @param kichCo the kichCo to set
     */
    public void setKichCo(String kichCo) {
        this.kichCo = kichCo;
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
}
