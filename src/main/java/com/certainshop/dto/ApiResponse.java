package com.certainshop.dto;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ApiResponse<T> {
    private boolean thanhCong;
    private String thongBao;
    private T duLieu;
    private int maLoi = 0;

    public static <T> ApiResponse<T> ok(T data) {
        return ApiResponse.<T>builder().thanhCong(true).duLieu(data).build();
    }

    public static <T> ApiResponse<T> ok(String msg, T data) {
        return ApiResponse.<T>builder().thanhCong(true).thongBao(msg).duLieu(data).build();
    }

    public static <T> ApiResponse<T> loi(String msg) {
        return ApiResponse.<T>builder().thanhCong(false).thongBao(msg).build();
    }

    public static <T> ApiResponse<T> loi(int code, String msg) {
        return ApiResponse.<T>builder().thanhCong(false).maLoi(code).thongBao(msg).build();
    }

    /**
     * @return the thanhCong
     */
    public boolean isThanhCong() {
        return thanhCong;
    }

    /**
     * @param thanhCong the thanhCong to set
     */
    public void setThanhCong(boolean thanhCong) {
        this.thanhCong = thanhCong;
    }

    /**
     * @return the thongBao
     */
    public String getThongBao() {
        return thongBao;
    }

    /**
     * @param thongBao the thongBao to set
     */
    public void setThongBao(String thongBao) {
        this.thongBao = thongBao;
    }

    /**
     * @return the duLieu
     */
    public T getDuLieu() {
        return duLieu;
    }

    /**
     * @param duLieu the duLieu to set
     */
    public void setDuLieu(T duLieu) {
        this.duLieu = duLieu;
    }

    /**
     * @return the maLoi
     */
    public int getMaLoi() {
        return maLoi;
    }

    /**
     * @param maLoi the maLoi to set
     */
    public void setMaLoi(int maLoi) {
        this.maLoi = maLoi;
    }
}
