-- =====================================================
-- Script xóa 12 bảng snake_case trùng lặp trong database
-- Chỉ giữ lại các bảng PascalCase (đang được JPA sử dụng)
-- =====================================================

USE [certain_shop]
GO

-- Bước 1: Xóa các FOREIGN KEY constraints trước
-- (để tránh lỗi khi DROP TABLE)

-- FK của bien_the
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK9ndkc9rem0wb4xethp4qkpsn')
    ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FK9ndkc9rem0wb4xethp4qkpsn]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKdilrlq8vq4vvcuu6fg0ht8vju')
    ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FKdilrlq8vq4vvcuu6fg0ht8vju]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKh2dhysvrw2pnhacnh1xlyonr0')
    ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FKh2dhysvrw2pnhacnh1xlyonr0]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKkk53hh7y3twhgngbpcpylthk8')
    ALTER TABLE [dbo].[bien_the] DROP CONSTRAINT [FKkk53hh7y3twhgngbpcpylthk8]
GO

-- FK của chi_tiet_don_hang
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKk2knfk78gkwo3srle9wd00fat')
    ALTER TABLE [dbo].[chi_tiet_don_hang] DROP CONSTRAINT [FKk2knfk78gkwo3srle9wd00fat]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKt57maavf6s28hxyar724mdr1b')
    ALTER TABLE [dbo].[chi_tiet_don_hang] DROP CONSTRAINT [FKt57maavf6s28hxyar724mdr1b]
GO

-- FK của don_hang
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK3tq0qg6f6ranwlr8gvfii79d3')
    ALTER TABLE [dbo].[don_hang] DROP CONSTRAINT [FK3tq0qg6f6ranwlr8gvfii79d3]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKec7ntc61uhko624hwt130w1yc')
    ALTER TABLE [dbo].[don_hang] DROP CONSTRAINT [FKec7ntc61uhko624hwt130w1yc]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKm66hy6vf9vuoi3tdept6h771l')
    ALTER TABLE [dbo].[don_hang] DROP CONSTRAINT [FKm66hy6vf9vuoi3tdept6h771l]
GO

-- FK của san_pham
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKmnhsdc3pdlvp4pkronxu5hasp')
    ALTER TABLE [dbo].[san_pham] DROP CONSTRAINT [FKmnhsdc3pdlvp4pkronxu5hasp]
GO
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKrum92qs4m7i0u7p7ub6bhbrr5')
    ALTER TABLE [dbo].[san_pham] DROP CONSTRAINT [FKrum92qs4m7i0u7p7ub6bhbrr5]
GO

-- FK của nguoi_dung
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FKa5oibkto18llfdid5w4mv4v47')
    ALTER TABLE [dbo].[nguoi_dung] DROP CONSTRAINT [FKa5oibkto18llfdid5w4mv4v47]
GO

-- =====================================================
-- Bước 2: DROP các bảng snake_case (thứ tự con trước cha)
-- =====================================================

-- Bảng con (có FK tham chiếu đến bảng khác)
IF OBJECT_ID('dbo.chi_tiet_don_hang', 'U') IS NOT NULL
    DROP TABLE [dbo].[chi_tiet_don_hang]
GO
PRINT N'✓ Đã xóa bảng: chi_tiet_don_hang'
GO

IF OBJECT_ID('dbo.bien_the', 'U') IS NOT NULL
    DROP TABLE [dbo].[bien_the]
GO
PRINT N'✓ Đã xóa bảng: bien_the'
GO

IF OBJECT_ID('dbo.don_hang', 'U') IS NOT NULL
    DROP TABLE [dbo].[don_hang]
GO
PRINT N'✓ Đã xóa bảng: don_hang'
GO

IF OBJECT_ID('dbo.san_pham', 'U') IS NOT NULL
    DROP TABLE [dbo].[san_pham]
GO
PRINT N'✓ Đã xóa bảng: san_pham'
GO

IF OBJECT_ID('dbo.nguoi_dung', 'U') IS NOT NULL
    DROP TABLE [dbo].[nguoi_dung]
GO
PRINT N'✓ Đã xóa bảng: nguoi_dung'
GO

-- Bảng cha (không có FK tham chiếu đến bảng khác)
IF OBJECT_ID('dbo.chat_lieu', 'U') IS NOT NULL
    DROP TABLE [dbo].[chat_lieu]
GO
PRINT N'✓ Đã xóa bảng: chat_lieu'
GO

IF OBJECT_ID('dbo.danh_muc', 'U') IS NOT NULL
    DROP TABLE [dbo].[danh_muc]
GO
PRINT N'✓ Đã xóa bảng: danh_muc'
GO

IF OBJECT_ID('dbo.khuyen_mai', 'U') IS NOT NULL
    DROP TABLE [dbo].[khuyen_mai]
GO
PRINT N'✓ Đã xóa bảng: khuyen_mai'
GO

IF OBJECT_ID('dbo.kich_thuoc', 'U') IS NOT NULL
    DROP TABLE [dbo].[kich_thuoc]
GO
PRINT N'✓ Đã xóa bảng: kich_thuoc'
GO

IF OBJECT_ID('dbo.mau_sac', 'U') IS NOT NULL
    DROP TABLE [dbo].[mau_sac]
GO
PRINT N'✓ Đã xóa bảng: mau_sac'
GO

IF OBJECT_ID('dbo.thuong_hieu', 'U') IS NOT NULL
    DROP TABLE [dbo].[thuong_hieu]
GO
PRINT N'✓ Đã xóa bảng: thuong_hieu'
GO

IF OBJECT_ID('dbo.vai_tro', 'U') IS NOT NULL
    DROP TABLE [dbo].[vai_tro]
GO
PRINT N'✓ Đã xóa bảng: vai_tro'
GO

PRINT N''
PRINT N'======================================'
PRINT N'  Hoàn tất! Đã xóa 12 bảng trùng lặp'
PRINT N'======================================'
GO
