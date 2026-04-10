package com.certainshop.dto;

import lombok.*;
import java.time.LocalDateTime;

/**
 * DTO chi tiết địa chỉ của khách hàng
 */
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Data @Builder
public class DiaChiChiTietDto {
    
    private Long id;
    private String hoTen;
    private String soDienThoai;
    private String diaChiDong1; // Số nhà, đường
    private String phuongXa;
    private String quanHuyen;
    private String tinhThanh;
    
    // Mã GHN
    private Integer maTinhGHN;
    private Integer maHuyenGHN;
    private String maXaGHN;
    
    private Boolean laMacDinh;
    private LocalDateTime thoiGianTao;
    
    // Phương thức tiện lợi
    public String getDiaChiDayDu() {
        StringBuilder sb = new StringBuilder();
        if (getDiaChiDong1() != null && !diaChiDong1.isBlank()) sb.append(getDiaChiDong1());
        if (getPhuongXa() != null && !phuongXa.isBlank()) sb.append(", ").append(getPhuongXa());
        if (getQuanHuyen() != null && !quanHuyen.isBlank()) sb.append(", ").append(getQuanHuyen());
        if (getTinhThanh() != null && !tinhThanh.isBlank()) sb.append(", ").append(getTinhThanh());
        return sb.toString();
    }

    /**
     * @return the id
     */
    public Long getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Long id) {
        this.id = id;
    }

    /**
     * @return the hoTen
     */
    public String getHoTen() {
        return hoTen;
    }

    /**
     * @param hoTen the hoTen to set
     */
    public void setHoTen(String hoTen) {
        this.hoTen = hoTen;
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
     * @return the diaChiDong1
     */
    public String getDiaChiDong1() {
        return diaChiDong1;
    }

    /**
     * @param diaChiDong1 the diaChiDong1 to set
     */
    public void setDiaChiDong1(String diaChiDong1) {
        this.diaChiDong1 = diaChiDong1;
    }

    /**
     * @return the phuongXa
     */
    public String getPhuongXa() {
        return phuongXa;
    }

    /**
     * @param phuongXa the phuongXa to set
     */
    public void setPhuongXa(String phuongXa) {
        this.phuongXa = phuongXa;
    }

    /**
     * @return the quanHuyen
     */
    public String getQuanHuyen() {
        return quanHuyen;
    }

    /**
     * @param quanHuyen the quanHuyen to set
     */
    public void setQuanHuyen(String quanHuyen) {
        this.quanHuyen = quanHuyen;
    }

    /**
     * @return the tinhThanh
     */
    public String getTinhThanh() {
        return tinhThanh;
    }

    /**
     * @param tinhThanh the tinhThanh to set
     */
    public void setTinhThanh(String tinhThanh) {
        this.tinhThanh = tinhThanh;
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
     * @return the laMacDinh
     */
    public Boolean getLaMacDinh() {
        return laMacDinh;
    }

    /**
     * @param laMacDinh the laMacDinh to set
     */
    public void setLaMacDinh(Boolean laMacDinh) {
        this.laMacDinh = laMacDinh;
    }

    /**
     * @return the thoiGianTao
     */
    public LocalDateTime getThoiGianTao() {
        return thoiGianTao;
    }

    /**
     * @param thoiGianTao the thoiGianTao to set
     */
    public void setThoiGianTao(LocalDateTime thoiGianTao) {
        this.thoiGianTao = thoiGianTao;
    }
}
