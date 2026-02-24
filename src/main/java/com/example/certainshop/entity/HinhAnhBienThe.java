package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "HinhAnhBienThe")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HinhAnhBienThe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "BienTheId", nullable = false)
    private BienThe bienThe;

    @Column(name = "DuongDan", nullable = false, length = 255)
    private String duongDan;  // Đường dẫn ảnh: /img/bienthe/ten-anh.jpg

    @Column(name = "LaAnhChinh")
    private Boolean laAnhChinh = false;

    @Column(name = "ThuTu")
    private Integer thuTu = 0;

    @Column(name = "MoTa", length = 255)
    private String moTa;

    @Column(name = "NgayTao")
    private LocalDateTime ngayTao;

}