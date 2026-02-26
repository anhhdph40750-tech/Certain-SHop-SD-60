-- ============================================================
-- Certain_Shop - Full Database Backup
-- Generated : 2026-02-26 19:24:07
-- ============================================================
USE [master];
GO
IF DB_ID('Certain_Shop') IS NULL BEGIN
    CREATE DATABASE [Certain_Shop];
END
GO
USE [Certain_Shop];
GO
SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
GO

-- ============================================================
-- DROP FOREIGN KEYS
-- ============================================================
IF OBJECT_ID(N'FKdilrlq8vq4vvcuu6fg0ht8vju','F') IS NOT NULL ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FKdilrlq8vq4vvcuu6fg0ht8vju];
IF OBJECT_ID(N'FK9ndkc9rem0wb4xethp4qkpsn','F') IS NOT NULL ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FK9ndkc9rem0wb4xethp4qkpsn];
IF OBJECT_ID(N'FKkk53hh7y3twhgngbpcpylthk8','F') IS NOT NULL ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FKkk53hh7y3twhgngbpcpylthk8];
IF OBJECT_ID(N'FKh2dhysvrw2pnhacnh1xlyonr0','F') IS NOT NULL ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FKh2dhysvrw2pnhacnh1xlyonr0];
IF OBJECT_ID(N'FK_BienThe_SanPham','F') IS NOT NULL ALTER TABLE [dbo].[BienThe] DROP CONSTRAINT [FK_BienThe_SanPham];
IF OBJECT_ID(N'FK_BienThe_KichThuoc','F') IS NOT NULL ALTER TABLE [dbo].[BienThe] DROP CONSTRAINT [FK_BienThe_KichThuoc];
IF OBJECT_ID(N'FK_BienThe_MauSac','F') IS NOT NULL ALTER TABLE [dbo].[BienThe] DROP CONSTRAINT [FK_BienThe_MauSac];
IF OBJECT_ID(N'FK_BienThe_ChatLieu','F') IS NOT NULL ALTER TABLE [dbo].[BienThe] DROP CONSTRAINT [FK_BienThe_ChatLieu];
IF OBJECT_ID(N'FKk2knfk78gkwo3srle9wd00fat','F') IS NOT NULL ALTER TABLE [dbo].[chi_tiet_don_hang] DROP CONSTRAINT [FKk2knfk78gkwo3srle9wd00fat];
IF OBJECT_ID(N'FKt57maavf6s28hxyar724mdr1b','F') IS NOT NULL ALTER TABLE [dbo].[chi_tiet_don_hang] DROP CONSTRAINT [FKt57maavf6s28hxyar724mdr1b];
IF OBJECT_ID(N'FK_CTDH_DonHang','F') IS NOT NULL ALTER TABLE [dbo].[ChiTietDonHang] DROP CONSTRAINT [FK_CTDH_DonHang];
IF OBJECT_ID(N'FK_CTDH_BienThe','F') IS NOT NULL ALTER TABLE [dbo].[ChiTietDonHang] DROP CONSTRAINT [FK_CTDH_BienThe];
IF OBJECT_ID(N'FK_DanhGia_SanPham','F') IS NOT NULL ALTER TABLE [dbo].[DanhGia] DROP CONSTRAINT [FK_DanhGia_SanPham];
IF OBJECT_ID(N'FK_DanhGia_NguoiDung','F') IS NOT NULL ALTER TABLE [dbo].[DanhGia] DROP CONSTRAINT [FK_DanhGia_NguoiDung];
IF OBJECT_ID(N'FK_DanhGia_CTDonHang','F') IS NOT NULL ALTER TABLE [dbo].[DanhGia] DROP CONSTRAINT [FK_DanhGia_CTDonHang];
IF OBJECT_ID(N'FK_DiaChi_NguoiDung','F') IS NOT NULL ALTER TABLE [dbo].[DiaChiNguoiDung] DROP CONSTRAINT [FK_DiaChi_NguoiDung];
IF OBJECT_ID(N'FKm66hy6vf9vuoi3tdept6h771l','F') IS NOT NULL ALTER TABLE [dbo].[don_hang] DROP CONSTRAINT [FKm66hy6vf9vuoi3tdept6h771l];
IF OBJECT_ID(N'FK3tq0qg6f6ranwlr8gvfii79d3','F') IS NOT NULL ALTER TABLE [dbo].[don_hang] DROP CONSTRAINT [FK3tq0qg6f6ranwlr8gvfii79d3];
IF OBJECT_ID(N'FKec7ntc61uhko624hwt130w1yc','F') IS NOT NULL ALTER TABLE [dbo].[don_hang] DROP CONSTRAINT [FKec7ntc61uhko624hwt130w1yc];
IF OBJECT_ID(N'FK_DonHang_NguoiDung','F') IS NOT NULL ALTER TABLE [dbo].[DonHang] DROP CONSTRAINT [FK_DonHang_NguoiDung];
IF OBJECT_ID(N'FK_DonHang_NhanVien','F') IS NOT NULL ALTER TABLE [dbo].[DonHang] DROP CONSTRAINT [FK_DonHang_NhanVien];
IF OBJECT_ID(N'FK_DonHang_KhuyenMai','F') IS NOT NULL ALTER TABLE [dbo].[DonHang] DROP CONSTRAINT [FK_DonHang_KhuyenMai];
IF OBJECT_ID(N'FK_GioHang_NguoiDung','F') IS NOT NULL ALTER TABLE [dbo].[GioHang] DROP CONSTRAINT [FK_GioHang_NguoiDung];
IF OBJECT_ID(N'FK_GHCT_GioHang','F') IS NOT NULL ALTER TABLE [dbo].[GioHangChiTiet] DROP CONSTRAINT [FK_GHCT_GioHang];
IF OBJECT_ID(N'FK_GHCT_BienThe','F') IS NOT NULL ALTER TABLE [dbo].[GioHangChiTiet] DROP CONSTRAINT [FK_GHCT_BienThe];
IF OBJECT_ID(N'FK_HinhAnh_BienThe','F') IS NOT NULL ALTER TABLE [dbo].[HinhAnhBienThe] DROP CONSTRAINT [FK_HinhAnh_BienThe];
IF OBJECT_ID(N'FK_LSTD_DonHang','F') IS NOT NULL ALTER TABLE [dbo].[LichSuTrangThaiDon] DROP CONSTRAINT [FK_LSTD_DonHang];
IF OBJECT_ID(N'FK_LSTD_NguoiDung','F') IS NOT NULL ALTER TABLE [dbo].[LichSuTrangThaiDon] DROP CONSTRAINT [FK_LSTD_NguoiDung];
IF OBJECT_ID(N'FKa5oibkto18llfdid5w4mv4v47','F') IS NOT NULL ALTER TABLE [dbo].[nguoi_dung] DROP CONSTRAINT [FKa5oibkto18llfdid5w4mv4v47];
IF OBJECT_ID(N'FK_NguoiDung_VaiTro','F') IS NOT NULL ALTER TABLE [dbo].[NguoiDung] DROP CONSTRAINT [FK_NguoiDung_VaiTro];
IF OBJECT_ID(N'FKmnhsdc3pdlvp4pkronxu5hasp','F') IS NOT NULL ALTER TABLE [dbo].[san_pham] DROP CONSTRAINT [FKmnhsdc3pdlvp4pkronxu5hasp];
IF OBJECT_ID(N'FKrum92qs4m7i0u7p7ub6bhbrr5','F') IS NOT NULL ALTER TABLE [dbo].[san_pham] DROP CONSTRAINT [FKrum92qs4m7i0u7p7ub6bhbrr5];
IF OBJECT_ID(N'FK_SanPham_DanhMuc','F') IS NOT NULL ALTER TABLE [dbo].[SanPham] DROP CONSTRAINT [FK_SanPham_DanhMuc];
IF OBJECT_ID(N'FK_SanPham_ThuongHieu','F') IS NOT NULL ALTER TABLE [dbo].[SanPham] DROP CONSTRAINT [FK_SanPham_ThuongHieu];
IF OBJECT_ID(N'FK_ThanhToan_DonHang','F') IS NOT NULL ALTER TABLE [dbo].[ThanhToan] DROP CONSTRAINT [FK_ThanhToan_DonHang];
GO

