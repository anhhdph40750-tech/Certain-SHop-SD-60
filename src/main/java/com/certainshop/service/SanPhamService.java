package com.certainshop.service;

import com.certainshop.dto.BienTheDto;
import com.certainshop.dto.SanPhamDto;
import com.certainshop.entity.*;
import com.certainshop.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.text.Normalizer;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional
public class SanPhamService {

    private final SanPhamRepository sanPhamRepository;
    private final BienTheRepository bienTheRepository;
    private final DanhMucRepository danhMucRepository;
    private final ThuongHieuRepository thuongHieuRepository;
    private final KichThuocRepository kichThuocRepository;
    private final MauSacRepository mauSacRepository;
    private final ChatLieuRepository chatLieuRepository;
    private final HinhAnhBienTheRepository hinhAnhBienTheRepository;

    /**
     * Tạo sản phẩm mới cùng biến thể
     */
    public SanPham taoSanPham(SanPhamDto dto) {
        // Validate trùng tên
        if (sanPhamRepository.existsByTenSanPham(dto.getTenSanPham())) {
            throw new IllegalArgumentException("Tên sản phẩm đã tồn tại");
        }

        DanhMuc danhMuc = danhMucRepository.findById(dto.getDanhMucId())
                .orElseThrow(() -> new RuntimeException("Danh mục không tồn tại"));

        ThuongHieu thuongHieu = null;
        if (dto.getThuongHieuId() != null) {
            thuongHieu = thuongHieuRepository.findById(dto.getThuongHieuId()).orElse(null);
        }

        SanPham sanPham = SanPham.builder()
                .tenSanPham(dto.getTenSanPham())
                .duongDan(taoDuongDan(dto.getTenSanPham()))
                .moTa(dto.getMoTaChiTiet())
                .giaGoc(dto.getGiaGoc())
                .giaBan(dto.getGiaGoc()) // giaBan defaults to giaGoc
                .danhMuc(danhMuc)
                .thuongHieu(thuongHieu)
                .trangThaiSanPham(Boolean.FALSE.equals(dto.getTrangThai()) ? "NGUNG_BAN" : "DANG_BAN")
                .build();

        sanPham = sanPhamRepository.save(sanPham);

        // Tạo biến thể
        if (dto.getDanhSachBienThe() != null && !dto.getDanhSachBienThe().isEmpty()) {
            taoNhieuBienThe(sanPham, dto.getDanhSachBienThe());
        }

        return sanPham;
    }

    /**
     * Cập nhật sản phẩm
     */
    public SanPham capNhatSanPham(Long id, SanPhamDto dto) {
        SanPham sanPham = sanPhamRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        if (sanPhamRepository.existsByTenSanPhamAndIdNot(dto.getTenSanPham(), id)) {
            throw new IllegalArgumentException("Tên sản phẩm đã tồn tại");
        }

        DanhMuc danhMuc = danhMucRepository.findById(dto.getDanhMucId())
                .orElseThrow(() -> new RuntimeException("Danh mục không tồn tại"));

        ThuongHieu thuongHieu = null;
        if (dto.getThuongHieuId() != null) {
            thuongHieu = thuongHieuRepository.findById(dto.getThuongHieuId()).orElse(null);
        }

        sanPham.setTenSanPham(dto.getTenSanPham());
        sanPham.setDuongDan(taoDuongDan(dto.getTenSanPham()));
        sanPham.setMoTa(dto.getMoTaChiTiet());
        sanPham.setGiaGoc(dto.getGiaGoc());
        sanPham.setGiaBan(dto.getGiaGoc()); // giaBan defaults to giaGoc
        sanPham.setDanhMuc(danhMuc);
        sanPham.setThuongHieu(thuongHieu);
        sanPham.setTrangThai(dto.getTrangThai() != null ? dto.getTrangThai() : true);

        return sanPhamRepository.save(sanPham);
    }

