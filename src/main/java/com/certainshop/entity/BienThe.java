package com.certainshop.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "BienThe")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BienThe {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "SanPhamId", nullable = false)
    @JsonIgnore
    private SanPham sanPham;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "KichThuocId")
    private KichThuoc kichThuoc;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "MauSacId")
    private MauSac mauSac;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ChatLieuId")
    private ChatLieu chatLieu;

    @Column(name = "GiaBan", precision = 18, scale = 2)
    private BigDecimal gia;

    @Column(name = "SoLuongTon")
    private Integer soLuongTon = 0;

    @Column(name = "MacDinh")
    private Boolean macDinh = false;

    @Column(name = "TrangThai")
    private Boolean trangThai = true;

    @Column(name = "ThoiGianTao")
    private LocalDateTime ngayTao;

    @Column(name = "ThoiGianCapNhat")
    private LocalDateTime ngayCapNhat;

    @OneToMany(mappedBy = "bienThe", cascade = CascadeType.ALL, fetch = FetchType.LAZY, orphanRemoval = true)
    private List<HinhAnhBienThe> danhSachHinhAnh;

    @PrePersist
    protected void truocKhiTao() {
        setNgayTao(LocalDateTime.now());
    }

    @PreUpdate
    protected void truocKhiCapNhat() {
        setNgayCapNhat(LocalDateTime.now());
    }

    // Lấy ảnh chính
    public String getAnhChinh() {
        if (getDanhSachHinhAnh() == null || getDanhSachHinhAnh().isEmpty())
            return "/img/no-image.png";
        for (HinhAnhBienThe h : getDanhSachHinhAnh()) {
            if (Boolean.TRUE.equals(h.getLaAnhChinh()))
                return h.getDuongDan();
        }
        return getDanhSachHinhAnh().get(0).getDuongDan();
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
     * @return the sanPham
     */
    public SanPham getSanPham() {
        return sanPham;
    }

    /**
     * @param sanPham the sanPham to set
     */
    public void setSanPham(SanPham sanPham) {
        this.sanPham = sanPham;
    }

    /**
     * @return the kichThuoc
     */
    public KichThuoc getKichThuoc() {
        return kichThuoc;
    }

    /**
     * @param kichThuoc the kichThuoc to set
     */
    public void setKichThuoc(KichThuoc kichThuoc) {
        this.kichThuoc = kichThuoc;
    }

    /**
     * @return the mauSac
     */
    public MauSac getMauSac() {
        return mauSac;
    }

    /**
     * @param mauSac the mauSac to set
     */
    public void setMauSac(MauSac mauSac) {
        this.mauSac = mauSac;
    }

    /**
     * @return the chatLieu
     */
    public ChatLieu getChatLieu() {
        return chatLieu;
    }

    /**
     * @param chatLieu the chatLieu to set
     */
    public void setChatLieu(ChatLieu chatLieu) {
        this.chatLieu = chatLieu;
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

    /**
     * @return the ngayTao
     */
    public LocalDateTime getNgayTao() {
        return ngayTao;
    }

    /**
     * @param ngayTao the ngayTao to set
     */
    public void setNgayTao(LocalDateTime ngayTao) {
        this.ngayTao = ngayTao;
    }

    /**
     * @return the ngayCapNhat
     */
    public LocalDateTime getNgayCapNhat() {
        return ngayCapNhat;
    }

    /**
     * @param ngayCapNhat the ngayCapNhat to set
     */
    public void setNgayCapNhat(LocalDateTime ngayCapNhat) {
        this.ngayCapNhat = ngayCapNhat;
    }

    /**
     * @return the danhSachHinhAnh
     */
    public List<HinhAnhBienThe> getDanhSachHinhAnh() {
        return danhSachHinhAnh;
    }

    /**
     * @param danhSachHinhAnh the danhSachHinhAnh to set
     */
    public void setDanhSachHinhAnh(List<HinhAnhBienThe> danhSachHinhAnh) {
        this.danhSachHinhAnh = danhSachHinhAnh;
    }
}