-- ============================================================
-- DROP TABLES (reverse order)
-- ============================================================
IF OBJECT_ID('[dbo].[vai_tro]','U') IS NOT NULL DROP TABLE [dbo].[vai_tro];
IF OBJECT_ID('[dbo].[thuong_hieu]','U') IS NOT NULL DROP TABLE [dbo].[thuong_hieu];
IF OBJECT_ID('[dbo].[san_pham]','U') IS NOT NULL DROP TABLE [dbo].[san_pham];
IF OBJECT_ID('[dbo].[nguoi_dung]','U') IS NOT NULL DROP TABLE [dbo].[nguoi_dung];
IF OBJECT_ID('[dbo].[mau_sac]','U') IS NOT NULL DROP TABLE [dbo].[mau_sac];
IF OBJECT_ID('[dbo].[kich_thuoc]','U') IS NOT NULL DROP TABLE [dbo].[kich_thuoc];
IF OBJECT_ID('[dbo].[khuyen_mai]','U') IS NOT NULL DROP TABLE [dbo].[khuyen_mai];
IF OBJECT_ID('[dbo].[don_hang]','U') IS NOT NULL DROP TABLE [dbo].[don_hang];
IF OBJECT_ID('[dbo].[danh_muc]','U') IS NOT NULL DROP TABLE [dbo].[danh_muc];
IF OBJECT_ID('[dbo].[chi_tiet_don_hang]','U') IS NOT NULL DROP TABLE [dbo].[chi_tiet_don_hang];
IF OBJECT_ID('[dbo].[chat_lieu]','U') IS NOT NULL DROP TABLE [dbo].[chat_lieu];
IF OBJECT_ID('[dbo].[bien_the]','U') IS NOT NULL DROP TABLE [dbo].[bien_the];
IF OBJECT_ID('[dbo].[ThanhToan]','U') IS NOT NULL DROP TABLE [dbo].[ThanhToan];
IF OBJECT_ID('[dbo].[DanhGia]','U') IS NOT NULL DROP TABLE [dbo].[DanhGia];
IF OBJECT_ID('[dbo].[LichSuTrangThaiDon]','U') IS NOT NULL DROP TABLE [dbo].[LichSuTrangThaiDon];
IF OBJECT_ID('[dbo].[ChiTietDonHang]','U') IS NOT NULL DROP TABLE [dbo].[ChiTietDonHang];
IF OBJECT_ID('[dbo].[DonHang]','U') IS NOT NULL DROP TABLE [dbo].[DonHang];
IF OBJECT_ID('[dbo].[GioHangChiTiet]','U') IS NOT NULL DROP TABLE [dbo].[GioHangChiTiet];
IF OBJECT_ID('[dbo].[GioHang]','U') IS NOT NULL DROP TABLE [dbo].[GioHang];
IF OBJECT_ID('[dbo].[HinhAnhBienThe]','U') IS NOT NULL DROP TABLE [dbo].[HinhAnhBienThe];
IF OBJECT_ID('[dbo].[BienThe]','U') IS NOT NULL DROP TABLE [dbo].[BienThe];
IF OBJECT_ID('[dbo].[SanPham]','U') IS NOT NULL DROP TABLE [dbo].[SanPham];
IF OBJECT_ID('[dbo].[KhuyenMai]','U') IS NOT NULL DROP TABLE [dbo].[KhuyenMai];
IF OBJECT_ID('[dbo].[KichThuoc]','U') IS NOT NULL DROP TABLE [dbo].[KichThuoc];
IF OBJECT_ID('[dbo].[MauSac]','U') IS NOT NULL DROP TABLE [dbo].[MauSac];
IF OBJECT_ID('[dbo].[ChatLieu]','U') IS NOT NULL DROP TABLE [dbo].[ChatLieu];
IF OBJECT_ID('[dbo].[DanhMuc]','U') IS NOT NULL DROP TABLE [dbo].[DanhMuc];
IF OBJECT_ID('[dbo].[ThuongHieu]','U') IS NOT NULL DROP TABLE [dbo].[ThuongHieu];
IF OBJECT_ID('[dbo].[DiaChiNguoiDung]','U') IS NOT NULL DROP TABLE [dbo].[DiaChiNguoiDung];
IF OBJECT_ID('[dbo].[NguoiDung]','U') IS NOT NULL DROP TABLE [dbo].[NguoiDung];
IF OBJECT_ID('[dbo].[VaiTro]','U') IS NOT NULL DROP TABLE [dbo].[VaiTro];
GO

-- ============================================================
-- CREATE TABLES
-- ============================================================
CREATE TABLE [dbo].[VaiTro] (
    [Id] INT IDENTITY(1,1) NOT NULL,
    [TenVaiTro] VARCHAR(50) NOT NULL,
    [QuyenHan] VARCHAR(255) NULL,
    CONSTRAINT [UQ__VaiTro__1DA55814373343EF] UNIQUE ([TenVaiTro])
);
GO

CREATE TABLE [dbo].[NguoiDung] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [TenDangNhap] VARCHAR(100) NOT NULL,
    [Email] VARCHAR(150) NULL,
    [MatKhauMaHoa] VARCHAR(255) NOT NULL,
    [HoTen] NVARCHAR(150) NULL,
    [SoDienThoai] VARCHAR(20) NULL,
    [NgaySinh] DATE NULL,
    [GioiTinh] BIT NULL,
    [AnhDaiDien] VARCHAR(500) NULL,
    [VaiTroId] INT NOT NULL,
    [TrangThai] VARCHAR(30) DEFAULT ('HOAT_DONG') NOT NULL,
    [LanDangNhapCuoi] DATETIME NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL,
    [DangHoatDong] BIT DEFAULT ((1)) NULL,
    [MaDatLaiMatKhau] VARCHAR(255) NULL,
    [LanDoiMatKhauCuoi] DATETIME NULL,
    CONSTRAINT [UQ__NguoiDun__55F68FC0CC3434E6] UNIQUE ([TenDangNhap]),
    CONSTRAINT [UQ__NguoiDun__A9D1053477413C8E] UNIQUE ([Email])
);
GO

CREATE TABLE [dbo].[DiaChiNguoiDung] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [NguoiDungId] BIGINT NOT NULL,
    [TenNguoiNhan] NVARCHAR(150) NULL,
    [SoDienThoai] VARCHAR(20) NULL,
    [DiaChiCuThe] NVARCHAR(500) NULL,
    [PhuongXa] NVARCHAR(150) NULL,
    [QuanHuyen] NVARCHAR(150) NULL,
    [TinhThanh] NVARCHAR(150) NULL,
    [MaTinhGHN] INT NULL,
    [MaHuyenGHN] INT NULL,
    [MaXaGHN] NVARCHAR(50) NULL,
    [LaMacDinh] BIT DEFAULT ((0)) NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL
);
GO

CREATE TABLE [dbo].[ThuongHieu] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [TenThuongHieu] NVARCHAR(150) NOT NULL,
    [MoTa] NVARCHAR(500) NULL,
    [TrangThai] BIT DEFAULT ((1)) NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL
);
GO

CREATE TABLE [dbo].[DanhMuc] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [TenDanhMuc] NVARCHAR(150) NOT NULL,
    [DuongDan] VARCHAR(255) NULL,
    [MoTa] NVARCHAR(500) NULL,
    [ThuTuHienThi] INT DEFAULT ((0)) NOT NULL,
    [DangHoatDong] BIT DEFAULT ((1)) NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL
);
GO

CREATE TABLE [dbo].[ChatLieu] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [TenChatLieu] NVARCHAR(150) NOT NULL,
    [MoTa] NVARCHAR(500) NULL
);
GO

CREATE TABLE [dbo].[MauSac] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [TenMauSac] NVARCHAR(100) NOT NULL,
    [MaHex] VARCHAR(10) NULL,
    [MoTa] NVARCHAR(255) NULL
);
GO

CREATE TABLE [dbo].[KichThuoc] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [TenKichThuoc] VARCHAR(50) NOT NULL,
    [ThuTu] INT DEFAULT ((0)) NOT NULL
);
GO

