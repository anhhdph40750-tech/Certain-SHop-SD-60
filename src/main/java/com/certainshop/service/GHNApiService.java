package com.certainshop.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.math.BigDecimal;
import java.util.*;

/**
 * Service gọi API GHN - Giao Hàng Nhanh (môi trường dev)
 */
@Service
@Slf4j
public class GHNApiService {

    @Value("${ghn.apiUrl:https://dev-online-gateway.ghn.vn}")
    private String apiUrl;

    @Value("${ghn.token:}")
    private String token;

    @Value("${ghn.shopId:}")
    private String shopId;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    /**
     * Lấy danh sách tỉnh/thành phố
     */
    public List<Map<String, Object>> layDanhSachTinh() {
        try {
            String url = apiUrl + "/shiip/public-api/master-data/province";
            HttpHeaders headers = taoHeaders();
            ResponseEntity<String> response = restTemplate.exchange(
                    url, HttpMethod.GET, new HttpEntity<>(headers), String.class);

            JsonNode root = objectMapper.readTree(response.getBody());
            List<Map<String, Object>> danhSach = new ArrayList<>();

            if (root.has("data") && root.get("data").isArray()) {
                for (JsonNode node : root.get("data")) {
                    Map<String, Object> tinh = new HashMap<>();
                    tinh.put("ProvinceID", node.get("ProvinceID").asInt());
                    tinh.put("ProvinceName", node.get("ProvinceName").asText());
                    danhSach.add(tinh);
                }
            }
            return danhSach;
        } catch (Exception e) {
            log.warn("Không thể lấy danh sách tỉnh từ GHN: {}", e.getMessage());
            return DuLieuDiaChi.layDanhSachTinh();
        }
    }

