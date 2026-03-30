package com.certainshop.service;

import com.certainshop.entity.Voucher;
import com.certainshop.repository.VoucherRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class VoucherService {

    private final VoucherRepository voucherRepository;

    /**
     * Tìm voucher theo mã
     */
    public Optional<Voucher> timTheoMa(String maVoucher) {
        return voucherRepository.findByMaVoucher(maVoucher);
    }

    /**
     * Kiểm tra & áp dụng voucher cho đơn hàng
     * @param maVoucher Mã voucher
     * @param giaTriDonHang Giá trị đơn hàng
     * @return Giá trị giảm, 0 nếu voucher không hợp lệ
     */
    public BigDecimal tinhGiaTriGiam(String maVoucher, BigDecimal giaTriDonHang) {
        Optional<Voucher> voucherOpt = timTheoMa(maVoucher);
        if (voucherOpt.isEmpty()) {
            log.warn("[Voucher] Voucher không tồn tại: {}", maVoucher);
            return BigDecimal.ZERO;
        }

        Voucher voucher = voucherOpt.get();

        // Validate voucher
        if (!voucher.isValid()) {
            log.warn("[Voucher] Voucher không hợp lệ hoặc hết hạn: {}", maVoucher);
            return BigDecimal.ZERO;
        }

        // Check minimum order value
        if (voucher.getGiaTriToiThieu() != null &&
                giaTriDonHang.compareTo(voucher.getGiaTriToiThieu()) < 0) {
            log.warn("[Voucher] Đơn hàng ({}) không đủ giá trị tối thiểu ({})",
                    giaTriDonHang, voucher.getGiaTriToiThieu());
            return BigDecimal.ZERO;
        }

        return voucher.tinhGiaTriGiam(giaTriDonHang);
    }

    /**
     * Danh sách voucher còn hiệu lực (cho customers)
     */
    @Transactional(readOnly = true)
    public List<Voucher> danhSachVoucherHoatDong() {
        return voucherRepository.findAllValidVouchers(LocalDateTime.now());
    }

    /**
     * Danh sách TẤT CẢ vouchers cho admin (Bao gồm ngừng hoạt động)
     */
    @Transactional(readOnly = false)
    public List<Voucher> danhSachChoAdmin() {
        LocalDateTime now = LocalDateTime.now();
        List<Voucher> vouchers = voucherRepository.findAllVouchers();

        for (Voucher v : vouchers) {
            boolean expired = v.getNgayKetThuc() != null && now.isAfter(v.getNgayKetThuc());
            boolean exhausted = v.getSoLuongToiDa() != null
                    && v.getSoLuongSuDung() != null
                    && v.getSoLuongSuDung() >= v.getSoLuongToiDa();

            if ((expired || exhausted) && Boolean.TRUE.equals(v.getTrangThai())) {
                v.setTrangThai(false);
                voucherRepository.save(v);
            }
        }

        return vouchers;
    }

    /**
     * Danh sách TẤT CẢ vouchers hoạt động (không bị xóa) cho checkout
     */
    @Transactional(readOnly = false)
    public List<Voucher> danhSachTatCaVoucher() {
        LocalDateTime now = LocalDateTime.now();
        List<Voucher> vouchers = voucherRepository.findAllActive();

        // Reset trạng thái khi hết hạn/hết lượt để FE không còn xem voucher đó như "đang hoạt động"
        for (Voucher v : vouchers) {
            boolean expired = v.getNgayKetThuc() != null && now.isAfter(v.getNgayKetThuc());
            boolean exhausted = v.getSoLuongToiDa() != null
                    && v.getSoLuongSuDung() != null
                    && v.getSoLuongSuDung() >= v.getSoLuongToiDa();

            if ((expired || exhausted) && Boolean.TRUE.equals(v.getTrangThai())) {
                v.setTrangThai(false);
                voucherRepository.save(v);
            }
        }

        return vouchers;
    }

    /**
     * Tăng số lần sử dụng voucher (gọi khi đơn hàng được xác nhận)
     */
    public void tangSoLanSuDung(String maVoucher) {
        Optional<Voucher> voucherOpt = timTheoMa(maVoucher);
        if (voucherOpt.isPresent()) {
            Voucher voucher = voucherOpt.get();
            voucher.setSoLuongSuDung(voucher.getSoLuongSuDung() != null ? voucher.getSoLuongSuDung() + 1 : 1);
            voucherRepository.save(voucher);
            log.info("[Voucher] Đã tăng lần sử dụng: {} (total: {})", maVoucher, voucher.getSoLuongSuDung());
        }
    }

    /**
     * Giảm số lần sử dụng voucher (gọi khi đơn hàng bị hủy)
     */
    public void giamSoLanSuDung(String maVoucher) {
        Optional<Voucher> voucherOpt = timTheoMa(maVoucher);
        if (voucherOpt.isPresent()) {
            Voucher voucher = voucherOpt.get();
            if (voucher.getSoLuongSuDung() != null && voucher.getSoLuongSuDung() > 0) {
                voucher.setSoLuongSuDung(voucher.getSoLuongSuDung() - 1);
                voucherRepository.save(voucher);
                log.info("[Voucher] Đã giảm lần sử dụng: {} (total: {})", maVoucher, voucher.getSoLuongSuDung());
            }
        }
    }

    /**
     * Tạo voucher mới (admin only)
     */
    public Voucher taoVoucher(Voucher voucher) {
        // Validate
        if (voucherRepository.existsByMaVoucher(voucher.getMaVoucher())) {
            throw new IllegalArgumentException("Mã voucher đã tồn tại: " + voucher.getMaVoucher());
        }

        if (voucher.getNgayBatDau() == null) {
            throw new IllegalArgumentException("Ngày bắt đầu không được để trống");
        }
        if (voucher.getNgayKetThuc() == null) {
            throw new IllegalArgumentException("Ngày kết thúc không được để trống");
        }
        if (voucher.getLoaiGiam() == null || voucher.getLoaiGiam().isBlank()) {
            throw new IllegalArgumentException("Loại giảm không được để trống");
        }
        if (voucher.getGiaTriGiam() == null) {
            throw new IllegalArgumentException("Giá trị giảm không được để trống");
        }
        if (voucher.getGiaTriGiamToiDa() == null) {
            throw new IllegalArgumentException("Giá trị giảm tối đa không được để trống");
        }

        if (voucher.getNgayBatDau().isAfter(voucher.getNgayKetThuc())) {
            throw new IllegalArgumentException("Ngày bắt đầu phải trước ngày kết thúc");
        }

        if (!"PERCENT".equals(voucher.getLoaiGiam()) && !"FIXED".equals(voucher.getLoaiGiam())) {
            throw new IllegalArgumentException("Loại giảm phải là PERCENT hoặc FIXED");
        }

        // Disallow negative values
        if (voucher.getGiaTriToiThieu() != null && voucher.getGiaTriToiThieu().compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Giá trị đơn hàng tối thiểu không được âm");
        }
        if (voucher.getGiaTriGiamToiDa().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá trị giảm tối đa phải lớn hơn 0");
        }
        if (voucher.getSoLuongToiDa() != null && voucher.getSoLuongToiDa() < 0) {
            throw new IllegalArgumentException("Số lần sử dụng tối đa không được âm");
        }

        // Validate discount value based on type
        if ("PERCENT".equals(voucher.getLoaiGiam())) {
            // For percentage: must be between 0 and 100
            if (voucher.getGiaTriGiam().compareTo(BigDecimal.ZERO) <= 0 ||
                voucher.getGiaTriGiam().compareTo(new BigDecimal("100")) > 0) {
                throw new IllegalArgumentException("Giá trị giảm (%) phải từ 1 đến 100");
            }
        } else if ("FIXED".equals(voucher.getLoaiGiam())) {
            // For fixed amount: must be greater than 0
            if (voucher.getGiaTriGiam().compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Giá trị giảm (đ) phải lớn hơn 0");
            }
        }

        return voucherRepository.save(voucher);
    }

    /**
     * Cập nhật voucher (admin only)
     */
    public Voucher capNhatVoucher(Long id, Voucher updates) {
        Voucher voucher = voucherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Voucher không tồn tại"));

        if (updates.getNgayBatDau() == null) {
            throw new IllegalArgumentException("Ngày bắt đầu không được để trống");
        }
        if (updates.getNgayKetThuc() == null) {
            throw new IllegalArgumentException("Ngày kết thúc không được để trống");
        }
        if (updates.getLoaiGiam() == null || updates.getLoaiGiam().isBlank()) {
            throw new IllegalArgumentException("Loại giảm không được để trống");
        }
        if (updates.getGiaTriGiam() == null) {
            throw new IllegalArgumentException("Giá trị giảm không được để trống");
        }
        if (updates.getGiaTriGiamToiDa() == null) {
            throw new IllegalArgumentException("Giá trị giảm tối đa không được để trống");
        }

        // Validate date range
        if (updates.getNgayBatDau().isAfter(updates.getNgayKetThuc())) {
            throw new IllegalArgumentException("Ngày bắt đầu phải trước ngày kết thúc");
        }

        // Validate discount type
        if (!"PERCENT".equals(updates.getLoaiGiam()) && !"FIXED".equals(updates.getLoaiGiam())) {
            throw new IllegalArgumentException("Loại giảm phải là PERCENT hoặc FIXED");
        }

        // Disallow negative values
        if (updates.getGiaTriToiThieu() != null && updates.getGiaTriToiThieu().compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Giá trị đơn hàng tối thiểu không được âm");
        }
        if (updates.getGiaTriGiamToiDa().compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Giá trị giảm tối đa phải lớn hơn 0");
        }
        if (updates.getSoLuongToiDa() != null && updates.getSoLuongToiDa() < 0) {
            throw new IllegalArgumentException("Số lần sử dụng tối đa không được âm");
        }

        // Validate discount value based on type
        if ("PERCENT".equals(updates.getLoaiGiam())) {
            // For percentage: must be between 0 and 100
            if (updates.getGiaTriGiam().compareTo(BigDecimal.ZERO) <= 0 ||
                updates.getGiaTriGiam().compareTo(new BigDecimal("100")) > 0) {
                throw new IllegalArgumentException("Giá trị giảm (%) phải từ 1 đến 100");
            }
        } else if ("FIXED".equals(updates.getLoaiGiam())) {
            // For fixed amount: must be greater than 0
            if (updates.getGiaTriGiam().compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Giá trị giảm (đ) phải lớn hơn 0");
            }
        }

        voucher.setMoTa(updates.getMoTa());
        voucher.setNgayBatDau(updates.getNgayBatDau());
        voucher.setNgayKetThuc(updates.getNgayKetThuc());
        voucher.setGiaTriToiThieu(updates.getGiaTriToiThieu());
        voucher.setGiaTriGiam(updates.getGiaTriGiam());
        voucher.setGiaTriGiamToiDa(updates.getGiaTriGiamToiDa());
        voucher.setLoaiGiam(updates.getLoaiGiam());
        voucher.setSoLuongToiDa(updates.getSoLuongToiDa());
        voucher.setTrangThai(updates.getTrangThai());

        return voucherRepository.save(voucher);
    }

    /**
     * Xóa voucher (soft delete)
     */
    public void xoaVoucher(Long id) {
        Voucher voucher = voucherRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Voucher không tồn tại"));
        voucher.setTrangThai(false);
        voucherRepository.save(voucher);
    }
}
