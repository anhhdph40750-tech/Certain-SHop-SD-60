package com.example.certainshop.repository;

import com.example.certainshop.entity.BienThe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BienTheRepository extends JpaRepository<BienThe, Long> {
}