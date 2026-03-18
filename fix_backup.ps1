# ============================================================
# Fix Certain_Shop_Backup_Full.sql
#   1. Add PRIMARY KEY CLUSTERED ([Id]) to every PascalCase table
#   2. Remove snake_case table sections (CREATE, INSERT, FK)
# ============================================================
$inFile  = "d:\project\certainshop-be\Certain_Shop_Backup_Full.sql"
$outFile = "d:\project\certainshop-be\Certain_Shop_Backup_Full.sql"

$lines = [System.IO.File]::ReadAllLines($inFile, [System.Text.Encoding]::UTF8)
$out   = [System.Collections.Generic.List[string]]::new()

# PascalCase tables that need PK added (all have Id as identity column)
$pascalTables = @("VaiTro","NguoiDung","DiaChiNguoiDung","ThuongHieu","DanhMuc",
                  "ChatLieu","MauSac","KichThuoc","KhuyenMai","SanPham","BienThe",
                  "HinhAnhBienThe","GioHang","GioHangChiTiet","DonHang",
                  "ChiTietDonHang","LichSuTrangThaiDon","DanhGia","ThanhToan")

# snake_case tables to SKIP entirely
$snakeTables = @("bien_the","chat_lieu","chi_tiet_don_hang","danh_muc","don_hang",
                 "khuyen_mai","kich_thuoc","mau_sac","nguoi_dung","san_pham",
                 "thuong_hieu","vai_tro")

$skipBlock   = $false   # skip current table block
$inCreateTbl = $false   # inside a CREATE TABLE for a pascal table
$currentTbl  = ""
$tableLines  = [System.Collections.Generic.List[string]]::new()

function IsSnake([string]$tblName) {
    return $snakeTables -contains $tblName
}

function IsSnakeFK([string]$line) {
    foreach ($st in $snakeTables) {
        if ($line -match "\[$st\]") { return $true }
    }
    return $false
}

$i = 0
while ($i -lt $lines.Count) {
    $line = $lines[$i]

    # ---- Detect CREATE TABLE start ----
    if ($line -match "^CREATE TABLE \[dbo\]\.\[(.+)\] \($") {
        $tblName = $Matches[1]

        if (IsSnake $tblName) {
            # Skip entire snake_case block until "GO" after ");"
            $skipBlock = $true
            Write-Host "  Skipping snake table: $tblName"
        } else {
            # PascalCase: accumulate lines to inject PK
            $inCreateTbl = $true
            $currentTbl  = $tblName
            $tableLines.Clear()
            $tableLines.Add($line) | Out-Null
        }
        $i++; continue
    }

    # ---- Inside skipped block ----
    if ($skipBlock) {
        if ($line.TrimStart() -eq "GO" -and $i -gt 0) {
            # Check if previous was ");" end of CREATE TABLE followed by GO
            # We skip until we hit "GO" after the ");" of this table and one more "GO" (empty line)
            $prev = if ($i -gt 0) { $lines[$i-1].Trim() } else { "" }
            if ($prev -eq "" -or $prev -eq "GO" -or $prev.StartsWith(");")) {
                $skipBlock = $false
            }
        }
        $i++; continue
    }

    # ---- Inside PascalCase CREATE TABLE accumulation ----
    if ($inCreateTbl) {
        if ($line.TrimStart().StartsWith(");")) {
            # End of CREATE TABLE - inject PK before closing
            # Find last non-empty line in tableLines to add comma
            # The last item has no trailing comma (from script logic)
            # We need to add a comma to the last content line, then add PK, then ");", then GO
            $lastContentIdx = -1
            for ($j = $tableLines.Count - 1; $j -ge 0; $j--) {
                if ($tableLines[$j].Trim() -ne "") {
                    $lastContentIdx = $j; break
                }
            }
            if ($lastContentIdx -ge 0) {
                # Add comma to last content line if missing
                $lastLine = $tableLines[$lastContentIdx]
                if (-not $lastLine.TrimEnd().EndsWith(",")) {
                    $tableLines[$lastContentIdx] = $lastLine + ","
                }
            }
            # Add PK constraint
            $tableLines.Add("    CONSTRAINT [PK_$currentTbl] PRIMARY KEY CLUSTERED ([Id])") | Out-Null
            $tableLines.Add(");") | Out-Null
            foreach ($tl in $tableLines) { $out.Add($tl) | Out-Null }
            $inCreateTbl = $false
            $currentTbl  = ""
            $tableLines.Clear()
        } else {
            $tableLines.Add($line) | Out-Null
        }
        $i++; continue
    }

    # ---- Filter FK ADD lines ----
    # Skip ALTER TABLE ADD CONSTRAINT FK lines that reference snake_case tables
    if ($line -match "^ALTER TABLE \[dbo\]\.\[(.+)\] ADD CONSTRAINT") {
        $tblName2 = $Matches[1]
        if (IsSnake $tblName2) {
            # Skip this ALTER TABLE block (2 lines: ALTER TABLE + FOREIGN KEY)
            $i += 2  # skip next line (FOREIGN KEY ...) + GO
            # also skip GO line
            while ($i -lt $lines.Count -and $lines[$i].Trim() -eq "") { $i++ }
            if ($i -lt $lines.Count -and $lines[$i].Trim() -eq "GO") { $i++ }
            continue
        }
        # Check second line (FOREIGN KEY references)
        if ($i + 1 -lt $lines.Count -and (IsSnakeFK $lines[$i+1])) {
            $i += 2
            while ($i -lt $lines.Count -and $lines[$i].Trim() -eq "") { $i++ }
            if ($i -lt $lines.Count -and $lines[$i].Trim() -eq "GO") { $i++ }
            continue
        }
    }

    # ---- Filter snake FK DROP lines ----
    if ($line -match "^IF OBJECT_ID\(N'(.+?)','F'\).*ALTER TABLE \[dbo\]\.\[(.+?)\] DROP CONSTRAINT") {
        $tbl3 = $Matches[2]
        if (IsSnake $tbl3) { $i++; continue }
    }

    # ---- Filter SET IDENTITY_INSERT for snake tables ----
    if ($line -match "SET IDENTITY_INSERT \[dbo\]\.\[(.+?)\]") {
        $tbl4 = $Matches[1]
        if (IsSnake $tbl4) { $i++; continue }
    }

    # ---- Filter INSERT INTO for snake tables ----
    if ($line -match "^INSERT INTO \[dbo\]\.\[(.+?)\]") {
        $tbl5 = $Matches[1]
        if (IsSnake $tbl5) { $i++; continue }
    }

    # ---- Add current line ----
    $out.Add($line) | Out-Null
    $i++
}

Write-Host "Writing fixed file: $outFile"
[System.IO.File]::WriteAllLines($outFile, $out.ToArray(), (New-Object System.Text.UTF8Encoding $false))
$size = [math]::Round((Get-Item $outFile).Length / 1KB, 1)
Write-Host "Done! $size KB"

# Quick verify
$pkCount = ($out | Where-Object { $_ -match "PRIMARY KEY" }).Count
$fkCount = ($out | Where-Object { $_ -match "FOREIGN KEY" }).Count
$ctCount = ($out | Where-Object { $_ -match "CREATE TABLE" }).Count
Write-Host "CREATE TABLE: $ctCount | PRIMARY KEY: $pkCount | FOREIGN KEY: $fkCount"
