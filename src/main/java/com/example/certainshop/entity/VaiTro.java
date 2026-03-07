package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "VaiTro")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class VaiTro {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "TenVaiTro", nullable = false, length = 50)
    private String tenVaiTro;

    @Column(name = "QuyenHan", length = 255)
    private String quyenHan;
}