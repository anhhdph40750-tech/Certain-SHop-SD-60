package com.certainshop.dto;

import jakarta.validation.constraints.*;
import lombok.*;
import java.math.BigDecimal;

/**
 * DTO biến thể sản phẩm
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BienTheDto {

    private Long id;

    private Long sanPhamId;

    private Long kichThuocId;

    private Long mauSacId;

    private Long chatLieuId;

    @NotNull(message = "Giá biến thể không được để trống")
    @DecimalMin(value = "0", inclusive = false, message = "Giá phải lớn hơn 0")
    private BigDecimal gia;

    @NotNull(message = "Số lượng không được để trống")
    @Min(value = 0, message = "Số lượng không được âm")
    private Integer soLuongTon;

    private Boolean macDinh = false;

    private Boolean trangThai = true;

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
     * @return the sanPhamId
     */
    public Long getSanPhamId() {
        return sanPhamId;
    }

    /**
     * @param sanPhamId the sanPhamId to set
     */
    public void setSanPhamId(Long sanPhamId) {
        this.sanPhamId = sanPhamId;
    }

    /**
     * @return the kichThuocId
     */
    public Long getKichThuocId() {
        return kichThuocId;
    }

    /**
     * @param kichThuocId the kichThuocId to set
     */
    public void setKichThuocId(Long kichThuocId) {
        this.kichThuocId = kichThuocId;
    }

    /**
     * @return the mauSacId
     */
    public Long getMauSacId() {
        return mauSacId;
    }

    /**
     * @param mauSacId the mauSacId to set
     */
    public void setMauSacId(Long mauSacId) {
        this.mauSacId = mauSacId;
    }

    /**
     * @return the chatLieuId
     */
    public Long getChatLieuId() {
        return chatLieuId;
    }

    /**
     * @param chatLieuId the chatLieuId to set
     */
    public void setChatLieuId(Long chatLieuId) {
        this.chatLieuId = chatLieuId;
    }

    /**
     * @return the gia
     */
    public BigDecimal getGia() {
        return gia;
    }

    /**
     * @param gia the gia to set
     */
    public void setGia(BigDecimal gia) {
        this.gia = gia;
    }

    /**
     * @return the soLuongTon
     */
    public Integer getSoLuongTon() {
        return soLuongTon;
    }

    /**
     * @param soLuongTon the soLuongTon to set
     */
    public void setSoLuongTon(Integer soLuongTon) {
        this.soLuongTon = soLuongTon;
    }

    /**
     * @return the macDinh
     */
    public Boolean getMacDinh() {
        return macDinh;
    }

    /**
     * @param macDinh the macDinh to set
     */
    public void setMacDinh(Boolean macDinh) {
        this.macDinh = macDinh;
    }

    /**
     * @return the trangThai
     */
    public Boolean getTrangThai() {
        return trangThai;
    }

    /**
     * @param trangThai the trangThai to set
     */
    public void setTrangThai(Boolean trangThai) {
        this.trangThai = trangThai;
    }
}