    /**
     * Lấy danh sách quận/huyện theo tỉnh
     */
    public List<Map<String, Object>> layDanhSachHuyen(int maTinh) {
        try {
            String url = apiUrl + "/shiip/public-api/master-data/district";
            HttpHeaders headers = taoHeaders();
            Map<String, Object> body = Map.of("province_id", maTinh);
            ResponseEntity<String> response = restTemplate.exchange(
                    url, HttpMethod.POST,
                    new HttpEntity<>(body, headers), String.class);

            JsonNode root = objectMapper.readTree(response.getBody());
            List<Map<String, Object>> danhSach = new ArrayList<>();

            if (root.has("data") && root.get("data").isArray()) {
                for (JsonNode node : root.get("data")) {
                    Map<String, Object> huyen = new HashMap<>();
                    huyen.put("DistrictID", node.get("DistrictID").asInt());
                    huyen.put("DistrictName", node.get("DistrictName").asText());
                    danhSach.add(huyen);
                }
            }
            return danhSach;
        } catch (Exception e) {
            log.warn("Không thể lấy danh sách huyện từ GHN: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Lấy danh sách xã/phường theo huyện
     */
    public List<Map<String, Object>> layDanhSachXa(int maHuyen) {
        try {
            String url = apiUrl + "/shiip/public-api/master-data/ward";
            HttpHeaders headers = taoHeaders();
            Map<String, Object> body = Map.of("district_id", maHuyen);
            ResponseEntity<String> response = restTemplate.exchange(
                    url, HttpMethod.POST,
                    new HttpEntity<>(body, headers), String.class);

            JsonNode root = objectMapper.readTree(response.getBody());
            List<Map<String, Object>> danhSach = new ArrayList<>();

            if (root.has("data") && root.get("data").isArray()) {
                for (JsonNode node : root.get("data")) {
                    Map<String, Object> xa = new HashMap<>();
                    xa.put("WardCode", node.get("WardCode").asText());
                    xa.put("WardName", node.get("WardName").asText());
                    danhSach.add(xa);
                }
            }
            return danhSach;
        } catch (Exception e) {
            log.warn("Không thể lấy danh sách xã từ GHN: {}", e.getMessage());
            return new ArrayList<>();
        }
    }

    /**
     * Tính phí vận chuyển GHN
     */
    public BigDecimal tinhPhiVanChuyen(int maHuyenNhan, String maXaNhan, int tongKhoiLuongGram) {
        try {
            String url = apiUrl + "/shiip/public-api/v2/shipping-order/fee";
            HttpHeaders headers = taoHeadersVoiShopId();

            Map<String, Object> body = new HashMap<>();
            body.put("service_type_id", 2); // Express
            body.put("to_district_id", maHuyenNhan);
            body.put("to_ward_code", maXaNhan);
            body.put("weight", tongKhoiLuongGram);
            body.put("length", 30);
            body.put("width", 20);
            body.put("height", 5);
            body.put("insurance_value", 0);

            ResponseEntity<String> response = restTemplate.exchange(
                    url, HttpMethod.POST,
                    new HttpEntity<>(body, headers), String.class);

            JsonNode root = objectMapper.readTree(response.getBody());
            if (root.has("data") && root.get("data").has("total")) {
                return BigDecimal.valueOf(root.get("data").get("total").asLong());
            }
        } catch (Exception e) {
            log.warn("Không thể tính phí vận chuyển GHN: {}", e.getMessage());
        }
        // Phí mặc định nếu API lỗi
        return BigDecimal.valueOf(30000L);
    }

    private HttpHeaders taoHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        if (!token.isBlank()) headers.set("Token", token);
        return headers;
    }

    private HttpHeaders taoHeadersVoiShopId() {
        HttpHeaders headers = taoHeaders();
        if (!shopId.isBlank()) headers.set("ShopId", shopId);
        return headers;
    }

    /**
     * Dữ liệu địa chỉ dự phòng khi API GHN không khả dụng
     */
    public static class DuLieuDiaChi {
        public static List<Map<String, Object>> layDanhSachTinh() {
            List<Map<String, Object>> tinhList = new ArrayList<>();
            Object[][] data = {
                {201, "Hà Nội"}, {202, "TP. Hồ Chí Minh"}, {203, "Đà Nẵng"},
                {204, "Hải Phòng"}, {205, "Cần Thơ"}, {206, "An Giang"},
                {207, "Bà Rịa - Vũng Tàu"}, {208, "Bắc Giang"}, {209, "Bắc Kạn"},
                {210, "Bạc Liêu"}, {211, "Bắc Ninh"}, {212, "Bến Tre"},
                {213, "Bình Định"}, {214, "Bình Dương"}, {215, "Bình Phước"},
                {216, "Bình Thuận"}, {217, "Cà Mau"}, {218, "Cao Bằng"},
                {219, "Đắk Lắk"}, {220, "Đắk Nông"}, {221, "Điện Biên"},
                {222, "Đồng Nai"}, {223, "Đồng Tháp"}, {224, "Gia Lai"},
                {225, "Hà Giang"}, {226, "Hà Nam"}, {227, "Hà Tĩnh"},
                {228, "Hải Dương"}, {229, "Hậu Giang"}, {230, "Hòa Bình"},
                {231, "Hưng Yên"}, {232, "Khánh Hòa"}, {233, "Kiên Giang"},
                {234, "Kon Tum"}, {235, "Lai Châu"}, {236, "Lâm Đồng"},
                {237, "Lạng Sơn"}, {238, "Lào Cai"}, {239, "Long An"},
                {240, "Nam Định"}, {241, "Nghệ An"}, {242, "Ninh Bình"},
                {243, "Ninh Thuận"}, {244, "Phú Thọ"}, {245, "Phú Yên"},
                {246, "Quảng Bình"}, {247, "Quảng Nam"}, {248, "Quảng Ngãi"},
                {249, "Quảng Ninh"}, {250, "Quảng Trị"}, {251, "Sóc Trăng"},
                {252, "Sơn La"}, {253, "Tây Ninh"}, {254, "Thái Bình"},
                {255, "Thái Nguyên"}, {256, "Thanh Hóa"}, {257, "Thừa Thiên Huế"},
                {258, "Tiền Giang"}, {259, "Trà Vinh"}, {260, "Tuyên Quang"},
                {261, "Vĩnh Long"}, {262, "Vĩnh Phúc"}, {263, "Yên Bái"}
            };
            for (Object[] row : data) {
                tinhList.add(Map.of("ProvinceID", row[0], "ProvinceName", row[1]));
            }
            return tinhList;
        }
    }
}
