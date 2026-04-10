-- ============================================================
-- CERTAIN SHOP - Database Full Backup
-- Generated: 2026-02-25
-- Database: Certain_Shop (SQL Server)
-- ============================================================

SET NOCOUNT ON;
GO

-- Drop existing database (comment out if you want to keep data)
-- IF EXISTS (SELECT * FROM sys.databases WHERE name = 'Certain_Shop')
-- BEGIN
--     ALTER DATABASE [Certain_Shop] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--     DROP DATABASE [Certain_Shop];
-- END
-- GO

-- Create database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'Certain_Shop')
BEGIN
    CREATE DATABASE [Certain_Shop];
END
GO

USE [Certain_Shop];
GO

-- ============================================================
-- TABLE: VaiTro (Roles)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'VaiTro')
CREATE TABLE [dbo].[VaiTro](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [TenVaiTro] [nvarchar](50) NOT NULL,
    [MoTa] [nvarchar](255) NULL,
    [ThoiGianTao] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- ============================================================
-- TABLE: NguoiDung (Users)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'NguoiDung')
CREATE TABLE [dbo].[NguoiDung](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [TenDangNhap] [nvarchar](100) NOT NULL UNIQUE,
    [Email] [nvarchar](100) NOT NULL UNIQUE,
    [MatKhau] [nvarchar](255) NOT NULL,
    [HoTen] [nvarchar](150) NOT NULL,
    [SoDienThoai] [nvarchar](20) NULL,
    [AnhDaiDien] [nvarchar](255) NULL,
    [DangHoatDong] [bit] DEFAULT 1,
    [TrangThai] [nvarchar](30) DEFAULT 'HOAT_DONG',
    [VaiTroId] [bigint] NOT NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    [ThoiGianCapNhat] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([VaiTroId]) REFERENCES [VaiTro]([Id])
);
GO

-- ============================================================
-- TABLE: DanhMuc (Categories)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DanhMuc')
CREATE TABLE [dbo].[DanhMuc](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [TenDanhMuc] [nvarchar](150) NOT NULL,
    [DuongDan] [nvarchar](255) NULL,
    [MoTa] [nvarchar](255) NULL,
    [ThuTuHienThi] [int] NULL,
    [DangHoatDong] [bit] DEFAULT 1,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- ============================================================
-- TABLE: ThuongHieu (Brands)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ThuongHieu')
CREATE TABLE [dbo].[ThuongHieu](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [TenThuongHieu] [nvarchar](150) NOT NULL,
    [TrangThai] [bit] DEFAULT 1,
    [MoTa] [nvarchar](500) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- ============================================================
-- TABLE: SanPham (Products)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'SanPham')
CREATE TABLE [dbo].[SanPham](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [MaSanPham] [nvarchar](50) NOT NULL,
    [TenSanPham] [nvarchar](255) NOT NULL,
    [MoTa] [nvarchar](MAX) NULL,
    [GiaGoc] [numeric](18, 2) NULL,
    [GiaBan] [numeric](18, 2) NULL,
    [AnhChinh] [nvarchar](500) NULL,
    [DuongDan] [nvarchar](255) NULL,
    [TrangThaiSanPham] [nvarchar](30) DEFAULT 'DANG_BAN',
    [DanhMucId] [bigint] NOT NULL,
    [ThuongHieuId] [bigint] NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    [ThoiGianCapNhat] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([DanhMucId]) REFERENCES [DanhMuc]([Id]),
    FOREIGN KEY ([ThuongHieuId]) REFERENCES [ThuongHieu]([Id])
);
GO

-- ============================================================
-- TABLE: KichThuoc (Sizes)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'KichThuoc')
CREATE TABLE [dbo].[KichThuoc](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [KichCo] [nvarchar](50) NOT NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- ============================================================
-- TABLE: MauSac (Colors)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'MauSac')
CREATE TABLE [dbo].[MauSac](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [TenMau] [nvarchar](50) NOT NULL,
    [MaHex] [nvarchar](10) NULL,
    [MoTa] [nvarchar](255) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- ============================================================
-- TABLE: ChatLieu (Materials)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ChatLieu')
CREATE TABLE [dbo].[ChatLieu](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [TenChatLieu] [nvarchar](150) NOT NULL,
    [MoTa] [nvarchar](255) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- ============================================================
-- TABLE: BienThe (Product Variants)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BienThe')
CREATE TABLE [dbo].[BienThe](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [SanPhamId] [bigint] NOT NULL,
    [KichThuocId] [bigint] NULL,
    [MauSacId] [bigint] NULL,
    [ChatLieuId] [bigint] NULL,
    [GiaBan] [numeric](18, 2) NULL,
    [SoLuongTon] [int] DEFAULT 0,
    [MacDinh] [bit] DEFAULT 0,
    [TrangThai] [bit] DEFAULT 1,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    [ThoiGianCapNhat] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([SanPhamId]) REFERENCES [SanPham]([Id]),
    FOREIGN KEY ([KichThuocId]) REFERENCES [KichThuoc]([Id]),
    FOREIGN KEY ([MauSacId]) REFERENCES [MauSac]([Id]),
    FOREIGN KEY ([ChatLieuId]) REFERENCES [ChatLieu]([Id])
);
GO

-- ============================================================
-- TABLE: HinhAnhBienThe (Product Images)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'HinhAnhBienThe')
CREATE TABLE [dbo].[HinhAnhBienThe](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [BienTheId] [bigint] NOT NULL,
    [DuongDan] [nvarchar](255) NOT NULL,
    [LaAnhChinh] [bit] DEFAULT 0,
    [ThuTu] [int] DEFAULT 0,
    [MoTa] [nvarchar](255) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([BienTheId]) REFERENCES [BienThe]([Id]) ON DELETE CASCADE
);
GO

-- ============================================================
-- TABLE: GioHang (Shopping Carts)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GioHang')
CREATE TABLE [dbo].[GioHang](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [NguoiDungId] [bigint] NOT NULL UNIQUE,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    [ThoiGianCapNhat] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([NguoiDungId]) REFERENCES [NguoiDung]([Id])
);
GO

-- ============================================================
-- TABLE: GioHangChiTiet (Cart Items)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'GioHangChiTiet')
CREATE TABLE [dbo].[GioHangChiTiet](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [GioHangId] [bigint] NOT NULL,
    [BienTheId] [bigint] NOT NULL,
    [SoLuong] [int] DEFAULT 1,
    [GiaBan] [numeric](18, 2) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    [ThoiGianCapNhat] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([GioHangId]) REFERENCES [GioHang]([Id]) ON DELETE CASCADE,
    FOREIGN KEY ([BienTheId]) REFERENCES [BienThe]([Id])
);
GO