CREATE TABLE [dbo].[KhuyenMai] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [MaKhuyenMai] VARCHAR(50) NOT NULL,
    [TenKhuyenMai] NVARCHAR(200) NOT NULL,
    [MoTa] NVARCHAR(500) NULL,
    [LoaiGiam] VARCHAR(20) DEFAULT ('PHAN_TRAM') NOT NULL,
    [GiaTriGiam] DECIMAL(18,2) NOT NULL,
    [DonHangToiThieu] DECIMAL(18,2) DEFAULT ((0)) NOT NULL,
    [GiaTriToiDa] DECIMAL(18,2) NULL,
    [SoLuongToiDa] INT NULL,
    [SoLuongDaDung] INT DEFAULT ((0)) NOT NULL,
    [NgayBatDau] DATETIME NOT NULL,
    [NgayKetThuc] DATETIME NOT NULL,
    [TrangThaiKhuyenMai] VARCHAR(30) DEFAULT ('DANG_HOAT_DONG') NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL,
    CONSTRAINT [UQ__KhuyenMa__6F56B3BC5FAEC67B] UNIQUE ([MaKhuyenMai])
);
GO

CREATE TABLE [dbo].[SanPham] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [MaSanPham] VARCHAR(50) NULL,
    [TenSanPham] NVARCHAR(255) NOT NULL,
    [MoTa] NVARCHAR(MAX) NULL,
    [GiaGoc] DECIMAL(18,2) NULL,
    [GiaBan] DECIMAL(18,2) NULL,
    [DanhMucId] BIGINT NULL,
    [ThuongHieuId] BIGINT NULL,
    [AnhChinh] VARCHAR(500) NULL,
    [DuongDan] VARCHAR(255) NULL,
    [TrangThaiSanPham] VARCHAR(30) DEFAULT ('DANG_BAN') NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL
);
GO

CREATE TABLE [dbo].[BienThe] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [SanPhamId] BIGINT NOT NULL,
    [KichThuocId] BIGINT NULL,
    [MauSacId] BIGINT NULL,
    [ChatLieuId] BIGINT NULL,
    [GiaBan] DECIMAL(18,2) NULL,
    [SoLuongTon] INT DEFAULT ((0)) NOT NULL,
    [MacDinh] BIT DEFAULT ((0)) NOT NULL,
    [TrangThai] BIT DEFAULT ((1)) NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL
);
GO

CREATE TABLE [dbo].[HinhAnhBienThe] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [BienTheId] BIGINT NOT NULL,
    [DuongDan] VARCHAR(500) NOT NULL,
    [LaAnhChinh] BIT DEFAULT ((0)) NOT NULL,
    [ThuTu] INT DEFAULT ((0)) NOT NULL,
    [MoTa] NVARCHAR(255) NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL
);
GO

CREATE TABLE [dbo].[GioHang] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [NguoiDungId] BIGINT NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL,
    CONSTRAINT [UQ__GioHang__C4BBA4BCCE33218B] UNIQUE ([NguoiDungId])
);
GO

CREATE TABLE [dbo].[GioHangChiTiet] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [GioHangId] BIGINT NOT NULL,
    [BienTheId] BIGINT NOT NULL,
    [SoLuong] INT DEFAULT ((1)) NOT NULL,
    [DonGia] DECIMAL(18,2) NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL,
    CONSTRAINT [UQ_GioHang_BienThe] UNIQUE ([GioHangId], [BienTheId])
);
GO

CREATE TABLE [dbo].[DonHang] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [NguoiDungId] BIGINT NULL,
    [NhanVienId] BIGINT NULL,
    [MaDonHang] VARCHAR(50) NOT NULL,
    [LoaiDonHang] VARCHAR(30) NOT NULL,
    [TrangThaiDonHang] VARCHAR(50) DEFAULT ('CHO_XAC_NHAN') NOT NULL,
    [TongTienHang] DECIMAL(18,2) NULL,
    [SoTienGiamGia] DECIMAL(18,2) DEFAULT ((0)) NOT NULL,
    [PhiVanChuyen] DECIMAL(18,2) DEFAULT ((0)) NOT NULL,
    [TongTienThanhToan] DECIMAL(18,2) DEFAULT ((0)) NOT NULL,
    [KhuyenMaiId] BIGINT NULL,
    [TenNguoiNhan] NVARCHAR(150) NULL,
    [SdtNguoiNhan] VARCHAR(20) NULL,
    [DiaChiGiaoHang] NVARCHAR(500) NULL,
    [MaTinhGHN] INT NULL,
    [MaHuyenGHN] INT NULL,
    [MaXaGHN] NVARCHAR(50) NULL,
    [PhuongThucThanhToan] VARCHAR(50) NULL,
    [DaThanhToan] BIT DEFAULT ((0)) NOT NULL,
    [VnpayTxnRef] VARCHAR(100) NULL,
    [VnpayResponseCode] VARCHAR(10) NULL,
    [ThoiGianTuHuy] DATETIME NULL,
    [GhiChu] NVARCHAR(500) NULL,
    [GhiChuThuNgan] NVARCHAR(500) NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL,
    CONSTRAINT [UQ__DonHang__129584ACF40EF664] UNIQUE ([MaDonHang])
);
GO

CREATE TABLE [dbo].[ChiTietDonHang] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [DonHangId] BIGINT NOT NULL,
    [BienTheId] BIGINT NOT NULL,
    [SoLuong] INT DEFAULT ((1)) NOT NULL,
    [GiaTaiThoiDiemMua] DECIMAL(18,2) NOT NULL
);
GO

CREATE TABLE [dbo].[LichSuTrangThaiDon] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [DonHangId] BIGINT NOT NULL,
    [TrangThaiCu] VARCHAR(50) NULL,
    [TrangThaiMoi] VARCHAR(50) NOT NULL,
    [GhiChu] NVARCHAR(500) NULL,
    [NguoiThayDoiId] BIGINT NULL,
    [ThoiGian] DATETIME DEFAULT (getdate()) NOT NULL
);
GO

CREATE TABLE [dbo].[DanhGia] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [SanPhamId] BIGINT NOT NULL,
    [NguoiDungId] BIGINT NOT NULL,
    [ChiTietDonHangId] BIGINT NULL,
    [DiemDanhGia] INT NOT NULL,
    [TieuDe] NVARCHAR(255) NULL,
    [NoiDung] NVARCHAR(MAX) NULL,
    [HinhAnh] VARCHAR(500) NULL,
    [TrangThai] BIT DEFAULT ((1)) NOT NULL,
    [ThoiGianTao] DATETIME DEFAULT (getdate()) NOT NULL,
    [ThoiGianCapNhat] DATETIME NULL
);
GO

CREATE TABLE [dbo].[ThanhToan] (
    [Id] BIGINT IDENTITY(1,1) NOT NULL,
    [DonHangId] BIGINT NOT NULL,
    [PhuongThucThanhToan] VARCHAR(50) NULL,
    [TrangThaiThanhToan] VARCHAR(50) NULL,
    [SoTienThanhToan] DECIMAL(18,2) NULL,
    [ThoiDiemThanhToan] DATETIME NULL,
    [MaGiaoDichVNPay] VARCHAR(100) NULL,
    [MaNganHang] VARCHAR(50) NULL,
    [ThongTinGiaoDich] NVARCHAR(500) NULL
);
GO

CREATE TABLE [dbo].[bien_the] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [gia] NUMERIC(18,2) NULL,
    [mac_dinh] BIT NULL,
    [ngay_cap_nhat] DATETIME2(6) NULL,
    [ngay_tao] DATETIME2(6) NULL,
    [so_luong_ton] INT NULL,
    [trang_thai] BIT NULL,
    [chat_lieu_id] BIGINT NULL,
    [kich_thuoc_id] BIGINT NULL,
    [mau_sac_id] BIGINT NULL,
    [san_pham_id] BIGINT NOT NULL,
    [gia_ban] NUMERIC(18,2) NULL,
    [thoi_gian_cap_nhat] DATETIME2(6) NULL,
    [thoi_gian_tao] DATETIME2(6) NULL
);
GO

CREATE TABLE [dbo].[chat_lieu] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [mo_ta] VARCHAR(500) NULL,
    [ten_chat_lieu] VARCHAR(100) NULL
);
GO

