package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "ThuongHieu")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ThuongHieu {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TenThuongHieu", length = 150)
    private String tenThuongHieu;

    @Column(name = "TrangThai")
    private Boolean trangThai = true;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;
}