-- ============================================================
-- TABLE: DiaChiNguoiDung (User Addresses)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DiaChiNguoiDung')
CREATE TABLE [dbo].[DiaChiNguoiDung](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [NguoiDungId] [bigint] NOT NULL,
    [TenNguoiNhan] [nvarchar](150) NOT NULL,
    [SoDienThoai] [nvarchar](20) NOT NULL,
    [TinhThanh] [nvarchar](150) NOT NULL,
    [QuanHuyen] [nvarchar](150) NULL,
    [PhuongXa] [nvarchar](150) NULL,
    [DiaChiCuThe] [nvarchar](255) NOT NULL,
    [MaTinhGHN] [int] NULL,
    [MaHuyenGHN] [int] NULL,
    [MaXaGHN] [nvarchar](50) NULL,
    [LaHienTai] [bit] DEFAULT 0,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    [ThoiGianCapNhat] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([NguoiDungId]) REFERENCES [NguoiDung]([Id]) ON DELETE CASCADE
);
GO

-- ============================================================
-- TABLE: KhuyenMai (Promotions)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'KhuyenMai')
CREATE TABLE [dbo].[KhuyenMai](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [TenKhuyenMai] [nvarchar](255) NOT NULL,
    [MoTa] [nvarchar](500) NULL,
    [PhanTramGiam] [int] NULL,
    [GiaTriGiamToiDa] [numeric](18, 2) NULL,
    [GiaTriDonHangToiThieu] [numeric](18, 2) NULL,
    [NgayBatDau] [datetime2](7) NOT NULL,
    [NgayKetThuc] [datetime2](7) NOT NULL,
    [TrangThai] [bit] DEFAULT 1,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

-- ============================================================
-- TABLE: DonHang (Orders)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DonHang')
CREATE TABLE [dbo].[DonHang](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [MaDonHang] [nvarchar](50) NOT NULL UNIQUE,
    [NguoiDungId] [bigint] NOT NULL,
    [NhanVienId] [bigint] NULL,
    [TenNguoiNhan] [nvarchar](150) NOT NULL,
    [SoDienThoai] [nvarchar](20) NOT NULL,
    [DiaChiGiao] [nvarchar](255) NOT NULL,
    [TinhThanh] [nvarchar](150) NOT NULL,
    [TongGia] [numeric](18, 2) NULL,
    [TrangThaiDonHang] [nvarchar](30) DEFAULT 'CHO_XAC_NHAN',
    [KhuyenMaiId] [bigint] NULL,
    [GhiChu] [nvarchar](500) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    [ThoiGianCapNhat] [datetime2](7) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([NguoiDungId]) REFERENCES [NguoiDung]([Id]),
    FOREIGN KEY ([NhanVienId]) REFERENCES [NguoiDung]([Id]),
    FOREIGN KEY ([KhuyenMaiId]) REFERENCES [KhuyenMai]([Id])
);
GO

-- ============================================================
-- TABLE: ChiTietDonHang (Order Items)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ChiTietDonHang')
CREATE TABLE [dbo].[ChiTietDonHang](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [DonHangId] [bigint] NOT NULL,
    [BienTheId] [bigint] NOT NULL,
    [SoLuong] [int] NOT NULL,
    [GiaBan] [numeric](18, 2) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([DonHangId]) REFERENCES [DonHang]([Id]) ON DELETE CASCADE,
    FOREIGN KEY ([BienTheId]) REFERENCES [BienThe]([Id])
);
GO

-- ============================================================
-- TABLE: LichSuTrangThaiDon (Order Status History)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'LichSuTrangThaiDon')
CREATE TABLE [dbo].[LichSuTrangThaiDon](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [DonHangId] [bigint] NOT NULL,
    [TrangThaiCu] [nvarchar](30) NULL,
    [TrangThaiMoi] [nvarchar](30) NOT NULL,
    [NguoiThayDoiId] [bigint] NULL,
    [GhiChu] [nvarchar](255) NULL,
    [ThoiGian] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([DonHangId]) REFERENCES [DonHang]([Id]) ON DELETE CASCADE,
    FOREIGN KEY ([NguoiThayDoiId]) REFERENCES [NguoiDung]([Id])
);
GO

