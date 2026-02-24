package com.example.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "ChatLieu")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatLieu {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "TenChatLieu", length = 100)
    private String tenChatLieu;
}