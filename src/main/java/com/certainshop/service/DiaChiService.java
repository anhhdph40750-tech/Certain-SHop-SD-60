package com.certainshop.service;

import com.certainshop.dto.DiaChiChiTietDto;
import com.certainshop.entity.DiaChiNguoiDung;
import com.certainshop.entity.NguoiDung;
import com.certainshop.repository.DiaChiNguoiDungRepository;
import com.certainshop.repository.NguoiDungRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class DiaChiService {

    @Autowired
    private DiaChiNguoiDungRepository diaChiRepository;
    @Autowired
    private NguoiDungRepository nguoiDungRepository;

    @Transactional(readOnly = true)
    public List<DiaChiNguoiDung> layDanhSachDiaChi(Long nguoiDungId) {
        return diaChiRepository.findByNguoiDungIdOrderByLaMacDinhDesc(nguoiDungId);
    }

    @Transactional(readOnly = true)
    public Optional<DiaChiNguoiDung> layDiaChiMacDinh(Long nguoiDungId) {
        return diaChiRepository.findByNguoiDungIdAndLaMacDinhTrue(nguoiDungId);
    }

    private static final org.slf4j.Logger log
            = org.slf4j.LoggerFactory.getLogger(DiaChiService.class);

    /**
     * Lấy danh sách địa chỉ của khách hàng (dạng DTO)
     */
    @Transactional(readOnly = true)
    public List<DiaChiChiTietDto> layDanhSachDiaChiDto(NguoiDung nguoiDung) {
        return diaChiRepository.findByNguoiDungIdOrderByLaMacDinhDesc(nguoiDung.getId()).stream()
                .map(this::convertToDto)
                .collect(Collectors.toList());
    }

    /**
     * Lấy địa chỉ mặc định (dạng DTO)
     */
    @Transactional(readOnly = true)
    public Optional<DiaChiChiTietDto> layDiaChiMacDinhDto(NguoiDung nguoiDung) {
        return diaChiRepository.findByNguoiDungIdAndLaMacDinhTrue(nguoiDung.getId())
                .map(this::convertToDto);
    }

    /**
     * Lấy chi tiết một địa chỉ (dạng DTO)
     */
    @Transactional(readOnly = true)
    public Optional<DiaChiChiTietDto> layDiaChiChiTietDto(Long diaChiId, NguoiDung nguoiDung) {
        Optional<DiaChiNguoiDung> diaChi = diaChiRepository.findById(diaChiId);
        if (diaChi.isEmpty()) {
            return Optional.empty();
        }

        // Kiểm tra quyền sở hữu
        if (!diaChi.get().getNguoiDung().getId().equals(nguoiDung.getId())) {
            log.warn("Người dùng {} cố gắng truy cập địa chỉ của người khác", nguoiDung.getId());
            return Optional.empty();
        }

        return diaChi.map(this::convertToDto);
    }

    /**
     * Tạo địa chỉ mới (dạng DTO)
     */
    public DiaChiChiTietDto taoDiaChiDto(NguoiDung nguoiDung, DiaChiChiTietDto dto) {
        // Nếu không có địa chỉ nào, set mặc định
        boolean isFirst = diaChiRepository.findByNguoiDungIdOrderByLaMacDinhDesc(nguoiDung.getId()).isEmpty();

        DiaChiNguoiDung diaChi = new DiaChiNguoiDung();

        diaChi.setNguoiDung(nguoiDung);
        diaChi.setHoTen(dto.getHoTen());
        diaChi.setSoDienThoai(dto.getSoDienThoai());
        diaChi.setDiaChiDong1(dto.getDiaChiDong1());
        diaChi.setPhuongXa(dto.getPhuongXa());
        diaChi.setQuanHuyen(dto.getQuanHuyen());
        diaChi.setTinhThanh(dto.getTinhThanh());
        diaChi.setMaTinhGHN(dto.getMaTinhGHN());
        diaChi.setMaHuyenGHN(dto.getMaHuyenGHN());
        diaChi.setMaXaGHN(dto.getMaXaGHN());
        diaChi.setLaMacDinh(isFirst || Boolean.TRUE.equals(dto.getLaMacDinh()));
        diaChi.setThoiGianTao(LocalDateTime.now());
        DiaChiNguoiDung saved = diaChiRepository.save(diaChi);
        log.info("Tạo địa chỉ mới cho người dùng {}: {}", nguoiDung.getId(), saved.getId());

        return convertToDto(saved);
    }

    /**
     * Cập nhật địa chỉ (dạng DTO)
     */
    public DiaChiChiTietDto capNhatDiaChiDto(Long diaChiId, NguoiDung nguoiDung, DiaChiChiTietDto dto) {
        Optional<DiaChiNguoiDung> existing = diaChiRepository.findById(diaChiId);
        if (existing.isEmpty()) {
            throw new RuntimeException("Địa chỉ không tồn tại");
        }

        DiaChiNguoiDung diaChi = existing.get();

        // Kiểm tra quyền sở hữu
        if (!diaChi.getNguoiDung().getId().equals(nguoiDung.getId())) {
            throw new RuntimeException("Không có quyền cập nhật địa chỉ này");
        }

        // Cập nhật
        diaChi.setHoTen(dto.getHoTen());
        diaChi.setSoDienThoai(dto.getSoDienThoai());
        diaChi.setDiaChiDong1(dto.getDiaChiDong1());
        diaChi.setPhuongXa(dto.getPhuongXa());
        diaChi.setQuanHuyen(dto.getQuanHuyen());
        diaChi.setTinhThanh(dto.getTinhThanh());
        diaChi.setMaTinhGHN(dto.getMaTinhGHN());
        diaChi.setMaHuyenGHN(dto.getMaHuyenGHN());
        diaChi.setMaXaGHN(dto.getMaXaGHN());

        // Nếu đặt làm mặc định, bỏ mặc định với các địa chỉ khác
        if (Boolean.TRUE.equals(dto.getLaMacDinh())) {
            diaChiRepository.findByNguoiDungIdAndLaMacDinhTrue(nguoiDung.getId())
                    .filter(d -> !d.getId().equals(diaChiId))
                    .ifPresent(d -> {
                        d.setLaMacDinh(false);
                        diaChiRepository.save(d);
                    });
            diaChi.setLaMacDinh(true);
        }

        diaChi.setThoiGianCapNhat(LocalDateTime.now());
        DiaChiNguoiDung updated = diaChiRepository.save(diaChi);

        log.info("Cập nhật địa chỉ {} cho người dùng {}", diaChiId, nguoiDung.getId());
        return convertToDto(updated);
    }

    /**
     * Xóa địa chỉ
     */
    public void xoaDiaChiDto(Long diaChiId, NguoiDung nguoiDung) {
        Optional<DiaChiNguoiDung> existing = diaChiRepository.findById(diaChiId);
        if (existing.isEmpty()) {
            throw new RuntimeException("Địa chỉ không tồn tại");
        }

        DiaChiNguoiDung diaChi = existing.get();

        // Kiểm tra quyền sở hữu
        if (!diaChi.getNguoiDung().getId().equals(nguoiDung.getId())) {
            throw new RuntimeException("Không có quyền xóa địa chỉ này");
        }

        diaChiRepository.deleteById(diaChiId);
        log.info("Xóa địa chỉ {} của người dùng {}", diaChiId, nguoiDung.getId());
    }

    /**
     * Đặt địa chỉ làm mặc định
     */
    public void datDiaChiMacDinhDto(Long diaChiId, NguoiDung nguoiDung) {
        Optional<DiaChiNguoiDung> existing = diaChiRepository.findById(diaChiId);
        if (existing.isEmpty()) {
            throw new RuntimeException("Địa chỉ không tồn tại");
        }

        DiaChiNguoiDung diaChi = existing.get();

        // Kiểm tra quyền sở hữu
        if (!diaChi.getNguoiDung().getId().equals(nguoiDung.getId())) {
            throw new RuntimeException("Không có quyền cập nhật địa chỉ này");
        }

        // Bỏ mặc định với địa chỉ cũ
        diaChiRepository.findByNguoiDungIdAndLaMacDinhTrue(nguoiDung.getId())
                .ifPresent(d -> {
                    d.setLaMacDinh(false);
                    diaChiRepository.save(d);
                });

        // Đặt mặc định
        diaChi.setLaMacDinh(true);
        diaChiRepository.save(diaChi);

        log.info("Đặt địa chỉ {} làm mặc định cho người dùng {}", diaChiId, nguoiDung.getId());
    }

    // ===== Methods cũ (giữ lại cho tương thích) =====
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

    /**
     * Convert entity to DTO
     */
    private DiaChiChiTietDto convertToDto(DiaChiNguoiDung entity) {
        DiaChiChiTietDto dto = new DiaChiChiTietDto();

        dto.setId(entity.getId());
        dto.setHoTen(entity.getHoTen());
        dto.setSoDienThoai(entity.getSoDienThoai());
        dto.setDiaChiDong1(entity.getDiaChiDong1());
        dto.setPhuongXa(entity.getPhuongXa());
        dto.setQuanHuyen(entity.getQuanHuyen());
        dto.setTinhThanh(entity.getTinhThanh());
        dto.setMaTinhGHN(entity.getMaTinhGHN());
        dto.setMaHuyenGHN(entity.getMaHuyenGHN());
        dto.setMaXaGHN(entity.getMaXaGHN());
        dto.setLaMacDinh(entity.getLaMacDinh());
        dto.setThoiGianTao(entity.getThoiGianTao());

        return dto;
    }
}
