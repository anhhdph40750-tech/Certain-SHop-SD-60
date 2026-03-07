package com.example.certainshop.service;

import com.example.certainshop.entity.SanPham;
import com.example.certainshop.repository.SanPhamRepository;
import com.example.certainshop.repository.BienTheRepository;
import lombok.RequiredArgsConstructor;
import org.hibernate.Hibernate;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class SanPhamService {

    private final SanPhamRepository sanPhamRepository;
    private final BienTheRepository bienTheRepository;  // Thêm dòng này

    public List<SanPham> getAllSanPham() {
        List<SanPham> sanPhams = sanPhamRepository.findByTrangThaiTrue();

        sanPhams.forEach(sp -> {
            Hibernate.initialize(sp.getBienTheList());
            sp.getBienTheList().forEach(bt -> Hibernate.initialize(bt.getHinhAnhList()));
        });

        return sanPhams;
    }
}