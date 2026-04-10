package com.certainshop.entity;

import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "DonHang")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DonHang {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NguoiDungId")
    private NguoiDung nguoiDung;

    @Column(name = "MaDonHang", length = 50)
    private String maDonHang;

    @Column(name = "TongTienHang", precision = 18, scale = 2)
    private BigDecimal tongTien;

    @Column(name = "SoTienGiamGia", precision = 18, scale = 2)
    private BigDecimal soTienGiamGia = BigDecimal.ZERO;

    @Column(name = "PhiVanChuyen", precision = 18, scale = 2)
    private BigDecimal phiVanChuyen = BigDecimal.ZERO;

    @Column(name = "TongTienThanhToan", precision = 18, scale = 2)
    private BigDecimal tongTienThanhToan;

    @Column(name = "TrangThaiDonHang", length = 50)
    private String trangThaiDonHang;

    // ONLINE hoặc TAI_QUAY
    @Column(name = "LoaiDonHang", length = 50)
    private String loaiDonHang;

    // COD hoặc VNPAY
    @Column(name = "PhuongThucThanhToan", length = 50)
    private String phuongThucThanhToan;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "KhuyenMaiId")
    private KhuyenMai khuyenMai;

    // Mã voucher áp dụng
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "VoucherId")
    private Voucher voucher;

    // Thông tin giao hàng
    @Column(name = "TenNguoiNhan", length = 150)
    private String tenNguoiNhan;

    @Column(name = "SdtNguoiNhan", length = 20)
    private String sdtNguoiNhan;

    @Column(name = "DiaChiGiaoHang", length = 500)
    private String diaChiGiaoHang;

    @Column(name = "DaThanhToan")
    private Boolean daThanhToan = false;

    @Column(name = "MaTinhGHN")
    private Integer maTinhGHN;

    @Column(name = "MaHuyenGHN")
    private Integer maHuyenGHN;

    @Column(name = "MaXaGHN", length = 20)
    private String maXaGHN;

    @Column(name = "GhiChu", length = 255)
    private String ghiChu;

    @Column(name = "GhiChuThuNgan", length = 255)
    private String ghiChuThuNgan;

    // Nhân viên tạo/xử lí (cho bán tại quầy)
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "NhanVienId")
    private NguoiDung nhanVien;

    // VNPay transaction ref
    @Column(name = "VnpayTxnRef", length = 100)
    private String vnPayTransactionRef;

    @Column(name = "ThoiGianTao")
    private LocalDateTime thoiGianTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime thoiGianCapNhat;

    // Thời gian tự hủy (cho hóa đơn chờ tại quầy)
    @Column(name = "ThoiGianTuHuy")
    private LocalDateTime thoiGianTuHuy;

    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<ChiTietDonHang> danhSachChiTiet;

    @OneToMany(mappedBy = "donHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @OrderBy("thoiGian ASC")
    private List<LichSuTrangThaiDon> lichSuTrangThai;

    @OneToOne(mappedBy = "donHang", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private ThanhToan thanhToan;

    @PrePersist
    protected void truocKhiTao() {
        LocalDateTime now = LocalDateTime.now();
        setThoiGianTao(now);
        setThoiGianCapNhat(now); // Set on creation too
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
     * @return the nguoiDung
     */
    public NguoiDung getNguoiDung() {
        return nguoiDung;
    }

    /**
     * @param nguoiDung the nguoiDung to set
     */
    public void setNguoiDung(NguoiDung nguoiDung) {
        this.nguoiDung = nguoiDung;
    }

    /**
     * @return the maDonHang
     */
    public String getMaDonHang() {
        return maDonHang;
    }

    /**
     * @param maDonHang the maDonHang to set
     */
    public void setMaDonHang(String maDonHang) {
        this.maDonHang = maDonHang;
    }

    /**
     * @return the tongTien
     */
    public BigDecimal getTongTien() {
        return tongTien;
    }

    /**
     * @param tongTien the tongTien to set
     */
    public void setTongTien(BigDecimal tongTien) {
        this.tongTien = tongTien;
    }

    /**
     * @return the soTienGiamGia
     */
    public BigDecimal getSoTienGiamGia() {
        return soTienGiamGia;
    }

    /**
     * @param soTienGiamGia the soTienGiamGia to set
     */
    public void setSoTienGiamGia(BigDecimal soTienGiamGia) {
        this.soTienGiamGia = soTienGiamGia;
    }

    /**
     * @return the phiVanChuyen
     */
    public BigDecimal getPhiVanChuyen() {
        return phiVanChuyen;
    }

    /**
     * @param phiVanChuyen the phiVanChuyen to set
     */
    public void setPhiVanChuyen(BigDecimal phiVanChuyen) {
        this.phiVanChuyen = phiVanChuyen;
    }

    /**
     * @return the tongTienThanhToan
     */
    public BigDecimal getTongTienThanhToan() {
        return tongTienThanhToan;
    }

    /**
     * @param tongTienThanhToan the tongTienThanhToan to set
     */
    public void setTongTienThanhToan(BigDecimal tongTienThanhToan) {
        this.tongTienThanhToan = tongTienThanhToan;
    }

    /**
     * @return the trangThaiDonHang
     */
    public String getTrangThaiDonHang() {
        return trangThaiDonHang;
    }

    /**
     * @param trangThaiDonHang the trangThaiDonHang to set
     */
    public void setTrangThaiDonHang(String trangThaiDonHang) {
        this.trangThaiDonHang = trangThaiDonHang;
    }

    /**
     * @return the loaiDonHang
     */
    public String getLoaiDonHang() {
        return loaiDonHang;
    }

    /**
     * @param loaiDonHang the loaiDonHang to set
     */
    public void setLoaiDonHang(String loaiDonHang) {
        this.loaiDonHang = loaiDonHang;
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
     * @return the khuyenMai
     */
    public KhuyenMai getKhuyenMai() {
        return khuyenMai;
    }

    /**
     * @param khuyenMai the khuyenMai to set
     */
    public void setKhuyenMai(KhuyenMai khuyenMai) {
        this.khuyenMai = khuyenMai;
    }

    /**
     * @return the voucher
     */
    public Voucher getVoucher() {
        return voucher;
    }

    /**
     * @param voucher the voucher to set
     */
    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
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
     * @return the sdtNguoiNhan
     */
    public String getSdtNguoiNhan() {
        return sdtNguoiNhan;
    }

    /**
     * @param sdtNguoiNhan the sdtNguoiNhan to set
     */
    public void setSdtNguoiNhan(String sdtNguoiNhan) {
        this.sdtNguoiNhan = sdtNguoiNhan;
    }

    /**
     * @return the diaChiGiaoHang
     */
    public String getDiaChiGiaoHang() {
        return diaChiGiaoHang;
    }

    /**
     * @param diaChiGiaoHang the diaChiGiaoHang to set
     */
    public void setDiaChiGiaoHang(String diaChiGiaoHang) {
        this.diaChiGiaoHang = diaChiGiaoHang;
    }

    /**
     * @return the daThanhToan
     */
    public Boolean getDaThanhToan() {
        return daThanhToan;
    }

    /**
     * @param daThanhToan the daThanhToan to set
     */
    public void setDaThanhToan(Boolean daThanhToan) {
        this.daThanhToan = daThanhToan;
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
     * @return the ghiChuThuNgan
     */
    public String getGhiChuThuNgan() {
        return ghiChuThuNgan;
    }

    /**
     * @param ghiChuThuNgan the ghiChuThuNgan to set
     */
    public void setGhiChuThuNgan(String ghiChuThuNgan) {
        this.ghiChuThuNgan = ghiChuThuNgan;
    }

    /**
     * @return the nhanVien
     */
    public NguoiDung getNhanVien() {
        return nhanVien;
    }

    /**
     * @param nhanVien the nhanVien to set
     */
    public void setNhanVien(NguoiDung nhanVien) {
        this.nhanVien = nhanVien;
    }

    /**
     * @return the vnPayTransactionRef
     */
    public String getVnPayTransactionRef() {
        return vnPayTransactionRef;
    }

    /**
     * @param vnPayTransactionRef the vnPayTransactionRef to set
     */
    public void setVnPayTransactionRef(String vnPayTransactionRef) {
        this.vnPayTransactionRef = vnPayTransactionRef;
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
     * @return the thoiGianTuHuy
     */
    public LocalDateTime getThoiGianTuHuy() {
        return thoiGianTuHuy;
    }

    /**
     * @param thoiGianTuHuy the thoiGianTuHuy to set
     */
    public void setThoiGianTuHuy(LocalDateTime thoiGianTuHuy) {
        this.thoiGianTuHuy = thoiGianTuHuy;
    }

    /**
     * @return the danhSachChiTiet
     */
    public List<ChiTietDonHang> getDanhSachChiTiet() {
        return danhSachChiTiet;
    }

    /**
     * @param danhSachChiTiet the danhSachChiTiet to set
     */
    public void setDanhSachChiTiet(List<ChiTietDonHang> danhSachChiTiet) {
        this.danhSachChiTiet = danhSachChiTiet;
    }

    /**
     * @return the lichSuTrangThai
     */
    public List<LichSuTrangThaiDon> getLichSuTrangThai() {
        return lichSuTrangThai;
    }

    /**
     * @param lichSuTrangThai the lichSuTrangThai to set
     */
    public void setLichSuTrangThai(List<LichSuTrangThaiDon> lichSuTrangThai) {
        this.lichSuTrangThai = lichSuTrangThai;
    }

    /**
     * @return the thanhToan
     */
    public ThanhToan getThanhToan() {
        return thanhToan;
    }

    /**
     * @param thanhToan the thanhToan to set
     */
    public void setThanhToan(ThanhToan thanhToan) {
        this.thanhToan = thanhToan;
    }
}
