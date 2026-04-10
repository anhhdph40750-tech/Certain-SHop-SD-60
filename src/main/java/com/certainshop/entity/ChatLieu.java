package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ChatLieu")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class ChatLieu {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Column(name = "TenChatLieu", length = 100)
    private String tenChatLieu;

    @Column(name = "MoTa", length = 500)
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
     * @return the tenChatLieu
     */
    public String getTenChatLieu() {
        return tenChatLieu;
    }

    /**
     * @param tenChatLieu the tenChatLieu to set
     */
    public void setTenChatLieu(String tenChatLieu) {
        this.tenChatLieu = tenChatLieu;
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