CREATE TABLE [dbo].[chi_tiet_don_hang] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [gia_tai_thoi_diem_mua] NUMERIC(18,2) NULL,
    [so_luong] INT NULL,
    [thanh_tien] NUMERIC(18,2) NULL,
    [bien_the_id] BIGINT NOT NULL,
    [don_hang_id] BIGINT NOT NULL
);
GO

CREATE TABLE [dbo].[danh_muc] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [dang_hoat_dong] BIT NULL,
    [duong_dan] VARCHAR(255) NULL,
    [mo_ta] VARCHAR(255) NULL,
    [ten_danh_muc] VARCHAR(150) NULL,
    [thoi_gian_tao] DATETIME2(6) NULL,
    [thu_tu_hien_thi] INT NULL
);
GO

CREATE TABLE [dbo].[don_hang] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [dia_chi_giao_hang] VARCHAR(500) NULL,
    [ghi_chu] VARCHAR(255) NULL,
    [ghi_chu_thu_ngan] VARCHAR(255) NULL,
    [loai_don_hang] VARCHAR(50) NULL,
    [ma_don_hang] VARCHAR(50) NULL,
    [ma_huyenghn] INT NULL,
    [ma_tinhghn] INT NULL,
    [ma_xaghn] VARCHAR(20) NULL,
    [phi_van_chuyen] NUMERIC(18,2) NULL,
    [phuong_thuc_thanh_toan] VARCHAR(50) NULL,
    [phuong_xa_giao] VARCHAR(100) NULL,
    [quan_huyen_giao] VARCHAR(100) NULL,
    [sdt_nguoi_nhan] VARCHAR(20) NULL,
    [so_tien_giam_gia] NUMERIC(18,2) NULL,
    [ten_nguoi_nhan] VARCHAR(150) NULL,
    [thoi_gian_cap_nhat] DATETIME2(6) NULL,
    [thoi_gian_tao] DATETIME2(6) NULL,
    [thoi_gian_tu_huy] DATETIME2(6) NULL,
    [tinh_thanh_giao] VARCHAR(100) NULL,
    [tong_tien] NUMERIC(18,2) NULL,
    [tong_tien_thanh_toan] NUMERIC(18,2) NULL,
    [trang_thai_don_hang] VARCHAR(50) NULL,
    [vn_pay_transaction_ref] VARCHAR(100) NULL,
    [khuyen_mai_id] BIGINT NULL,
    [nguoi_dung_id] BIGINT NULL,
    [nhan_vien_id] BIGINT NULL,
    [da_thanh_toan] BIT NULL,
    [tong_tien_hang] NUMERIC(18,2) NULL,
    [vnpay_txn_ref] VARCHAR(100) NULL
);
GO

CREATE TABLE [dbo].[khuyen_mai] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [gia_tri_don_hang_toi_thieu] NUMERIC(18,2) NULL,
    [gia_tri_giam] NUMERIC(18,2) NULL,
    [gia_tri_don_hang_toi_da] NUMERIC(18,2) NULL,
    [loai_giam_gia] VARCHAR(50) NULL,
    [ma_khuyen_mai] VARCHAR(50) NULL,
    [mo_ta] VARCHAR(255) NULL,
    [ngay_bat_dau] DATETIME2(6) NULL,
    [ngay_cap_nhat] DATETIME2(6) NULL,
    [ngay_ket_thuc] DATETIME2(6) NULL,
    [ngay_tao] DATETIME2(6) NULL,
    [so_lan_da_su_dung] INT NULL,
    [so_lan_su_dung_toi_da] INT NULL,
    [ten_khuyen_mai] VARCHAR(150) NULL,
    [trang_thai_hoat_dong] BIT NULL
);
GO

CREATE TABLE [dbo].[kich_thuoc] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [kich_co] VARCHAR(50) NULL,
    [ten_kich_thuoc] VARCHAR(50) NULL,
    [thu_tu] INT NULL
);
GO

CREATE TABLE [dbo].[mau_sac] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [ma_hex] VARCHAR(10) NULL,
    [ten_mau] VARCHAR(50) NULL,
    [mo_ta] VARCHAR(255) NULL,
    [ten_mau_sac] VARCHAR(100) NULL
);
GO

CREATE TABLE [dbo].[nguoi_dung] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [anh_dai_dien] VARCHAR(255) NULL,
    [dang_hoat_dong] BIT NULL,
    [email] VARCHAR(150) NULL,
    [gioi_tinh] BIT NULL,
    [ho_ten] VARCHAR(150) NULL,
    [lan_dang_nhap_cuoi] DATETIME2(6) NULL,
    [lan_doi_mat_khau_cuoi] DATETIME2(6) NULL,
    [ma_dat_lai_mat_khau] VARCHAR(255) NULL,
    [mat_khau_ma_hoa] VARCHAR(255) NOT NULL,
    [ngay_sinh] DATE NULL,
    [so_dien_thoai] VARCHAR(20) NULL,
    [ten_dang_nhap] VARCHAR(100) NOT NULL,
    [thoi_gian_cap_nhat] DATETIME2(6) NULL,
    [thoi_gian_tao] DATETIME2(6) NULL,
    [vai_tro_id] INT NULL,
    [trang_thai] VARCHAR(30) NULL,
    CONSTRAINT [UK_o0s268lrp9is6o1e4ek6m1lc6] UNIQUE ([ten_dang_nhap])
);
GO

CREATE TABLE [dbo].[san_pham] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [gia_goc] NUMERIC(18,2) NULL,
    [mo_ta_chi_tiet] NVARCHAR(MAX) NULL,
    [ngay_cap_nhat] DATETIME2(6) NULL,
    [ngay_tao] DATETIME2(6) NULL,
    [ten_san_pham] VARCHAR(255) NULL,
    [trang_thai] BIT NULL,
    [danh_muc_id] BIGINT NULL,
    [thuong_hieu_id] BIGINT NULL,
    [anh_chinh] VARCHAR(500) NULL,
    [duong_dan] VARCHAR(255) NULL,
    [gia_ban] NUMERIC(18,2) NULL,
    [ma_san_pham] VARCHAR(50) NULL,
    [mo_ta] NVARCHAR(MAX) NULL,
    [thoi_gian_cap_nhat] DATETIME2(6) NULL,
    [thoi_gian_tao] DATETIME2(6) NULL,
    [trang_thai_san_pham] VARCHAR(30) NULL
);
GO

CREATE TABLE [dbo].[thuong_hieu] (
    [id] BIGINT IDENTITY(1,1) NOT NULL,
    [mo_ta] VARCHAR(500) NULL,
    [ten_thuong_hieu] VARCHAR(150) NULL,
    [thoi_gian_tao] DATETIME2(6) NULL,
    [trang_thai] BIT NULL
);
GO

CREATE TABLE [dbo].[vai_tro] (
    [id] INT IDENTITY(1,1) NOT NULL,
    [quyen_han] VARCHAR(255) NULL,
    [ten_vai_tro] VARCHAR(50) NOT NULL
);
GO

-- ============================================================
-- ADD FOREIGN KEYS
-- ============================================================
ALTER TABLE [dbo].[BienThe] ADD CONSTRAINT [FK_BienThe_ChatLieu]
    FOREIGN KEY ([ChatLieuId]) REFERENCES [dbo].[ChatLieu] ([Id]);
GO
ALTER TABLE [dbo].[BienThe] ADD CONSTRAINT [FK_BienThe_KichThuoc]
    FOREIGN KEY ([KichThuocId]) REFERENCES [dbo].[KichThuoc] ([Id]);
GO
ALTER TABLE [dbo].[BienThe] ADD CONSTRAINT [FK_BienThe_MauSac]
    FOREIGN KEY ([MauSacId]) REFERENCES [dbo].[MauSac] ([Id]);
GO
ALTER TABLE [dbo].[BienThe] ADD CONSTRAINT [FK_BienThe_SanPham]
    FOREIGN KEY ([SanPhamId]) REFERENCES [dbo].[SanPham] ([Id]);
GO
ALTER TABLE [dbo].[ChiTietDonHang] ADD CONSTRAINT [FK_CTDH_BienThe]
    FOREIGN KEY ([BienTheId]) REFERENCES [dbo].[BienThe] ([Id]);
