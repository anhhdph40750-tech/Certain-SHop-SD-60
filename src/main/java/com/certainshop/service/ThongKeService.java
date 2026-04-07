package com.certainshop.service;

import com.certainshop.constant.VaiTroConst;
import com.certainshop.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class ThongKeService {

    private final DonHangRepository donHangRepository;
    private final BienTheRepository bienTheRepository;
    private final ChiTietDonHangRepository chiTietDonHangRepository;
    private final NguoiDungRepository nguoiDungRepository;

    /**
     * Tổng quan dashboard
     */
    public Map<String, Object> layThongKeTongQuan() {
        Map<String, Object> data = new HashMap<>();

        LocalDateTime dauThang = LocalDateTime.now().withDayOfMonth(1).withHour(0).withMinute(0).withSecond(0);
        LocalDateTime cuoiThang = LocalDateTime.now();

        // Doanh thu tháng này
        BigDecimal doanhThuThang = donHangRepository.tinhTongDoanhThu(dauThang, cuoiThang);
        data.put("doanhThuThang", doanhThuThang);

        // Doanh thu hôm nay
        LocalDateTime dauHom = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0);
        BigDecimal doanhThuHomNay = donHangRepository.tinhTongDoanhThu(dauHom, cuoiThang);
        data.put("doanhThuHomNay", doanhThuHomNay);

        // Thống kê đơn hàng theo trạng thái
        List<Object[]> thongKeTrangThai = donHangRepository.demDonHangTheoTrangThai(dauThang, cuoiThang);
        Map<String, Long> soLuongTheoTrangThai = new HashMap<>();
        for (Object[] row : thongKeTrangThai) {
            soLuongTheoTrangThai.put((String) row[0], (Long) row[1]);
        }
        data.put("thongKeTrangThai", soLuongTheoTrangThai);

        // Tổng khách hàng
        long tongKhachHang = nguoiDungRepository.findByVaiTro(VaiTroConst.KHACH_HANG).size();
        data.put("tongKhachHang", tongKhachHang);

        return data;
    }


    /**
     * Thống kê doanh thu theo ngày (trong khoảng)
     */
    public List<Object[]> thongKeDoanhThuTheoNgay(LocalDateTime tuNgay, LocalDateTime denNgay) {
        return donHangRepository.thongKeDoanhThuTheoNgay(tuNgay, denNgay);
    }

    /**
     * Sản phẩm sắp hết hàng (ngưỡng <= 10)
     */
    public List<?> sanPhamSapHetHang() {
        return bienTheRepository.findBienTheSapHetHang(10);
    }

    /**
     * Sản phẩm hết hàng
     */
    public List<?> sanPhamHetHang() {
        return bienTheRepository.findBienTheHetHang();
    }

    /**
     * Sản phẩm bán chạy trong 1 tháng gần nhất
     */
    public List<Object[]> sanPhamBanChay() {

        LocalDateTime denNgay = LocalDateTime.now();
        LocalDateTime tuNgay = denNgay.minusDays(30);

        return chiTietDonHangRepository.thongKeSanPhamBanChay(tuNgay, denNgay);
    }
//    public List<Object[]> sanPhamBanChay() {
//        LocalDateTime tuNgay = LocalDate.now()
//                .withDayOfMonth(1)
//                .atStartOfDay();
//
//        LocalDateTime denNgay = tuNgay.plusMonths(1);
//
//        return chiTietDonHangRepository.thongKeSanPhamBanChay(tuNgay, denNgay);
//    }


//    public List<Object[]> sanPhamBanChay() {
//
//        LocalDateTime tuNgay = LocalDate.now()
//                .withDayOfMonth(1)
//                .minusMonths(2)   // lùi 2 tháng
//                .atStartOfDay();
//
//        LocalDateTime denNgay = LocalDate.now()
//                .withDayOfMonth(1)
//                .plusMonths(1)    // đầu tháng sau
//                .atStartOfDay();
//
//        return chiTietDonHangRepository.thongKeSanPhamBanChay(tuNgay, denNgay);
//    }
    /**
     * Thống kê số hóa đơn hoàn tất theo ngày trong khoảng thời gian
     */
    public List<Object[]> demHoaDonHoanTatTheoNgay(LocalDateTime tuNgay, LocalDateTime denNgay) {
        return donHangRepository.demHoaDonHoanTatTheoNgay(tuNgay, denNgay);
    }

    /**
     * Tổng doanh thu
     */
    public BigDecimal tinhTongDoanhThu(LocalDateTime tuNgay, LocalDateTime denNgay) {
        return donHangRepository.tinhTongDoanhThu(tuNgay, denNgay);
    }
}
