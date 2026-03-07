package com.certainshop.repository;

import com.certainshop.entity.GioHangChiTiet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface GioHangChiTietRepository extends JpaRepository<GioHangChiTiet, Long> {
    Optional<GioHangChiTiet> findByGioHangIdAndBienTheId(Long gioHangId, Long bienTheId);
    void deleteByGioHangId(Long gioHangId);
}