GO
ALTER TABLE [dbo].[ChiTietDonHang] ADD CONSTRAINT [FK_CTDH_DonHang]
    FOREIGN KEY ([DonHangId]) REFERENCES [dbo].[DonHang] ([Id]);
GO
ALTER TABLE [dbo].[DanhGia] ADD CONSTRAINT [FK_DanhGia_CTDonHang]
    FOREIGN KEY ([ChiTietDonHangId]) REFERENCES [dbo].[ChiTietDonHang] ([Id]);
GO
ALTER TABLE [dbo].[DanhGia] ADD CONSTRAINT [FK_DanhGia_NguoiDung]
    FOREIGN KEY ([NguoiDungId]) REFERENCES [dbo].[NguoiDung] ([Id]);
GO
ALTER TABLE [dbo].[DanhGia] ADD CONSTRAINT [FK_DanhGia_SanPham]
    FOREIGN KEY ([SanPhamId]) REFERENCES [dbo].[SanPham] ([Id]);
GO
ALTER TABLE [dbo].[DiaChiNguoiDung] ADD CONSTRAINT [FK_DiaChi_NguoiDung]
    FOREIGN KEY ([NguoiDungId]) REFERENCES [dbo].[NguoiDung] ([Id]);
GO
ALTER TABLE [dbo].[DonHang] ADD CONSTRAINT [FK_DonHang_KhuyenMai]
    FOREIGN KEY ([KhuyenMaiId]) REFERENCES [dbo].[KhuyenMai] ([Id]);
GO
ALTER TABLE [dbo].[DonHang] ADD CONSTRAINT [FK_DonHang_NguoiDung]
    FOREIGN KEY ([NguoiDungId]) REFERENCES [dbo].[NguoiDung] ([Id]);
GO
ALTER TABLE [dbo].[DonHang] ADD CONSTRAINT [FK_DonHang_NhanVien]
    FOREIGN KEY ([NhanVienId]) REFERENCES [dbo].[NguoiDung] ([Id]);
GO
ALTER TABLE [dbo].[GioHangChiTiet] ADD CONSTRAINT [FK_GHCT_BienThe]
    FOREIGN KEY ([BienTheId]) REFERENCES [dbo].[BienThe] ([Id]);
GO
ALTER TABLE [dbo].[GioHangChiTiet] ADD CONSTRAINT [FK_GHCT_GioHang]
    FOREIGN KEY ([GioHangId]) REFERENCES [dbo].[GioHang] ([Id]);
GO
ALTER TABLE [dbo].[GioHang] ADD CONSTRAINT [FK_GioHang_NguoiDung]
    FOREIGN KEY ([NguoiDungId]) REFERENCES [dbo].[NguoiDung] ([Id]);
GO
ALTER TABLE [dbo].[HinhAnhBienThe] ADD CONSTRAINT [FK_HinhAnh_BienThe]
    FOREIGN KEY ([BienTheId]) REFERENCES [dbo].[BienThe] ([Id]);
GO
ALTER TABLE [dbo].[LichSuTrangThaiDon] ADD CONSTRAINT [FK_LSTD_DonHang]
    FOREIGN KEY ([DonHangId]) REFERENCES [dbo].[DonHang] ([Id]);
GO
ALTER TABLE [dbo].[LichSuTrangThaiDon] ADD CONSTRAINT [FK_LSTD_NguoiDung]
    FOREIGN KEY ([NguoiThayDoiId]) REFERENCES [dbo].[NguoiDung] ([Id]);
GO
ALTER TABLE [dbo].[NguoiDung] ADD CONSTRAINT [FK_NguoiDung_VaiTro]
    FOREIGN KEY ([VaiTroId]) REFERENCES [dbo].[VaiTro] ([Id]);
GO
ALTER TABLE [dbo].[SanPham] ADD CONSTRAINT [FK_SanPham_DanhMuc]
    FOREIGN KEY ([DanhMucId]) REFERENCES [dbo].[DanhMuc] ([Id]);
GO
ALTER TABLE [dbo].[SanPham] ADD CONSTRAINT [FK_SanPham_ThuongHieu]
    FOREIGN KEY ([ThuongHieuId]) REFERENCES [dbo].[ThuongHieu] ([Id]);
GO
ALTER TABLE [dbo].[ThanhToan] ADD CONSTRAINT [FK_ThanhToan_DonHang]
    FOREIGN KEY ([DonHangId]) REFERENCES [dbo].[DonHang] ([Id]);
GO
ALTER TABLE [dbo].[don_hang] ADD CONSTRAINT [FK3tq0qg6f6ranwlr8gvfii79d3]
    FOREIGN KEY ([nguoi_dung_id]) REFERENCES [dbo].[nguoi_dung] ([id]);
GO
ALTER TABLE [dbo].[bien_the] ADD CONSTRAINT [FK9ndkc9rem0wb4xethp4qkpsn]
    FOREIGN KEY ([kich_thuoc_id]) REFERENCES [dbo].[kich_thuoc] ([id]);
GO
ALTER TABLE [dbo].[nguoi_dung] ADD CONSTRAINT [FKa5oibkto18llfdid5w4mv4v47]
    FOREIGN KEY ([vai_tro_id]) REFERENCES [dbo].[vai_tro] ([id]);
GO
ALTER TABLE [dbo].[bien_the] ADD CONSTRAINT [FKdilrlq8vq4vvcuu6fg0ht8vju]
    FOREIGN KEY ([chat_lieu_id]) REFERENCES [dbo].[chat_lieu] ([id]);
GO
ALTER TABLE [dbo].[don_hang] ADD CONSTRAINT [FKec7ntc61uhko624hwt130w1yc]
    FOREIGN KEY ([nhan_vien_id]) REFERENCES [dbo].[nguoi_dung] ([id]);
GO
ALTER TABLE [dbo].[bien_the] ADD CONSTRAINT [FKh2dhysvrw2pnhacnh1xlyonr0]
    FOREIGN KEY ([san_pham_id]) REFERENCES [dbo].[san_pham] ([id]);
GO
ALTER TABLE [dbo].[chi_tiet_don_hang] ADD CONSTRAINT [FKk2knfk78gkwo3srle9wd00fat]
    FOREIGN KEY ([bien_the_id]) REFERENCES [dbo].[bien_the] ([id]);
GO
ALTER TABLE [dbo].[bien_the] ADD CONSTRAINT [FKkk53hh7y3twhgngbpcpylthk8]
    FOREIGN KEY ([mau_sac_id]) REFERENCES [dbo].[mau_sac] ([id]);
GO
ALTER TABLE [dbo].[don_hang] ADD CONSTRAINT [FKm66hy6vf9vuoi3tdept6h771l]
    FOREIGN KEY ([khuyen_mai_id]) REFERENCES [dbo].[khuyen_mai] ([id]);
GO
ALTER TABLE [dbo].[san_pham] ADD CONSTRAINT [FKmnhsdc3pdlvp4pkronxu5hasp]
    FOREIGN KEY ([danh_muc_id]) REFERENCES [dbo].[danh_muc] ([id]);
GO
ALTER TABLE [dbo].[san_pham] ADD CONSTRAINT [FKrum92qs4m7i0u7p7ub6bhbrr5]
    FOREIGN KEY ([thuong_hieu_id]) REFERENCES [dbo].[thuong_hieu] ([id]);
GO
ALTER TABLE [dbo].[chi_tiet_don_hang] ADD CONSTRAINT [FKt57maavf6s28hxyar724mdr1b]
    FOREIGN KEY ([don_hang_id]) REFERENCES [dbo].[don_hang] ([id]);
GO

