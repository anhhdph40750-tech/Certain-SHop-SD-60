package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "NguoiDung")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class NguoiDung {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @Column(name = "TenDangNhap", unique = true, nullable = false, length = 100)
    private String tenDangNhap;

    @Column(name = "Email", unique = true, length = 150)
    private String email;

    @Column(name = "MatKhauMaHoa", nullable = false, length = 255)
    private String matKhauMaHoa;

    @Column(name = "HoTen", length = 150)
    private String hoTen;

    @Column(name = "SoDienThoai", length = 20)
    private String soDienThoai;

    @Column(name = "CCCD", length = 20)
    private String cccd;

    @Column(name = "MaNguoiDung", length = 20)
    private String maNguoiDung;

    @Column(name = "NgaySinh")
    private LocalDate ngaySinh;

    @Column(name = "GioiTinh")
    private Boolean gioiTinh; // true=Nam, false=Nu, null=Khong xac dinh

    @Column(name = "TrangThai", length = 30)
    private String trangThai = "HOAT_DONG";

    @Column(name = "AnhDaiDien", length = 255)
    private String anhDaiDien;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "VaiTroId")
    private VaiTro vaiTro;

    @Column(name = "DangHoatDong")
    private Boolean dangHoatDong = true;

    @Column(name = "LanDangNhapCuoi")
    private LocalDateTime lanDangNhapCuoi;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;

    @Column(name = "MaDatLaiMatKhau", length = 255)
    private String maDatLaiMatKhau;

    @Column(name = "LanDoiMatKhauCuoi")
    private LocalDateTime lanDoiMatKhauCuoi;

    @OneToMany(mappedBy = "nguoiDung", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<DiaChiNguoiDung> danhSachDiaChi;

    @PrePersist
    protected void truocKhiTao() {
        setThoiGianTao(LocalDateTime.now());
        setDangHoatDong((Boolean) true);
        if (getTrangThai() == null)
            setTrangThai("HOAT_DONG");
    }

    @PreUpdate
    protected void truocKhiCapNhat() {
        setThoiGianCapNhat(LocalDateTime.now());
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
     * @return the tenDangNhap
     */
    public String getTenDangNhap() {
        return tenDangNhap;
    }

    /**
     * @param tenDangNhap the tenDangNhap to set
     */
    public void setTenDangNhap(String tenDangNhap) {
        this.tenDangNhap = tenDangNhap;
    }

    /**
     * @return the email
     */
    public String getEmail() {
        return email;
    }

    /**
     * @param email the email to set
     */
    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * @return the matKhauMaHoa
     */
    public String getMatKhauMaHoa() {
        return matKhauMaHoa;
    }

    /**
     * @param matKhauMaHoa the matKhauMaHoa to set
     */
    public void setMatKhauMaHoa(String matKhauMaHoa) {
        this.matKhauMaHoa = matKhauMaHoa;
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
     * @return the cccd
     */
    public String getCccd() {
        return cccd;
    }

    /**
     * @param cccd the cccd to set
     */
    public void setCccd(String cccd) {
        this.cccd = cccd;
    }

    /**
     * @return the maNguoiDung
     */
    public String getMaNguoiDung() {
        return maNguoiDung;
    }

    /**
     * @param maNguoiDung the maNguoiDung to set
     */
    public void setMaNguoiDung(String maNguoiDung) {
        this.maNguoiDung = maNguoiDung;
    }

    /**
     * @return the ngaySinh
     */
    public LocalDate getNgaySinh() {
        return ngaySinh;
    }

    /**
     * @param ngaySinh the ngaySinh to set
     */
    public void setNgaySinh(LocalDate ngaySinh) {
        this.ngaySinh = ngaySinh;
    }

    /**
     * @return the gioiTinh
     */
    public Boolean getGioiTinh() {
        return gioiTinh;
    }

    /**
     * @param gioiTinh the gioiTinh to set
     */
    public void setGioiTinh(Boolean gioiTinh) {
        this.gioiTinh = gioiTinh;
    }

    /**
     * @return the trangThai
     */
    public String getTrangThai() {
        return trangThai;
    }

    /**
     * @param trangThai the trangThai to set
     */
    public void setTrangThai(String trangThai) {
        this.trangThai = trangThai;
    }

    /**
     * @return the anhDaiDien
     */
    public String getAnhDaiDien() {
        return anhDaiDien;
    }

    /**
     * @param anhDaiDien the anhDaiDien to set
     */
    public void setAnhDaiDien(String anhDaiDien) {
        this.anhDaiDien = anhDaiDien;
    }

    /**
     * @return the vaiTro
     */
    public VaiTro getVaiTro() {
        return vaiTro;
    }

    /**
     * @param vaiTro the vaiTro to set
     */
    public void setVaiTro(VaiTro vaiTro) {
        this.vaiTro = vaiTro;
    }

    /**
     * @return the dangHoatDong
     */
    public Boolean getDangHoatDong() {
        return dangHoatDong;
    }

    /**
     * @param dangHoatDong the dangHoatDong to set
     */
    public void setDangHoatDong(Boolean dangHoatDong) {
        this.dangHoatDong = dangHoatDong;
    }

    /**
     * @return the lanDangNhapCuoi
     */
    public LocalDateTime getLanDangNhapCuoi() {
        return lanDangNhapCuoi;
    }

    /**
     * @param lanDangNhapCuoi the lanDangNhapCuoi to set
     */
    public void setLanDangNhapCuoi(LocalDateTime lanDangNhapCuoi) {
        this.lanDangNhapCuoi = lanDangNhapCuoi;
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

    /**
     * @return the thoiGianCapNhat
     */
    public LocalDateTime getThoiGianCapNhat() {
        return thoiGianCapNhat;
    }

    /**
     * @param thoiGianCapNhat the thoiGianCapNhat to set
     */
    public void setThoiGianCapNhat(LocalDateTime thoiGianCapNhat) {
        this.thoiGianCapNhat = thoiGianCapNhat;
    }

    /**
     * @return the maDatLaiMatKhau
     */
    public String getMaDatLaiMatKhau() {
        return maDatLaiMatKhau;
    }

    /**
     * @param maDatLaiMatKhau the maDatLaiMatKhau to set
     */
    public void setMaDatLaiMatKhau(String maDatLaiMatKhau) {
        this.maDatLaiMatKhau = maDatLaiMatKhau;
    }

    /**
     * @return the lanDoiMatKhauCuoi
     */
    public LocalDateTime getLanDoiMatKhauCuoi() {
        return lanDoiMatKhauCuoi;
    }

    /**
     * @param lanDoiMatKhauCuoi the lanDoiMatKhauCuoi to set
     */
    public void setLanDoiMatKhauCuoi(LocalDateTime lanDoiMatKhauCuoi) {
        this.lanDoiMatKhauCuoi = lanDoiMatKhauCuoi;
    }

    /**
     * @return the danhSachDiaChi
     */
    public List<DiaChiNguoiDung> getDanhSachDiaChi() {
        return danhSachDiaChi;
    }

    /**
     * @param danhSachDiaChi the danhSachDiaChi to set
     */
    public void setDanhSachDiaChi(List<DiaChiNguoiDung> danhSachDiaChi) {
        this.danhSachDiaChi = danhSachDiaChi;
    }
}
