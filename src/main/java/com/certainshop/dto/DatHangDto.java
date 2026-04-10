package com.certainshop.dto;

import jakarta.validation.constraints.*;
import lombok.*;

/**
 * DTO đặt hàng online
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DatHangDto {

    // ID địa chỉ đã lưu (nếu chọn từ danh sách)
    private Long diaChiId;

    // Hoặc nhập địa chỉ mới
    @NotBlank(message = "Tên người nhận không được để trống")
    private String tenNguoiNhan;

    @NotBlank(message = "Số điện thoại không được để trống")
    @Pattern(regexp = "^(0[0-9]{9})$", message = "Số điện thoại không hợp lệ")
    private String soDienThoai;

    @NotBlank(message = "Địa chỉ không được để trống")
    private String diaChiCuThe;

    // GHN codes
    private Integer maTinhGHN;
    private Integer maHuyenGHN;
    private String maXaGHN;

    // Tên hiển thị
    private String tenTinh;
    private String tenHuyen;
    private String tenXa;

    private String phuongThucThanhToan; // COD hoặc VNPAY

    private Long khuyenMaiId;

    // Mã voucher (hệ thống Voucher mới hoặc KhuyenMai cũ) gửi từ FE
    private String maVoucher;

    private String ghiChu;

    private Boolean luuDiaChi = false;

    // Phí vận chuyển tính từ GHN
    private java.math.BigDecimal phiVanChuyen = java.math.BigDecimal.ZERO;

    /**
     * @return the diaChiId
     */
    public Long getDiaChiId() {
        return diaChiId;
    }

    /**
     * @param diaChiId the diaChiId to set
     */
    public void setDiaChiId(Long diaChiId) {
        this.diaChiId = diaChiId;
    }

    /**
     * @return the tenNguoiNhan
     */
    public String getTenNguoiNhan() {
        return tenNguoiNhan;
    }

    /**
     * @param tenNguoiNhan the tenNguoiNhan to set
     */
    public void setTenNguoiNhan(String tenNguoiNhan) {
        this.tenNguoiNhan = tenNguoiNhan;
    }

    /**
     * @return the soDienThoai
     */
    public String getSoDienThoai() {
        return soDienThoai;
    }

    /**
     * @param soDienThoai the soDienThoai to set
     */
    public void setSoDienThoai(String soDienThoai) {
        this.soDienThoai = soDienThoai;
    }

    /**
     * @return the diaChiCuThe
     */
    public String getDiaChiCuThe() {
        return diaChiCuThe;
    }

    /**
     * @param diaChiCuThe the diaChiCuThe to set
     */
    public void setDiaChiCuThe(String diaChiCuThe) {
        this.diaChiCuThe = diaChiCuThe;
    }

    /**
     * @return the maTinhGHN
     */
    public Integer getMaTinhGHN() {
        return maTinhGHN;
    }

    /**
     * @param maTinhGHN the maTinhGHN to set
     */
    public void setMaTinhGHN(Integer maTinhGHN) {
        this.maTinhGHN = maTinhGHN;
    }

    /**
     * @return the maHuyenGHN
     */
    public Integer getMaHuyenGHN() {
        return maHuyenGHN;
    }

    /**
     * @param maHuyenGHN the maHuyenGHN to set
     */
    public void setMaHuyenGHN(Integer maHuyenGHN) {
        this.maHuyenGHN = maHuyenGHN;
    }

    /**
     * @return the maXaGHN
     */
    public String getMaXaGHN() {
        return maXaGHN;
    }

    /**
     * @param maXaGHN the maXaGHN to set
     */
    public void setMaXaGHN(String maXaGHN) {
        this.maXaGHN = maXaGHN;
    }

    /**
     * @return the tenTinh
     */
    public String getTenTinh() {
        return tenTinh;
    }

    /**
     * @param tenTinh the tenTinh to set
     */
    public void setTenTinh(String tenTinh) {
        this.tenTinh = tenTinh;
    }

    /**
     * @return the tenHuyen
     */
    public String getTenHuyen() {
        return tenHuyen;
    }

    /**
     * @param tenHuyen the tenHuyen to set
     */
    public void setTenHuyen(String tenHuyen) {
        this.tenHuyen = tenHuyen;
    }

    /**
     * @return the tenXa
     */
    public String getTenXa() {
        return tenXa;
    }

    /**
     * @param tenXa the tenXa to set
     */
    public void setTenXa(String tenXa) {
        this.tenXa = tenXa;
    }

    /**
     * @return the phuongThucThanhToan
     */
    public String getPhuongThucThanhToan() {
        return phuongThucThanhToan;
    }

    /**
     * @param phuongThucThanhToan the phuongThucThanhToan to set
     */
    public void setPhuongThucThanhToan(String phuongThucThanhToan) {
        this.phuongThucThanhToan = phuongThucThanhToan;
    }

    /**
     * @return the khuyenMaiId
     */
    public Long getKhuyenMaiId() {
        return khuyenMaiId;
    }

    /**
     * @param khuyenMaiId the khuyenMaiId to set
     */
    public void setKhuyenMaiId(Long khuyenMaiId) {
        this.khuyenMaiId = khuyenMaiId;
    }

    /**
     * @return the maVoucher
     */
    public String getMaVoucher() {
        return maVoucher;
    }

    /**
     * @param maVoucher the maVoucher to set
     */
    public void setMaVoucher(String maVoucher) {
        this.maVoucher = maVoucher;
    }

    /**
     * @return the ghiChu
     */
    public String getGhiChu() {
        return ghiChu;
    }

    /**
     * @param ghiChu the ghiChu to set
     */
    public void setGhiChu(String ghiChu) {
        this.ghiChu = ghiChu;
    }

    /**
     * @return the luuDiaChi
     */
    public Boolean getLuuDiaChi() {
        return luuDiaChi;
    }

    /**
     * @param luuDiaChi the luuDiaChi to set
     */
    public void setLuuDiaChi(Boolean luuDiaChi) {
        this.luuDiaChi = luuDiaChi;
    }

    /**
     * @return the phiVanChuyen
     */
    public java.math.BigDecimal getPhiVanChuyen() {
        return phiVanChuyen;
    }

    /**
     * @param phiVanChuyen the phiVanChuyen to set
     */
    public void setPhiVanChuyen(java.math.BigDecimal phiVanChuyen) {
        this.phiVanChuyen = phiVanChuyen;
    }
}
