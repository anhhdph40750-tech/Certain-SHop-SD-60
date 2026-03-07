package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "MauSac")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MauSac {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TenMau", length = 50)
    private String tenMau;
}