package com.certainshop.config;

import com.certainshop.constant.VaiTroConst;
import com.certainshop.entity.NguoiDung;
import com.certainshop.entity.VaiTro;
import com.certainshop.repository.NguoiDungRepository;
import com.certainshop.repository.VaiTroRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.LocalDateTime;

@Configuration
@RequiredArgsConstructor
public class DataInitializer {

    @Autowired
    private NguoiDungRepository nguoiDungRepository;
    @Autowired
    private VaiTroRepository vaiTroRepository;
    @Autowired
    private  PasswordEncoder passwordEncoder;

    @Bean
    CommandLineRunner initDatabase() {
        return args -> {
            // 1. Kiểm tra và khởi tạo VaiTro SUPER_ADMIN
            VaiTro superAdminRole = vaiTroRepository.findByTenVaiTro("SUPER_ADMIN")
                    .orElseGet(() -> {
                        VaiTro newRole = new VaiTro();
                        newRole.setTenVaiTro("SUPER_ADMIN");
                        newRole.setQuyenHan("ALL_PRIVILEGES"); // Cấp tất cả quyền
                        return vaiTroRepository.save(newRole);
                    });

            // 2. Kiểm tra và khởi tạo VaiTro ADMIN
            VaiTro adminRole = vaiTroRepository.findByTenVaiTro("ADMIN")
                    .orElseGet(() -> {
                        VaiTro newRole = new VaiTro();
                        newRole.setTenVaiTro("ADMIN");
                        newRole.setQuyenHan("MANAGE_USERS, MANAGE_PRODUCTS"); // Quyền quản lý người dùng và sản phẩm
                        return vaiTroRepository.save(newRole);
                    });

            // 2.1 Kiểm tra và khởi tạo VaiTro NHAN_VIEN
            VaiTro nhanVienRole = vaiTroRepository.findByTenVaiTro("NHAN_VIEN")
                    .orElseGet(() -> {
                        VaiTro newRole = new VaiTro();
                        newRole.setTenVaiTro("NHAN_VIEN");
                        newRole.setQuyenHan("BAN_HANG"); // Quyền bán hàng
                        return vaiTroRepository.save(newRole);
                    });

            // 2.2 Kiểm tra và khởi tạo VaiTro KHACH_HANG
            VaiTro khachHangRole = vaiTroRepository.findByTenVaiTro("KHACH_HANG")
                    .orElseGet(() -> {
                        VaiTro newRole = new VaiTro();
                        newRole.setTenVaiTro("KHACH_HANG");
                        newRole.setQuyenHan("MUA_HANG"); // Quyền mua hàng
                        return vaiTroRepository.save(newRole);
                    });

            // 3. Kiểm tra xem user super admin đã tồn tại chưa
            String superAdminUsername = "superadmin";
            if (!nguoiDungRepository.existsByTenDangNhap(superAdminUsername)) {
                NguoiDung superAdminUser = NguoiDung.builder()
                        .tenDangNhap(superAdminUsername)
                        .email("superadmin@certainshop.com")
                        .matKhauMaHoa(passwordEncoder.encode("SuperAdmin@123")) // Mật khẩu mặc định
                        .hoTen("Super Administrator")
                        .maNguoiDung("SA001")
                        .trangThai("HOAT_DONG")
                        .dangHoatDong(true)
                        .vaiTro(superAdminRole)
                        .thoiGianTao(LocalDateTime.now())
                        .build();

                nguoiDungRepository.save(superAdminUser);
                System.out.println(">>> Đã tạo tài khoản Super Admin mặc định (superadmin/SuperAdmin@123)");
            } else {
                System.out.println(">>> Tài khoản Super Admin đã tồn tại, bỏ qua bước khởi tạo.");
            }

            // 4. Kiểm tra xem user admin đã tồn tại chưa (theo TenDangNhap)
            String adminUsername = "quocdat";
            if (!nguoiDungRepository.existsByTenDangNhap(adminUsername)) {

                NguoiDung adminUser = NguoiDung.builder()
                        .tenDangNhap(adminUsername)
                        .email("admin@certainshop.com")
                        .matKhauMaHoa(passwordEncoder.encode("Admin@123")) // Mật khẩu mặc định
                        .hoTen("Administrator")
                        .maNguoiDung("AD001")
                        .trangThai("HOAT_DONG")
                        .dangHoatDong(true)
                        .vaiTro(adminRole)
                        .thoiGianTao(LocalDateTime.now())
                        .build();

                nguoiDungRepository.save(adminUser);
                System.out.println(">>> Đã tạo tài khoản Admin mặc định (quocdat/Admin@123)");
            } else {
                System.out.println(">>> Tài khoản Admin đã tồn tại, bỏ qua bước khởi tạo.");
            }

            // 5. Kiểm tra xem user nhân viên hoangMinh đã tồn tại chưa
//            String nhanVienUsername = "hoangMinh";
//            if (!nguoiDungRepository.existsByTenDangNhap(nhanVienUsername)) {
//
//                NguoiDung nhanVienUser = NguoiDung.builder()
//                        .tenDangNhap(nhanVienUsername)
//                        .email("hoangminh@certainshop.com")
//                        .matKhauMaHoa(passwordEncoder.encode("Admin@123")) // Mật khẩu mặc định
//                        .hoTen("Hoàng Minh")
//                        .maNguoiDung("NV001")
//                        .trangThai("HOAT_DONG")
//                        .dangHoatDong(true)
//                        .vaiTro(nhanVienRole)
//                        .thoiGianTao(LocalDateTime.now())
//                        .build();
//
//                nguoiDungRepository.save(nhanVienUser);
//                System.out.println(">>> Đã tạo tài khoản Nhân viên mặc định (hoangMinh/Admin@123)");
//            } else {
//                System.out.println(">>> Tài khoản hoangMinh đã tồn tại, bỏ qua bước khởi tạo.");
//            }

            // 6. Kiểm tra xem user khách hàng khoai đã tồn tại chưa
            String khachHangUsername = "khoai";
            if (!nguoiDungRepository.existsByTenDangNhap(khachHangUsername)) {

                NguoiDung khachHangUser = NguoiDung.builder()
                        .tenDangNhap(khachHangUsername)
                        .email("khoai@certainshop.com")
                        .matKhauMaHoa(passwordEncoder.encode("Admin@123")) // Mật khẩu mặc định
                        .hoTen("Khoai")
                        .maNguoiDung("KH001")
                        .trangThai("HOAT_DONG")
                        .dangHoatDong(true)
                        .vaiTro(khachHangRole)
                        .thoiGianTao(LocalDateTime.now())
                        .build();

                nguoiDungRepository.save(khachHangUser);
                System.out.println(">>> Đã tạo tài khoản Khách hàng mặc định (khoai/Admin@123)");
            } else {
                System.out.println(">>> Tài khoản khoai đã tồn tại, bỏ qua bước khởi tạo.");
            }
        };
    }
}