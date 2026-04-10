USE [master]
GO
/****** Object:  Database [certain_shop]    Script Date: 3/22/2026 11:23:12 AM ******/
CREATE DATABASE [certain_shop]

GO
ALTER DATABASE [certain_shop] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [certain_shop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [certain_shop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [certain_shop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [certain_shop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [certain_shop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [certain_shop] SET ARITHABORT OFF 
GO
ALTER DATABASE [certain_shop] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [certain_shop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [certain_shop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [certain_shop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [certain_shop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [certain_shop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [certain_shop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [certain_shop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [certain_shop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [certain_shop] SET  ENABLE_BROKER 
GO
ALTER DATABASE [certain_shop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [certain_shop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [certain_shop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [certain_shop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [certain_shop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [certain_shop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [certain_shop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [certain_shop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [certain_shop] SET  MULTI_USER 
GO
ALTER DATABASE [certain_shop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [certain_shop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [certain_shop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [certain_shop] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [certain_shop] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [certain_shop] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [certain_shop] SET QUERY_STORE = ON
GO
ALTER DATABASE [certain_shop] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [certain_shop]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[BienThe]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BienThe](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SanPhamId] [bigint] NOT NULL,
	[KichThuocId] [bigint] NULL,
	[MauSacId] [bigint] NULL,
	[ChatLieuId] [bigint] NULL,
	[GiaBan] [decimal](18, 2) NULL,
	[SoLuongTon] [int] NOT NULL,
	[MacDinh] [bit] NOT NULL,
	[TrangThai] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ChatLieu]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatLieu](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenChatLieu] [nvarchar](150) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietDonHang](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DonHangId] [bigint] NOT NULL,
	[BienTheId] [bigint] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[GiaTaiThoiDiemMua] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DanhGia]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGia](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[SanPhamId] [bigint] NOT NULL,
	[NguoiDungId] [bigint] NOT NULL,
	[ChiTietDonHangId] [bigint] NULL,
	[DiemDanhGia] [int] NOT NULL,
	[TieuDe] [nvarchar](255) NULL,
	[NoiDung] [nvarchar](max) NULL,
	[HinhAnh] [varchar](500) NULL,
	[TrangThai] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhMuc]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMuc](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](150) NOT NULL,
	[DuongDan] [varchar](255) NULL,
	[MoTa] [nvarchar](500) NULL,
	[ThuTuHienThi] [int] NOT NULL,
	[DangHoatDong] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaChiNguoiDung]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaChiNguoiDung](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[NguoiDungId] [bigint] NOT NULL,
	[TenNguoiNhan] [nvarchar](150) NULL,
	[SoDienThoai] [varchar](20) NULL,
	[DiaChiCuThe] [nvarchar](500) NULL,
	[PhuongXa] [nvarchar](150) NULL,
	[QuanHuyen] [nvarchar](150) NULL,
	[TinhThanh] [nvarchar](150) NULL,
	[MaTinhGHN] [int] NULL,
	[MaHuyenGHN] [int] NULL,
	[MaXaGHN] [nvarchar](50) NULL,
	[LaMacDinh] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[NguoiDungId] [bigint] NULL,
	[NhanVienId] [bigint] NULL,
	[MaDonHang] [varchar](50) NOT NULL,
	[LoaiDonHang] [varchar](30) NOT NULL,
	[TrangThaiDonHang] [varchar](50) NOT NULL,
	[TongTienHang] [decimal](18, 2) NULL,
	[SoTienGiamGia] [decimal](18, 2) NOT NULL,
	[PhiVanChuyen] [decimal](18, 2) NOT NULL,
	[TongTienThanhToan] [decimal](18, 2) NOT NULL,
	[KhuyenMaiId] [bigint] NULL,
	[TenNguoiNhan] [nvarchar](150) NULL,
	[SdtNguoiNhan] [varchar](20) NULL,
	[DiaChiGiaoHang] [nvarchar](500) NULL,
	[MaTinhGHN] [int] NULL,
	[MaHuyenGHN] [int] NULL,
	[MaXaGHN] [nvarchar](50) NULL,
	[PhuongThucThanhToan] [varchar](50) NULL,
	[DaThanhToan] [bit] NOT NULL,
	[VnpayTxnRef] [varchar](100) NULL,
	[VnpayResponseCode] [varchar](10) NULL,
	[ThoiGianTuHuy] [datetime] NULL,
	[GhiChu] [nvarchar](500) NULL,
	[GhiChuThuNgan] [nvarchar](500) NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
	[VoucherId] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHang](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[NguoiDungId] [bigint] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHangChiTiet]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GioHangChiTiet](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GioHangId] [bigint] NOT NULL,
	[BienTheId] [bigint] NOT NULL,
	[SoLuong] [int] NOT NULL,
	[DonGia] [decimal](18, 2) NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HinhAnhBienThe]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhAnhBienThe](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BienTheId] [bigint] NOT NULL,
	[DuongDan] [varchar](500) NOT NULL,
	[LaAnhChinh] [bit] NOT NULL,
	[ThuTu] [int] NOT NULL,
	[MoTa] [nvarchar](255) NULL,
	[ThoiGianTao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MaKhuyenMai] [varchar](50) NOT NULL,
	[TenKhuyenMai] [nvarchar](200) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
	[LoaiGiam] [varchar](20) NOT NULL,
	[GiaTriGiam] [decimal](18, 2) NOT NULL,
	[DonHangToiThieu] [decimal](18, 2) NOT NULL,
	[GiaTriToiDa] [decimal](18, 2) NULL,
	[SoLuongToiDa] [int] NULL,
	[SoLuongDaDung] [int] NOT NULL,
	[NgayBatDau] [datetime] NOT NULL,
	[NgayKetThuc] [datetime] NOT NULL,
	[TrangThaiKhuyenMai] [varchar](30) NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[KichThuoc]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KichThuoc](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenKichThuoc] [varchar](50) NOT NULL,
	[ThuTu] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuTrangThaiDon]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuTrangThaiDon](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DonHangId] [bigint] NOT NULL,
	[TrangThaiCu] [varchar](50) NULL,
	[TrangThaiMoi] [varchar](50) NOT NULL,
	[GhiChu] [nvarchar](500) NULL,
	[NguoiThayDoiId] [bigint] NULL,
	[ThoiGian] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[MauSac]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MauSac](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenMauSac] [nvarchar](100) NOT NULL,
	[MaHex] [varchar](10) NULL,
	[MoTa] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [varchar](100) NOT NULL,
	[Email] [varchar](150) NULL,
	[MatKhauMaHoa] [varchar](255) NOT NULL,
	[HoTen] [nvarchar](150) NULL,
	[SoDienThoai] [varchar](20) NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[AnhDaiDien] [varchar](500) NULL,
	[VaiTroId] [int] NOT NULL,
	[TrangThai] [varchar](30) NOT NULL,
	[LanDangNhapCuoi] [datetime] NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
	[DangHoatDong] [bit] NULL,
	[MaDatLaiMatKhau] [varchar](255) NULL,
	[LanDoiMatKhauCuoi] [datetime] NULL,
	[CCCD] [varchar](20) NULL,
	[MaNguoiDung] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MaSanPham] [varchar](50) NULL,
	[TenSanPham] [nvarchar](255) NOT NULL,
	[MoTa] [nvarchar](max) NULL,
	[GiaGoc] [decimal](18, 2) NULL,
	[GiaBan] [decimal](18, 2) NULL,
	[DanhMucId] [bigint] NULL,
	[ThuongHieuId] [bigint] NULL,
	[AnhChinh] [varchar](500) NULL,
	[DuongDan] [varchar](255) NULL,
	[TrangThaiSanPham] [varchar](30) NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
	[TrangThai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToan]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhToan](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DonHangId] [bigint] NOT NULL,
	[PhuongThucThanhToan] [varchar](50) NULL,
	[TrangThaiThanhToan] [varchar](50) NULL,
	[SoTienThanhToan] [decimal](18, 2) NULL,
	[ThoiDiemThanhToan] [datetime] NULL,
	[MaGiaoDichVNPay] [varchar](100) NULL,
	[MaNganHang] [varchar](50) NULL,
	[ThongTinGiaoDich] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[ThuongHieu]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuongHieu](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenThuongHieu] [nvarchar](150) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
	[TrangThai] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  Table [dbo].[VaiTro]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenVaiTro] [varchar](50) NOT NULL,
	[QuyenHan] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Voucher]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Voucher](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MaVoucher] [nvarchar](50) NOT NULL,
	[MoTa] [nvarchar](500) NULL,
	[TrangThai] [bit] NOT NULL,
	[NgayBatDau] [datetime] NOT NULL,
	[NgayKetThuc] [datetime] NOT NULL,
	[GiaTriToiThieu] [decimal](18, 2) NULL,
	[LoaiGiam] [nvarchar](10) NOT NULL,
	[GiaTriGiam] [decimal](18, 2) NOT NULL,
	[GiaTriGiamToiDa] [decimal](18, 2) NOT NULL,
	[SoLuongSuDung] [int] NOT NULL,
	[SoLuongToiDa] [int] NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BienThe] ON 

INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 1, 2, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 30, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 1, 3, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 46, 1, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 1, 4, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 45, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 1, 5, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 20, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 1, 2, 2, 1, CAST(259000.00 AS Decimal(18, 2)), 25, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 1, 3, 2, 1, CAST(259000.00 AS Decimal(18, 2)), 40, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, 1, 4, 2, 1, CAST(259000.00 AS Decimal(18, 2)), 35, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, 1, 2, 3, 1, CAST(259000.00 AS Decimal(18, 2)), 20, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (9, 1, 3, 3, 1, CAST(259000.00 AS Decimal(18, 2)), 30, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (10, 2, 3, 1, 1, CAST(319000.00 AS Decimal(18, 2)), 39, 1, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:21.867' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (11, 2, 4, 1, 1, CAST(319000.00 AS Decimal(18, 2)), 30, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:21.867' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (12, 2, 3, 2, 1, CAST(319000.00 AS Decimal(18, 2)), 25, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:21.867' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (13, 2, 4, 2, 1, CAST(319000.00 AS Decimal(18, 2)), 20, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:21.867' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (14, 3, 3, 1, 2, CAST(399000.00 AS Decimal(18, 2)), 20, 1, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:23.687' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (15, 3, 4, 1, 2, CAST(399000.00 AS Decimal(18, 2)), 15, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:23.687' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (16, 3, 3, 3, 2, CAST(399000.00 AS Decimal(18, 2)), 18, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:23.687' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (17, 4, 3, 1, 3, CAST(549000.00 AS Decimal(18, 2)), 24, 1, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:25.390' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (18, 4, 4, 1, 3, CAST(549000.00 AS Decimal(18, 2)), 19, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:25.390' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (19, 4, 3, 5, 3, CAST(549000.00 AS Decimal(18, 2)), 15, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:27:25.390' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (26, 7, 3, 1, 1, CAST(359000.00 AS Decimal(18, 2)), 20, 1, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:18:43.857' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (27, 7, 4, 1, 1, CAST(359000.00 AS Decimal(18, 2)), 15, 0, 0, CAST(N'2026-02-24T20:31:56.040' AS DateTime), CAST(N'2026-02-28T10:18:43.857' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (30, 10, 3, 2, 2, NULL, 0, 0, 0, CAST(N'2026-02-26T20:18:53.897' AS DateTime), CAST(N'2026-02-28T10:27:15.547' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (31, 11, 4, 3, 3, NULL, 3, 0, 0, CAST(N'2026-02-26T21:10:54.760' AS DateTime), CAST(N'2026-02-28T10:18:40.530' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (32, 11, NULL, NULL, NULL, NULL, 0, 0, 0, CAST(N'2026-02-26T21:11:16.757' AS DateTime), CAST(N'2026-02-28T10:18:40.530' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (33, 11, 5, 5, 1, NULL, 0, 0, 0, CAST(N'2026-02-26T21:12:50.773' AS DateTime), CAST(N'2026-02-26T21:13:54.377' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (36, 13, 1, 2, 1, CAST(200000.00 AS Decimal(18, 2)), 9, 1, 0, CAST(N'2026-02-27T23:18:24.660' AS DateTime), CAST(N'2026-02-28T10:00:04.370' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (37, 13, 2, 2, 1, CAST(200000.00 AS Decimal(18, 2)), 10, 0, 0, CAST(N'2026-02-27T23:18:24.677' AS DateTime), CAST(N'2026-02-28T10:00:04.370' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (38, 15, 2, 7, 1, CAST(600000.00 AS Decimal(18, 2)), 9, 1, 0, CAST(N'2026-02-28T10:28:43.050' AS DateTime), CAST(N'2026-02-28T11:52:41.000' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (39, 15, 1, 3, 1, CAST(70000.00 AS Decimal(18, 2)), 9, 0, 0, CAST(N'2026-02-28T10:28:43.067' AS DateTime), CAST(N'2026-02-28T11:52:41.000' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (40, 15, NULL, NULL, NULL, NULL, 0, 0, 0, CAST(N'2026-02-28T10:48:46.307' AS DateTime), CAST(N'2026-02-28T10:49:04.523' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (41, 15, NULL, NULL, NULL, NULL, 0, 0, 0, CAST(N'2026-02-28T10:48:46.307' AS DateTime), CAST(N'2026-02-28T10:49:06.610' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (42, 15, 1, 7, 1, CAST(500000.00 AS Decimal(18, 2)), 7, 0, 0, CAST(N'2026-02-28T11:07:43.370' AS DateTime), CAST(N'2026-02-28T11:52:41.000' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (44, 16, 2, 1, 1, CAST(50000.00 AS Decimal(18, 2)), 0, 1, 1, CAST(N'2026-02-28T11:39:21.493' AS DateTime), CAST(N'2026-03-21T23:29:37.517' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (45, 16, 3, 2, 1, CAST(600000.00 AS Decimal(18, 2)), 9, 0, 1, CAST(N'2026-02-28T11:39:21.523' AS DateTime), CAST(N'2026-03-21T23:28:27.433' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (46, 16, NULL, NULL, NULL, NULL, 10, 0, 1, CAST(N'2026-02-28T11:39:36.410' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (47, 17, 4, 7, 1, CAST(60000.00 AS Decimal(18, 2)), 598, 1, 0, CAST(N'2026-02-28T11:46:25.877' AS DateTime), CAST(N'2026-02-28T11:51:08.113' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (48, 18, 1, 1, 1, CAST(60000.00 AS Decimal(18, 2)), 10, 1, 0, CAST(N'2026-02-28T11:54:31.817' AS DateTime), CAST(N'2026-02-28T12:06:04.827' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (49, 18, 1, 7, 1, CAST(600000.00 AS Decimal(18, 2)), 10, 0, 0, CAST(N'2026-02-28T11:54:31.833' AS DateTime), CAST(N'2026-02-28T12:06:04.827' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (50, 18, 6, 6, 1, CAST(600000.00 AS Decimal(18, 2)), 10, 0, 0, CAST(N'2026-02-28T11:54:31.850' AS DateTime), CAST(N'2026-02-28T12:06:04.830' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (51, 19, 1, 1, 1, CAST(550000.00 AS Decimal(18, 2)), 7, 1, 1, CAST(N'2026-02-28T12:06:55.707' AS DateTime), CAST(N'2026-03-21T22:47:07.627' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (52, 19, 1, 2, 1, CAST(550000.00 AS Decimal(18, 2)), 8, 0, 1, CAST(N'2026-02-28T12:06:55.727' AS DateTime), CAST(N'2026-03-21T23:29:56.600' AS DateTime))
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (53, 19, 2, 2, 1, CAST(500000.00 AS Decimal(18, 2)), 10, 0, 1, CAST(N'2026-02-28T12:06:55.740' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[BienThe] OFF
GO
SET IDENTITY_INSERT [dbo].[ChatLieu] ON 

INSERT [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (1, N'Cotton 100%', N'Vải cotton tự nhiên thoáng mát')
INSERT [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (2, N'Cotton Polyester', N'Pha 65% cotton 35% poly')
INSERT [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (3, N'Polyester', N'Thoáng khô nhanh')
INSERT [dbo].[ChatLieu] ([Id], [TenChatLieu], [MoTa]) VALUES (4, N'Linen', N'Vải lanh nhẹ mát mùa hè')
SET IDENTITY_INSERT [dbo].[ChatLieu] OFF
GO
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] ON 

INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (1, 1, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (2, 1, 17, 1, CAST(549000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (3, 2, 14, 1, CAST(399000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (4, 3, 10, 1, CAST(319000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (6, 4, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (7, 5, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (8, 6, 17, 1, CAST(549000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (9, 6, 18, 1, CAST(549000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (10, 7, 10, 2, CAST(319000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (11, 8, 10, 3, CAST(319000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (12, 9, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (13, 10, 10, 1, CAST(319000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (14, 11, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (15, 12, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (16, 13, 10, 1, CAST(319000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (17, 14, 10, 1, CAST(319000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (18, 14, 26, 1, CAST(359000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (19, 15, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (20, 16, 36, 1, CAST(200000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (21, 17, 26, 1, CAST(359000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (22, 18, 39, 1, CAST(70000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (23, 19, 38, 1, CAST(600000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (24, 20, 42, 1, CAST(500000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (25, 20, 39, 1, CAST(70000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (26, 20, 44, 1, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (27, 21, 47, 2, CAST(60000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (28, 22, 51, 2, CAST(550000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (29, 23, 44, 1, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (30, 24, 44, 1, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (31, 25, 31, 2, CAST(500000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (32, 26, 51, 1, CAST(550000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (33, 28, 44, 1, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (34, 29, 45, 1, CAST(600000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (35, 30, 45, 1, CAST(600000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (36, 31, 44, 4, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (37, 32, 44, 2, CAST(50000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (38, 33, 52, 2, CAST(550000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (39, 34, 51, 1, CAST(550000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[ChiTietDonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[DanhGia] ON 

INSERT [dbo].[DanhGia] ([Id], [SanPhamId], [NguoiDungId], [ChiTietDonHangId], [DiemDanhGia], [TieuDe], [NoiDung], [HinhAnh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 1, 4, 1, 5, N'Áo đẹp, chất lượng tốt', N'Vải cotton mềm mịn, màu không phai sau nhiều lần giặt.', NULL, 1, CAST(N'2026-02-24T20:31:56.130' AS DateTime), NULL)
INSERT [dbo].[DanhGia] ([Id], [SanPhamId], [NguoiDungId], [ChiTietDonHangId], [DiemDanhGia], [TieuDe], [NoiDung], [HinhAnh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 4, 4, 2, 4, N'Nike chất như kỳ vọng', N'Co giãn tốt, rất thoải mái khi tập gym.', NULL, 1, CAST(N'2026-02-24T20:31:56.130' AS DateTime), NULL)
INSERT [dbo].[DanhGia] ([Id], [SanPhamId], [NguoiDungId], [ChiTietDonHangId], [DiemDanhGia], [TieuDe], [NoiDung], [HinhAnh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 3, 5, 3, 5, N'Áo polo sang trọng', N'Mặc đi làm, dự tiệc đều phù hợp.', NULL, 1, CAST(N'2026-02-24T20:31:56.130' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[DanhGia] OFF
GO
SET IDENTITY_INSERT [dbo].[DanhMuc] ON 

INSERT [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (1, N'Áo thun', N'ao-thun', N'Áo thun nam nữ các loại', 1, 1, CAST(N'2026-02-24T20:31:55.960' AS DateTime))
INSERT [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (2, N'Áo polo', N'ao-polo', N'Áo polo cổ bẻ thời trang', 2, 1, CAST(N'2026-02-24T20:31:55.960' AS DateTime))
SET IDENTITY_INSERT [dbo].[DanhMuc] OFF
GO
SET IDENTITY_INSERT [dbo].[DiaChiNguoiDung] ON 

INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, N'Lê Minh Tuấn', N'0912345678', N'12 Nguyễn Huệ', N'Phường Bến Nghé', N'Quận 1', N'TP. Hồ Chí Minh', 202, 1442, N'20211', 1, CAST(N'2026-02-24T20:31:55.950' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 4, N'Lê Minh Tuấn', N'0912345678', N'88 Lê Lợi', N'Phường Phạm Ngũ Lão', N'Quận 1', N'TP. Hồ Chí Minh', 202, 1442, N'20209', 0, CAST(N'2026-02-24T20:31:55.950' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 5, N'Phạm Thị Mai', N'0987654321', N'45 Trần Hưng Đạo', N'Phường Hàng Bài', N'Quận Hoàn Kiếm', N'Hà Nội', 201, 1489, N'1A0102', 1, CAST(N'2026-02-24T20:31:55.950' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 4, N'Test DC', N'0912345678', N'123 Le Loi', N'P. Ben Thanh', N'Q.1', N'TP HCM', 202, 3695, N'90737', 0, CAST(N'2026-02-25T16:20:30.037' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 4, N'Test DC', N'0912345678', N'123 Le Loi', N'P. Ben Thanh', N'Q.1', N'TP HCM', 202, 3695, N'90737', 0, CAST(N'2026-02-25T16:25:47.640' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 9, N'Trung Kiên', N'0964641839', N'Trần Kiên', N'Phường Trà Bá', N'Thành phố Pleiku', N'Gia Lai', 207, 1546, N'380112', 1, CAST(N'2026-02-27T13:15:48.630' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, 9, N'Trung Kiên', N'0964641839', N'Trần Kiên', N'Xã Cương Sơn', N'Huyện Lục Nam', N'Bắc Giang', 248, 1965, N'180509', 0, CAST(N'2026-02-27T13:16:47.107' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, 10, N'Trung Kiên', N'0964641839', N'22 test', N'Xã Vĩnh Viễn A', N'Huyện Long Mỹ', N'Hậu Giang', 250, 3445, N'640307', 1, CAST(N'2026-02-28T11:18:26.537' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (9, 10, N'kiên anh', N'0964657389', N'22 đường test', N'Xã Dương Xá', N'Huyện Gia Lâm', N'Hà Nội', 201, 1703, N'1A1211', 0, CAST(N'2026-02-28T12:09:16.790' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (10, 17, N'sấ', NULL, N'fdfsd', N'Xã Hương Lạc', N'Huyện Lạng Giang', N'Bắc Giang', 248, 1760, N'180807', 1, CAST(N'2026-03-22T00:23:29.037' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (11, 18, N'Trung kiên test', N'0956571839', NULL, N'Xã Hợp Thịnh', N'Huyện Hiệp Hòa', N'Bắc Giang', 248, 1759, N'180715', 1, CAST(N'2026-03-22T10:19:42.507' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (12, 19, N'Kiên test', NULL, N'test', N'Xã Bằng Vân', N'Huyện Ngân Sơn', N'Bắc Kạn', 245, 3242, N'110502', 1, CAST(N'2026-03-22T10:21:16.420' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (13, 20, N'kien test', NULL, N'test 22/03/2026', N'Xã Bình Long', N'Huyện Võ Nhai', N'Thái Nguyên', NULL, NULL, NULL, 1, CAST(N'2026-03-22T10:23:52.617' AS DateTime), CAST(N'2026-03-22T10:24:21.393' AS DateTime))
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (14, 21, N'đức anh', NULL, N'test2026', N'Xã Hương Lâm', N'Huyện Hiệp Hòa', N'Bắc Giang', 248, 1759, N'180717', 1, CAST(N'2026-03-22T10:25:31.020' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[DiaChiNguoiDung] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (1, 4, NULL, N'DH20240001', N'ONLINE', N'DA_GIAO', CAST(808000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(788000.00 AS Decimal(18, 2)), 1, N'Lê Minh Tuấn', N'0912345678', N'12 Nguyễn Huệ, P.Bến Nghé, Q.1, TP.HCM', NULL, NULL, NULL, N'VNPAY', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-09T20:31:56.093' AS DateTime), NULL, NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (2, 5, NULL, N'DH20240002', N'ONLINE', N'DANG_GIAO', CAST(399000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(429000.00 AS Decimal(18, 2)), NULL, N'Phạm Thị Mai', N'0987654321', N'45 Trần Hưng Đạo, P.Hàng Bài, Q.Hoàn Kiếm, Hà Nội', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-21T20:31:56.093' AS DateTime), NULL, NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (3, NULL, 2, N'DH20240003', N'TAI_QUAY', N'HOAN_THANH', CAST(698000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(698000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-17T20:31:56.093' AS DateTime), NULL, NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (4, 4, NULL, N'DH20240004', N'ONLINE', N'DANG_XU_LY', CAST(259000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(289000.00 AS Decimal(18, 2)), NULL, N'Lê Minh Tuấn', N'0912345678', N'88 Lê Lợi, P.Phạm Ngũ Lão, Q.1, TP.HCM', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-24T18:31:56.093' AS DateTime), CAST(N'2026-02-27T20:35:53.243' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (5, 9, NULL, N'DH202602262021168123', N'ONLINE', N'DA_HUY', CAST(259000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(259000.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', N'fdfdsfdsfsdf', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-26T20:21:16.837' AS DateTime), CAST(N'2026-02-26T20:44:39.083' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (6, 9, NULL, N'DH202602262022216341', N'ONLINE', N'DANG_GIAO', CAST(1098000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1098000.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', N'fsafasfasf', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-26T20:22:22.003' AS DateTime), CAST(N'2026-02-27T20:29:11.620' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (7, 11, NULL, N'DH202602262047084440', N'ONLINE', N'DA_HUY', CAST(638000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(638000.00 AS Decimal(18, 2)), NULL, N'kiennguyen', N'0567451637', N'fafasfs', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-26T20:47:08.773' AS DateTime), CAST(N'2026-02-26T20:47:30.057' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (8, 11, NULL, N'DH202602262047443550', N'ONLINE', N'DA_HUY', CAST(957000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(957000.00 AS Decimal(18, 2)), NULL, N'kiennguyen', N'0567451637', N'fsfasf', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-26T20:47:44.340' AS DateTime), CAST(N'2026-02-26T21:03:54.567' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (9, 9, NULL, N'DH202602262121211135', N'ONLINE', N'DANG_GIAO', CAST(259000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(259000.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', N'yygjygjhhg', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-26T21:21:21.403' AS DateTime), CAST(N'2026-02-27T20:00:07.777' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (10, 9, NULL, N'DH202602262122509757', N'ONLINE', N'DA_HUY', CAST(319000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(319000.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', N'fyfjfhfjhfhjf', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-26T21:22:50.017' AS DateTime), CAST(N'2026-02-26T22:10:05.690' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (11, 9, NULL, N'DH202602270020318034', N'ONLINE', N'DA_HUY', CAST(259000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(259000.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', N'Hồ Chí Minh ', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-27T00:20:31.530' AS DateTime), CAST(N'2026-02-27T11:58:14.320' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (12, 9, NULL, N'DH202602270027519578', N'ONLINE', N'DA_HUY', CAST(259000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(259000.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', N'fsfsa', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-27T00:27:51.757' AS DateTime), CAST(N'2026-02-27T11:58:14.323' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (13, 9, NULL, N'DH202602271307259596', N'ONLINE', N'HOAN_TAT', CAST(319000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(319000.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', N'Hồ Chí Minh', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, N'', NULL, CAST(N'2026-02-27T13:07:25.557' AS DateTime), CAST(N'2026-02-27T20:35:46.750' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (14, 9, NULL, N'DH202602271510520888', N'ONLINE', N'DA_HUY', CAST(678000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)), CAST(713000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'Trần Kiên, Phường Trà Bá, Thành phố Pleiku, Gia Lai', 207, 1546, N'380112', N'VNPAY', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-27T15:10:52.763' AS DateTime), CAST(N'2026-02-27T15:42:20.600' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (15, 9, NULL, N'DH202602271542442687', N'ONLINE', N'HOAN_TAT', CAST(259000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)), CAST(294000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'Trần Kiên, Phường Trà Bá, Thành phố Pleiku, Gia Lai', 207, 1546, N'380112', N'VNPAY', 1, N'15433360', NULL, NULL, NULL, NULL, CAST(N'2026-02-27T15:42:44.300' AS DateTime), CAST(N'2026-02-27T20:35:48.850' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (16, 9, NULL, N'DH202602280006070079', N'ONLINE', N'DANG_GIAO', CAST(200000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)), CAST(235000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'Trần Kiên, Phường Trà Bá, Thành phố Pleiku, Gia Lai', 207, 1546, N'380112', N'COD', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-28T00:06:07.620' AS DateTime), CAST(N'2026-02-28T11:37:09.957' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (17, 9, NULL, N'DH202602280007533852', N'ONLINE', N'DA_HUY', CAST(359000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(35000.00 AS Decimal(18, 2)), CAST(394000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'Trần Kiên, Phường Trà Bá, Thành phố Pleiku, Gia Lai', 207, 1546, N'380112', N'COD', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-28T00:07:53.357' AS DateTime), CAST(N'2026-02-28T00:07:57.510' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (18, 10, NULL, N'DH202602281120070204', N'ONLINE', N'DA_HUY', CAST(70000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(114000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'VNPAY', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-28T11:20:07.383' AS DateTime), CAST(N'2026-02-28T11:36:08.340' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (19, 10, NULL, N'DH202602281121550077', N'ONLINE', N'HOAN_TAT', CAST(600000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(644000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'VNPAY', 1, N'15433961', NULL, NULL, NULL, NULL, CAST(N'2026-02-28T11:21:55.720' AS DateTime), CAST(N'2026-02-28T11:24:48.350' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (20, 10, NULL, N'DH202602281139590414', N'ONLINE', N'HOAN_TAT', CAST(620000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(664000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'COD', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-28T11:39:59.730' AS DateTime), CAST(N'2026-02-28T11:40:25.350' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (21, 10, NULL, N'DH202602281146461074', N'ONLINE', N'HOAN_TAT', CAST(120000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(164000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'COD', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-28T11:46:46.107' AS DateTime), CAST(N'2026-02-28T11:46:58.900' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (22, 10, NULL, N'DH202602281209341859', N'ONLINE', N'HOAN_TAT', CAST(1100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(1144000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'VNPAY', 1, N'15433982', NULL, NULL, NULL, NULL, CAST(N'2026-02-28T12:09:34.587' AS DateTime), CAST(N'2026-02-28T12:10:39.490' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (23, 10, NULL, N'DH202602281212261925', N'ONLINE', N'HOAN_TAT', CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(94000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'COD', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-28T12:12:26.830' AS DateTime), CAST(N'2026-02-28T12:12:39.873' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (24, 10, NULL, N'DH202602281212581490', N'ONLINE', N'HOAN_TAT', CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(94000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'COD', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-28T12:12:58.747' AS DateTime), CAST(N'2026-02-28T12:13:11.743' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (25, 9, NULL, N'DH202603032343207229', N'ONLINE', N'CHO_XAC_NHAN', CAST(1000000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1000000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'Trần Kiên, Phường Trà Bá, Thành phố Pleiku, Gia Lai', 207, 1546, N'380112', N'COD', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-03T23:43:20.313' AS DateTime), CAST(N'2026-03-03T23:43:20.313' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (26, NULL, 2, N'DH202603212246466181', N'TAI_QUAY', N'HOAN_TAT', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, N'Khách lẻ', N'', NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-21T22:46:46.530' AS DateTime), CAST(N'2026-03-21T22:47:28.933' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (27, NULL, 2, N'DH202603212310428999', N'TAI_QUAY', N'DA_HUY', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, CAST(N'2026-03-22T01:10:42.443' AS DateTime), NULL, NULL, CAST(N'2026-03-21T23:10:42.453' AS DateTime), CAST(N'2026-03-21T23:11:08.257' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (28, 9, 2, N'DH202603212311012464', N'TAI_QUAY', N'HOAN_TAT', CAST(0.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, N'trung kien', N'0956651738', NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-21T23:11:01.607' AS DateTime), CAST(N'2026-03-21T23:11:33.803' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (29, NULL, 2, N'DH202603212312018243', N'TAI_QUAY', N'HOAN_TAT', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, N'Khách lẻ', N'', NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-21T23:12:01.487' AS DateTime), CAST(N'2026-03-21T23:12:33.350' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (30, NULL, 2, N'DH202603212312036935', N'TAI_QUAY', N'DA_HUY', CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, CAST(N'2026-03-22T01:12:03.287' AS DateTime), NULL, NULL, CAST(N'2026-03-21T23:12:03.287' AS DateTime), CAST(N'2026-03-21T23:28:27.430' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (31, 10, 2, N'DH202603212328328477', N'TAI_QUAY', N'HOAN_TAT', CAST(200000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(150000.00 AS Decimal(18, 2)), NULL, N'Nguyễn Cao Trung Kien', N'0967674587', NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-21T23:28:32.293' AS DateTime), CAST(N'2026-03-21T23:28:57.160' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (32, 10, 2, N'DH202603212329326768', N'TAI_QUAY', N'HOAN_TAT', CAST(100000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), NULL, N'Nguyễn Cao Trung Kien', N'0967674587', NULL, NULL, NULL, NULL, N'CHUYEN_KHOAN', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-21T23:29:32.353' AS DateTime), CAST(N'2026-03-21T23:29:45.417' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (33, NULL, 2, N'DH202603212329512208', N'TAI_QUAY', N'HOAN_TAT', CAST(1100000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1100000.00 AS Decimal(18, 2)), NULL, N'Khách lẻ', N'', NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-21T23:29:51.720' AS DateTime), CAST(N'2026-03-21T23:30:03.347' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat], [VoucherId]) VALUES (34, 10, NULL, N'DH202603221020064523', N'ONLINE', N'CHO_XAC_NHAN', CAST(550000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(44000.00 AS Decimal(18, 2)), CAST(594000.00 AS Decimal(18, 2)), NULL, N'Trung Kiên', N'0964641839', N'22 test, Xã Vĩnh Viễn A, Huyện Long Mỹ, Hậu Giang', 250, 3445, N'640307', N'COD', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-03-22T10:20:06.660' AS DateTime), CAST(N'2026-03-22T10:20:06.660' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[GioHang] ON 

INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, CAST(N'2026-02-24T20:31:56.047' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 5, CAST(N'2026-02-24T20:31:56.047' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 6, CAST(N'2026-02-25T15:59:53.103' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 7, CAST(N'2026-02-25T16:00:19.923' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 1, CAST(N'2026-02-25T16:33:32.477' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 9, CAST(N'2026-02-25T17:02:28.313' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, 10, CAST(N'2026-02-26T20:24:00.163' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, 11, CAST(N'2026-02-26T20:46:34.640' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (9, 12, CAST(N'2026-02-26T21:07:27.537' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (10, 13, CAST(N'2026-02-28T08:38:52.640' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[GioHang] OFF
GO
SET IDENTITY_INSERT [dbo].[GioHangChiTiet] ON 

INSERT [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 2, 14, 1, CAST(399000.00 AS Decimal(18, 2)), CAST(N'2026-02-24T20:31:56.063' AS DateTime), NULL)
INSERT [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 1, 1, 2, CAST(259000.00 AS Decimal(18, 2)), CAST(N'2026-02-25T16:26:22.817' AS DateTime), NULL)
INSERT [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (27, 7, 51, 1, CAST(550000.00 AS Decimal(18, 2)), CAST(N'2026-03-22T10:20:21.980' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[GioHangChiTiet] OFF
GO
SET IDENTITY_INSERT [dbo].[HinhAnhBienThe] ON 

INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (1, 30, N'/uploads/images/b3f9995e-c7d5-4209-93fd-2e7b474d1b6d_sg-11134201-22100-3od0skjhwviv74.jpg', 1, 0, N'sg-11134201-22100-3od0skjhwviv74.jpg', CAST(N'2026-02-26T20:18:58.003' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (2, 30, N'/uploads/images/a5e7b967-baa5-4fa9-9b72-55f42e8e12b0_bd0c2592f5a37bfd22b2.jpg', 0, 0, N'bd0c2592f5a37bfd22b2.jpg', CAST(N'2026-02-26T20:19:22.967' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (3, 31, N'/uploads/images/86589ec0-ea31-43a3-a32c-c4da13078d48_sg-11134201-22100-3od0skjhwviv74.jpg', 1, 0, N'sg-11134201-22100-3od0skjhwviv74.jpg', CAST(N'2026-02-26T21:11:05.570' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (4, 32, N'/uploads/images/1b256183-cb80-4771-87c7-e850237fe0fd_bd0c2592f5a37bfd22b2.jpg', 1, 0, N'bd0c2592f5a37bfd22b2.jpg', CAST(N'2026-02-26T21:11:29.580' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (7, 36, N'/uploads/images/eb806452-35f1-45d3-943a-3be65b46d28c_bd0c2592f5a37bfd22b2.jpg', 1, 0, N'bd0c2592f5a37bfd22b2.jpg', CAST(N'2026-02-27T23:18:44.097' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (8, 37, N'/uploads/images/db42ea4e-2b35-4b56-93f4-15b59a0e6f65_d5bd60efb1de3f8066cf.jpg', 1, 0, N'd5bd60efb1de3f8066cf.jpg', CAST(N'2026-02-27T23:18:47.477' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (9, 38, N'/uploads/images/6ae5d337-ba0b-48df-b87a-51b2c4e200f4_pngtree-black-t-shirt-mockup-png-image_14529131.png', 1, 0, N'pngtree-black-t-shirt-mockup-png-image_14529131.png', CAST(N'2026-02-28T10:28:47.750' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (11, 39, N'/uploads/images/cc10aea8-4087-481e-a189-d9bb42fb0af9_sg-11134201-22100-3od0skjhwviv74.jpg', 1, 0, N'sg-11134201-22100-3od0skjhwviv74.jpg', CAST(N'2026-02-28T10:29:01.173' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (12, 38, N'/uploads/images/8ec91366-18a0-48fa-9d9b-9e03fd3aa422_22b443cb92fa1ca445eb.jpg', 0, 0, N'22b443cb92fa1ca445eb.jpg', CAST(N'2026-02-28T10:29:04.807' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (13, 39, N'/uploads/images/673f1509-f2fc-4a2b-984c-b2bc38ed687d_d5bd60efb1de3f8066cf.jpg', 0, 0, N'd5bd60efb1de3f8066cf.jpg', CAST(N'2026-02-28T10:29:09.497' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (14, 42, N'/uploads/images/7b2753de-49ba-421a-9328-552649393b0a_605293301_2719899281690169_5562315521143959385_n.jpg', 1, 0, N'605293301_2719899281690169_5562315521143959385_n.jpg', CAST(N'2026-02-28T11:08:15.987' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (15, 44, N'/uploads/images/2c832e5c-9441-41c7-afbd-11f3212f852f_pngtree-white-polo-t-shirt-png-image_11468133.png', 1, 0, N'pngtree-white-polo-t-shirt-png-image_11468133.png', CAST(N'2026-02-28T11:39:26.150' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (16, 45, N'/uploads/images/6c914ec1-af41-4621-9c80-29aa39b3a12f_pngtree-white-sport-polo-shirt-mockup-hanging-png-file-png-image_11588389.png', 1, 0, N'pngtree-white-sport-polo-shirt-mockup-hanging-png-file-png-image_11588389.png', CAST(N'2026-02-28T11:39:28.953' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (17, 44, N'/uploads/images/9c3eaebf-a028-4d2e-b471-4c1ccd3af325_pngtree-black-t-shirt-mockup-png-image_14529131.png', 0, 0, N'pngtree-black-t-shirt-mockup-png-image_14529131.png', CAST(N'2026-02-28T11:39:32.110' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (18, 45, N'/uploads/images/f5109d44-ea6d-4adc-aff8-e1edfa4a194e_pngtree-black-t-shirt-mockup-png-image_14529131.png', 0, 0, N'pngtree-black-t-shirt-mockup-png-image_14529131.png', CAST(N'2026-02-28T11:39:35.117' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (19, 47, N'/uploads/images/38fbb3cb-9ff9-421e-8842-a0bf6cdef99c_d5bd60efb1de3f8066cf.jpg', 1, 0, N'd5bd60efb1de3f8066cf.jpg', CAST(N'2026-02-28T11:46:30.260' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (20, 48, N'/uploads/images/8a765a5a-157e-49aa-bba5-5d70799152a5_pngtree-white-polo-t-shirt-png-image_11468133.png', 1, 0, N'pngtree-white-polo-t-shirt-png-image_11468133.png', CAST(N'2026-02-28T11:54:35.910' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (21, 48, N'/uploads/images/495e3302-5c6f-437f-b471-8a86e6d7b105_pngtree-white-sport-polo-shirt-mockup-hanging-png-file-png-image_11588389.png', 0, 0, N'pngtree-white-sport-polo-shirt-mockup-hanging-png-file-png-image_11588389.png', CAST(N'2026-02-28T11:54:39.870' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (23, 49, N'/uploads/images/ea87e916-166a-4ea1-b51b-a360b8d7972e_bd0c2592f5a37bfd22b2.jpg', 1, 0, N'bd0c2592f5a37bfd22b2.jpg', CAST(N'2026-02-28T11:54:48.417' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (24, 50, N'/uploads/images/8d8f54e8-2f83-4fc1-8bc9-09027bcdd8d0_d5bd60efb1de3f8066cf.jpg', 1, 0, N'd5bd60efb1de3f8066cf.jpg', CAST(N'2026-02-28T11:54:52.040' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (25, 51, N'/uploads/images/9bc01c1d-dc47-4604-9f11-0a756b5afe8c_bd0c2592f5a37bfd22b2.jpg', 1, 0, N'bd0c2592f5a37bfd22b2.jpg', CAST(N'2026-02-28T12:07:01.160' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (26, 51, N'/uploads/images/9b1886b0-5e4b-4a91-93f8-8bb6973ea5bd_22b443cb92fa1ca445eb.jpg', 0, 0, N'22b443cb92fa1ca445eb.jpg', CAST(N'2026-02-28T12:07:04.427' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (27, 52, N'/uploads/images/2b1c8b27-a32d-464e-8145-f2b53223431f_pngtree-white-polo-t-shirt-png-image_11468133.png', 1, 0, N'pngtree-white-polo-t-shirt-png-image_11468133.png', CAST(N'2026-02-28T12:07:07.373' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (28, 52, N'/uploads/images/cbe738cc-a795-483c-b887-04a546db2a9b_d5bd60efb1de3f8066cf.jpg', 0, 0, N'd5bd60efb1de3f8066cf.jpg', CAST(N'2026-02-28T12:07:11.823' AS DateTime))
INSERT [dbo].[HinhAnhBienThe] ([Id], [BienTheId], [DuongDan], [LaAnhChinh], [ThuTu], [MoTa], [ThoiGianTao]) VALUES (30, 53, N'/uploads/images/8dfd92b8-980c-459f-bd7b-36f2b29b7169_605293301_2719899281690169_5562315521143959385_n.jpg', 1, 0, N'605293301_2719899281690169_5562315521143959385_n.jpg', CAST(N'2026-02-28T12:07:28.383' AS DateTime))
SET IDENTITY_INSERT [dbo].[HinhAnhBienThe] OFF
GO
SET IDENTITY_INSERT [dbo].[KhuyenMai] ON 

INSERT [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, N'WELCOME10', N'Chào mừng - Giảm 10%', N'Giảm 10% đơn đầu tiên', N'PHAN_TRAM', CAST(10.00 AS Decimal(18, 2)), CAST(199000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), 100, 12, CAST(N'2026-01-25T20:31:56.073' AS DateTime), CAST(N'2026-04-25T20:31:56.073' AS DateTime), N'DANG_HOAT_DONG', CAST(N'2026-02-24T20:31:56.073' AS DateTime), NULL)
INSERT [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, N'SALE50K', N'Giảm 50.000đ', N'Giảm 50k đơn từ 499k', N'SO_TIEN', CAST(50000.00 AS Decimal(18, 2)), CAST(499000.00 AS Decimal(18, 2)), NULL, 200, 8, CAST(N'2026-02-24T20:31:56.073' AS DateTime), CAST(N'2026-03-26T20:31:56.073' AS DateTime), N'DANG_HOAT_DONG', CAST(N'2026-02-24T20:31:56.073' AS DateTime), NULL)
INSERT [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, N'FREESHIP', N'Miễn phí vận chuyển', N'FreeShip đơn từ 399k', N'SO_TIEN', CAST(30000.00 AS Decimal(18, 2)), CAST(399000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), 500, 45, CAST(N'2026-02-17T20:31:56.073' AS DateTime), CAST(N'2026-03-19T20:31:56.073' AS DateTime), N'DANG_HOAT_DONG', CAST(N'2026-02-24T20:31:56.073' AS DateTime), NULL)
INSERT [dbo].[KhuyenMai] ([Id], [MaKhuyenMai], [TenKhuyenMai], [MoTa], [LoaiGiam], [GiaTriGiam], [DonHangToiThieu], [GiaTriToiDa], [SoLuongToiDa], [SoLuongDaDung], [NgayBatDau], [NgayKetThuc], [TrangThaiKhuyenMai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, N'FLASH20', N'Flash sale giảm 20%', N'Chỉ áp dụng hôm nay', N'PHAN_TRAM', CAST(20.00 AS Decimal(18, 2)), CAST(299000.00 AS Decimal(18, 2)), CAST(100000.00 AS Decimal(18, 2)), 50, 50, CAST(N'2026-02-19T20:31:56.073' AS DateTime), CAST(N'2026-02-23T20:31:56.073' AS DateTime), N'HET_HAN', CAST(N'2026-02-24T20:31:56.073' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[KhuyenMai] OFF
GO
SET IDENTITY_INSERT [dbo].[KichThuoc] ON 

INSERT [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (1, N'XS', 1)
INSERT [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (2, N'S', 2)
INSERT [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (3, N'M', 3)
INSERT [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (4, N'L', 4)
INSERT [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (5, N'XL', 5)
INSERT [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (6, N'2XL', 6)
INSERT [dbo].[KichThuoc] ([Id], [TenKichThuoc], [ThuTu]) VALUES (7, N'3XL', 7)
SET IDENTITY_INSERT [dbo].[KichThuoc] OFF
GO
SET IDENTITY_INSERT [dbo].[LichSuTrangThaiDon] ON 

INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (1, 1, NULL, N'CHO_XAC_NHAN', N'Đặt hàng online', 4, CAST(N'2026-02-09T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (2, 1, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'Nhân viên xác nhận', 2, CAST(N'2026-02-10T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (3, 1, N'DA_XAC_NHAN', N'DANG_GIAO', N'Bàn giao đơn vị vận chuyển', 2, CAST(N'2026-02-11T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (4, 1, N'DANG_GIAO', N'DA_GIAO', N'Khách xác nhận đã nhận hàng', 4, CAST(N'2026-02-14T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (5, 2, NULL, N'CHO_XAC_NHAN', N'Đặt hàng online', 5, CAST(N'2026-02-21T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (6, 2, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'Nhân viên xác nhận', 2, CAST(N'2026-02-22T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (7, 2, N'DA_XAC_NHAN', N'DANG_GIAO', N'Bàn giao GHN', 2, CAST(N'2026-02-23T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (8, 3, NULL, N'HOAN_THANH', N'Bán tại quầy - tiền mặt', 2, CAST(N'2026-02-17T20:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (9, 4, NULL, N'CHO_XAC_NHAN', N'Đặt hàng online, chờ xác nhận', 4, CAST(N'2026-02-24T18:31:56.113' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (10, 5, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-26T20:21:17.020' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (11, 6, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-26T20:22:22.063' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (12, 6, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, CAST(N'2026-02-26T20:22:58.730' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (13, 5, N'CHO_THANH_TOAN', N'DA_HUY', N'Tự động hủy - quá hạn thanh toán VNPay', NULL, CAST(N'2026-02-26T20:44:39.013' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (14, 7, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 11, CAST(N'2026-02-26T20:47:08.807' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (15, 7, N'CHO_XAC_NHAN', N'DA_HUY', N'Khách hủy: Khách hàng tự hủy', 11, CAST(N'2026-02-26T20:47:30.057' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (16, 8, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 11, CAST(N'2026-02-26T20:47:44.357' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (17, 8, N'CHO_THANH_TOAN', N'DA_HUY', N'Tự động hủy - quá hạn thanh toán VNPay', NULL, CAST(N'2026-02-26T21:03:54.507' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (18, 9, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-26T21:21:21.460' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (19, 9, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, CAST(N'2026-02-26T21:22:08.420' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (20, 10, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-26T21:22:50.037' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (21, 10, N'CHO_THANH_TOAN', N'DA_HUY', N'Tự động hủy - quá hạn thanh toán VNPay', NULL, CAST(N'2026-02-26T22:10:05.657' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (22, 11, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-27T00:20:31.580' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (23, 12, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-27T00:27:51.807' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (24, 11, N'CHO_THANH_TOAN', N'DA_HUY', N'Tự động hủy - quá hạn thanh toán VNPay', NULL, CAST(N'2026-02-27T11:58:14.247' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (25, 12, N'CHO_THANH_TOAN', N'DA_HUY', N'Tự động hủy - quá hạn thanh toán VNPay', NULL, CAST(N'2026-02-27T11:58:14.307' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (26, 13, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-27T13:07:25.660' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (27, 14, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-27T15:10:52.800' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (28, 14, N'CHO_THANH_TOAN', N'DA_HUY', N'Tự động hủy - quá hạn thanh toán VNPay', NULL, CAST(N'2026-02-27T15:42:20.563' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (29, 15, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-27T15:42:44.333' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (30, 15, N'CHO_THANH_TOAN', N'DA_THANH_TOAN', N'Thanh toan VNPay thanh cong. Ma giao dich: 15433360', NULL, CAST(N'2026-02-27T15:43:30.783' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (31, 9, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 1, CAST(N'2026-02-27T20:00:03.863' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (32, 9, N'DANG_XU_LY', N'DANG_GIAO', N'', 1, CAST(N'2026-02-27T20:00:07.777' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (33, 15, N'DA_THANH_TOAN', N'CHO_XAC_NHAN', N'', 1, CAST(N'2026-02-27T20:28:40.277' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (34, 15, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, CAST(N'2026-02-27T20:28:42.103' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (35, 15, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 1, CAST(N'2026-02-27T20:28:44.040' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (36, 15, N'DANG_XU_LY', N'DANG_GIAO', N'', 1, CAST(N'2026-02-27T20:28:45.267' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (37, 13, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, CAST(N'2026-02-27T20:29:03.283' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (38, 13, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 1, CAST(N'2026-02-27T20:29:05.140' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (39, 13, N'DANG_XU_LY', N'DANG_GIAO', N'', 1, CAST(N'2026-02-27T20:29:05.793' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (40, 6, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 1, CAST(N'2026-02-27T20:29:09.640' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (41, 6, N'DANG_XU_LY', N'DANG_GIAO', N'', 1, CAST(N'2026-02-27T20:29:11.620' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (42, 4, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, CAST(N'2026-02-27T20:29:19.420' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (43, 13, N'DANG_GIAO', N'HOAN_TAT', N'', 1, CAST(N'2026-02-27T20:35:46.677' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (44, 15, N'DANG_GIAO', N'HOAN_TAT', N'', 1, CAST(N'2026-02-27T20:35:48.753' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (45, 4, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 1, CAST(N'2026-02-27T20:35:53.163' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (46, 16, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-28T00:06:07.657' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (47, 17, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, CAST(N'2026-02-28T00:07:53.373' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (48, 17, N'CHO_XAC_NHAN', N'DA_HUY', N'Khách hủy: Khách hàng tự hủy', 9, CAST(N'2026-02-28T00:07:57.507' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (49, 16, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 2, CAST(N'2026-02-28T00:32:04.907' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (50, 18, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 10, CAST(N'2026-02-28T11:20:07.417' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (51, 19, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 10, CAST(N'2026-02-28T11:21:55.753' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (52, 19, N'CHO_THANH_TOAN', N'DA_THANH_TOAN', N'Thanh toan VNPay thanh cong. Ma giao dich: 15433961', NULL, CAST(N'2026-02-28T11:22:51.943' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (53, 19, N'DA_THANH_TOAN', N'CHO_XAC_NHAN', N'', 1, CAST(N'2026-02-28T11:24:43.543' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (54, 19, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, CAST(N'2026-02-28T11:24:44.890' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (55, 19, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 1, CAST(N'2026-02-28T11:24:46.810' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (56, 19, N'DANG_XU_LY', N'DANG_GIAO', N'', 1, CAST(N'2026-02-28T11:24:47.660' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (57, 19, N'DANG_GIAO', N'HOAN_TAT', N'', 1, CAST(N'2026-02-28T11:24:48.343' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (58, 16, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 2, CAST(N'2026-02-28T11:27:17.713' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (59, 18, N'CHO_THANH_TOAN', N'DA_HUY', N'Tự động hủy - quá hạn thanh toán VNPay', NULL, CAST(N'2026-02-28T11:36:08.257' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (60, 16, N'DANG_XU_LY', N'DANG_GIAO', N'', 2, CAST(N'2026-02-28T11:37:09.903' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (61, 20, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 10, CAST(N'2026-02-28T11:39:59.810' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (62, 20, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 2, CAST(N'2026-02-28T11:40:06.747' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (63, 20, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 2, CAST(N'2026-02-28T11:40:12.483' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (64, 20, N'DANG_XU_LY', N'DANG_GIAO', N'', 2, CAST(N'2026-02-28T11:40:23.877' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (65, 20, N'DANG_XU_LY', N'DANG_GIAO', N'', 2, CAST(N'2026-02-28T11:40:23.903' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (66, 20, N'DANG_GIAO', N'HOAN_TAT', N'', 2, CAST(N'2026-02-28T11:40:25.337' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (67, 21, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 10, CAST(N'2026-02-28T11:46:46.140' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (68, 21, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 2, CAST(N'2026-02-28T11:46:53.217' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (69, 21, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 2, CAST(N'2026-02-28T11:46:55.383' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (70, 21, N'DANG_XU_LY', N'DANG_GIAO', N'', 2, CAST(N'2026-02-28T11:46:57.307' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (71, 21, N'DANG_XU_LY', N'DANG_GIAO', N'', 2, CAST(N'2026-02-28T11:46:57.373' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (72, 21, N'DANG_GIAO', N'HOAN_TAT', N'', 2, CAST(N'2026-02-28T11:46:58.880' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (73, 22, NULL, N'CHO_THANH_TOAN', N'Đặt hàng thành công', 10, CAST(N'2026-02-28T12:09:34.643' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (74, 22, N'CHO_THANH_TOAN', N'DA_THANH_TOAN', N'Thanh toán VNPay thành công. Mã giao dịch: 15433982', NULL, CAST(N'2026-02-28T12:10:19.667' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (75, 22, N'DA_THANH_TOAN', N'CHO_XAC_NHAN', N'', 1, CAST(N'2026-02-28T12:10:34.327' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (76, 22, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 1, CAST(N'2026-02-28T12:10:36.737' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (77, 22, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 1, CAST(N'2026-02-28T12:10:37.827' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (78, 22, N'DANG_XU_LY', N'DANG_GIAO', N'', 1, CAST(N'2026-02-28T12:10:38.687' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (79, 22, N'DANG_GIAO', N'HOAN_TAT', N'', 1, CAST(N'2026-02-28T12:10:39.483' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (80, 23, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 10, CAST(N'2026-02-28T12:12:26.857' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (81, 23, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 2, CAST(N'2026-02-28T12:12:33.263' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (82, 23, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 2, CAST(N'2026-02-28T12:12:36.637' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (83, 23, N'DANG_XU_LY', N'DANG_GIAO', N'', 2, CAST(N'2026-02-28T12:12:38.157' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (84, 23, N'DANG_GIAO', N'HOAN_TAT', N'', 2, CAST(N'2026-02-28T12:12:39.870' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (85, 24, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 10, CAST(N'2026-02-28T12:12:58.750' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (86, 24, N'CHO_XAC_NHAN', N'DA_XAC_NHAN', N'', 2, CAST(N'2026-02-28T12:13:06.887' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (87, 24, N'DA_XAC_NHAN', N'DANG_XU_LY', N'', 2, CAST(N'2026-02-28T12:13:08.493' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (88, 24, N'DANG_XU_LY', N'DANG_GIAO', N'', 2, CAST(N'2026-02-28T12:13:10.097' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (89, 24, N'DANG_GIAO', N'HOAN_TAT', N'', 2, CAST(N'2026-02-28T12:13:11.733' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (90, 25, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 9, CAST(N'2026-03-03T23:43:20.503' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (91, 26, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T22:46:46.617' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (92, 26, N'HOA_DON_CHO', N'HOAN_TAT', N'Thanh toán tại quầy - TIEN_MAT', 2, CAST(N'2026-03-21T22:47:28.903' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (93, 27, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T23:10:42.500' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (94, 28, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T23:11:01.623' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (95, 27, N'HOA_DON_CHO', N'DA_HUY', N'Hủy hóa đơn chờ', 2, CAST(N'2026-03-21T23:11:08.250' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (96, 28, N'HOA_DON_CHO', N'HOAN_TAT', N'Thanh toán tại quầy - TIEN_MAT', 2, CAST(N'2026-03-21T23:11:33.800' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (97, 29, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T23:12:01.503' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (98, 30, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T23:12:03.290' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (99, 29, N'HOA_DON_CHO', N'HOAN_TAT', N'Thanh toán tại quầy - TIEN_MAT', 2, CAST(N'2026-03-21T23:12:33.343' AS DateTime))
GO
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (100, 30, N'HOA_DON_CHO', N'DA_HUY', N'Hủy hóa đơn chờ', 2, CAST(N'2026-03-21T23:28:27.373' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (101, 31, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T23:28:32.313' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (102, 31, N'HOA_DON_CHO', N'HOAN_TAT', N'Thanh toán tại quầy - TIEN_MAT', 2, CAST(N'2026-03-21T23:28:57.153' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (103, 32, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T23:29:32.370' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (104, 32, N'HOA_DON_CHO', N'HOAN_TAT', N'Thanh toán tại quầy - CHUYEN_KHOAN', 2, CAST(N'2026-03-21T23:29:45.397' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (105, 33, NULL, N'HOA_DON_CHO', N'Tạo hóa đơn chờ tại quầy', 2, CAST(N'2026-03-21T23:29:51.737' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (106, 33, N'HOA_DON_CHO', N'HOAN_TAT', N'Thanh toán tại quầy - TIEN_MAT', 2, CAST(N'2026-03-21T23:30:03.343' AS DateTime))
INSERT [dbo].[LichSuTrangThaiDon] ([Id], [DonHangId], [TrangThaiCu], [TrangThaiMoi], [GhiChu], [NguoiThayDoiId], [ThoiGian]) VALUES (107, 34, NULL, N'CHO_XAC_NHAN', N'Đặt hàng thành công', 10, CAST(N'2026-03-22T10:20:06.710' AS DateTime))
SET IDENTITY_INSERT [dbo].[LichSuTrangThaiDon] OFF
GO
SET IDENTITY_INSERT [dbo].[MauSac] ON 

INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (1, N'Đen', N'#212121', N'Đen cơ bản nhiều')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (2, N'Trắng', N'#FFFFFF', N'Trắng tinh')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (3, N'Xanh navy', N'#1A237E', N'Xanh đậm navy')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (4, N'Xám', N'#757575', N'Xám trung tính')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (5, N'Đỏ', N'#C62828', N'Đỏ đậm')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (6, N'Xanh lá', N'#2E7D32', N'Xanh lá đậm')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (7, N'Be', N'#F5F5DC', N'Màu be kem')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (8, N'Màu đỏ nhạt', N'#6c1e1e', N'')
SET IDENTITY_INSERT [dbo].[MauSac] OFF
GO
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (1, N'admin', N'admin@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Quản trị viên', N'0901000001', NULL, 1, NULL, 1, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (2, N'nhanvien01', N'nv01@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Trần Văn Nam', N'0901000002', NULL, 1, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (3, N'nhanvien02', N'nv02@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Nguyễn Thị Lan', N'0901000003', NULL, 0, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (4, N'khachhang01', N'kh01@test.com', N'$2a$10$KEELnfLt9gPU61.1jwyzhOxfes0qPrlUKJIdKinBE9PhtWX4ahHje', N'KH Test 01', N'0987654321', NULL, 1, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), CAST(N'2026-03-21T23:42:29.577' AS DateTime), 1, NULL, CAST(N'2026-02-25T16:25:46.470' AS DateTime), NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (5, N'khachhang02', N'kh02@gmail.com', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Phạm Thị Mai', N'0987654321', NULL, 0, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), CAST(N'2026-03-21T23:42:33.397' AS DateTime), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (6, N'testuser5', N'test5@test.com', N'$2a$10$UAL4Z7JegNQSkuf.Gxwh0ewd9ykhRbKnrf8EPVEqqlPHcOTzTbSwO', N'Test User 5', NULL, NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-25T15:59:53.070' AS DateTime), CAST(N'2026-03-22T00:24:39.937' AS DateTime), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (7, N'testqc01', N'testqc01@test.com', N'$2a$10$IE1VI1KqaZySIEvtR4kqQOfebnr18TdP2ssSeeYGbU3tlH.6Nts3S', N'Test QC User', NULL, NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-25T16:00:19.923' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (8, N'testnv_qc', N'testnv_qc@test.com', N'$2a$10$FdkyhBP4v.hzULRcoSQQr.5e8DkWHUnXNApFUrFzy5mB.bL9hrKty', N'NV QC Test', N'0999888777', NULL, NULL, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-25T16:20:30.923' AS DateTime), CAST(N'2026-02-28T08:41:14.607' AS DateTime), 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (9, N'kien1', N'kien1@gmail.com', N'$2a$10$qcxiYAuII5NrvYE7RAzyr.0pciJONtPF74hkpB4tekCvZt7ZbEcZu', N'trung kien', N'0956651738', NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-25T17:02:28.253' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (10, N'kiennct', N'kiennct2711.it@gmail.com', N'$2a$10$urRsBB.wIQFPgU4lTrdpjOa.eYTRgsLRIDK4HqmLI6f3D/VgO5mfy', N'Nguyễn Cao Trung Kien', N'0967674587', NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-26T20:24:00.130' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (11, N'kiennguyen', N'kiennguyenfpt2711@gmail.com', N'$2a$10$TNC5L3rXJkGwohcZMTNEoucfEEmg1uD2SmdfT/n1okA.qI5p.0uca', N'kiennguyen', N'0567451637', NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-26T20:46:34.623' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (12, N'ducanh01', N'hoducanh204@gmail.com', N'$2a$10$n0zv4HHg8IVW19DX3ZI6HexpvRq1b0RICMYL4qdnzG0smEQ2P5H3.', N'Đức Anh', N'0964641839', NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-26T21:07:27.523' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (13, N'kiennct1', N'kientrungak@gmail.com', N'$2a$10$wX1fqpOBpxRrwhFGtqr4AOOiZhjoWFWvuv4Un0dDTrBAS0SP6g.l2', N'Nguyễn Cao Trung Kiên', N'0965651738', NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-28T08:38:52.570' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (14, N'kien2', N'kiennct2i11.it@gmail.com', N'$2a$10$Mr6t0UALDiHOvYQVj3IhWu1MJl5agunHSS1.EICrTjIaUpWh3WMv2', N'kien', N'0967671536', NULL, NULL, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-03-06T00:07:21.650' AS DateTime), CAST(N'2026-03-06T00:07:38.647' AS DateTime), 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (15, N'1', N'1', N'$2a$10$zCGbzjZVgwyBMn4AzyTA4uOqi8dNMui0/J1o7eQQp3gqY12O2u7Iy', N'1', NULL, NULL, NULL, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-03-06T00:07:45.513' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (16, N'test@gmail.com', N'1test@gmail.com', N'$2a$10$8ooEule.Dfq.BQXtEieU2uQIZjzMAQWOgCH1gciaNP1OKzbHZJc7u', N'tesst', N'', NULL, NULL, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-03-21T23:42:11.827' AS DateTime), NULL, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (17, N'nhanvien03', N'kientrufsafasngak@gmail.com', N'$2a$10$7dUy5HLTr01YQk95UfiYgOs.nPFE5oQDWv1kJ6OxpnNRDxwJb7S4O', N'sấ', NULL, CAST(N'2026-03-27' AS Date), 1, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-03-22T00:23:28.967' AS DateTime), CAST(N'2026-03-22T00:23:29.057' AS DateTime), 1, NULL, NULL, NULL, N'NV00017')
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (18, N'13131', N'kienfasfas@gmail.com', N'$2a$10$VtKrKNEV9k5.WM95wnY0FOTwyLEH1aOUBn76jYWKqqECwCIxIRbOu', N'Trung kiên test', N'0956571839', NULL, 1, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-03-22T10:19:42.493' AS DateTime), CAST(N'2026-03-22T10:19:42.517' AS DateTime), 1, NULL, NULL, NULL, N'KH00018')
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (19, N'kientest1', N'kientest1@gmail.com', N'$2a$10$M39S5RTD4s/MwbUaDs48J.6VC1Ccr8r00gwIJ724dirND0EqnYAo2', N'Kiên test', NULL, NULL, 1, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-03-22T10:21:16.407' AS DateTime), CAST(N'2026-03-22T10:21:16.427' AS DateTime), 1, NULL, NULL, NULL, N'NV00019')
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (20, N'kientest', N'kientest10@gmail.com', N'$2a$10$cnFN59JtDeIWmrkzKKJiW.UaUNPelyCWFS6Q6W/fKm.WqnqKEEbAG', N'Trung kiên nguyễn', NULL, NULL, 1, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-03-22T10:23:52.607' AS DateTime), CAST(N'2026-03-22T10:24:21.357' AS DateTime), 1, NULL, NULL, NULL, N'KH00020')
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi], [CCCD], [MaNguoiDung]) VALUES (21, N'ducanh', N'ducanh@gmail.com', N'$2a$10$iPB/B.rhUiH3xEyYROBlMuwaeoAuQDxlCJrJhl5FggjEPemLpG20O', N'đức anh', NULL, NULL, 1, NULL, 2, N'DA_XOA', NULL, CAST(N'2026-03-22T10:25:31.003' AS DateTime), CAST(N'2026-03-22T10:25:54.160' AS DateTime), 0, NULL, NULL, NULL, N'NV00021')
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (1, N'SP001', N'Áo thun Certain Basic Beautiful', N'Áo cotton cổ tròn màu trơn basic.', CAST(299000.00 AS Decimal(18, 2)), CAST(299000.00 AS Decimal(18, 2)), 1, 1, N'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500&h=500&fit=crop', N'ao-thun-certain-basic-beautiful', N'NGUNG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), CAST(N'2026-02-28T10:27:20.017' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (2, N'SP002', N'Áo thun Certain Graphic', N'Áo thun in hình graphic bold.', CAST(349000.00 AS Decimal(18, 2)), CAST(319000.00 AS Decimal(18, 2)), 1, 1, N'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=500&h=500&fit=crop', N'ao-thun-certain-graphic', N'NGUNG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), CAST(N'2026-02-28T10:27:21.863' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (3, N'SP003', N'Áo polo Certain Classic', N'Áo polo cổ bẻ sang trọng.', CAST(450000.00 AS Decimal(18, 2)), CAST(399000.00 AS Decimal(18, 2)), 2, 1, N'https://images.unsplash.com/photo-1625910513413-5fc45e80fd05?w=500&h=500&fit=crop', N'ao-polo-certain-classic', N'NGUNG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), CAST(N'2026-02-28T10:27:23.687' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (4, N'SP004', N'Áo thun Nike Dri-FIT', N'Công nghệ Dri-FIT thấm hút mồ hôi.', CAST(599000.00 AS Decimal(18, 2)), CAST(549000.00 AS Decimal(18, 2)), 1, 2, N'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=500&h=500&fit=crop', N'ao-thun-nike-drifit', N'NGUNG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), CAST(N'2026-02-28T10:27:25.387' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (7, N'SP007', N'Áo thun Puma Essential', N'Áo thun polo Puma đơn giản.', CAST(399000.00 AS Decimal(18, 2)), CAST(359000.00 AS Decimal(18, 2)), 1, 4, N'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=500&h=500&fit=crop', N'ao-thun-puma', N'NGUNG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), CAST(N'2026-02-28T10:27:27.007' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (9, NULL, N'Test QC Product', N'Mo ta test', CAST(100000.00 AS Decimal(18, 2)), NULL, 1, NULL, NULL, NULL, N'NGUNG_BAN', CAST(N'2026-02-25T16:20:30.993' AS DateTime), CAST(N'2026-02-28T10:27:17.810' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (10, NULL, N'Áo thun cổ lọ', N'', CAST(400000.00 AS Decimal(18, 2)), CAST(400000.00 AS Decimal(18, 2)), 1, 1, N'/uploads/images/b3f9995e-c7d5-4209-93fd-2e7b474d1b6d_sg-11134201-22100-3od0skjhwviv74.jpg', N'ao-thun-co-lo', N'NGUNG_BAN', CAST(N'2026-02-26T20:18:48.023' AS DateTime), CAST(N'2026-02-28T10:27:15.547' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (11, NULL, N'Áo thun niken test hhuh', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(500000.00 AS Decimal(18, 2)), 2, 2, N'/uploads/images/1b256183-cb80-4771-87c7-e850237fe0fd_bd0c2592f5a37bfd22b2.jpg', N'ao-thun-niken-test-hhuh', N'NGUNG_BAN', CAST(N'2026-02-26T21:10:31.323' AS DateTime), CAST(N'2026-02-28T10:27:12.933' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (13, NULL, N'SP Test haha', N'test', CAST(700000.00 AS Decimal(18, 2)), CAST(700000.00 AS Decimal(18, 2)), 1, 2, N'/uploads/images/db42ea4e-2b35-4b56-93f4-15b59a0e6f65_d5bd60efb1de3f8066cf.jpg', N'sp-test-haha', N'NGUNG_BAN', CAST(N'2026-02-27T23:16:22.723' AS DateTime), CAST(N'2026-02-28T10:27:09.917' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (15, NULL, N'Áo thun cổ tròn đẹp vãi', N'Áo thun đẹp', CAST(700000.00 AS Decimal(18, 2)), CAST(700000.00 AS Decimal(18, 2)), 2, 2, N'/uploads/images/7b2753de-49ba-421a-9328-552649393b0a_605293301_2719899281690169_5562315521143959385_n.jpg', N'ao-thun-co-tron-dep-vai', N'NGUNG_BAN', CAST(N'2026-02-28T10:28:06.793' AS DateTime), CAST(N'2026-02-28T11:52:41.000' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (16, NULL, N'Áo polo test', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(500000.00 AS Decimal(18, 2)), 2, 1, N'/uploads/images/6c914ec1-af41-4621-9c80-29aa39b3a12f_pngtree-white-sport-polo-shirt-mockup-hanging-png-file-png-image_11588389.png', N'ao-polo-test', N'DANG_BAN', CAST(N'2026-02-28T11:38:39.553' AS DateTime), CAST(N'2026-02-28T11:39:28.957' AS DateTime), 1)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (17, NULL, N'fsafsafas', N'', CAST(500000.00 AS Decimal(18, 2)), CAST(500000.00 AS Decimal(18, 2)), 1, 1, N'/uploads/images/38fbb3cb-9ff9-421e-8842-a0bf6cdef99c_d5bd60efb1de3f8066cf.jpg', N'fsafsafas', N'NGUNG_BAN', CAST(N'2026-02-28T11:46:06.087' AS DateTime), CAST(N'2026-02-28T11:51:08.113' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (18, NULL, N'Áo thun cổ tròn đẹp đẽ test', N'', CAST(600000.00 AS Decimal(18, 2)), CAST(600000.00 AS Decimal(18, 2)), 1, 1, N'/uploads/images/8d8f54e8-2f83-4fc1-8bc9-09027bcdd8d0_d5bd60efb1de3f8066cf.jpg', N'ao-thun-co-tron-dep-de-test', N'NGUNG_BAN', CAST(N'2026-02-28T11:53:18.170' AS DateTime), CAST(N'2026-02-28T12:06:04.827' AS DateTime), 0)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat], [TrangThai]) VALUES (19, NULL, N'Áo thun đẹp cổ tròn đẹp test', N'', CAST(600000.00 AS Decimal(18, 2)), CAST(600000.00 AS Decimal(18, 2)), 1, 1, N'/uploads/images/8dfd92b8-980c-459f-bd7b-36f2b29b7169_605293301_2719899281690169_5562315521143959385_n.jpg', N'ao-thun-dep-co-tron-dep-test', N'DANG_BAN', CAST(N'2026-02-28T12:06:26.117' AS DateTime), CAST(N'2026-02-28T12:08:03.743' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] ON 

INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (1, N'Certain', N'Thương hiệu in-house', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (2, N'Nike', N'Thương hiệu thể thao Mỹ', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (3, N'Adidas', N'Thương hiệu thể thao Đức', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (4, N'Puma', N'Thương hiệu thể thao Đức', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (5, N'Test ', N'Test', 1, CAST(N'2026-02-27T20:50:55.833' AS DateTime))
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (1, N'ADMIN', NULL)
INSERT [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (2, N'NHAN_VIEN', NULL)
INSERT [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (3, N'KHACH_HANG', NULL)
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
SET IDENTITY_INSERT [dbo].[Voucher] ON 

INSERT [dbo].[Voucher] ([Id], [MaVoucher], [MoTa], [TrangThai], [NgayBatDau], [NgayKetThuc], [GiaTriToiThieu], [LoaiGiam], [GiaTriGiam], [GiaTriGiamToiDa], [SoLuongSuDung], [SoLuongToiDa], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, N'SUMMER2026', N'Khuyến mãi hè 2026 - Giảm 20% tối da 50.000d', 1, CAST(N'2026-05-31T00:00:00.000' AS DateTime), CAST(N'2026-08-31T23:59:59.000' AS DateTime), CAST(200000.00 AS Decimal(18, 2)), N'PERCENT', CAST(20.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), 0, 100, CAST(N'2026-02-27T23:46:27.757' AS DateTime), CAST(N'2026-02-28T11:26:25.097' AS DateTime))
INSERT [dbo].[Voucher] ([Id], [MaVoucher], [MoTa], [TrangThai], [NgayBatDau], [NgayKetThuc], [GiaTriToiThieu], [LoaiGiam], [GiaTriGiam], [GiaTriGiamToiDa], [SoLuongSuDung], [SoLuongToiDa], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, N'FLASHSALE', N'Chương trình Năm mới 2026 - Giảm 12%', 1, CAST(N'2026-02-21T00:00:00.000' AS DateTime), CAST(N'2026-02-28T23:59:59.000' AS DateTime), CAST(100000.00 AS Decimal(18, 2)), N'PERCENT', CAST(15.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), 0, 100, CAST(N'2026-02-27T23:46:27.763' AS DateTime), CAST(N'2026-02-28T11:55:38.897' AS DateTime))
INSERT [dbo].[Voucher] ([Id], [MaVoucher], [MoTa], [TrangThai], [NgayBatDau], [NgayKetThuc], [GiaTriToiThieu], [LoaiGiam], [GiaTriGiam], [GiaTriGiamToiDa], [SoLuongSuDung], [SoLuongToiDa], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, N'BIRTHDAY50K', N'Quà sinh nhật - Giảm 50.000d', 1, CAST(N'2025-12-30T00:00:00.000' AS DateTime), CAST(N'2026-12-31T23:59:59.000' AS DateTime), CAST(0.00 AS Decimal(18, 2)), N'FIXED', CAST(50000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), 0, 1005, CAST(N'2026-02-27T23:46:27.763' AS DateTime), CAST(N'2026-02-28T00:01:51.840' AS DateTime))
INSERT [dbo].[Voucher] ([Id], [MaVoucher], [MoTa], [TrangThai], [NgayBatDau], [NgayKetThuc], [GiaTriToiThieu], [LoaiGiam], [GiaTriGiam], [GiaTriGiamToiDa], [SoLuongSuDung], [SoLuongToiDa], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, N'NEWYEAR2026', N'Chuong trình Nam m?i - Gi?m 12%', 0, CAST(N'2026-01-01T00:00:00.000' AS DateTime), CAST(N'2026-01-31T23:59:59.000' AS DateTime), CAST(150000.00 AS Decimal(18, 2)), N'PERCENT', CAST(12.00 AS Decimal(18, 2)), CAST(100000.00 AS Decimal(18, 2)), 0, 500, CAST(N'2026-02-27T23:46:27.763' AS DateTime), CAST(N'2026-02-28T00:01:57.780' AS DateTime))
INSERT [dbo].[Voucher] ([Id], [MaVoucher], [MoTa], [TrangThai], [NgayBatDau], [NgayKetThuc], [GiaTriToiThieu], [LoaiGiam], [GiaTriGiam], [GiaTriGiamToiDa], [SoLuongSuDung], [SoLuongToiDa], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, N'TEST', N'', 1, CAST(N'2026-02-27T00:00:00.000' AS DateTime), CAST(N'2026-03-07T23:59:59.000' AS DateTime), NULL, N'PERCENT', CAST(10.00 AS Decimal(18, 2)), CAST(20000.00 AS Decimal(18, 2)), 0, 10, CAST(N'2026-02-28T12:04:51.357' AS DateTime), CAST(N'2026-02-28T12:05:00.673' AS DateTime))
INSERT [dbo].[Voucher] ([Id], [MaVoucher], [MoTa], [TrangThai], [NgayBatDau], [NgayKetThuc], [GiaTriToiThieu], [LoaiGiam], [GiaTriGiam], [GiaTriGiamToiDa], [SoLuongSuDung], [SoLuongToiDa], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, N'FRIDAY2028', N'test', 1, CAST(N'2026-02-27T00:00:00.000' AS DateTime), CAST(N'2026-03-12T23:59:59.000' AS DateTime), NULL, N'PERCENT', CAST(10.00 AS Decimal(18, 2)), CAST(501000.00 AS Decimal(18, 2)), 0, 10, CAST(N'2026-02-28T12:11:48.780' AS DateTime), CAST(N'2026-02-28T12:11:55.807' AS DateTime))
SET IDENTITY_INSERT [dbo].[Voucher] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DonHang__129584ACC197B2DD]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[DonHang] ADD UNIQUE NONCLUSTERED 
(
	[MaDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__GioHang__C4BBA4BCC3475415]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[GioHang] ADD UNIQUE NONCLUSTERED 
(
	[NguoiDungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UK1wgot3ffx6wdi1fh2osxdwfya]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[GioHangChiTiet] ADD  CONSTRAINT [UK1wgot3ffx6wdi1fh2osxdwfya] UNIQUE NONCLUSTERED 
(
	[GioHangId] ASC,
	[BienTheId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_GioHang_BienThe]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[GioHangChiTiet] ADD  CONSTRAINT [UQ_GioHang_BienThe] UNIQUE NONCLUSTERED 
(
	[GioHangId] ASC,
	[BienTheId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__KhuyenMa__6F56B3BC28007620]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[KhuyenMai] ADD UNIQUE NONCLUSTERED 
(
	[MaKhuyenMai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_o0s268lrp9is6o1e4ek6m1lc6]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_majqh5g4djy2tp3p9dvr64brp]    Script Date: 3/22/2026 11:23:13 AM ******/
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NguoiDun__55F68FC0CC6B2ABE]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[NguoiDung] ADD UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NguoiDun__A9D10534419755E6]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[NguoiDung] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__VaiTro__1DA55814DA251CC4]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[VaiTro] ADD UNIQUE NONCLUSTERED 
(
	[TenVaiTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Voucher__0AAC5B105CC9A8EB]    Script Date: 3/22/2026 11:23:13 AM ******/
ALTER TABLE [dbo].[Voucher] ADD UNIQUE NONCLUSTERED 
(
	[MaVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Voucher_MaVoucher]    Script Date: 3/22/2026 11:23:13 AM ******/
CREATE NONCLUSTERED INDEX [IX_Voucher_MaVoucher] ON [dbo].[Voucher]
(
	[MaVoucher] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Voucher_NgayHoatDong]    Script Date: 3/22/2026 11:23:13 AM ******/
CREATE NONCLUSTERED INDEX [IX_Voucher_NgayHoatDong] ON [dbo].[Voucher]
(
	[NgayBatDau] ASC,
	[NgayKetThuc] ASC,
	[TrangThai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BienThe] ADD  DEFAULT ((0)) FOR [SoLuongTon]
GO
ALTER TABLE [dbo].[BienThe] ADD  DEFAULT ((0)) FOR [MacDinh]
GO
ALTER TABLE [dbo].[BienThe] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[BienThe] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[ChiTietDonHang] ADD  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[DanhGia] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[DanhGia] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[DanhMuc] ADD  DEFAULT ((0)) FOR [ThuTuHienThi]
GO
ALTER TABLE [dbo].[DanhMuc] ADD  DEFAULT ((1)) FOR [DangHoatDong]
GO
ALTER TABLE [dbo].[DanhMuc] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[DiaChiNguoiDung] ADD  DEFAULT ((0)) FOR [LaMacDinh]
GO
ALTER TABLE [dbo].[DiaChiNguoiDung] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ('CHO_XAC_NHAN') FOR [TrangThaiDonHang]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [SoTienGiamGia]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [PhiVanChuyen]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [TongTienThanhToan]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT ((0)) FOR [DaThanhToan]
GO
ALTER TABLE [dbo].[DonHang] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[GioHang] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[GioHangChiTiet] ADD  DEFAULT ((1)) FOR [SoLuong]
GO
ALTER TABLE [dbo].[GioHangChiTiet] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[HinhAnhBienThe] ADD  DEFAULT ((0)) FOR [LaAnhChinh]
GO
ALTER TABLE [dbo].[HinhAnhBienThe] ADD  DEFAULT ((0)) FOR [ThuTu]
GO
ALTER TABLE [dbo].[HinhAnhBienThe] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[KhuyenMai] ADD  DEFAULT ('PHAN_TRAM') FOR [LoaiGiam]
GO
ALTER TABLE [dbo].[KhuyenMai] ADD  DEFAULT ((0)) FOR [DonHangToiThieu]
GO
ALTER TABLE [dbo].[KhuyenMai] ADD  DEFAULT ((0)) FOR [SoLuongDaDung]
GO
ALTER TABLE [dbo].[KhuyenMai] ADD  DEFAULT ('DANG_HOAT_DONG') FOR [TrangThaiKhuyenMai]
GO
ALTER TABLE [dbo].[KhuyenMai] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[KichThuoc] ADD  DEFAULT ((0)) FOR [ThuTu]
GO
ALTER TABLE [dbo].[LichSuTrangThaiDon] ADD  DEFAULT (getdate()) FOR [ThoiGian]
GO
ALTER TABLE [dbo].[NguoiDung] ADD  DEFAULT ('HOAT_DONG') FOR [TrangThai]
GO
ALTER TABLE [dbo].[NguoiDung] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[NguoiDung] ADD  DEFAULT ((1)) FOR [DangHoatDong]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT ('DANG_BAN') FOR [TrangThaiSanPham]
GO
ALTER TABLE [dbo].[SanPham] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[ThuongHieu] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[ThuongHieu] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT ((1)) FOR [TrangThai]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT ((0)) FOR [SoLuongSuDung]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT (getdate()) FOR [ThoiGianTao]
GO
ALTER TABLE [dbo].[Voucher] ADD  DEFAULT (getdate()) FOR [ThoiGianCapNhat]
GO
ALTER TABLE [dbo].[BienThe]  WITH CHECK ADD  CONSTRAINT [FK_BienThe_ChatLieu] FOREIGN KEY([ChatLieuId])
REFERENCES [dbo].[ChatLieu] ([Id])
GO
ALTER TABLE [dbo].[BienThe] CHECK CONSTRAINT [FK_BienThe_ChatLieu]
GO
ALTER TABLE [dbo].[BienThe]  WITH CHECK ADD  CONSTRAINT [FK_BienThe_KichThuoc] FOREIGN KEY([KichThuocId])
REFERENCES [dbo].[KichThuoc] ([Id])
GO
ALTER TABLE [dbo].[BienThe] CHECK CONSTRAINT [FK_BienThe_KichThuoc]
GO
ALTER TABLE [dbo].[BienThe]  WITH CHECK ADD  CONSTRAINT [FK_BienThe_MauSac] FOREIGN KEY([MauSacId])
REFERENCES [dbo].[MauSac] ([Id])
GO
ALTER TABLE [dbo].[BienThe] CHECK CONSTRAINT [FK_BienThe_MauSac]
GO
ALTER TABLE [dbo].[BienThe]  WITH CHECK ADD  CONSTRAINT [FK_BienThe_SanPham] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[SanPham] ([Id])
GO
ALTER TABLE [dbo].[BienThe] CHECK CONSTRAINT [FK_BienThe_SanPham]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CTDH_BienThe] FOREIGN KEY([BienTheId])
REFERENCES [dbo].[BienThe] ([Id])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CTDH_BienThe]
GO
ALTER TABLE [dbo].[ChiTietDonHang]  WITH CHECK ADD  CONSTRAINT [FK_CTDH_DonHang] FOREIGN KEY([DonHangId])
REFERENCES [dbo].[DonHang] ([Id])
GO
ALTER TABLE [dbo].[ChiTietDonHang] CHECK CONSTRAINT [FK_CTDH_DonHang]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_CTDonHang] FOREIGN KEY([ChiTietDonHangId])
REFERENCES [dbo].[ChiTietDonHang] ([Id])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_CTDonHang]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_NguoiDung] FOREIGN KEY([NguoiDungId])
REFERENCES [dbo].[NguoiDung] ([Id])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_NguoiDung]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_SanPham] FOREIGN KEY([SanPhamId])
REFERENCES [dbo].[SanPham] ([Id])
GO
ALTER TABLE [dbo].[DanhGia] CHECK CONSTRAINT [FK_DanhGia_SanPham]
GO
ALTER TABLE [dbo].[DiaChiNguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_DiaChi_NguoiDung] FOREIGN KEY([NguoiDungId])
REFERENCES [dbo].[NguoiDung] ([Id])
GO
ALTER TABLE [dbo].[DiaChiNguoiDung] CHECK CONSTRAINT [FK_DiaChi_NguoiDung]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_KhuyenMai] FOREIGN KEY([KhuyenMaiId])
REFERENCES [dbo].[KhuyenMai] ([Id])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_KhuyenMai]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_NguoiDung] FOREIGN KEY([NguoiDungId])
REFERENCES [dbo].[NguoiDung] ([Id])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_NguoiDung]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_NhanVien] FOREIGN KEY([NhanVienId])
REFERENCES [dbo].[NguoiDung] ([Id])
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_NhanVien]
GO
ALTER TABLE [dbo].[DonHang]  WITH CHECK ADD  CONSTRAINT [FK_DonHang_Voucher] FOREIGN KEY([VoucherId])
REFERENCES [dbo].[Voucher] ([Id])
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[DonHang] CHECK CONSTRAINT [FK_DonHang_Voucher]
GO
ALTER TABLE [dbo].[GioHang]  WITH CHECK ADD  CONSTRAINT [FK_GioHang_NguoiDung] FOREIGN KEY([NguoiDungId])
REFERENCES [dbo].[NguoiDung] ([Id])
GO
ALTER TABLE [dbo].[GioHang] CHECK CONSTRAINT [FK_GioHang_NguoiDung]
GO
ALTER TABLE [dbo].[GioHangChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GHCT_BienThe] FOREIGN KEY([BienTheId])
REFERENCES [dbo].[BienThe] ([Id])
GO
ALTER TABLE [dbo].[GioHangChiTiet] CHECK CONSTRAINT [FK_GHCT_BienThe]
GO
ALTER TABLE [dbo].[GioHangChiTiet]  WITH CHECK ADD  CONSTRAINT [FK_GHCT_GioHang] FOREIGN KEY([GioHangId])
REFERENCES [dbo].[GioHang] ([Id])
GO
ALTER TABLE [dbo].[GioHangChiTiet] CHECK CONSTRAINT [FK_GHCT_GioHang]
GO
ALTER TABLE [dbo].[HinhAnhBienThe]  WITH CHECK ADD  CONSTRAINT [FK_HinhAnh_BienThe] FOREIGN KEY([BienTheId])
REFERENCES [dbo].[BienThe] ([Id])
GO
ALTER TABLE [dbo].[HinhAnhBienThe] CHECK CONSTRAINT [FK_HinhAnh_BienThe]
GO
ALTER TABLE [dbo].[LichSuTrangThaiDon]  WITH CHECK ADD  CONSTRAINT [FK_LSTD_DonHang] FOREIGN KEY([DonHangId])
REFERENCES [dbo].[DonHang] ([Id])
GO
ALTER TABLE [dbo].[LichSuTrangThaiDon] CHECK CONSTRAINT [FK_LSTD_DonHang]
GO
ALTER TABLE [dbo].[LichSuTrangThaiDon]  WITH CHECK ADD  CONSTRAINT [FK_LSTD_NguoiDung] FOREIGN KEY([NguoiThayDoiId])
REFERENCES [dbo].[NguoiDung] ([Id])
GO
ALTER TABLE [dbo].[LichSuTrangThaiDon] CHECK CONSTRAINT [FK_LSTD_NguoiDung]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_NguoiDung_VaiTro] FOREIGN KEY([VaiTroId])
REFERENCES [dbo].[VaiTro] ([Id])
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_NguoiDung_VaiTro]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_DanhMuc] FOREIGN KEY([DanhMucId])
REFERENCES [dbo].[DanhMuc] ([Id])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_DanhMuc]
GO
ALTER TABLE [dbo].[SanPham]  WITH CHECK ADD  CONSTRAINT [FK_SanPham_ThuongHieu] FOREIGN KEY([ThuongHieuId])
REFERENCES [dbo].[ThuongHieu] ([Id])
GO
ALTER TABLE [dbo].[SanPham] CHECK CONSTRAINT [FK_SanPham_ThuongHieu]
GO
ALTER TABLE [dbo].[ThanhToan]  WITH CHECK ADD  CONSTRAINT [FK_ThanhToan_DonHang] FOREIGN KEY([DonHangId])
REFERENCES [dbo].[DonHang] ([Id])
GO
ALTER TABLE [dbo].[ThanhToan] CHECK CONSTRAINT [FK_ThanhToan_DonHang]
GO
ALTER TABLE [dbo].[DanhGia]  WITH CHECK ADD CHECK  (([DiemDanhGia]>=(1) AND [DiemDanhGia]<=(5)))
GO
USE [master]
GO
ALTER DATABASE [certain_shop] SET  READ_WRITE 
GO
