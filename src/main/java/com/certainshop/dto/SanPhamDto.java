package com.certainshop.dto;

import jakarta.validation.constraints.*;
import lombok.*;
import java.math.BigDecimal;
import java.util.List;

/**
 * DTO tạo/cập nhật sản phẩm
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SanPhamDto {

    private Long id;

    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(max = 255, message = "Tên sản phẩm tối đa 255 ký tự")
    private String tenSanPham;

    private String moTaChiTiet;

    @NotNull(message = "Giá gốc không được để trống")
    @DecimalMin(value = "0", inclusive = false, message = "Giá gốc phải lớn hơn 0")
    private BigDecimal giaGoc;

    @NotNull(message = "Danh mục không được để trống")
    private Long danhMucId;

    private Long thuongHieuId;

    private Boolean trangThai = true;

    // Danh sách biến thể
    private List<BienTheDto> danhSachBienThe;

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
     * @return the tenSanPham
     */
    public String getTenSanPham() {
        return tenSanPham;
    }

    /**
     * @param tenSanPham the tenSanPham to set
     */
    public void setTenSanPham(String tenSanPham) {
        this.tenSanPham = tenSanPham;
    }

    /**
     * @return the moTaChiTiet
     */
    public String getMoTaChiTiet() {
        return moTaChiTiet;
    }

    /**
     * @param moTaChiTiet the moTaChiTiet to set
     */
    public void setMoTaChiTiet(String moTaChiTiet) {
        this.moTaChiTiet = moTaChiTiet;
    }

    /**
     * @return the giaGoc
     */
    public BigDecimal getGiaGoc() {
        return giaGoc;
    }

    /**
     * @param giaGoc the giaGoc to set
     */
    public void setGiaGoc(BigDecimal giaGoc) {
        this.giaGoc = giaGoc;
    }

    /**
     * @return the danhMucId
     */
    public Long getDanhMucId() {
        return danhMucId;
    }

    /**
     * @param danhMucId the danhMucId to set
     */
    public void setDanhMucId(Long danhMucId) {
        this.danhMucId = danhMucId;
    }

    /**
     * @return the thuongHieuId
     */
    public Long getThuongHieuId() {
        return thuongHieuId;
    }

    /**
     * @param thuongHieuId the thuongHieuId to set
     */
    public void setThuongHieuId(Long thuongHieuId) {
        this.thuongHieuId = thuongHieuId;
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

    /**
     * @return the danhSachBienThe
     */
    public List<BienTheDto> getDanhSachBienThe() {
        return danhSachBienThe;
    }

    /**
     * @param danhSachBienThe the danhSachBienThe to set
     */
    public void setDanhSachBienThe(List<BienTheDto> danhSachBienThe) {
        this.danhSachBienThe = danhSachBienThe;
    }
}
