package com.certainshop.util;

import com.certainshop.entity.BienThe;
import com.certainshop.entity.SanPham;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class ExcelHelper {
    public static final String TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    public static final String[] HEADERs = {"Mã SP", "Tên SP", "Giá Gốc", "Giá Bán", "Danh Mục ID", "Thương Hiệu ID", "Kích Thước ID", "Màu Sắc ID", "Giá Biến Thể", "Số Lượng Tồn"};
    public static final String SHEET = "SanPhams";

    public static boolean hasExcelFormat(MultipartFile file) {
        return TYPE.equals(file.getContentType());
    }

    public static ByteArrayInputStream sanPhamsToExcel(List<SanPham> sanPhams) {
        try (Workbook workbook = new XSSFWorkbook(); ByteArrayOutputStream out = new ByteArrayOutputStream()) {
            Sheet sheet = workbook.createSheet(SHEET);

            // Header
            Row headerRow = sheet.createRow(0);
            for (int col = 0; col < HEADERs.length; col++) {
                Cell cell = headerRow.createCell(col);
                cell.setCellValue(HEADERs[col]);
            }

            int rowIdx = 1;
            for (SanPham sp : sanPhams) {
                if (sp.getDanhSachBienThe() != null && !sp.getDanhSachBienThe().isEmpty()) {
                    for (BienThe bt : sp.getDanhSachBienThe()) {
                        Row row = sheet.createRow(rowIdx++);
                        fillProductData(row, sp);
                        fillVariantData(row, bt);
                    }
                } else {
                    Row row = sheet.createRow(rowIdx++);
                    fillProductData(row, sp);
                }
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("Lỗi export dữ liệu ra file Excel: " + e.getMessage());
        }
    }

    private static void fillProductData(Row row, SanPham sp) {
        row.createCell(0).setCellValue(sp.getMaSanPham() != null ? sp.getMaSanPham() : "");
        row.createCell(1).setCellValue(sp.getTenSanPham() != null ? sp.getTenSanPham() : "");
        row.createCell(2).setCellValue(sp.getGiaGoc() != null ? sp.getGiaGoc().doubleValue() : 0);
        row.createCell(3).setCellValue(sp.getGiaBan() != null ? sp.getGiaBan().doubleValue() : 0);
        row.createCell(4).setCellValue(sp.getDanhMuc() != null ? sp.getDanhMuc().getId() : 0);
        row.createCell(5).setCellValue(sp.getThuongHieu() != null ? sp.getThuongHieu().getId() : 0);
    }

    private static void fillVariantData(Row row, BienThe bt) {
        row.createCell(6).setCellValue(bt.getKichThuoc() != null ? bt.getKichThuoc().getId() : 0);
        row.createCell(7).setCellValue(bt.getMauSac() != null ? bt.getMauSac().getId() : 0);
        row.createCell(8).setCellValue(bt.getGia() != null ? bt.getGia().doubleValue() : 0);
        row.createCell(9).setCellValue(bt.getSoLuongTon() != null ? bt.getSoLuongTon() : 0);
    }
}
