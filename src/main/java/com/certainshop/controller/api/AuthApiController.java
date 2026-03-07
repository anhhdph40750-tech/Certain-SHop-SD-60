package com.certainshop.controller.api;

import com.certainshop.dto.ApiResponse;
import com.certainshop.dto.DangKyDto;
import com.certainshop.entity.NguoiDung;
import com.certainshop.repository.NguoiDungRepository;
import com.certainshop.service.NguoiDungService;
import com.certainshop.util.JwtUtil;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthApiController {

    private final AuthenticationManager authenticationManager;
    private final UserDetailsService userDetailsService;
    private final JwtUtil jwtUtil;
    private final NguoiDungService nguoiDungService;
    private final NguoiDungRepository nguoiDungRepository;

    @PostMapping("/dang-nhap")
    public ResponseEntity<?> dangNhap(@RequestBody Map<String, String> request) {
        String tenDangNhap = request.get("tenDangNhap");
        String matKhau = request.get("matKhau");

        if (tenDangNhap == null || matKhau == null) {
            return ResponseEntity.badRequest()
                    .body(ApiResponse.loi("Tên đăng nhập và mật khẩu không được để trống"));
        }

        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(tenDangNhap, matKhau));
        } catch (BadCredentialsException e) {
            return ResponseEntity.status(401)
                    .body(ApiResponse.loi(401, "Tên đăng nhập hoặc mật khẩu không đúng"));
        } catch (Exception e) {
            return ResponseEntity.status(401)
                    .body(ApiResponse.loi(401, e.getMessage() != null ? e.getMessage() : "Đăng nhập thất bại"));
        }

        UserDetails userDetails = userDetailsService.loadUserByUsername(tenDangNhap);
        String token = jwtUtil.taoToken(userDetails);

        // Lấy thông tin người dùng để trả về
        NguoiDung nd = nguoiDungRepository.findByTenDangNhap(tenDangNhap).orElseThrow();

        Map<String, Object> responseData = Map.of(
                "token", token,
                "tokenType", "Bearer",
                "nguoiDung", Map.of(
                        "id", nd.getId(),
                        "tenDangNhap", nd.getTenDangNhap(),
                        "hoTen", nd.getHoTen() != null ? nd.getHoTen() : "",
                        "email", nd.getEmail() != null ? nd.getEmail() : "",
                        "vaiTro", nd.getVaiTro().getTenVaiTro(),
                        "anhDaiDien", nd.getAnhDaiDien() != null ? nd.getAnhDaiDien() : ""
                )
        );

        return ResponseEntity.ok(ApiResponse.ok("Đăng nhập thành công", responseData));
    }

    @PostMapping("/dang-ky")
    public ResponseEntity<?> dangKy(@Valid @RequestBody DangKyDto dto) {
        try {
            NguoiDung nguoiDung = nguoiDungService.dangKy(dto);
            UserDetails userDetails = userDetailsService.loadUserByUsername(nguoiDung.getTenDangNhap());
            String token = jwtUtil.taoToken(userDetails);

            Map<String, Object> responseData = Map.of(
                    "token", token,
                    "tokenType", "Bearer",
                    "nguoiDung", Map.of(
                            "id", nguoiDung.getId(),
                            "tenDangNhap", nguoiDung.getTenDangNhap(),
                            "hoTen", nguoiDung.getHoTen() != null ? nguoiDung.getHoTen() : "",
                            "email", nguoiDung.getEmail() != null ? nguoiDung.getEmail() : "",
                            "vaiTro", nguoiDung.getVaiTro().getTenVaiTro()
                    )
            );

            return ResponseEntity.ok(ApiResponse.ok("Đăng ký thành công", responseData));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.loi(e.getMessage()));
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body(ApiResponse.loi("Đăng ký thất bại: " + e.getMessage()));
        }
    }

    @GetMapping("/toi")
    public ResponseEntity<?> layThongTinBanThan(
            @RequestHeader("Authorization") String authHeader) {
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            return ResponseEntity.status(401).body(ApiResponse.loi(401, "Chưa đăng nhập"));
        }
        String token = authHeader.substring(7);
        String tenDangNhap = jwtUtil.layTenDangNhap(token);
        NguoiDung nd = nguoiDungRepository.findByTenDangNhap(tenDangNhap)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy người dùng"));

        Map<String, Object> data = Map.of(
                "id", nd.getId(),
                "tenDangNhap", nd.getTenDangNhap(),
                "hoTen", nd.getHoTen() != null ? nd.getHoTen() : "",
                "email", nd.getEmail() != null ? nd.getEmail() : "",
                "soDienThoai", nd.getSoDienThoai() != null ? nd.getSoDienThoai() : "",
                "vaiTro", nd.getVaiTro().getTenVaiTro(),
                "anhDaiDien", nd.getAnhDaiDien() != null ? nd.getAnhDaiDien() : ""
        );
        return ResponseEntity.ok(ApiResponse.ok(data));
    }
}