-- ============================================================
-- TABLE: ThanhToan (Payments)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ThanhToan')
CREATE TABLE [dbo].[ThanhToan](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [DonHangId] [bigint] NOT NULL UNIQUE,
    [HinhThucThanhToan] [nvarchar](50) NOT NULL,
    [TrangThaiThanhToan] [nvarchar](30) DEFAULT 'CHO_THANH_TOAN',
    [NgayThanhToan] [datetime2](7) NULL,
    [GhiChu] [nvarchar](255) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([DonHangId]) REFERENCES [DonHang]([Id])
);
GO

-- ============================================================
-- TABLE: DanhGia (Reviews)
-- ============================================================
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'DanhGia')
CREATE TABLE [dbo].[DanhGia](
    [Id] [bigint] IDENTITY(1,1) NOT NULL,
    [SanPhamId] [bigint] NOT NULL,
    [NguoiDungId] [bigint] NOT NULL,
    [ChiTietDonHangId] [bigint] NULL,
    [SoSao] [int] NOT NULL CHECK ([SoSao] >= 1 AND [SoSao] <= 5),
    [NhanXet] [nvarchar](500) NULL,
    [ThoiGianTao] [datetime2](7) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    FOREIGN KEY ([SanPhamId]) REFERENCES [SanPham]([Id]),
    FOREIGN KEY ([NguoiDungId]) REFERENCES [NguoiDung]([Id]),
    FOREIGN KEY ([ChiTietDonHangId]) REFERENCES [ChiTietDonHang]([Id])
);
GO

-- ============================================================
-- Insert Sample Data
-- ============================================================

-- Insert VaiTro
IF NOT EXISTS (SELECT 1 FROM VaiTro WHERE TenVaiTro = 'ADMIN')
BEGIN
    INSERT INTO VaiTro (TenVaiTro, MoTa, ThoiGianTao)
    VALUES 
        ('ADMIN', 'Quản trị viên hệ thống', GETDATE()),
        ('NHAN_VIEN', 'Nhân viên bán hàng', GETDATE()),
        ('KHACH_HANG', 'Khách hàng', GETDATE());
END
GO

-- Insert DanhMuc
IF NOT EXISTS (SELECT 1 FROM DanhMuc WHERE TenDanhMuc = 'Áo thun')
BEGIN
    INSERT INTO DanhMuc (TenDanhMuc, DuongDan, MoTa, ThuTuHienThi, DangHoatDong, ThoiGianTao)
    VALUES
        ('Áo thun', 'ao-thun', 'Áo thun nam nữ các loại', 1, 1, GETDATE()),
        ('Áo polo', 'ao-polo', 'Áo polo nam nữ', 2, 1, GETDATE()),
        ('Áo khoác', 'ao-khoac', 'Áo khoác, áo jacket', 3, 1, GETDATE()),
        ('Quần', 'quan', 'Quần âu, quần jean, quần kaki', 4, 1, GETDATE());
