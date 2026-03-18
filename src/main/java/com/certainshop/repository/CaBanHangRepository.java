package com.certainshop.repository;

import com.certainshop.entity.CaBanHang;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface CaBanHangRepository extends JpaRepository<CaBanHang, Long> {

    @Query("SELECT c FROM CaBanHang c WHERE c.nhanVien.id = :nhanVienId AND c.trangThai = 'DANG_MO'")
    Optional<CaBanHang> findCaDangMo(@Param("nhanVienId") Long nhanVienId);
}
