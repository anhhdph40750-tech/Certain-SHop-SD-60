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
import org.springframework.beans.factory.annotation.Autowired;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import com.certainshop.util.ExcelHelper;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.InputStream;
import java.nio.file.*;
import java.text.Normalizer;
import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;
import java.util.Optional;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Transactional
public class SanPhamService {

    @Autowired
    private SanPhamRepository sanPhamRepository;

    @Autowired
    private BienTheRepository bienTheRepository;

    @Autowired
    private DanhMucRepository danhMucRepository;

    @Autowired
    private ThuongHieuRepository thuongHieuRepository;

    @Autowired
    private KichThuocRepository kichThuocRepository;

    @Autowired
    private MauSacRepository mauSacRepository;
    @Autowired
    private ChatLieuRepository chatLieuRepository;
    @Autowired
    private HinhAnhBienTheRepository hinhAnhBienTheRepository;

    /**
     * Tạo sản phẩm mới cùng biến thể
     */
    public SanPham taoSanPham(SanPhamDto dto) {
        if (dto.getTenSanPham() == null || dto.getTenSanPham().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên sản phẩm không được để trống");
        }
        if (dto.getDanhMucId() == null) {
            throw new IllegalArgumentException("Danh mục không được để trống");
        }

        // Validate trùng tên
        if (sanPhamRepository.existsByTenSanPham(dto.getTenSanPham())) {
            throw new IllegalArgumentException("Tên sản phẩm đã tồn tại");
        }

        if (dto.getGiaGoc() == null || dto.getGiaGoc().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá gốc phải lớn hơn 0");
        }

        DanhMuc danhMuc = danhMucRepository.findById(dto.getDanhMucId())
                .orElseThrow(() -> new RuntimeException("Danh mục không tồn tại"));

        ThuongHieu thuongHieu = null;
        if (dto.getThuongHieuId() != null) {
            thuongHieu = thuongHieuRepository.findById(dto.getThuongHieuId()).orElse(null);
        }

        SanPham sanPham = SanPham.builder()
                .maSanPham("SP_" + UUID.randomUUID().toString().substring(0, 8).toUpperCase())
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

        if (dto.getTenSanPham() == null || dto.getTenSanPham().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên sản phẩm không được để trống");
        }
        if (dto.getDanhMucId() == null) {
            throw new IllegalArgumentException("Danh mục không được để trống");
        }

        if (sanPhamRepository.existsByTenSanPhamAndIdNot(dto.getTenSanPham(), id)) {
            throw new IllegalArgumentException("Tên sản phẩm đã tồn tại");
        }

        if (dto.getGiaGoc() == null || dto.getGiaGoc().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá gốc phải lớn hơn 0");
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
     * Ngừng bán sản phẩm (soft delete - chuyển trạng thái sang NGUNG_BAN)
     */
    public void xoaSanPham(Long id) {
        SanPham sanPham = sanPhamRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        sanPham.setTrangThaiSanPham("NGUNG_BAN");
        sanPham.setTrangThai(false);
        sanPhamRepository.save(sanPham);
    }

    /**
     * Toggle trạng thái sản phẩm: DANG_BAN ↔ NGUNG_BAN
     */
    public String toggleTrangThai(Long id) {
        SanPham sanPham = sanPhamRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        if ("DANG_BAN".equals(sanPham.getTrangThaiSanPham())) {
            sanPham.setTrangThaiSanPham("NGUNG_BAN");
            sanPham.setTrangThai(false);
        } else {
            sanPham.setTrangThaiSanPham("DANG_BAN");
            sanPham.setTrangThai(true);
        }
        sanPhamRepository.save(sanPham);
        return sanPham.getTrangThaiSanPham();
    }

    public ByteArrayInputStream xuatExcel() {
        List<SanPham> sanPhams = sanPhamRepository.findAll();
        return ExcelHelper.sanPhamsToExcel(sanPhams);
    }

    @Transactional
    public void nhapExcel(MultipartFile file) {
        try {
            Workbook workbook = new XSSFWorkbook(file.getInputStream());
            Sheet sheet = workbook.getSheet(ExcelHelper.SHEET);
            if (sheet == null) {
                sheet = workbook.getSheetAt(0);
            }

            java.util.Iterator<Row> rows = sheet.iterator();
            int rowNumber = 0;

            while (rows.hasNext()) {
                Row currentRow = rows.next();
                if (rowNumber == 0) {
                    rowNumber++;
                    continue; // Skip header
                }

                String maSanPham = "";
                if (currentRow.getCell(0) != null) {
                    if (currentRow.getCell(0).getCellType() == CellType.STRING) {
                         maSanPham = currentRow.getCell(0).getStringCellValue();
                    } else if (currentRow.getCell(0).getCellType() == CellType.NUMERIC) {
                         maSanPham = String.valueOf((long) currentRow.getCell(0).getNumericCellValue());
                    }
                }
                
                String tenSanPham = currentRow.getCell(1) != null ? currentRow.getCell(1).getStringCellValue() : "";
                double giaGoc = currentRow.getCell(2) != null ? currentRow.getCell(2).getNumericCellValue() : 0;
                double giaBan = currentRow.getCell(3) != null ? currentRow.getCell(3).getNumericCellValue() : 0;
                long danhMucId = currentRow.getCell(4) != null ? (long) currentRow.getCell(4).getNumericCellValue() : 0;
                long thuongHieuId = currentRow.getCell(5) != null ? (long) currentRow.getCell(5).getNumericCellValue() : 0;

                long kichThuocId = currentRow.getCell(6) != null ? (long) currentRow.getCell(6).getNumericCellValue() : 0;
                long mauSacId = currentRow.getCell(7) != null ? (long) currentRow.getCell(7).getNumericCellValue() : 0;
                double giaBienThe = currentRow.getCell(8) != null ? currentRow.getCell(8).getNumericCellValue() : 0;
                int soLuongTon = currentRow.getCell(9) != null ? (int) currentRow.getCell(9).getNumericCellValue() : 0;

                if (tenSanPham.trim().isEmpty()) {
                    continue;
                }

                SanPham sp = null;
                if (!maSanPham.trim().isEmpty()) {
                    final String mSP = maSanPham.trim();
                    Optional<SanPham> opt = sanPhamRepository.findAll().stream().filter(s -> mSP.equals(s.getMaSanPham())).findFirst();
                    if (opt.isPresent()) {
                        sp = opt.get();
                    }
                }

                if (sp == null) {
                    sp = new SanPham();
                    sp.setMaSanPham(maSanPham.isEmpty() ? "SP_" + UUID.randomUUID().toString().substring(0, 8) : maSanPham);
                    sp.setTenSanPham(tenSanPham);
                    sp.setGiaGoc(BigDecimal.valueOf(giaGoc));
                    sp.setGiaBan(BigDecimal.valueOf(giaBan));
                    sp.setDuongDan(taoDuongDan(tenSanPham) + "-" + System.currentTimeMillis() % 1000);
                    sp.setTrangThaiSanPham("DANG_BAN");
                    sp.setTrangThai(true);

                    if (danhMucId > 0) {
                        danhMucRepository.findById(danhMucId).ifPresent(sp::setDanhMuc);
                    }
                    if (thuongHieuId > 0) {
                        thuongHieuRepository.findById(thuongHieuId).ifPresent(sp::setThuongHieu);
                    }
                    sp = sanPhamRepository.save(sp);
                }

                if (kichThuocId > 0 && mauSacId > 0) {
                    final SanPham finalSp = sp;
                    boolean exists = false;
                    List<BienThe> bts = bienTheRepository.findBySanPhamId(finalSp.getId());
                    if (bts != null && !bts.isEmpty()) {
                        exists = bts.stream().anyMatch(bt ->
                                bt.getKichThuoc() != null && bt.getKichThuoc().getId() == kichThuocId &&
                                bt.getMauSac() != null && bt.getMauSac().getId() == mauSacId
                        );
                    }
                    if (!exists) {
                        BienThe bt = new BienThe();
                        bt.setSanPham(finalSp);
                        kichThuocRepository.findById(kichThuocId).ifPresent(bt::setKichThuoc);
                        mauSacRepository.findById(mauSacId).ifPresent(bt::setMauSac);
                        bt.setGia(BigDecimal.valueOf(giaBienThe > 0 ? giaBienThe : giaBan));
                        bt.setSoLuongTon(soLuongTon);
                        bt.setMacDinh(bts == null || bts.isEmpty());
                        bienTheRepository.save(bt);
                    }
                }
            }
            workbook.close();
        } catch (IOException e) {
            throw new RuntimeException("Lỗi nhập dữ liệu từ file Excel: " + e.getMessage());
        }
    }

    /**
     * Tạo biến thể cho sản phẩm
     */
    public BienThe taoBienThe(Long sanPhamId, BienTheDto dto) {
        if (dto.getGia() == null || dto.getGia().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá biến thể phải lớn hơn 0");
        }
        if (dto.getSoLuongTon() == null || dto.getSoLuongTon() < 0) {
            throw new IllegalArgumentException("Số lượng tồn không được âm");
        }
        if (dto.getKichThuocId() == null) {
            throw new IllegalArgumentException("Kích thước không được để trống");
        }
        if (dto.getMauSacId() == null) {
            throw new IllegalArgumentException("Màu sắc không được để trống");
        }

        SanPham sanPham = sanPhamRepository.findById(sanPhamId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        // Kiểm tra trùng biến thể
        long excludeId = dto.getId() != null ? dto.getId() : -1L;
        boolean trung = bienTheRepository.kiemTraTrungBienThe(
                sanPhamId, dto.getKichThuocId(), dto.getMauSacId(), dto.getChatLieuId(), excludeId);
        if (trung) {
            throw new IllegalArgumentException("Biến thể với tổ hợp kích thước, màu sắc, chất liệu này đã tồn tại");
        }

        KichThuoc kichThuoc = kichThuocRepository.findById(dto.getKichThuocId())
                .orElseThrow(() -> new RuntimeException("Kích thước không tồn tại"));
        MauSac mauSac = mauSacRepository.findById(dto.getMauSacId())
                .orElseThrow(() -> new RuntimeException("Màu sắc không tồn tại"));
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

    /**
     * Tạo nhiều biến thể cùng lúc (bulk add) cho sản phẩm đã tồn tại
     */
    public List<BienThe> taoBulkBienThe(Long sanPhamId, List<BienTheDto> danhSach) {
        SanPham sanPham = sanPhamRepository.findById(sanPhamId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy sản phẩm"));

        List<BienThe> result = new ArrayList<>();
        boolean daDatMacDinh = false;

        // Kiểm tra xem có biến thể mặc định nào chưa
        List<BienThe> existingVariants = bienTheRepository.findBySanPhamId(sanPhamId);
        daDatMacDinh = existingVariants.stream().anyMatch(BienThe::getMacDinh);

        for (int i = 0; i < danhSach.size(); i++) {
            BienTheDto dto = danhSach.get(i);
            dto.setSanPhamId(sanPhamId);

            // Nếu chưa có biến thể mặc định, set biến thể đầu tiên làm mặc định
            if (!daDatMacDinh && i == 0) {
                dto.setMacDinh(true);
                daDatMacDinh = true;
            }

            result.add(taoBienThe(sanPhamId, dto));
        }

        return result;
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
    public BienThe capNhatBienThe(Long bienTheId, BienTheDto dto) {
        if (dto.getGia() == null || dto.getGia().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá biến thể phải lớn hơn 0");
        }
        if (dto.getSoLuongTon() == null || dto.getSoLuongTon() < 0) {
            throw new IllegalArgumentException("Số lượng tồn không được âm");
        }
        if (dto.getKichThuocId() == null) {
            throw new IllegalArgumentException("Kích thước không được để trống");
        }
        if (dto.getMauSacId() == null) {
            throw new IllegalArgumentException("Màu sắc không được để trống");
        }

        BienThe bienThe = bienTheRepository.findById(bienTheId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy biến thể"));

        boolean trung = bienTheRepository.kiemTraTrungBienThe(
                bienThe.getSanPham().getId(), dto.getKichThuocId(),
                dto.getMauSacId(), dto.getChatLieuId(), bienTheId);
        if (trung) {
            throw new IllegalArgumentException("Biến thể này đã tồn tại");
        }

        KichThuoc kichThuoc = kichThuocRepository.findById(dto.getKichThuocId())
                .orElseThrow(() -> new RuntimeException("Kích thước không tồn tại"));
        MauSac mauSac = mauSacRepository.findById(dto.getMauSacId())
                .orElseThrow(() -> new RuntimeException("Màu sắc không tồn tại"));
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
        if (file == null || file.isEmpty() || file.getSize() <= 0) {
            throw new IllegalArgumentException("File ảnh không hợp lệ");
        }
        String contentType = file.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            throw new IllegalArgumentException("File phải là ảnh (image/*)");
        }
        long maxSize = 5L * 1024L * 1024L; // 5MB
        if (file.getSize() > maxSize) {
            throw new IllegalArgumentException("Dung lượng ảnh không được vượt quá 5MB");
        }

        BienThe bienThe = bienTheRepository.findById(bienTheId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy biến thể"));

        String originalFilename = file.getOriginalFilename();
        String ext = "";
        if (originalFilename != null && originalFilename.lastIndexOf(".") > -1) {
            ext = originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        String tenFile = UUID.randomUUID() + ext;
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