-- ============================================================
-- INSERT DATA
-- ============================================================
SET IDENTITY_INSERT [dbo].[VaiTro] ON;
INSERT INTO [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (1, N'ADMIN', NULL);
INSERT INTO [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (2, N'NHAN_VIEN', NULL);
INSERT INTO [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (3, N'KHACH_HANG', NULL);
SET IDENTITY_INSERT [dbo].[VaiTro] OFF;
GO

SET IDENTITY_INSERT [dbo].[NguoiDung] ON;
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (1, N'admin', N'admin@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Quản trị viên', N'0901000001', NULL, 1, NULL, 1, N'HOAT_DONG', NULL, '2026-02-24 20:31:55.933', NULL, 1, NULL, NULL);
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (2, N'nhanvien01', N'nv01@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Trần Văn Nam', N'0901000002', NULL, 1, NULL, 2, N'HOAT_DONG', NULL, '2026-02-24 20:31:55.933', NULL, 1, NULL, NULL);
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (3, N'nhanvien02', N'nv02@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Nguyễn Thị Lan', N'0901000003', NULL, 0, NULL, 2, N'HOAT_DONG', NULL, '2026-02-24 20:31:55.933', NULL, 1, NULL, NULL);
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (4, N'khachhang01', N'kh01@test.com', N'$2a$10$KEELnfLt9gPU61.1jwyzhOxfes0qPrlUKJIdKinBE9PhtWX4ahHje', N'KH Test 01', N'0987654321', NULL, 1, NULL, 3, N'HOAT_DONG', NULL, '2026-02-24 20:31:55.933', '2026-02-25 16:25:46.473', 1, NULL, '2026-02-25 16:25:46.470');
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (5, N'khachhang02', N'kh02@gmail.com', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Phạm Thị Mai', N'0987654321', NULL, 0, NULL, 3, N'HOAT_DONG', NULL, '2026-02-24 20:31:55.933', NULL, 1, NULL, NULL);
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (6, N'testuser5', N'test5@test.com', N'$2a$10$UAL4Z7JegNQSkuf.Gxwh0ewd9ykhRbKnrf8EPVEqqlPHcOTzTbSwO', N'Test User 5', NULL, NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, '2026-02-25 15:59:53.070', NULL, 1, NULL, NULL);
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (7, N'testqc01', N'testqc01@test.com', N'$2a$10$IE1VI1KqaZySIEvtR4kqQOfebnr18TdP2ssSeeYGbU3tlH.6Nts3S', N'Test QC User', NULL, NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, '2026-02-25 16:00:19.923', NULL, 1, NULL, NULL);
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (8, N'testnv_qc', N'testnv_qc@test.com', N'$2a$10$FdkyhBP4v.hzULRcoSQQr.5e8DkWHUnXNApFUrFzy5mB.bL9hrKty', N'NV QC Test', N'0999888777', NULL, NULL, NULL, 2, N'HOAT_DONG', NULL, '2026-02-25 16:20:30.923', NULL, 1, NULL, NULL);
INSERT INTO [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (9, N'kien1', N'kien1@gmail.com', N'$2a$10$qcxiYAuII5NrvYE7RAzyr.0pciJONtPF74hkpB4tekCvZt7ZbEcZu', N'trung kien', N'0956651738', '2007-05-05 00:00:00.000', NULL, NULL, 3, N'HOAT_DONG', NULL, '2026-02-25 17:02:28.253', '2026-02-26 16:10:10.967', 1, NULL, NULL);
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF;
GO

SET IDENTITY_INSERT [dbo].[DiaChiNguoiDung] ON;
INSERT INTO [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, N'Lê Minh Tuấn', N'0912345678', N'12 Nguyễn Huệ', N'Phường Bến Nghé', N'Quận 1', N'TP. Hồ Chí Minh', 202, 1442, N'20211', 1, '2026-02-24 20:31:55.950', NULL);
INSERT INTO [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 4, N'Lê Minh Tuấn', N'0912345678', N'88 Lê Lợi', N'Phường Phạm Ngũ Lão', N'Quận 1', N'TP. Hồ Chí Minh', 202, 1442, N'20209', 0, '2026-02-24 20:31:55.950', NULL);
INSERT INTO [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 5, N'Phạm Thị Mai', N'0987654321', N'45 Trần Hưng Đạo', N'Phường Hàng Bài', N'Quận Hoàn Kiếm', N'Hà Nội', 201, 1489, N'1A0102', 1, '2026-02-24 20:31:55.950', NULL);
INSERT INTO [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 4, N'Test DC', N'0912345678', N'123 Le Loi', N'P. Ben Thanh', N'Q.1', N'TP HCM', 202, 3695, N'90737', 0, '2026-02-25 16:20:30.037', NULL);
INSERT INTO [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 4, N'Test DC', N'0912345678', N'123 Le Loi', N'P. Ben Thanh', N'Q.1', N'TP HCM', 202, 3695, N'90737', 0, '2026-02-25 16:25:47.640', NULL);
SET IDENTITY_INSERT [dbo].[DiaChiNguoiDung] OFF;
GO

SET IDENTITY_INSERT [dbo].[ThuongHieu] ON;
INSERT INTO [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (1, N'Certain', N'Thương hiệu in-house', 1, '2026-02-24 20:31:55.963');
INSERT INTO [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (2, N'Nike', N'Thương hiệu thể thao Mỹ', 1, '2026-02-24 20:31:55.963');
INSERT INTO [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (3, N'Adidas', N'Thương hiệu thể thao Đức', 1, '2026-02-24 20:31:55.963');
INSERT INTO [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (4, N'Puma', N'Thương hiệu thể thao Đức', 1, '2026-02-24 20:31:55.963');
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF;
GO

SET IDENTITY_INSERT [dbo].[DanhMuc] ON;
INSERT INTO [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (1, N'Áo thun', N'ao-thun', N'Áo thun nam nữ các loại', 1, 1, '2026-02-24 20:31:55.960');
INSERT INTO [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (2, N'Áo polo', N'ao-polo', N'Áo polo cổ bẻ thời trang', 2, 1, '2026-02-24 20:31:55.960');
INSERT INTO [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (3, N'Áo khoác', N'ao-khoac', N'Áo khoác bomber, dù nhẹ', 3, 0, '2026-02-24 20:31:55.960');
INSERT INTO [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (4, N'Quần', N'quan', N'Quần jean và cargo', 4, 0, '2026-02-24 20:31:55.960');
INSERT INTO [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (5, N'Phụ kiện', N'phu-kien', N'Mũ, túi, dây lưng', 5, 0, '2026-02-24 20:31:55.960');
SET IDENTITY_INSERT [dbo].[DanhMuc] OFF;
GO

SET IDENTITY_INSERT [dbo].[ChatLieu] ON;
INSERT INTO [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (1, N'Cotton 100%', N'Vải cotton tự nhiên thoáng mát');
INSERT INTO [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (2, N'Cotton Polyester', N'Pha 65% cotton 35% poly');
INSERT INTO [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (3, N'Polyester', N'Thoáng khô nhanh');
INSERT INTO [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (4, N'Linen', N'Vải lanh nhẹ mát mùa hè');
SET IDENTITY_INSERT [dbo].[ChatLieu] OFF;
GO

SET IDENTITY_INSERT [dbo].[MauSac] ON;
INSERT INTO [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (1, N'Đen', N'#212121', N'Đen cơ bản');
INSERT INTO [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (2, N'Trắng', N'#FFFFFF', N'Trắng tinh');
INSERT INTO [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (3, N'Xanh navy', N'#1A237E', N'Xanh đậm navy');
INSERT INTO [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (4, N'Xám', N'#757575', N'Xám trung tính');
INSERT INTO [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (5, N'Đỏ', N'#C62828', N'Đỏ đậm');
INSERT INTO [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (6, N'Xanh lá', N'#2E7D32', N'Xanh lá đậm');
INSERT INTO [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (7, N'Be', N'#F5F5DC', N'Màu be kem');
SET IDENTITY_INSERT [dbo].[MauSac] OFF;
GO

SET IDENTITY_INSERT [dbo].[KichThuoc] ON;
INSERT INTO [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (1, N'XS', 1);
INSERT INTO [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (2, N'S', 2);
INSERT INTO [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (3, N'M', 3);
INSERT INTO [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (4, N'L', 4);
INSERT INTO [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (5, N'XL', 5);
INSERT INTO [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (6, N'2XL', 6);
INSERT INTO [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (7, N'3XL', 7);
SET IDENTITY_INSERT [dbo].[KichThuoc] OFF;
GO

SET IDENTITY_INSERT [dbo].[KhuyenMai] ON;
INSERT INTO [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, N'WELCOME10', N'Chào mừng - Giảm 10%', N'Giảm 10% đơn đầu tiên', N'PHAN_TRAM', 10.00, 199000.00, 50000.00, 100, 12, '2026-01-25 20:31:56.073', '2026-04-25 20:31:56.073', N'DANG_HOAT_DONG', '2026-02-24 20:31:56.073', NULL);
INSERT INTO [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, N'SALE50K', N'Giảm 50.000đ', N'Giảm 50k đơn từ 499k', N'SO_TIEN', 50000.00, 499000.00, NULL, 200, 8, '2026-02-24 20:31:56.073', '2026-03-26 20:31:56.073', N'DANG_HOAT_DONG', '2026-02-24 20:31:56.073', NULL);
INSERT INTO [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, N'FREESHIP', N'Miễn phí vận chuyển', N'FreeShip đơn từ 399k', N'SO_TIEN', 30000.00, 399000.00, 30000.00, 500, 45, '2026-02-17 20:31:56.073', '2026-03-19 20:31:56.073', N'DANG_HOAT_DONG', '2026-02-24 20:31:56.073', NULL);
INSERT INTO [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, N'FLASH20', N'Flash sale giảm 20%', N'Chỉ áp dụng hôm nay', N'PHAN_TRAM', 20.00, 299000.00, 100000.00, 50, 50, '2026-02-19 20:31:56.073', '2026-02-23 20:31:56.073', N'HET_HAN', '2026-02-24 20:31:56.073', NULL);
SET IDENTITY_INSERT [dbo].[KhuyenMai] OFF;
GO

SET IDENTITY_INSERT [dbo].[SanPham] ON;
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, N'SP001', N'Áo thun Certain Basic', N'Áo cotton cổ tròn màu trơn basic.', 299000.00, 299000.00, 1, 1, N'/uploads/images/ade6b0b2-1740-47bf-acd5-45b4afb45743_sg-11134201-22100-3od0skjhwviv74.jpg', N'ao-thun-certain-basic', N'DANG_BAN', '2026-02-24 20:31:56.003', '2026-02-26 17:22:16.593');
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, N'SP002', N'Áo thun Certain Graphic', N'Áo thun in hình graphic bold.', 349000.00, 319000.00, 1, 1, N'/uploads/images/ao-thun-graphic.jpg', N'ao-thun-certain-graphic', N'DANG_BAN', '2026-02-24 20:31:56.003', NULL);
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, N'SP003', N'Áo polo Certain Classic', N'Áo polo cổ bẻ sang trọng.', 450000.00, 450000.00, 2, 1, N'/uploads/images/8e4a3758-9ee4-482f-825b-4e07945bd558_sg-11134201-22100-3od0skjhwviv74.jpg', N'ao-polo-certain-classic', N'DANG_BAN', '2026-02-24 20:31:56.003', '2026-02-26 17:24:35.257');
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, N'SP004', N'Áo thun Nike Dri-FIT test', N'Công nghệ Dri-FIT thấm hút mồ hôi.', 599000.00, 599000.00, 1, 2, N'/uploads/images/ao-thun-nike.jpg', N'ao-thun-nike-dri-fit-test', N'DANG_BAN', '2026-02-24 20:31:56.003', '2026-02-26 13:45:38.843');
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, N'SP005', N'Áo khoác Adidas Essentials', N'Áo khoác nhẹ chống gió thể thao.', 799000.00, 699000.00, 3, 3, N'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500&h=500&fit=crop', N'ao-khoac-adidas', N'NGUNG_BAN', '2026-02-24 20:31:56.003', NULL);
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, N'SP006', N'Quần cargo Certain', N'Quần cargo túi hộp streetwear.', 499000.00, 449000.00, 4, 1, N'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=500&h=500&fit=crop', N'quan-cargo-certain', N'NGUNG_BAN', '2026-02-24 20:31:56.003', NULL);
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, N'SP007', N'Áo thun Puma Essential', N'Áo thun polo Puma đơn giản.', 399000.00, 359000.00, 1, 4, N'/uploads/images/ao-thun-puma.jpg', N'ao-thun-puma', N'DANG_BAN', '2026-02-24 20:31:56.003', NULL);
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, N'SP008', N'Áo polo Nike Court', N'Áo polo tennis kỹ thuật cao.', 699000.00, 629000.00, 2, 2, N'/uploads/images/ao-polo-nike.jpg', N'ao-polo-nike-court', N'DANG_BAN', '2026-02-24 20:31:56.003', NULL);
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (9, NULL, N'Test QC Product', N'Mo ta test', 100000.00, NULL, 1, NULL, NULL, NULL, N'NGUNG_BAN', '2026-02-25 16:20:30.993', '2026-02-25 16:25:15.930');
INSERT INTO [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (10, NULL, N'Áo thun Nike Dri-FIT test1464646', N'', 400000.00, 400000.00, 1, 2, NULL, N'ao-thun-nike-dri-fit-test1464646', N'DANG_BAN', '2026-02-26 16:11:24.463', '2026-02-26 16:13:40.823');
SET IDENTITY_INSERT [dbo].[SanPham] OFF;
GO

SET IDENTITY_INSERT [dbo].[BienThe] ON;
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 1, 2, 1, 1, 259000.00, 30, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 1, 3, 1, 1, 259000.00, 50, 1, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 1, 4, 1, 1, 259000.00, 45, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 1, 5, 1, 1, 259000.00, 18, 0, 1, '2026-02-24 20:31:56.040', '2026-02-26 17:36:57.460');
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 1, 2, 2, 1, 259000.00, 25, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 1, 3, 2, 1, 259000.00, 40, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, 1, 4, 2, 1, 259000.00, 35, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, 1, 2, 3, 1, 259000.00, 20, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (9, 1, 3, 3, 1, 259000.00, 30, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (10, 2, 3, 1, 1, 319000.00, 40, 1, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (11, 2, 4, 1, 1, 319000.00, 30, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (12, 2, 3, 2, 1, 319000.00, 25, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (13, 2, 4, 2, 1, 319000.00, 20, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (14, 3, 3, 1, 2, 399000.00, 17, 1, 1, '2026-02-24 20:31:56.040', '2026-02-26 17:36:57.460');
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (15, 3, 4, 1, 2, 399000.00, 15, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (16, 3, 3, 3, 2, 399000.00, 9, 0, 1, '2026-02-24 20:31:56.040', '2026-02-26 17:36:57.460');
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (17, 4, 3, 1, 3, 549000.00, 25, 1, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (18, 4, 4, 1, 3, 549000.00, 20, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (19, 4, 3, 5, 3, 549000.00, 15, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (20, 5, 3, 4, 3, 699000.00, 15, 1, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (21, 5, 4, 4, 3, 699000.00, 12, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (22, 5, 3, 1, 3, 699000.00, 10, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (23, 6, 3, 1, 2, 449000.00, 30, 1, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (24, 6, 4, 1, 2, 449000.00, 25, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (25, 6, 3, 4, 2, 449000.00, 20, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (26, 7, 3, 1, 1, 359000.00, 20, 1, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (27, 7, 4, 1, 1, 359000.00, 15, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (28, 8, 3, 2, 2, 629000.00, 10, 1, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (29, 8, 4, 2, 2, 629000.00, 8, 0, 1, '2026-02-24 20:31:56.040', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (30, 10, 2, 3, 1, NULL, 0, 0, 1, '2026-02-26 16:11:50.317', NULL);
INSERT INTO [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (31, 3, NULL, NULL, NULL, NULL, 0, 0, 1, '2026-02-26 17:24:37.407', NULL);
SET IDENTITY_INSERT [dbo].[BienThe] OFF;
GO

SET IDENTITY_INSERT [dbo].[HinhAnhBienThe] ON;
INSERT INTO [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (3, 1, N'/uploads/images/ade6b0b2-1740-47bf-acd5-45b4afb45743_sg-11134201-22100-3od0skjhwviv74.jpg', 1, 0, N'sg-11134201-22100-3od0skjhwviv74.jpg', '2026-02-26 17:22:14.260');
INSERT INTO [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (4, 16, N'/uploads/images/8e4a3758-9ee4-482f-825b-4e07945bd558_sg-11134201-22100-3od0skjhwviv74.jpg', 1, 0, N'sg-11134201-22100-3od0skjhwviv74.jpg', '2026-02-26 17:24:32.423');
SET IDENTITY_INSERT [dbo].[HinhAnhBienThe] OFF;
GO

SET IDENTITY_INSERT [dbo].[GioHang] ON;
INSERT INTO [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, '2026-02-24 20:31:56.047', NULL);
INSERT INTO [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 5, '2026-02-24 20:31:56.047', NULL);
INSERT INTO [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 6, '2026-02-25 15:59:53.103', NULL);
INSERT INTO [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 7, '2026-02-25 16:00:19.923', NULL);
INSERT INTO [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 1, '2026-02-25 16:33:32.477', NULL);
INSERT INTO [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 9, '2026-02-25 17:02:28.313', NULL);
SET IDENTITY_INSERT [dbo].[GioHang] OFF;
GO

SET IDENTITY_INSERT [dbo].[GioHangChiTiet] ON;
INSERT INTO [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 2, 14, 1, 399000.00, '2026-02-24 20:31:56.063', NULL);
INSERT INTO [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 1, 1, 2, 259000.00, '2026-02-25 16:26:22.817', NULL);
INSERT INTO [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 6, 14, 1, 399000.00, '2026-02-26 14:22:45.307', NULL);
INSERT INTO [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 5, 28, 1, 629000.00, '2026-02-26 16:14:26.243', NULL);
INSERT INTO [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, 6, 16, 3, 399000.00, '2026-02-26 16:15:55.323', '2026-02-26 16:15:58.040');
INSERT INTO [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, 6, 4, 1, 259000.00, '2026-02-26 17:30:18.103', NULL);
SET IDENTITY_INSERT [dbo].[GioHangChiTiet] OFF;
GO

SET IDENTITY_INSERT [dbo].[DonHang] ON;
INSERT INTO [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, NULL, N'DH20240001', N'ONLINE', N'DA_GIAO', 808000.00, 50000.00, 30000.00, 788000.00, 1, N'Lê Minh Tuấn', N'0912345678', N'12 Nguyễn Huệ, P.Bến Nghé, Q.1, TP.HCM', NULL, NULL, NULL, N'VNPAY', 1, NULL, NULL, NULL, NULL, NULL, '2026-02-09 20:31:56.093', NULL);
INSERT INTO [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 5, NULL, N'DH20240002', N'ONLINE', N'DANG_GIAO', 399000.00, 0.00, 30000.00, 429000.00, NULL, N'Phạm Thị Mai', N'0987654321', N'45 Trần Hưng Đạo, P.Hàng Bài, Q.Hoàn Kiếm, Hà Nội', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, NULL, NULL, '2026-02-21 20:31:56.093', NULL);
INSERT INTO [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, NULL, 2, N'DH20240003', N'TAI_QUAY', N'HOAN_THANH', 698000.00, 0.00, 0.00, 698000.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, '2026-02-17 20:31:56.093', NULL);
INSERT INTO [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 4, NULL, N'DH20240004', N'ONLINE', N'CHO_XAC_NHAN', 259000.00, 0.00, 30000.00, 289000.00, NULL, N'Lê Minh Tuấn', N'0912345678', N'88 Lê Lợi, P.Phạm Ngũ Lão, Q.1, TP.HCM', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, NULL, NULL, '2026-02-24 18:31:56.093', NULL);
INSERT INTO [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (11, 9, NULL, N'DH202602261720115471', N'ONLINE', N'DA_XAC_NHAN', 1596000.00, 0.00, 0.00, 1596000.00, NULL, N'trung kien', N'0956651738', N'sdfdfsdfdsfsf', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, N'', NULL, '2026-02-26 17:20:11.633', '2026-02-26 17:20:45.743');
INSERT INTO [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (12, 9, NULL, N'DH202602261730277845', N'ONLINE', N'DA_XAC_NHAN', 1855000.00, 0.00, 0.00, 1855000.00, NULL, N'trung kien', N'0956651738', N'fasfasf', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, N'', NULL, '2026-02-26 17:30:27.837', '2026-02-26 17:30:43.430');
INSERT INTO [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (13, 9, NULL, N'DH202602261736399804', N'ONLINE', N'DA_XAC_NHAN', 1855000.00, 0.00, 0.00, 1855000.00, NULL, N'trung kien', N'0956651738', N'đâs', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, N'', NULL, '2026-02-26 17:36:39.893', '2026-02-26 17:36:57.460');
SET IDENTITY_INSERT [dbo].[DonHang] OFF;
GO

SET IDENTITY_INSERT [dbo].[ChiTietDonHang] ON;
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (1, 1, 2, 1, 259000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (2, 1, 17, 1, 549000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (3, 2, 14, 1, 399000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (4, 3, 10, 1, 319000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (5, 3, 20, 1, 699000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (6, 4, 2, 1, 259000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (7, 11, 14, 1, 399000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (8, 11, 16, 3, 399000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (9, 12, 14, 1, 399000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (10, 12, 16, 3, 399000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (11, 12, 4, 1, 259000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (12, 13, 14, 1, 399000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (13, 13, 16, 3, 399000.00);
INSERT INTO [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (14, 13, 4, 1, 259000.00);
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] OFF;
GO

SET IDENTITY_INSERT [dbo].[LichSuTrangThaiDon] ON;
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (1, 1, NULL, N'CHO_XAC_NHAN', N'Đặt hàng online', 4, '2026-02-09 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (2, 1, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'Nhân viên xác nhận', 2, '2026-02-10 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (3, 1, N'DA_XAC_NHAN', N'DANG_GIAO', N'Bàn giao đơn vị vận chuyển', 2, '2026-02-11 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (4, 1, N'DANG_GIAO', N'DA_GIAO', N'Khách xác nhận đã nhận hàng', 4, '2026-02-14 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (5, 2, NULL, N'CHO_XAC_NHAN', N'Đặt hàng online', 5, '2026-02-21 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (6, 2, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'Nhân viên xác nhận', 2, '2026-02-22 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (7, 2, N'DA_XAC_NHAN', N'DANG_GIAO', N'Bàn giao GHN', 2, '2026-02-23 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (8, 3, NULL, N'HOAN_THANH', N'Bán tại quầy - tiền mặt', 2, '2026-02-17 20:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (9, 4, NULL, N'CHO_XAC_NHAN', N'Đặt hàng online, chờ xác nhận', 4, '2026-02-24 18:31:56.113');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (10, 11, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, '2026-02-26 17:20:11.730');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (11, 11, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, '2026-02-26 17:20:45.720');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (12, 11, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, '2026-02-26 17:20:45.743');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (13, 12, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, '2026-02-26 17:30:27.890');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (14, 12, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, '2026-02-26 17:30:43.427');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (15, 13, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, '2026-02-26 17:36:39.913');
INSERT INTO [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (16, 13, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, '2026-02-26 17:36:57.457');
SET IDENTITY_INSERT [dbo].[LichSuTrangThaiDon] OFF;
GO

SET IDENTITY_INSERT [dbo].[DanhGia] ON;
INSERT INTO [dbo].[DanhGia] ([Id], [SanPhamId], [NguoiDungId], [ChiTietDonHangId], [DiemDanhGia], [TieuDe], [NoiDung], [HinhAnh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 1, 4, 1, 5, N'Áo đẹp, chất lượng tốt', N'Vải cotton mềm mịn, màu không phai sau nhiều lần giặt.', NULL, 1, '2026-02-24 20:31:56.130', NULL);
INSERT INTO [dbo].[DanhGia] ([Id], [SanPhamId], [NguoiDungId], [ChiTietDonHangId], [DiemDanhGia], [TieuDe], [NoiDung], [HinhAnh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 4, 4, 2, 4, N'Nike chất như kỳ vọng', N'Co giãn tốt, rất thoải mái khi tập gym.', NULL, 1, '2026-02-24 20:31:56.130', NULL);
INSERT INTO [dbo].[DanhGia] ([Id], [SanPhamId], [NguoiDungId], [ChiTietDonHangId], [DiemDanhGia], [TieuDe], [NoiDung], [HinhAnh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 3, 5, 3, 5, N'Áo polo sang trọng', N'Mặc đi làm, dự tiệc đều phù hợp.', NULL, 1, '2026-02-24 20:31:56.130', NULL);
SET IDENTITY_INSERT [dbo].[DanhGia] OFF;
GO

