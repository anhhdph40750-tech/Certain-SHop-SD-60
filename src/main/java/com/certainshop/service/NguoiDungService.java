package com.certainshop.service;

import com.certainshop.constant.VaiTroConst;
import com.certainshop.dto.DangKyDto;
import com.certainshop.entity.DiaChiNguoiDung;
import com.certainshop.entity.GioHang;
import com.certainshop.entity.NguoiDung;
import com.certainshop.entity.VaiTro;
import com.certainshop.repository.DiaChiNguoiDungRepository;
import com.certainshop.repository.GioHangRepository;
import com.certainshop.repository.NguoiDungRepository;
import com.certainshop.repository.VaiTroRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Transactional
public class NguoiDungService {

    private final NguoiDungRepository nguoiDungRepository;
    private final VaiTroRepository vaiTroRepository;
    private final GioHangRepository gioHangRepository;
    private final DiaChiNguoiDungRepository diaChiNguoiDungRepository;
    private final PasswordEncoder passwordEncoder;
    private final MailService mailService;

    /**
     *      * Đăng ký tài khoản khách hàng mới
     */
    public NguoiDung dangKy(DangKyDto dto) {
        // Validate trùng
        if (nguoiDungRepository.existsByTenDangNhap(dto.getTenDangNhap())) {
            throw new IllegalArgumentException("Tên đăng nhập đã tồn tại");
        }
        if (dto.getEmail() != null && !dto.getEmail().isBlank()
                && nguoiDungRepository.existsByEmail(dto.getEmail())) {
            throw new IllegalArgumentException("Email đã được sử dụng");
        }
        if (!dto.getMatKhau().equals(dto.getXacNhanMatKhau())) {
            throw new IllegalArgumentException("Mật khẩu xác nhận không khớp");
        }

        VaiTro vaiTroKhach = vaiTroRepository.findByTenVaiTro(VaiTroConst.KHACH_HANG)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy vai trò Khách hàng"));

        NguoiDung nguoiDung = NguoiDung.builder()
                .tenDangNhap(dto.getTenDangNhap())
                .email(dto.getEmail())
                .matKhauMaHoa(passwordEncoder.encode(dto.getMatKhau()))
                .hoTen(dto.getHoTen())
                .soDienThoai(dto.getSoDienThoai())
                .ngaySinh(dto.getNgaySinh())
                .gioiTinh("nam".equalsIgnoreCase(dto.getGioiTinh()) ? Boolean.TRUE :
                          "nu".equalsIgnoreCase(dto.getGioiTinh()) ? Boolean.FALSE : null)
                .vaiTro(vaiTroKhach)
                .dangHoatDong(true)
                .build();

        nguoiDung = nguoiDungRepository.save(nguoiDung);

        // Tạo giỏ hàng cho khách
        GioHang gioHang = GioHang.builder()
                .nguoiDung(nguoiDung)
                .build();
        gioHangRepository.save(gioHang);

        // Gửi email chào mừng (bất đồng bộ, không block transaction)
        mailService.guiMailChaoMung(
                nguoiDung.getEmail(),
                nguoiDung.getHoTen(),
                nguoiDung.getTenDangNhap()
        );

        return nguoiDung;
    }

    /**
     * Lấy người dùng theo tên đăng nhập
     */
    @Transactional(readOnly = true)
    public Optional<NguoiDung> timTheoTenDangNhap(String tenDangNhap) {
        return nguoiDungRepository.findByTenDangNhap(tenDangNhap);
    }

    /**
     * Lấy người dùng theo ID
     */
    @Transactional(readOnly = true)
    public Optional<NguoiDung> timTheoId(Long id) {
        return nguoiDungRepository.findById(id);
    }

    /**
     * Cập nhật thông tin cá nhân
     */
    public NguoiDung capNhatThongTin(Long id, NguoiDung thongTinMoi) {
        NguoiDung nguoiDung = nguoiDungRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        // Kiểm tra email trùng
        if (thongTinMoi.getEmail() != null && !thongTinMoi.getEmail().isBlank()) {
            if (nguoiDungRepository.existsByEmailAndIdNot(thongTinMoi.getEmail(), id)) {
                throw new IllegalArgumentException("Email đã được sử dụng bởi tài khoản khác");
            }
            nguoiDung.setEmail(thongTinMoi.getEmail());
        }

        nguoiDung.setHoTen(thongTinMoi.getHoTen());
        nguoiDung.setSoDienThoai(thongTinMoi.getSoDienThoai());
        nguoiDung.setNgaySinh(thongTinMoi.getNgaySinh());
        nguoiDung.setGioiTinh(thongTinMoi.getGioiTinh());

        return nguoiDungRepository.save(nguoiDung);
    }