    /**
     * Xóa mềm sản phẩm
     */
    public void xoaSanPham(Long id) {
        SanPham sanPham = sanPhamRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));
        sanPham.setTrangThai(false);
        // Xóa mềm tất cả biến thể
        List<BienThe> bienThes = bienTheRepository.findBySanPhamId(id);
        bienThes.forEach(bt -> bt.setTrangThai(false));
        bienTheRepository.saveAll(bienThes);
        sanPhamRepository.save(sanPham);
    }

    /**
     * Tạo biến thể cho sản phẩm
     */
    public BienThe taoBienThe(Long sanPhamId, BienTheDto dto) {
        SanPham sanPham = sanPhamRepository.findById(sanPhamId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        // Kiểm tra trùng biến thể
        long excludeId = dto.getId() != null ? dto.getId() : -1L;
        boolean trung = bienTheRepository.kiemTraTrungBienThe(
                sanPhamId, dto.getKichThuocId(), dto.getMauSacId(), dto.getChatLieuId(), excludeId);
        if (trung) {
            throw new IllegalArgumentException("Biến thể với tổ hợp kích thước, màu sắc, chất liệu này đã tồn tại");
        }

        KichThuoc kichThuoc = dto.getKichThuocId() != null ?
                kichThuocRepository.findById(dto.getKichThuocId()).orElse(null) : null;
        MauSac mauSac = dto.getMauSacId() != null ?
                mauSacRepository.findById(dto.getMauSacId()).orElse(null) : null;
        ChatLieu chatLieu = dto.getChatLieuId() != null ?
                chatLieuRepository.findById(dto.getChatLieuId()).orElse(null) : null;

        BienThe bienThe = BienThe.builder()
                .sanPham(sanPham)
                .kichThuoc(kichThuoc)
                .mauSac(mauSac)
                .chatLieu(chatLieu)
                .gia(dto.getGia())
                .soLuongTon(dto.getSoLuongTon())
                .macDinh(dto.getMacDinh() != null ? dto.getMacDinh() : false)
                .trangThai(true)
                .build();

        // Nếu là mặc định, bỏ mặc định của các biến thể khác
        if (Boolean.TRUE.equals(dto.getMacDinh())) {
            danhSachBienTheCuaSanPham(sanPhamId).forEach(bt -> {
                bt.setMacDinh(false);
                bienTheRepository.save(bt);
            });
        }

        return bienTheRepository.save(bienThe);
    }

    private void taoNhieuBienThe(SanPham sanPham, List<BienTheDto> danhSach) {
        boolean daDatMacDinh = false;
        for (int i = 0; i < danhSach.size(); i++) {
            BienTheDto dto = danhSach.get(i);
            dto.setSanPhamId(sanPham.getId());
            // Biến thể đầu tiên là mặc định nếu chưa có
            if (i == 0 && !daDatMacDinh) {
                dto.setMacDinh(true);
                daDatMacDinh = true;
            }
            if (Boolean.TRUE.equals(dto.getMacDinh())) daDatMacDinh = true;
            taoBienThe(sanPham.getId(), dto);
        }
    }

    /**
     * Cập nhật biến thể
     */
    public BienThe capNhatBienThe(Long bienTheId, BienTheDto dto) {
        BienThe bienThe = bienTheRepository.findById(bienTheId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy biến thể"));

        boolean trung = bienTheRepository.kiemTraTrungBienThe(
                bienThe.getSanPham().getId(), dto.getKichThuocId(),
                dto.getMauSacId(), dto.getChatLieuId(), bienTheId);
        if (trung) {
            throw new IllegalArgumentException("Biến thể này đã tồn tại");
        }

        KichThuoc kichThuoc = dto.getKichThuocId() != null ?
                kichThuocRepository.findById(dto.getKichThuocId()).orElse(null) : null;
        MauSac mauSac = dto.getMauSacId() != null ?
                mauSacRepository.findById(dto.getMauSacId()).orElse(null) : null;
        ChatLieu chatLieu = dto.getChatLieuId() != null ?
                chatLieuRepository.findById(dto.getChatLieuId()).orElse(null) : null;

        bienThe.setKichThuoc(kichThuoc);
        bienThe.setMauSac(mauSac);
        bienThe.setChatLieu(chatLieu);
        bienThe.setGia(dto.getGia());
        bienThe.setSoLuongTon(dto.getSoLuongTon());
        bienThe.setTrangThai(dto.getTrangThai() != null ? dto.getTrangThai() : true);

        if (Boolean.TRUE.equals(dto.getMacDinh())) {
            danhSachBienTheCuaSanPham(bienThe.getSanPham().getId()).forEach(bt -> {
                bt.setMacDinh(false);
                bienTheRepository.save(bt);
            });
            bienThe.setMacDinh(true);
        }

        return bienTheRepository.save(bienThe);
    }

    /**
     * Xóa mềm biến thể
     */
    public void xoaBienThe(Long bienTheId) {
        BienThe bienThe = bienTheRepository.findById(bienTheId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy biến thể"));
        bienThe.setTrangThai(false);
        bienTheRepository.save(bienThe);
    }

    /**
     * Upload ảnh biến thể
     */
    public HinhAnhBienThe uploadAnhBienThe(Long bienTheId, MultipartFile file,
                                            boolean laAnhChinh, String uploadDir) throws IOException {
        BienThe bienThe = bienTheRepository.findById(bienTheId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy biến thể"));

        String tenFile = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path duongDan = Paths.get(uploadDir).resolve(tenFile);
        Files.createDirectories(duongDan.getParent());
        Files.copy(file.getInputStream(), duongDan, StandardCopyOption.REPLACE_EXISTING);

        if (laAnhChinh) {
            // Bỏ ảnh chính cũ
            hinhAnhBienTheRepository.findByBienTheIdAndLaAnhChinhTrue(bienTheId)
                    .ifPresent(h -> { h.setLaAnhChinh(false); hinhAnhBienTheRepository.save(h); });
        }

        HinhAnhBienThe hinhAnh = HinhAnhBienThe.builder()
                .bienThe(bienThe)
                .duongDan("/uploads/images/" + tenFile)
                .laAnhChinh(laAnhChinh)
                .thuTu(0)
                .moTa(file.getOriginalFilename())
                .build();

        hinhAnh = hinhAnhBienTheRepository.save(hinhAnh);

        // Cập nhật ảnh chính cho sản phẩm nếu chưa có hoặc đây là ảnh chính
        SanPham sanPham = bienThe.getSanPham();
        if (sanPham != null && (sanPham.getAnhChinh() == null || laAnhChinh)) {
            sanPham.setAnhChinh("/uploads/images/" + tenFile);
            sanPhamRepository.save(sanPham);
        }

        return hinhAnh;
    }

    /**
     * Xóa ảnh biến thể
     */
    public void xoaAnh(Long anhId) {
        hinhAnhBienTheRepository.deleteById(anhId);
    }

    // --- TÌM KIẾM ---

    @Transactional(readOnly = true)
    public Optional<SanPham> timTheoId(Long id) {
        return sanPhamRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public Page<SanPham> timKiemChoKhachHang(String tuKhoa, Long danhMucId,
                                               Long thuongHieuId, Pageable pageable) {
        return sanPhamRepository.timKiemVaLoc(tuKhoa, danhMucId, thuongHieuId, pageable);
    }

    @Transactional(readOnly = true)
    public Page<SanPham> timKiemAdmin(String tuKhoa, Long danhMucId,
                                       Long thuongHieuId, Boolean trangThai, Pageable pageable) {
        String trangThaiStr = trangThai == null ? null : (trangThai ? "DANG_BAN" : "NGUNG_BAN");
        return sanPhamRepository.timKiemAdmin(tuKhoa, danhMucId, thuongHieuId, trangThaiStr, pageable);
    }

    @Transactional(readOnly = true)
    public List<BienThe> danhSachBienTheCuaSanPham(Long sanPhamId) {
        return bienTheRepository.findBySanPhamId(sanPhamId);
    }

    @Transactional(readOnly = true)
    public Optional<BienThe> timBienTheTheoId(Long id) {
        return bienTheRepository.findById(id);
    }

    @Transactional(readOnly = true)
    public List<BienThe> layBienTheSapHetHang(int nguong) {
        return bienTheRepository.findBienTheSapHetHang(nguong);
    }

    @Transactional(readOnly = true)
    public Page<SanPham> layTheoCategory(String duongDan, Pageable pageable) {
        return sanPhamRepository.findByDanhMucDuongDan(duongDan, pageable);
    }

    @Transactional(readOnly = true)
    public Optional<SanPham> timTheoDuongDan(String duongDan) {
        return sanPhamRepository.findByDuongDan(duongDan);
    }

    @Transactional(readOnly = true)
    public Page<SanPham> timTheoSlugDanhMuc(String duongDan, Pageable pageable) {
        return sanPhamRepository.findByDanhMucDuongDan(duongDan, pageable);
    }

    @Transactional(readOnly = true)
    public List<SanPham> timSanPhamBanChay(Pageable pageable) {
        java.time.LocalDateTime tuNgay = java.time.LocalDateTime.now().minusDays(30);
        return sanPhamRepository.findSanPhamBanChay(tuNgay, pageable);
    }

    /**
     * Chuyển tên sản phẩm thành slug (đường dẫn thân thiện URL)
     */
    private String taoDuongDan(String ten) {
        if (ten == null) return null;
        String normalized = Normalizer.normalize(ten, Normalizer.Form.NFD);
        // Bỏ dấu tiếng Việt
        normalized = normalized.replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        // Xử lý đ/Đ
        normalized = normalized.replace("đ", "d").replace("Đ", "D");
        // Lowercase, chỉ giữ chữ/số/dấu cách
        normalized = normalized.toLowerCase().replaceAll("[^a-z0-9\\s-]", "");
        // Thay khoảng trắng bằng dấu gạch ngang
        normalized = normalized.trim().replaceAll("\\s+", "-");
        // Bỏ gạch ngang trùng
        normalized = normalized.replaceAll("-+", "-");
        return normalized;
    }
}
