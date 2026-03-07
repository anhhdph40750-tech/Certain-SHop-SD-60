package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "KichThuoc")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class KichThuoc {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "KichCo", length = 50)
    private String kichCo;
}