    /**
     * Đổi mật khẩu
     */
    public void doiMatKhau(Long id, String matKhauCu, String matKhauMoi) {
        NguoiDung nguoiDung = nguoiDungRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        if (!passwordEncoder.matches(matKhauCu, nguoiDung.getMatKhauMaHoa())) {
            throw new IllegalArgumentException("Mật khẩu cũ không đúng");
        }

        nguoiDung.setMatKhauMaHoa(passwordEncoder.encode(matKhauMoi));
        nguoiDung.setLanDoiMatKhauCuoi(LocalDateTime.now());
        nguoiDungRepository.save(nguoiDung);
    }

    /**
     * Cập nhật ảnh đại diện
     */
    public void capNhatAnh(Long id, String duongDanAnh) {
        NguoiDung nguoiDung = nguoiDungRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        nguoiDung.setAnhDaiDien(duongDanAnh);
        nguoiDungRepository.save(nguoiDung);
    }

    /**
     * Lấy danh sách nhân viên/admin (cho admin quản lý)
     */
    @Transactional(readOnly = true)
    public Page<NguoiDung> timKiem(String tuKhoa, Pageable pageable) {
        return nguoiDungRepository.timKiem(tuKhoa, pageable);
    }

    @Transactional(readOnly = true)
    public Page<NguoiDung> timKiem(String tuKhoa, String tenVaiTro, Pageable pageable) {
        return nguoiDungRepository.timKiem(tuKhoa, tenVaiTro, pageable);
    }

    /**
     * Tạo tài khoản nhân viên (admin) — hỗ trợ đầy đủ thông tin + địa chỉ
     */
    public NguoiDung taoNhanVien(NguoiDung nhanVien, String matKhau, Integer vaiTroId,
                                  DiaChiNguoiDung diaChi) {
        if (nguoiDungRepository.existsByTenDangNhap(nhanVien.getTenDangNhap())) {
            throw new IllegalArgumentException("Tên đăng nhập đã tồn tại");
        }
        if (nhanVien.getEmail() != null && !nhanVien.getEmail().isBlank()
                && nguoiDungRepository.existsByEmail(nhanVien.getEmail())) {
            throw new IllegalArgumentException("Email đã được sử dụng");
        }

        VaiTro vaiTro = vaiTroRepository.findById(vaiTroId)
                .orElseThrow(() -> new RuntimeException("Vai trò không tồn tại"));

        nhanVien.setMatKhauMaHoa(passwordEncoder.encode(matKhau));
        nhanVien.setVaiTro(vaiTro);
        nhanVien.setDangHoatDong(true);

        NguoiDung saved = nguoiDungRepository.save(nhanVien);

        // Sinh mã người dùng dựa theo vai trò và ID
        String prefix;
        switch (vaiTro.getTenVaiTro()) {
            case "NHAN_VIEN" -> prefix = "NV";
            case "ADMIN"    -> prefix = "AD";
            default         -> prefix = "KH";
        }
        saved.setMaNguoiDung(prefix + String.format("%05d", saved.getId()));
        saved = nguoiDungRepository.save(saved);

        // Lưu địa chỉ mặc định nếu có
        if (diaChi != null && diaChi.getTinhThanh() != null
                && !diaChi.getTinhThanh().isBlank()) {
            diaChi.setNguoiDung(saved);
            diaChi.setLaMacDinh(true);
            diaChiNguoiDungRepository.save(diaChi);
        }

        return saved;
    }

    /**
     * Overload tương thích ngược — không địa chỉ
     */
    public NguoiDung taoNhanVien(NguoiDung nhanVien, String matKhau, Integer vaiTroId) {
        return taoNhanVien(nhanVien, matKhau, vaiTroId, null);
    }

    /**
     * Xóa người dùng (chỉ cho phép xóa khi không có đơn hàng, admin gốc không thể xóa)
     */
    public void xoaNguoiDung(Long id) {
        if (id == 1L) {
            throw new IllegalArgumentException("Không thể xóa tài khoản Admin gốc");
        }
        NguoiDung nd = nguoiDungRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        // Soft-delete: khóa tài khoản thay vì xóa vật lý (giữ toàn vẹn dữ liệu đơn hàng)
        nd.setDangHoatDong(false);
        nd.setTrangThai("DA_XOA");
        nguoiDungRepository.save(nd);
    }