END
GO

-- Insert ThuongHieu
IF NOT EXISTS (SELECT 1 FROM ThuongHieu WHERE TenThuongHieu = 'Certain')
BEGIN
    INSERT INTO ThuongHieu (TenThuongHieu, TrangThai, MoTa, ThoiGianTao)
    VALUES
        ('Certain', 1, 'Thương hiệu Certain Shop', GETDATE()),
        ('Nike', 1, 'Thương hiệu Nike', GETDATE()),
        ('Adidas', 1, 'Thương hiệu Adidas', GETDATE()),
        ('Puma', 1, 'Thương hiệu Puma', GETDATE());
END
GO

-- Insert KichThuoc
IF NOT EXISTS (SELECT 1 FROM KichThuoc WHERE KichCo = 'S')
BEGIN
    INSERT INTO KichThuoc (KichCo, ThoiGianTao)
    VALUES
        ('XS', GETDATE()),
        ('S', GETDATE()),
        ('M', GETDATE()),
        ('L', GETDATE()),
        ('XL', GETDATE()),
        ('2XL', GETDATE());
END
GO

-- Insert MauSac
IF NOT EXISTS (SELECT 1 FROM MauSac WHERE TenMau = 'Trắng')
BEGIN
    INSERT INTO MauSac (TenMau, MaHex, MoTa, ThoiGianTao)
    VALUES
        ('Trắng', '#FFFFFF', 'Màu trắng', GETDATE()),
        ('Đen', '#000000', 'Màu đen', GETDATE()),
        ('Xám', '#808080', 'Màu xám', GETDATE()),
        ('Xanh', '#0066CC', 'Màu xanh', GETDATE()),
        ('Đỏ', '#FF0000', 'Màu đỏ', GETDATE());
END
GO

-- Insert ChatLieu
IF NOT EXISTS (SELECT 1 FROM ChatLieu WHERE TenChatLieu = 'Cotton')
BEGIN
    INSERT INTO ChatLieu (TenChatLieu, MoTa, ThoiGianTao)
    VALUES
        ('Cotton 100%', 'Chất liệu cotton nguyên chất', GETDATE()),
        ('Cotton blend', 'Cotton hỗn hợp (60% cotton)', GETDATE()),
        ('Polyester', 'Chất liệu polyester', GETDATE());
END
GO

-- ============================================================
-- Create Indexes for Performance
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_NguoiDung_TenDangNhap' AND object_id = OBJECT_ID('NguoiDung'))
    CREATE UNIQUE INDEX IX_NguoiDung_TenDangNhap ON NguoiDung(TenDangNhap);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_NguoiDung_Email' AND object_id = OBJECT_ID('NguoiDung'))
    CREATE UNIQUE INDEX IX_NguoiDung_Email ON NguoiDung(Email);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_DonHang_NguoiDungId' AND object_id = OBJECT_ID('DonHang'))
    CREATE INDEX IX_DonHang_NguoiDungId ON DonHang(NguoiDungId);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_DonHang_TrangThaiDonHang' AND object_id = OBJECT_ID('DonHang'))
    CREATE INDEX IX_DonHang_TrangThaiDonHang ON DonHang(TrangThaiDonHang);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GioHang_NguoiDungId' AND object_id = OBJECT_ID('GioHang'))
    CREATE UNIQUE INDEX IX_GioHang_NguoiDungId ON GioHang(NguoiDungId);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_GioHangChiTiet_GioHangId' AND object_id = OBJECT_ID('GioHangChiTiet'))
    CREATE INDEX IX_GioHangChiTiet_GioHangId ON GioHangChiTiet(GioHangId);

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_SanPham_DanhMucId' AND object_id = OBJECT_ID('SanPham'))
    CREATE INDEX IX_SanPham_DanhMucId ON SanPham(DanhMucId);
GO

-- ============================================================
-- Drop existing user if exists
-- ============================================================
IF EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'shop_user')
BEGIN
    DROP LOGIN [shop_user];
END
GO

-- ============================================================
-- Script completed successfully
-- ============================================================
PRINT 'Database schema created successfully!';
PRINT 'Tables created: 20';
PRINT 'Indexes created: 7';
PRINT 'Database is ready to use.';
GO
