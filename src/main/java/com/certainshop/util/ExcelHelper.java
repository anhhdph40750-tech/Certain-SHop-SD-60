package com.certainshop.util;

import com.certainshop.entity.SanPham;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;

public class ExcelHelper {

    public static String TYPE = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
    public static String[] HEADERS = {"Mã SP", "Tên SP", "Giá Gốc", "Giá Bán", "Danh Mục (ID)", "Thương Hiệu (ID)", "Kích Thước (ID)", "Màu Sắc (ID)", "Giá Biến Thể", "Số Lượng Tồn"};
    public static String SHEET = "Sản Phẩm";

    public static boolean hasExcelFormat(MultipartFile file) {
        return TYPE.equals(file.getContentType());
    }

    public static ByteArrayInputStream sanPhamsToExcel(List<SanPham> sanPhams) {
        try (Workbook workbook = new XSSFWorkbook();
             ByteArrayOutputStream out = new ByteArrayOutputStream()) {

            Sheet sheet = workbook.createSheet(SHEET);

            // Header
            Row headerRow = sheet.createRow(0);
            for (int col = 0; col < HEADERS.length; col++) {
                Cell cell = headerRow.createCell(col);
                cell.setCellValue(HEADERS[col]);
            }

            int rowIdx = 1;
            for (SanPham sanPham : sanPhams) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(sanPham.getMaSanPham() != null ? sanPham.getMaSanPham() : "");
                row.createCell(1).setCellValue(sanPham.getTenSanPham() != null ? sanPham.getTenSanPham() : "");
                row.createCell(2).setCellValue(sanPham.getGiaGoc() != null ? sanPham.getGiaGoc().doubleValue() : 0);
                row.createCell(3).setCellValue(sanPham.getGiaBan() != null ? sanPham.getGiaBan().doubleValue() : 0);
                row.createCell(4).setCellValue(sanPham.getDanhMuc() != null ? sanPham.getDanhMuc().getId() : 0);
                row.createCell(5).setCellValue(sanPham.getThuongHieu() != null ? sanPham.getThuongHieu().getId() : 0);
                
                row.createCell(6).setCellValue(0); // kichThuocId
                row.createCell(7).setCellValue(0); // mauSacId
                row.createCell(8).setCellValue(0); // giaBienThe
                row.createCell(9).setCellValue(0); // soLuongTon
            }

            workbook.write(out);
            return new ByteArrayInputStream(out.toByteArray());
        } catch (IOException e) {
            throw new RuntimeException("Lỗi export dữ liệu ra file Excel: " + e.getMessage());
        }
    }
}
