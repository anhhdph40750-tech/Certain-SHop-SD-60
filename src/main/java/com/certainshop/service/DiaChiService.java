package com.certainshop.service;

import com.certainshop.entity.DiaChiNguoiDung;
import com.certainshop.entity.NguoiDung;
import com.certainshop.repository.DiaChiNguoiDungRepository;
import com.certainshop.repository.NguoiDungRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class DiaChiService {

    private final DiaChiNguoiDungRepository diaChiRepository;
    private final NguoiDungRepository nguoiDungRepository;

    @Transactional(readOnly = true)
    public List<DiaChiNguoiDung> layDanhSachDiaChi(Long nguoiDungId) {
        return diaChiRepository.findByNguoiDungIdOrderByLaMacDinhDesc(nguoiDungId);
    }

    @Transactional(readOnly = true)
    public Optional<DiaChiNguoiDung> layDiaChiMacDinh(Long nguoiDungId) {
        return diaChiRepository.findByNguoiDungIdAndLaMacDinhTrue(nguoiDungId);
    }

    public DiaChiNguoiDung themDiaChi(Long nguoiDungId, DiaChiNguoiDung diaChi) {
        NguoiDung nguoiDung = nguoiDungRepository.findById(nguoiDungId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        diaChi.setNguoiDung(nguoiDung);

        if (Boolean.TRUE.equals(diaChi.getLaMacDinh())) {
            diaChiRepository.boMacDinhTatCaDiaChi(nguoiDungId);
        } else if (diaChiRepository.countByNguoiDungId(nguoiDungId) == 0) {
            // Địa chỉ đầu tiên tự động là mặc định
            diaChi.setLaMacDinh(true);
        }

        return diaChiRepository.save(diaChi);
    }

    public DiaChiNguoiDung capNhatDiaChi(Long id, DiaChiNguoiDung diaChiMoi, Long nguoiDungId) {
        DiaChiNguoiDung diaChi = diaChiRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy địa chỉ"));

        if (!diaChi.getNguoiDung().getId().equals(nguoiDungId)) {
            throw new SecurityException("Không có quyền cập nhật địa chỉ này");
        }

        if (Boolean.TRUE.equals(diaChiMoi.getLaMacDinh()) && !Boolean.TRUE.equals(diaChi.getLaMacDinh())) {
            diaChiRepository.boMacDinhTatCaDiaChi(nguoiDungId);
        }

        diaChi.setHoTen(diaChiMoi.getHoTen());
        diaChi.setSoDienThoai(diaChiMoi.getSoDienThoai());
        diaChi.setDiaChiDong1(diaChiMoi.getDiaChiDong1());
        diaChi.setPhuongXa(diaChiMoi.getPhuongXa());
        diaChi.setQuanHuyen(diaChiMoi.getQuanHuyen());
        diaChi.setTinhThanh(diaChiMoi.getTinhThanh());
        diaChi.setMaTinhGHN(diaChiMoi.getMaTinhGHN());
        diaChi.setMaHuyenGHN(diaChiMoi.getMaHuyenGHN());
        diaChi.setMaXaGHN(diaChiMoi.getMaXaGHN());
        diaChi.setLaMacDinh(diaChiMoi.getLaMacDinh());

        return diaChiRepository.save(diaChi);
    }

    public void xoaDiaChi(Long id, Long nguoiDungId) {
        DiaChiNguoiDung diaChi = diaChiRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy địa chỉ"));

        if (!diaChi.getNguoiDung().getId().equals(nguoiDungId)) {
            throw new SecurityException("Không có quyền xóa địa chỉ này");
        }
        diaChiRepository.delete(diaChi);

        // Nếu xóa địa chỉ mặc định, set địa chỉ đầu tiên còn lại làm mặc định
        if (Boolean.TRUE.equals(diaChi.getLaMacDinh())) {
            List<DiaChiNguoiDung> conLai = diaChiRepository.findByNguoiDungIdOrderByLaMacDinhDesc(nguoiDungId);
            if (!conLai.isEmpty()) {
                DiaChiNguoiDung dau = conLai.get(0);
                dau.setLaMacDinh(true);
                diaChiRepository.save(dau);
            }
        }
    }

    public void datLamMacDinh(Long id, Long nguoiDungId) {
        DiaChiNguoiDung diaChi = diaChiRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy địa chỉ"));

        if (!diaChi.getNguoiDung().getId().equals(nguoiDungId)) {
            throw new SecurityException("Không có quyền cập nhật địa chỉ này");
        }

        diaChiRepository.boMacDinhTatCaDiaChi(nguoiDungId);
        diaChi.setLaMacDinh(true);
        diaChiRepository.save(diaChi);
    }
}
