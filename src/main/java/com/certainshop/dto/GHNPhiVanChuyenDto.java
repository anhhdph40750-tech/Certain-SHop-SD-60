package com.certainshop.dto;

import lombok.*;

import java.math.BigDecimal;

/**
 * DTO phí vận chuyển từ GHN
 */
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class GHNPhiVanChuyenDto {
    
    private BigDecimal total; // Tổng phí
    private BigDecimal serviceFee; // Phí dịch vụ
    private BigDecimal insuranceFee; // Phí bảo hiểm
    private BigDecimal pickStationFee;
    private BigDecimal couponValue; // Giảm giá
    private BigDecimal r2sFee;

    public BigDecimal getThamGiaGiam() {
        return getCouponValue() != null ? getCouponValue() : BigDecimal.ZERO;
    }

    /**
     * @return the total
     */
    public BigDecimal getTotal() {
        return total;
    }

    /**
     * @param total the total to set
     */
    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    /**
     * @return the serviceFee
     */
    public BigDecimal getServiceFee() {
        return serviceFee;
    }

    /**
     * @param serviceFee the serviceFee to set
     */
    public void setServiceFee(BigDecimal serviceFee) {
        this.serviceFee = serviceFee;
    }

    /**
     * @return the insuranceFee
     */
    public BigDecimal getInsuranceFee() {
        return insuranceFee;
    }

    /**
     * @param insuranceFee the insuranceFee to set
     */
    public void setInsuranceFee(BigDecimal insuranceFee) {
        this.insuranceFee = insuranceFee;
    }

    /**
     * @return the pickStationFee
     */
    public BigDecimal getPickStationFee() {
        return pickStationFee;
    }

    /**
     * @param pickStationFee the pickStationFee to set
     */
    public void setPickStationFee(BigDecimal pickStationFee) {
        this.pickStationFee = pickStationFee;
    }

    /**
     * @return the couponValue
     */
    public BigDecimal getCouponValue() {
        return couponValue;
    }

    /**
     * @param couponValue the couponValue to set
     */
    public void setCouponValue(BigDecimal couponValue) {
        this.couponValue = couponValue;
    }

    /**
     * @return the r2sFee
     */
    public BigDecimal getR2sFee() {
        return r2sFee;
    }

    /**
     * @param r2sFee the r2sFee to set
     */
    public void setR2sFee(BigDecimal r2sFee) {
        this.r2sFee = r2sFee;
    }
}
