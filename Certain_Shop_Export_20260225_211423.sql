/****** Object:  Table [dbo].[bien_the]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bien_the](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[gia] [numeric](18, 2) NULL,
	[mac_dinh] [bit] NULL,
	[ngay_cap_nhat] [datetime2](6) NULL,
	[ngay_tao] [datetime2](6) NULL,
	[so_luong_ton] [int] NULL,
	[trang_thai] [bit] NULL,
	[chat_lieu_id] [bigint] NULL,
	[kich_thuoc_id] [bigint] NULL,
	[mau_sac_id] [bigint] NULL,
	[san_pham_id] [bigint] NOT NULL,
	[gia_ban] [numeric](18, 2) NULL,
	[thoi_gian_cap_nhat] [datetime2](6) NULL,
	[thoi_gian_tao] [datetime2](6) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BienThe]    Script Date: 2/25/2026 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[chat_lieu]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chat_lieu](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[mo_ta] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_chat_lieu] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChatLieu]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChatLieu](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenChatLieu] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MoTa] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[chi_tiet_don_hang]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[chi_tiet_don_hang](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[gia_tai_thoi_diem_mua] [numeric](18, 2) NULL,
	[so_luong] [int] NULL,
	[thanh_tien] [numeric](18, 2) NULL,
	[bien_the_id] [bigint] NOT NULL,
	[don_hang_id] [bigint] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChiTietDonHang]    Script Date: 2/25/2026 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[danh_muc]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[danh_muc](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[dang_hoat_dong] [bit] NULL,
	[duong_dan] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mo_ta] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_danh_muc] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[thoi_gian_tao] [datetime2](6) NULL,
	[thu_tu_hien_thi] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGia]    Script Date: 2/25/2026 9:14:31 PM ******/
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
	[TieuDe] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NoiDung] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HinhAnh] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrangThai] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhMuc]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhMuc](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenDanhMuc] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[DuongDan] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MoTa] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThuTuHienThi] [int] NOT NULL,
	[DangHoatDong] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DiaChiNguoiDung]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DiaChiNguoiDung](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[NguoiDungId] [bigint] NOT NULL,
	[TenNguoiNhan] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SoDienThoai] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DiaChiCuThe] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhuongXa] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QuanHuyen] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TinhThanh] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaTinhGHN] [int] NULL,
	[MaHuyenGHN] [int] NULL,
	[MaXaGHN] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LaMacDinh] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[don_hang]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[don_hang](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[dia_chi_giao_hang] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ghi_chu] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ghi_chu_thu_ngan] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[loai_don_hang] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ma_don_hang] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ma_huyenghn] [int] NULL,
	[ma_tinhghn] [int] NULL,
	[ma_xaghn] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[phi_van_chuyen] [numeric](18, 2) NULL,
	[phuong_thuc_thanh_toan] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[phuong_xa_giao] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[quan_huyen_giao] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sdt_nguoi_nhan] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[so_tien_giam_gia] [numeric](18, 2) NULL,
	[ten_nguoi_nhan] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[thoi_gian_cap_nhat] [datetime2](6) NULL,
	[thoi_gian_tao] [datetime2](6) NULL,
	[thoi_gian_tu_huy] [datetime2](6) NULL,
	[tinh_thanh_giao] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[tong_tien] [numeric](18, 2) NULL,
	[tong_tien_thanh_toan] [numeric](18, 2) NULL,
	[trang_thai_don_hang] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vn_pay_transaction_ref] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[khuyen_mai_id] [bigint] NULL,
	[nguoi_dung_id] [bigint] NULL,
	[nhan_vien_id] [bigint] NULL,
	[da_thanh_toan] [bit] NULL,
	[tong_tien_hang] [numeric](18, 2) NULL,
	[vnpay_txn_ref] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DonHang]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DonHang](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[NguoiDungId] [bigint] NULL,
	[NhanVienId] [bigint] NULL,
	[MaDonHang] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LoaiDonHang] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TrangThaiDonHang] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TongTienHang] [decimal](18, 2) NULL,
	[SoTienGiamGia] [decimal](18, 2) NOT NULL,
	[PhiVanChuyen] [decimal](18, 2) NOT NULL,
	[TongTienThanhToan] [decimal](18, 2) NOT NULL,
	[KhuyenMaiId] [bigint] NULL,
	[TenNguoiNhan] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SdtNguoiNhan] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DiaChiGiaoHang] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaTinhGHN] [int] NULL,
	[MaHuyenGHN] [int] NULL,
	[MaXaGHN] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhuongThucThanhToan] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DaThanhToan] [bit] NOT NULL,
	[VnpayTxnRef] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VnpayResponseCode] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThoiGianTuHuy] [datetime] NULL,
	[GhiChu] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GhiChuThuNgan] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GioHang]    Script Date: 2/25/2026 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[GioHangChiTiet]    Script Date: 2/25/2026 9:14:31 PM ******/
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
/****** Object:  Table [dbo].[HinhAnhBienThe]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HinhAnhBienThe](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[BienTheId] [bigint] NOT NULL,
	[DuongDan] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LaAnhChinh] [bit] NOT NULL,
	[ThuTu] [int] NOT NULL,
	[MoTa] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThoiGianTao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[khuyen_mai]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[khuyen_mai](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[gia_tri_don_hang_toi_thieu] [numeric](18, 2) NULL,
	[gia_tri_giam] [numeric](18, 2) NULL,
	[gia_tri_don_hang_toi_da] [numeric](18, 2) NULL,
	[loai_giam_gia] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ma_khuyen_mai] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mo_ta] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ngay_bat_dau] [datetime2](6) NULL,
	[ngay_cap_nhat] [datetime2](6) NULL,
	[ngay_ket_thuc] [datetime2](6) NULL,
	[ngay_tao] [datetime2](6) NULL,
	[so_lan_da_su_dung] [int] NULL,
	[so_lan_su_dung_toi_da] [int] NULL,
	[ten_khuyen_mai] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[trang_thai_hoat_dong] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KhuyenMai]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KhuyenMai](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MaKhuyenMai] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TenKhuyenMai] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MoTa] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LoaiGiam] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GiaTriGiam] [decimal](18, 2) NOT NULL,
	[DonHangToiThieu] [decimal](18, 2) NOT NULL,
	[GiaTriToiDa] [decimal](18, 2) NULL,
	[SoLuongToiDa] [int] NULL,
	[SoLuongDaDung] [int] NOT NULL,
	[NgayBatDau] [datetime] NOT NULL,
	[NgayKetThuc] [datetime] NOT NULL,
	[TrangThaiKhuyenMai] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[kich_thuoc]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[kich_thuoc](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[kich_co] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_kich_thuoc] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[thu_tu] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[KichThuoc]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KichThuoc](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenKichThuoc] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ThuTu] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LichSuTrangThaiDon]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LichSuTrangThaiDon](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DonHangId] [bigint] NOT NULL,
	[TrangThaiCu] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrangThaiMoi] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GhiChu] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NguoiThayDoiId] [bigint] NULL,
	[ThoiGian] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[mau_sac]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mau_sac](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[ma_hex] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_mau] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mo_ta] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_mau_sac] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MauSac]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MauSac](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenMauSac] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MaHex] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MoTa] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[nguoi_dung]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[nguoi_dung](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[anh_dai_dien] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[dang_hoat_dong] [bit] NULL,
	[email] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[gioi_tinh] [bit] NULL,
	[ho_ten] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lan_dang_nhap_cuoi] [datetime2](6) NULL,
	[lan_doi_mat_khau_cuoi] [datetime2](6) NULL,
	[ma_dat_lai_mat_khau] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mat_khau_ma_hoa] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ngay_sinh] [date] NULL,
	[so_dien_thoai] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_dang_nhap] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[thoi_gian_cap_nhat] [datetime2](6) NULL,
	[thoi_gian_tao] [datetime2](6) NULL,
	[vai_tro_id] [int] NULL,
	[trang_thai] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NguoiDung]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NguoiDung](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenDangNhap] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MatKhauMaHoa] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[HoTen] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SoDienThoai] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NgaySinh] [date] NULL,
	[GioiTinh] [bit] NULL,
	[AnhDaiDien] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VaiTroId] [int] NOT NULL,
	[TrangThai] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LanDangNhapCuoi] [datetime] NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
	[DangHoatDong] [bit] NULL,
	[MaDatLaiMatKhau] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LanDoiMatKhauCuoi] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[san_pham]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[san_pham](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[gia_goc] [numeric](18, 2) NULL,
	[mo_ta_chi_tiet] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ngay_cap_nhat] [datetime2](6) NULL,
	[ngay_tao] [datetime2](6) NULL,
	[ten_san_pham] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[trang_thai] [bit] NULL,
	[danh_muc_id] [bigint] NULL,
	[thuong_hieu_id] [bigint] NULL,
	[anh_chinh] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[duong_dan] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[gia_ban] [numeric](18, 2) NULL,
	[ma_san_pham] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[mo_ta] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[thoi_gian_cap_nhat] [datetime2](6) NULL,
	[thoi_gian_tao] [datetime2](6) NULL,
	[trang_thai_san_pham] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SanPham]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SanPham](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[MaSanPham] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TenSanPham] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MoTa] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GiaGoc] [decimal](18, 2) NULL,
	[GiaBan] [decimal](18, 2) NULL,
	[DanhMucId] [bigint] NULL,
	[ThuongHieuId] [bigint] NULL,
	[AnhChinh] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DuongDan] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrangThaiSanPham] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
	[ThoiGianCapNhat] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhToan]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhToan](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DonHangId] [bigint] NOT NULL,
	[PhuongThucThanhToan] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrangThaiThanhToan] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SoTienThanhToan] [decimal](18, 2) NULL,
	[ThoiDiemThanhToan] [datetime] NULL,
	[MaGiaoDichVNPay] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaNganHang] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThongTinGiaoDich] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[thuong_hieu]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[thuong_hieu](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[mo_ta] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_thuong_hieu] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[thoi_gian_tao] [datetime2](6) NULL,
	[trang_thai] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThuongHieu]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThuongHieu](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[TenThuongHieu] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MoTa] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrangThai] [bit] NOT NULL,
	[ThoiGianTao] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[vai_tro]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[vai_tro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[quyen_han] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ten_vai_tro] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VaiTro]    Script Date: 2/25/2026 9:14:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TenVaiTro] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[QuyenHan] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BienThe] ON 

INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 1, 2, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 30, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 1, 3, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 50, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 1, 4, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 45, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 1, 5, 1, 1, CAST(259000.00 AS Decimal(18, 2)), 20, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 1, 2, 2, 1, CAST(259000.00 AS Decimal(18, 2)), 25, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 1, 3, 2, 1, CAST(259000.00 AS Decimal(18, 2)), 40, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, 1, 4, 2, 1, CAST(259000.00 AS Decimal(18, 2)), 35, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, 1, 2, 3, 1, CAST(259000.00 AS Decimal(18, 2)), 20, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (9, 1, 3, 3, 1, CAST(259000.00 AS Decimal(18, 2)), 30, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (10, 2, 3, 1, 1, CAST(319000.00 AS Decimal(18, 2)), 40, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (11, 2, 4, 1, 1, CAST(319000.00 AS Decimal(18, 2)), 30, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (12, 2, 3, 2, 1, CAST(319000.00 AS Decimal(18, 2)), 25, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (13, 2, 4, 2, 1, CAST(319000.00 AS Decimal(18, 2)), 20, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (14, 3, 3, 1, 2, CAST(399000.00 AS Decimal(18, 2)), 20, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (15, 3, 4, 1, 2, CAST(399000.00 AS Decimal(18, 2)), 15, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (16, 3, 3, 3, 2, CAST(399000.00 AS Decimal(18, 2)), 18, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (17, 4, 3, 1, 3, CAST(549000.00 AS Decimal(18, 2)), 25, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (18, 4, 4, 1, 3, CAST(549000.00 AS Decimal(18, 2)), 20, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (19, 4, 3, 5, 3, CAST(549000.00 AS Decimal(18, 2)), 15, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (20, 5, 3, 4, 3, CAST(699000.00 AS Decimal(18, 2)), 15, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (21, 5, 4, 4, 3, CAST(699000.00 AS Decimal(18, 2)), 12, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (22, 5, 3, 1, 3, CAST(699000.00 AS Decimal(18, 2)), 10, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (23, 6, 3, 1, 2, CAST(449000.00 AS Decimal(18, 2)), 30, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (24, 6, 4, 1, 2, CAST(449000.00 AS Decimal(18, 2)), 25, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (25, 6, 3, 4, 2, CAST(449000.00 AS Decimal(18, 2)), 20, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (26, 7, 3, 1, 1, CAST(359000.00 AS Decimal(18, 2)), 20, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (27, 7, 4, 1, 1, CAST(359000.00 AS Decimal(18, 2)), 15, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (28, 8, 3, 2, 2, CAST(629000.00 AS Decimal(18, 2)), 10, 1, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
INSERT [dbo].[BienThe] ([Id], [SanPhamId], [KichThuocId], [MauSacId], [ChatLieuId], [GiaBan], [SoLuongTon], [MacDinh], [TrangThai], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (29, 8, 4, 2, 2, CAST(629000.00 AS Decimal(18, 2)), 8, 0, 1, CAST(N'2026-02-24T20:31:56.040' AS DateTime), NULL)
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
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (5, 3, 20, 1, CAST(699000.00 AS Decimal(18, 2)))
INSERT [dbo].[ChiTietDonHang] ([Id], [DonHangId], [BienTheId], [SoLuong], [GiaTaiThoiDiemMua]) VALUES (6, 4, 2, 1, CAST(259000.00 AS Decimal(18, 2)))
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
INSERT [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (3, N'Áo khoác', N'ao-khoac', N'Áo khoác bomber, dù nhẹ', 3, 1, CAST(N'2026-02-24T20:31:55.960' AS DateTime))
INSERT [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (4, N'Quần', N'quan', N'Quần jean và cargo', 4, 1, CAST(N'2026-02-24T20:31:55.960' AS DateTime))
INSERT [dbo].[DanhMuc] ([Id], [TenDanhMuc], [DuongDan], [MoTa], [ThuTuHienThi], [DangHoatDong], [ThoiGianTao]) VALUES (5, N'Phụ kiện', N'phu-kien', N'Mũ, túi, dây lưng', 5, 1, CAST(N'2026-02-24T20:31:55.960' AS DateTime))
SET IDENTITY_INSERT [dbo].[DanhMuc] OFF
GO
SET IDENTITY_INSERT [dbo].[DiaChiNguoiDung] ON 

INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, N'Lê Minh Tuấn', N'0912345678', N'12 Nguyễn Huệ', N'Phường Bến Nghé', N'Quận 1', N'TP. Hồ Chí Minh', 202, 1442, N'20211', 1, CAST(N'2026-02-24T20:31:55.950' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 4, N'Lê Minh Tuấn', N'0912345678', N'88 Lê Lợi', N'Phường Phạm Ngũ Lão', N'Quận 1', N'TP. Hồ Chí Minh', 202, 1442, N'20209', 0, CAST(N'2026-02-24T20:31:55.950' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 5, N'Phạm Thị Mai', N'0987654321', N'45 Trần Hưng Đạo', N'Phường Hàng Bài', N'Quận Hoàn Kiếm', N'Hà Nội', 201, 1489, N'1A0102', 1, CAST(N'2026-02-24T20:31:55.950' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 4, N'Test DC', N'0912345678', N'123 Le Loi', N'P. Ben Thanh', N'Q.1', N'TP HCM', 202, 3695, N'90737', 0, CAST(N'2026-02-25T16:20:30.037' AS DateTime), NULL)
INSERT [dbo].[DiaChiNguoiDung] ([Id], [NguoiDungId], [TenNguoiNhan], [SoDienThoai], [DiaChiCuThe], [PhuongXa], [QuanHuyen], [TinhThanh], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [LaMacDinh], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 4, N'Test DC', N'0912345678', N'123 Le Loi', N'P. Ben Thanh', N'Q.1', N'TP HCM', 202, 3695, N'90737', 0, CAST(N'2026-02-25T16:25:47.640' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[DiaChiNguoiDung] OFF
GO
SET IDENTITY_INSERT [dbo].[DonHang] ON 

INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, NULL, N'DH20240001', N'ONLINE', N'DA_GIAO', CAST(808000.00 AS Decimal(18, 2)), CAST(50000.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(788000.00 AS Decimal(18, 2)), 1, N'Lê Minh Tuấn', N'0912345678', N'12 Nguyễn Huệ, P.Bến Nghé, Q.1, TP.HCM', NULL, NULL, NULL, N'VNPAY', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-09T20:31:56.093' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 5, NULL, N'DH20240002', N'ONLINE', N'DANG_GIAO', CAST(399000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(429000.00 AS Decimal(18, 2)), NULL, N'Phạm Thị Mai', N'0987654321', N'45 Trần Hưng Đạo, P.Hàng Bài, Q.Hoàn Kiếm, Hà Nội', NULL, NULL, NULL, N'COD', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-21T20:31:56.093' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, NULL, 2, N'DH20240003', N'TAI_QUAY', N'HOAN_THANH', CAST(698000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(698000.00 AS Decimal(18, 2)), NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'TIEN_MAT', 1, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-17T20:31:56.093' AS DateTime), NULL)
INSERT [dbo].[DonHang] ([Id], [NguoiDungId], [NhanVienId], [MaDonHang], [LoaiDonHang], [TrangThaiDonHang], [TongTienHang], [SoTienGiamGia], [PhiVanChuyen], [TongTienThanhToan], [KhuyenMaiId], [TenNguoiNhan], [SdtNguoiNhan], [DiaChiGiaoHang], [MaTinhGHN], [MaHuyenGHN], [MaXaGHN], [PhuongThucThanhToan], [DaThanhToan], [VnpayTxnRef], [VnpayResponseCode], [ThoiGianTuHuy], [GhiChu], [GhiChuThuNgan], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 4, NULL, N'DH20240004', N'ONLINE', N'CHO_XAC_NHAN', CAST(259000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(30000.00 AS Decimal(18, 2)), CAST(289000.00 AS Decimal(18, 2)), NULL, N'Lê Minh Tuấn', N'0912345678', N'88 Lê Lợi, P.Phạm Ngũ Lão, Q.1, TP.HCM', NULL, NULL, NULL, N'VNPAY', 0, NULL, NULL, NULL, NULL, NULL, CAST(N'2026-02-24T18:31:56.093' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[DonHang] OFF
GO
SET IDENTITY_INSERT [dbo].[GioHang] ON 

INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, 4, CAST(N'2026-02-24T20:31:56.047' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, 5, CAST(N'2026-02-24T20:31:56.047' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 6, CAST(N'2026-02-25T15:59:53.103' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 7, CAST(N'2026-02-25T16:00:19.923' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, 1, CAST(N'2026-02-25T16:33:32.477' AS DateTime), NULL)
INSERT [dbo].[GioHang] ([Id], [NguoiDungId], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, 9, CAST(N'2026-02-25T17:02:28.313' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[GioHang] OFF
GO
SET IDENTITY_INSERT [dbo].[GioHangChiTiet] ON 

INSERT [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, 2, 14, 1, CAST(399000.00 AS Decimal(18, 2)), CAST(N'2026-02-24T20:31:56.063' AS DateTime), NULL)
INSERT [dbo].[GioHangChiTiet] ([Id], [GioHangId], [BienTheId], [SoLuong], [DonGia], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, 1, 1, 2, CAST(259000.00 AS Decimal(18, 2)), CAST(N'2026-02-25T16:26:22.817' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[GioHangChiTiet] OFF
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
SET IDENTITY_INSERT [dbo].[LichSuTrangThaiDon] OFF
GO
SET IDENTITY_INSERT [dbo].[MauSac] ON 

INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (1, N'Đen', N'#212121', N'Đen cơ bản')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (2, N'Trắng', N'#FFFFFF', N'Trắng tinh')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (3, N'Xanh navy', N'#1A237E', N'Xanh đậm navy')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (4, N'Xám', N'#757575', N'Xám trung tính')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (5, N'Đỏ', N'#C62828', N'Đỏ đậm')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (6, N'Xanh lá', N'#2E7D32', N'Xanh lá đậm')
INSERT [dbo].[MauSac] ([Id], [TenMauSac], [MaHex], [MoTa]) VALUES (7, N'Be', N'#F5F5DC', N'Màu be kem')
SET IDENTITY_INSERT [dbo].[MauSac] OFF
GO
SET IDENTITY_INSERT [dbo].[NguoiDung] ON 

INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (1, N'admin', N'admin@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Quản trị viên', N'0901000001', NULL, 1, NULL, 1, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (2, N'nhanvien01', N'nv01@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Trần Văn Nam', N'0901000002', NULL, 1, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (3, N'nhanvien02', N'nv02@certainshop.vn', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Nguyễn Thị Lan', N'0901000003', NULL, 0, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (4, N'khachhang01', N'kh01@test.com', N'$2a$10$KEELnfLt9gPU61.1jwyzhOxfes0qPrlUKJIdKinBE9PhtWX4ahHje', N'KH Test 01', N'0987654321', NULL, 1, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), CAST(N'2026-02-25T16:25:46.473' AS DateTime), 1, NULL, CAST(N'2026-02-25T16:25:46.470' AS DateTime))
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (5, N'khachhang02', N'kh02@gmail.com', N'$2b$10$7YYqVUoU7uM28tE5yiLLjO6WEIWDN3CjDCf68TFv8lRr1Qp9To1KO', N'Phạm Thị Mai', N'0987654321', NULL, 0, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-24T20:31:55.933' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (6, N'testuser5', N'test5@test.com', N'$2a$10$UAL4Z7JegNQSkuf.Gxwh0ewd9ykhRbKnrf8EPVEqqlPHcOTzTbSwO', N'Test User 5', NULL, NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-25T15:59:53.070' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (7, N'testqc01', N'testqc01@test.com', N'$2a$10$IE1VI1KqaZySIEvtR4kqQOfebnr18TdP2ssSeeYGbU3tlH.6Nts3S', N'Test QC User', NULL, NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-25T16:00:19.923' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (8, N'testnv_qc', N'testnv_qc@test.com', N'$2a$10$FdkyhBP4v.hzULRcoSQQr.5e8DkWHUnXNApFUrFzy5mB.bL9hrKty', N'NV QC Test', N'0999888777', NULL, NULL, NULL, 2, N'HOAT_DONG', NULL, CAST(N'2026-02-25T16:20:30.923' AS DateTime), NULL, 1, NULL, NULL)
INSERT [dbo].[NguoiDung] ([Id], [TenDangNhap], [Email], [MatKhauMaHoa], [HoTen], [SoDienThoai], [NgaySinh], [GioiTinh], [AnhDaiDien], [VaiTroId], [TrangThai], [LanDangNhapCuoi], [ThoiGianTao], [ThoiGianCapNhat], [DangHoatDong], [MaDatLaiMatKhau], [LanDoiMatKhauCuoi]) VALUES (9, N'kien1', N'kien1@gmail.com', N'$2a$10$qcxiYAuII5NrvYE7RAzyr.0pciJONtPF74hkpB4tekCvZt7ZbEcZu', N'trung kien', N'0956651738', NULL, NULL, NULL, 3, N'HOAT_DONG', NULL, CAST(N'2026-02-25T17:02:28.253' AS DateTime), NULL, 1, NULL, NULL)
SET IDENTITY_INSERT [dbo].[NguoiDung] OFF
GO
SET IDENTITY_INSERT [dbo].[SanPham] ON 

INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (1, N'SP001', N'Áo thun Certain Basic', N'Áo cotton cổ tròn màu trơn basic.', CAST(299000.00 AS Decimal(18, 2)), CAST(259000.00 AS Decimal(18, 2)), 1, 1, N'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=500&h=500&fit=crop', N'ao-thun-certain-basic', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (2, N'SP002', N'Áo thun Certain Graphic', N'Áo thun in hình graphic bold.', CAST(349000.00 AS Decimal(18, 2)), CAST(319000.00 AS Decimal(18, 2)), 1, 1, N'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?w=500&h=500&fit=crop', N'ao-thun-certain-graphic', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (3, N'SP003', N'Áo polo Certain Classic', N'Áo polo cổ bẻ sang trọng.', CAST(450000.00 AS Decimal(18, 2)), CAST(399000.00 AS Decimal(18, 2)), 2, 1, N'https://images.unsplash.com/photo-1625910513413-5fc45e80fd05?w=500&h=500&fit=crop', N'ao-polo-certain-classic', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (4, N'SP004', N'Áo thun Nike Dri-FIT', N'Công nghệ Dri-FIT thấm hút mồ hôi.', CAST(599000.00 AS Decimal(18, 2)), CAST(549000.00 AS Decimal(18, 2)), 1, 2, N'https://images.unsplash.com/photo-1581655353564-df123a1eb820?w=500&h=500&fit=crop', N'ao-thun-nike-drifit', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (5, N'SP005', N'Áo khoác Adidas Essentials', N'Áo khoác nhẹ chống gió thể thao.', CAST(799000.00 AS Decimal(18, 2)), CAST(699000.00 AS Decimal(18, 2)), 3, 3, N'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=500&h=500&fit=crop', N'ao-khoac-adidas', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (6, N'SP006', N'Quần cargo Certain', N'Quần cargo túi hộp streetwear.', CAST(499000.00 AS Decimal(18, 2)), CAST(449000.00 AS Decimal(18, 2)), 4, 1, N'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=500&h=500&fit=crop', N'quan-cargo-certain', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (7, N'SP007', N'Áo thun Puma Essential', N'Áo thun polo Puma đơn giản.', CAST(399000.00 AS Decimal(18, 2)), CAST(359000.00 AS Decimal(18, 2)), 1, 4, N'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a?w=500&h=500&fit=crop', N'ao-thun-puma', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (8, N'SP008', N'Áo polo Nike Court', N'Áo polo tennis kỹ thuật cao.', CAST(699000.00 AS Decimal(18, 2)), CAST(629000.00 AS Decimal(18, 2)), 2, 2, N'https://images.unsplash.com/photo-1576566588028-4147f3842f27?w=500&h=500&fit=crop', N'ao-polo-nike-court', N'DANG_BAN', CAST(N'2026-02-24T20:31:56.003' AS DateTime), NULL)
INSERT [dbo].[SanPham] ([Id], [MaSanPham], [TenSanPham], [MoTa], [GiaGoc], [GiaBan], [DanhMucId], [ThuongHieuId], [AnhChinh], [DuongDan], [TrangThaiSanPham], [ThoiGianTao], [ThoiGianCapNhat]) VALUES (9, NULL, N'Test QC Product', N'Mo ta test', CAST(100000.00 AS Decimal(18, 2)), NULL, 1, NULL, NULL, NULL, N'NGUNG_BAN', CAST(N'2026-02-25T16:20:30.993' AS DateTime), CAST(N'2026-02-25T16:25:15.930' AS DateTime))
SET IDENTITY_INSERT [dbo].[SanPham] OFF
GO
SET IDENTITY_INSERT [dbo].[ThuongHieu] ON 

INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (1, N'Certain', N'Thương hiệu in-house', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (2, N'Nike', N'Thương hiệu thể thao Mỹ', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (3, N'Adidas', N'Thương hiệu thể thao Đức', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
INSERT [dbo].[ThuongHieu] ([Id], [TenThuongHieu], [MoTa], [TrangThai], [ThoiGianTao]) VALUES (4, N'Puma', N'Thương hiệu thể thao Đức', 1, CAST(N'2026-02-24T20:31:55.963' AS DateTime))
SET IDENTITY_INSERT [dbo].[ThuongHieu] OFF
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (1, N'ADMIN', NULL)
INSERT [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (2, N'NHAN_VIEN', NULL)
INSERT [dbo].[VaiTro] ([Id], [TenVaiTro], [QuyenHan]) VALUES (3, N'KHACH_HANG', NULL)
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__DonHang__129584ACF40EF664]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[DonHang] ADD UNIQUE NONCLUSTERED 
(
	[MaDonHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__GioHang__C4BBA4BCCE33218B]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[GioHang] ADD UNIQUE NONCLUSTERED 
(
	[NguoiDungId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ_GioHang_BienThe]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[GioHangChiTiet] ADD  CONSTRAINT [UQ_GioHang_BienThe] UNIQUE NONCLUSTERED 
(
	[GioHangId] ASC,
	[BienTheId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__KhuyenMa__6F56B3BC5FAEC67B]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[KhuyenMai] ADD UNIQUE NONCLUSTERED 
(
	[MaKhuyenMai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_o0s268lrp9is6o1e4ek6m1lc6]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[nguoi_dung] ADD  CONSTRAINT [UK_o0s268lrp9is6o1e4ek6m1lc6] UNIQUE NONCLUSTERED 
(
	[ten_dang_nhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UK_majqh5g4djy2tp3p9dvr64brp]    Script Date: 2/25/2026 9:14:31 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UK_majqh5g4djy2tp3p9dvr64brp] ON [dbo].[nguoi_dung]
(
	[email] ASC
)
WHERE ([email] IS NOT NULL)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NguoiDun__55F68FC0CC3434E6]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[NguoiDung] ADD UNIQUE NONCLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NguoiDun__A9D1053477413C8E]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[NguoiDung] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__VaiTro__1DA55814373343EF]    Script Date: 2/25/2026 9:14:31 PM ******/
ALTER TABLE [dbo].[VaiTro] ADD UNIQUE NONCLUSTERED 
(
	[TenVaiTro] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
ALTER TABLE [dbo].[bien_the]  WITH CHECK ADD  CONSTRAINT [FK9ndkc9rem0wb4xethp4qkpsn] FOREIGN KEY([kich_thuoc_id])
REFERENCES [dbo].[kich_thuoc] ([id])
GO
ALTER TABLE [dbo].[bien_the] CHECK CONSTRAINT [FK9ndkc9rem0wb4xethp4qkpsn]
GO
ALTER TABLE [dbo].[bien_the]  WITH CHECK ADD  CONSTRAINT [FKdilrlq8vq4vvcuu6fg0ht8vju] FOREIGN KEY([chat_lieu_id])
REFERENCES [dbo].[chat_lieu] ([id])
GO
ALTER TABLE [dbo].[bien_the] CHECK CONSTRAINT [FKdilrlq8vq4vvcuu6fg0ht8vju]
GO
ALTER TABLE [dbo].[bien_the]  WITH CHECK ADD  CONSTRAINT [FKh2dhysvrw2pnhacnh1xlyonr0] FOREIGN KEY([san_pham_id])
REFERENCES [dbo].[san_pham] ([id])
GO
ALTER TABLE [dbo].[bien_the] CHECK CONSTRAINT [FKh2dhysvrw2pnhacnh1xlyonr0]
GO
ALTER TABLE [dbo].[bien_the]  WITH CHECK ADD  CONSTRAINT [FKkk53hh7y3twhgngbpcpylthk8] FOREIGN KEY([mau_sac_id])
REFERENCES [dbo].[mau_sac] ([id])
GO
ALTER TABLE [dbo].[bien_the] CHECK CONSTRAINT [FKkk53hh7y3twhgngbpcpylthk8]
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
ALTER TABLE [dbo].[chi_tiet_don_hang]  WITH CHECK ADD  CONSTRAINT [FKk2knfk78gkwo3srle9wd00fat] FOREIGN KEY([bien_the_id])
REFERENCES [dbo].[bien_the] ([id])
GO
ALTER TABLE [dbo].[chi_tiet_don_hang] CHECK CONSTRAINT [FKk2knfk78gkwo3srle9wd00fat]
GO
ALTER TABLE [dbo].[chi_tiet_don_hang]  WITH CHECK ADD  CONSTRAINT [FKt57maavf6s28hxyar724mdr1b] FOREIGN KEY([don_hang_id])
REFERENCES [dbo].[don_hang] ([id])
GO
ALTER TABLE [dbo].[chi_tiet_don_hang] CHECK CONSTRAINT [FKt57maavf6s28hxyar724mdr1b]
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
ALTER TABLE [dbo].[don_hang]  WITH CHECK ADD  CONSTRAINT [FK3tq0qg6f6ranwlr8gvfii79d3] FOREIGN KEY([nguoi_dung_id])
REFERENCES [dbo].[nguoi_dung] ([id])
GO
ALTER TABLE [dbo].[don_hang] CHECK CONSTRAINT [FK3tq0qg6f6ranwlr8gvfii79d3]
GO
ALTER TABLE [dbo].[don_hang]  WITH CHECK ADD  CONSTRAINT [FKec7ntc61uhko624hwt130w1yc] FOREIGN KEY([nhan_vien_id])
REFERENCES [dbo].[nguoi_dung] ([id])
GO
ALTER TABLE [dbo].[don_hang] CHECK CONSTRAINT [FKec7ntc61uhko624hwt130w1yc]
GO
ALTER TABLE [dbo].[don_hang]  WITH CHECK ADD  CONSTRAINT [FKm66hy6vf9vuoi3tdept6h771l] FOREIGN KEY([khuyen_mai_id])
REFERENCES [dbo].[khuyen_mai] ([id])
GO
ALTER TABLE [dbo].[don_hang] CHECK CONSTRAINT [FKm66hy6vf9vuoi3tdept6h771l]
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
ALTER TABLE [dbo].[nguoi_dung]  WITH CHECK ADD  CONSTRAINT [FKa5oibkto18llfdid5w4mv4v47] FOREIGN KEY([vai_tro_id])
REFERENCES [dbo].[vai_tro] ([id])
GO
ALTER TABLE [dbo].[nguoi_dung] CHECK CONSTRAINT [FKa5oibkto18llfdid5w4mv4v47]
GO
ALTER TABLE [dbo].[NguoiDung]  WITH CHECK ADD  CONSTRAINT [FK_NguoiDung_VaiTro] FOREIGN KEY([VaiTroId])
REFERENCES [dbo].[VaiTro] ([Id])
GO
ALTER TABLE [dbo].[NguoiDung] CHECK CONSTRAINT [FK_NguoiDung_VaiTro]
GO
ALTER TABLE [dbo].[san_pham]  WITH CHECK ADD  CONSTRAINT [FKmnhsdc3pdlvp4pkronxu5hasp] FOREIGN KEY([danh_muc_id])
REFERENCES [dbo].[danh_muc] ([id])
GO
ALTER TABLE [dbo].[san_pham] CHECK CONSTRAINT [FKmnhsdc3pdlvp4pkronxu5hasp]
GO
ALTER TABLE [dbo].[san_pham]  WITH CHECK ADD  CONSTRAINT [FKrum92qs4m7i0u7p7ub6bhbrr5] FOREIGN KEY([thuong_hieu_id])
REFERENCES [dbo].[thuong_hieu] ([id])
GO
ALTER TABLE [dbo].[san_pham] CHECK CONSTRAINT [FKrum92qs4m7i0u7p7ub6bhbrr5]
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