    /**
     * Cập nhật thông tin nhân viên (admin)
     */
    public NguoiDung capNhatNhanVien(Long id, NguoiDung thongTinMoi, DiaChiNguoiDung diaChi) {
        NguoiDung nd = nguoiDungRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        if (id == 1L) {
            throw new IllegalArgumentException("Không thể chỉnh sửa Admin gốc từ trang này");
        }
        if (thongTinMoi.getEmail() != null && !thongTinMoi.getEmail().isBlank()
                && nguoiDungRepository.existsByEmailAndIdNot(thongTinMoi.getEmail(), id)) {
            throw new IllegalArgumentException("Email đã được sử dụng bởi tài khoản khác");
        }
        nd.setHoTen(thongTinMoi.getHoTen());
        nd.setSoDienThoai(thongTinMoi.getSoDienThoai());
        nd.setEmail(thongTinMoi.getEmail());
        nd.setCccd(thongTinMoi.getCccd());
        nd.setNgaySinh(thongTinMoi.getNgaySinh());
        nd.setGioiTinh(thongTinMoi.getGioiTinh());
        if (thongTinMoi.getAnhDaiDien() != null) {
            nd.setAnhDaiDien(thongTinMoi.getAnhDaiDien());
        }
        NguoiDung saved = nguoiDungRepository.save(nd);

        // Cập nhật địa chỉ mặc định nếu cung cấp
        if (diaChi != null && diaChi.getTinhThanh() != null
                && !diaChi.getTinhThanh().isBlank()) {
            diaChiNguoiDungRepository.findByNguoiDungIdAndLaMacDinhTrue(id).ifPresentOrElse(
                existing -> {
                    existing.setDiaChiDong1(diaChi.getDiaChiDong1());
                    existing.setPhuongXa(diaChi.getPhuongXa());
                    existing.setQuanHuyen(diaChi.getQuanHuyen());
                    existing.setTinhThanh(diaChi.getTinhThanh());
                    existing.setMaTinhGHN(diaChi.getMaTinhGHN());
                    existing.setMaHuyenGHN(diaChi.getMaHuyenGHN());
                    existing.setMaXaGHN(diaChi.getMaXaGHN());
                    diaChiNguoiDungRepository.save(existing);
                },
                () -> {
                    diaChi.setNguoiDung(saved);
                    diaChi.setLaMacDinh(true);
                    diaChiNguoiDungRepository.save(diaChi);
                }
            );
        }
        return saved;
    }

    /**
     * Khoá/mở khoá tài khoản
     */
    public void doiTrangThaiTaiKhoan(Long id, boolean dangHoatDong) {
        NguoiDung nguoiDung = nguoiDungRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        // Không cho khoá tài khoản admin cố định (ID = 1)
        if (id == 1L && !dangHoatDong) {
            throw new IllegalArgumentException("Không thể khóa tài khoản Admin gốc");
        }

        nguoiDung.setDangHoatDong(dangHoatDong);
        nguoiDungRepository.save(nguoiDung);
    }

    /**
     * Đổi vai trò
     */
    public void doiVaiTro(Long nguoiDungId, Integer vaiTroId) {
        if (nguoiDungId == 1L) {
            throw new IllegalArgumentException("Không thể thay đổi vai trò Admin gốc");
        }
        NguoiDung nguoiDung = nguoiDungRepository.findById(nguoiDungId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));
        VaiTro vaiTro = vaiTroRepository.findById(vaiTroId)
                .orElseThrow(() -> new RuntimeException("Vai trò không tồn tại"));
        nguoiDung.setVaiTro(vaiTro);
        nguoiDungRepository.save(nguoiDung);
    }

    /**
     * Cập nhật thời gian đăng nhập cuối
     */
    public void capNhatLanDangNhapCuoi(Long id) {
        nguoiDungRepository.findById(id).ifPresent(nd -> {
            nd.setLanDangNhapCuoi(LocalDateTime.now());
            nguoiDungRepository.save(nd);
        });
    }

    @Transactional(readOnly = true)
    public List<VaiTro> layTatCaVaiTro() {
        return vaiTroRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Page<NguoiDung> layTheoVaiTro(String tenVaiTro, Pageable pageable) {
        return nguoiDungRepository.findByTenVaiTro(tenVaiTro, pageable);
    }
}

