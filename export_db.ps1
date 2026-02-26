# ============================================================
# Certain_Shop - Full Backup (Schema + Data) v5
# Uses SqlDataReader -> PSCustomObject to avoid DataTable enum issues
# ============================================================
$srv = "localhost,14333"
$db  = "Certain_Shop"
$uid = "sa"
$pwd = "trungkien"
$out = "d:\project\certainshop-be\Certain_Shop_Backup_Full.sql"

# ---- Connection ----
$cn = New-Object System.Data.SqlClient.SqlConnection(
    "Server=$srv;Database=$db;User Id=$uid;Password=$pwd;TrustServerCertificate=True;")
$cn.Open()
Write-Host "Connected."

# ---- Query helper: returns array of PSCustomObject ----
function Q([string]$sql) {
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $sql
    $cmd.CommandTimeout = 120
    $rdr = $cmd.ExecuteReader()
    $rows = [System.Collections.Generic.List[PSCustomObject]]::new()
    while ($rdr.Read()) {
        $h = [ordered]@{}
        for ($i = 0; $i -lt $rdr.FieldCount; $i++) {
            $h[$rdr.GetName($i)] = if ($rdr.IsDBNull($i)) { $null } else { $rdr.GetValue($i) }
        }
        $rows.Add([PSCustomObject]$h)
    }
    $rdr.Close()
    $cmd.Dispose()
    return @($rows)
}

# ---- Scalar helper ----
function QScalar([string]$sql) {
    $cmd = $cn.CreateCommand()
    $cmd.CommandText = $sql
    $cmd.CommandTimeout = 120
    $v = $cmd.ExecuteScalar()
    $cmd.Dispose()
    return $v
}

# ---- Value formatter ----
function FmtVal([object]$v) {
    if ($null -eq $v) { return "NULL" }
    $tn = $v.GetType().Name
    if ($tn -eq "Boolean")  { if ($v) { return "1" } else { return "0" } }
    if ($tn -eq "DateTime") { return "'" + ([DateTime]$v).ToString("yyyy-MM-dd HH:mm:ss.fff") + "'" }
    if ($tn -in @("Decimal","Double","Single")) { return ($v.ToString([System.Globalization.CultureInfo]::InvariantCulture)) }
    if ($tn -in @("Int16","Int32","Int64","Byte","Int64")) { return ([string][long]$v) }
    $s = $v.ToString().Replace("'","''")
    return "N'" + $s + "'"
}

# ---- String builder ----
$sb = New-Object System.Text.StringBuilder(4MB)

# ============================================================
Write-Host "Step 1/4: Header + create DB..."
$sb.AppendLine("-- ============================================================") | Out-Null
$sb.AppendLine("-- Certain_Shop - Full Database Backup") | Out-Null
$sb.AppendLine("-- Generated : " + (Get-Date -Format "yyyy-MM-dd HH:mm:ss")) | Out-Null
$sb.AppendLine("-- ============================================================") | Out-Null
$sb.AppendLine("USE [master];") | Out-Null
$sb.AppendLine("GO") | Out-Null
$sb.AppendLine("IF DB_ID('$db') IS NULL BEGIN") | Out-Null
$sb.AppendLine("    CREATE DATABASE [$db];") | Out-Null
$sb.AppendLine("END") | Out-Null
$sb.AppendLine("GO") | Out-Null
$sb.AppendLine("USE [$db];") | Out-Null
$sb.AppendLine("GO") | Out-Null
$sb.AppendLine("SET NOCOUNT ON;") | Out-Null
$sb.AppendLine("SET QUOTED_IDENTIFIER ON;") | Out-Null
$sb.AppendLine("GO") | Out-Null
$sb.AppendLine("") | Out-Null

# ============================================================
Write-Host "Step 2/4: Drop FK + Drop tables..."

$allFks = Q @"
SELECT tp.name AS tbl, fk.name AS fkname
FROM sys.foreign_keys fk
JOIN sys.tables tp ON fk.parent_object_id = tp.object_id
WHERE tp.is_ms_shipped = 0 AND tp.name NOT LIKE '%[_]%' ORDER BY tp.name
"@

Write-Host "  FK count: $($allFks.Count)"

$sb.AppendLine("-- ============================================================") | Out-Null
$sb.AppendLine("-- DROP FOREIGN KEYS") | Out-Null
$sb.AppendLine("-- ============================================================") | Out-Null
foreach ($r in $allFks) {
    $tbl    = $r.tbl
    $fkname = $r.fkname
    $sb.AppendLine("IF OBJECT_ID(N'$fkname','F') IS NOT NULL ALTER TABLE [dbo].[$tbl] DROP CONSTRAINT [$fkname];") | Out-Null
}
$sb.AppendLine("GO") | Out-Null
$sb.AppendLine("") | Out-Null

# Table order: parents first (PascalCase tables only - skip Hibernate snake_case duplicates)
$tables = @("VaiTro","NguoiDung","DiaChiNguoiDung","ThuongHieu","DanhMuc","ChatLieu","MauSac","KichThuoc","KhuyenMai","SanPham","BienThe","HinhAnhBienThe","GioHang","GioHangChiTiet","DonHang","ChiTietDonHang","LichSuTrangThaiDon","DanhGia","ThanhToan")

# Get DB tables (only PascalCase - exclude snake_case which have no '_' pattern ... actually filter by explicit list)
$dbTableRows = Q "SELECT name FROM sys.tables WHERE is_ms_shipped=0 AND name NOT LIKE '%[_]%' ORDER BY name"
$dbTableNames = $dbTableRows | ForEach-Object { $_.name }
# Add any PascalCase tables in DB not in our list
foreach ($et in $dbTableNames) { if ($tables -notcontains $et) { $tables += $et } }
# Remove tables not in DB
$tables = @($tables | Where-Object { $dbTableNames -contains $_ })

Write-Host "  Tables: $($tables -join ', ')"

$sb.AppendLine("-- ============================================================") | Out-Null
$sb.AppendLine("-- DROP TABLES (reverse order)") | Out-Null
$sb.AppendLine("-- ============================================================") | Out-Null
for ($i = $tables.Count - 1; $i -ge 0; $i--) {
    $tn = $tables[$i]
    $sb.AppendLine("IF OBJECT_ID('[dbo].[$tn]','U') IS NOT NULL DROP TABLE [dbo].[$tn];") | Out-Null
}
$sb.AppendLine("GO") | Out-Null
$sb.AppendLine("") | Out-Null

# ============================================================
Write-Host "Step 3/4: CREATE TABLE DDL ($($tables.Count) tables)..."

$sb.AppendLine("-- ============================================================") | Out-Null
$sb.AppendLine("-- CREATE TABLES") | Out-Null
$sb.AppendLine("-- ============================================================") | Out-Null

foreach ($tableName in $tables) {
    Write-Host -NoNewline "  $tableName ..."

    # Columns
    $cols = Q ("SELECT c.name AS n, tp.name AS ty, c.max_length AS ml, c.precision AS pr, c.scale AS sc, " +
               "c.is_nullable AS inl, c.is_identity AS iid, ic.seed_value AS sv, ic.increment_value AS iv, " +
               "OBJECT_DEFINITION(c.default_object_id) AS dv " +
               "FROM sys.columns c JOIN sys.types tp ON c.user_type_id=tp.user_type_id " +
               "LEFT JOIN sys.identity_columns ic ON ic.object_id=c.object_id AND ic.column_id=c.column_id " +
               "WHERE c.object_id=OBJECT_ID('$tableName') ORDER BY c.column_id")

    $sb.AppendLine("CREATE TABLE [dbo].[$tableName] (") | Out-Null

    $colDefs = [System.Collections.Generic.List[string]]::new()

    foreach ($c in $cols) {
        $cname   = $c.n
        $ctype   = $c.ty
        $ml      = [int]$c.ml
        $pr      = [int]$c.pr
        $sc      = [int]$c.sc
        $nullable= [bool]$c.inl
        $isId    = [bool]$c.iid
        $sv      = $c.sv
        $iv      = $c.iv
        $dv      = $c.dv

        $typeDef = switch -Wildcard ($ctype) {
            "nvarchar"  { if ($ml -eq -1) { "NVARCHAR(MAX)" } else { "NVARCHAR($([int]($ml/2)))" } }
            "varchar"   { if ($ml -eq -1) { "VARCHAR(MAX)" }  else { "VARCHAR($ml)" } }
            "nchar"     { "NCHAR($([int]($ml/2)))" }
            "char"      { "CHAR($ml)" }
            "varbinary" { if ($ml -eq -1) { "VARBINARY(MAX)" } else { "VARBINARY($ml)" } }
            "decimal"   { "DECIMAL($pr,$sc)" }
            "numeric"   { "NUMERIC($pr,$sc)" }
            "float"     { "FLOAT($pr)" }
            "datetime2" { "DATETIME2($sc)" }
            "time"      { "TIME($sc)" }
            default     { $ctype.ToUpper() }
        }

        $identityDef = ""
        if ($isId) {
            $seedVal = if ($null -ne $sv) { [long]$sv } else { 1 }
            $incVal  = if ($null -ne $iv) { [long]$iv } else { 1 }
            $identityDef = " IDENTITY($seedVal,$incVal)"
        }

        $nullDef = if ($nullable) { " NULL" } else { " NOT NULL" }

        $defaultDef = ""
        if ($null -ne $dv -and $dv -ne "") {
            $defaultDef = " DEFAULT $dv"
        }

        $colDefs.Add("    [$cname] $typeDef$identityDef$defaultDef$nullDef") | Out-Null
    }

# Primary key: prefer formal PK, fallback to IDENTITY column
    $pkCols = Q ("SELECT c.name " +
               "FROM sys.indexes i " +
               "JOIN sys.index_columns ic ON i.object_id=ic.object_id AND i.index_id=ic.index_id " +
               "JOIN sys.columns c ON ic.object_id=c.object_id AND ic.column_id=c.column_id " +
               "WHERE i.is_primary_key=1 AND i.object_id=OBJECT_ID('$tableName') ORDER BY ic.key_ordinal")
    $pkName = QScalar "SELECT TOP 1 i.name FROM sys.indexes i WHERE i.is_primary_key=1 AND i.object_id=OBJECT_ID('$tableName')"

    if ($pkCols.Count -gt 0 -and $null -ne $pkName) {
        $pkColList = ($pkCols | ForEach-Object { "[" + $_.name + "]" }) -join ", "
        $colDefs.Add("    CONSTRAINT [$pkName] PRIMARY KEY CLUSTERED ($pkColList)") | Out-Null
    } else {
        # No formal PK — use identity column as PK (common when DB was created without ALTER TABLE ADD PK)
        $idCols = Q ("SELECT c.name FROM sys.identity_columns ic " +
                     "JOIN sys.columns c ON ic.object_id=c.object_id AND ic.column_id=c.column_id " +
                     "WHERE ic.object_id=OBJECT_ID('$tableName')")
        if ($idCols.Count -gt 0) {
            $idColList = ($idCols | ForEach-Object { "[" + $_.name + "]" }) -join ", "
            $colDefs.Add("    CONSTRAINT [PK_$tableName] PRIMARY KEY CLUSTERED ($idColList)") | Out-Null
        }
    }

    # Unique constraints
    $uqs = Q ("SELECT i.name AS idxname, c.name AS cname " +
              "FROM sys.indexes i " +
              "JOIN sys.index_columns ic ON i.object_id=ic.object_id AND i.index_id=ic.index_id " +
              "JOIN sys.columns c ON ic.object_id=c.object_id AND ic.column_id=c.column_id " +
              "WHERE i.is_unique_constraint=1 AND i.object_id=OBJECT_ID('$tableName') ORDER BY i.name, ic.key_ordinal")
    $uqGroups = $uqs | Group-Object { $_.idxname }
    foreach ($grp in $uqGroups) {
        $uqColList = ($grp.Group | ForEach-Object { "[" + $_.cname + "]" }) -join ", "
        $colDefs.Add("    CONSTRAINT [$($grp.Name)] UNIQUE ($uqColList)") | Out-Null
    }

    for ($i = 0; $i -lt $colDefs.Count; $i++) {
        $suffix = if ($i -lt $colDefs.Count - 1) { "," } else { "" }
        $sb.AppendLine($colDefs[$i] + $suffix) | Out-Null
    }
    $sb.AppendLine(");") | Out-Null
    $sb.AppendLine("GO") | Out-Null
    $sb.AppendLine("") | Out-Null
    Write-Host " done"
}

# FK constraints
$sb.AppendLine("-- ============================================================") | Out-Null
$sb.AppendLine("-- ADD FOREIGN KEYS") | Out-Null
$sb.AppendLine("-- ============================================================") | Out-Null

$fkDetails = Q @"
SELECT
    tp.name  AS childTbl,
    fk.name  AS fkname,
    cp.name  AS childCol,
    rp.name  AS parentTbl,
    rcp.name AS parentCol,
    fk.delete_referential_action_desc AS del_act,
    fk.update_referential_action_desc AS upd_act
FROM sys.foreign_keys fk
JOIN sys.tables tp  ON fk.parent_object_id  = tp.object_id
JOIN sys.tables rp  ON fk.referenced_object_id = rp.object_id
JOIN sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
JOIN sys.columns cp  ON fkc.parent_object_id  = cp.object_id  AND fkc.parent_column_id  = cp.column_id
JOIN sys.columns rcp ON fkc.referenced_object_id = rcp.object_id AND fkc.referenced_column_id = rcp.column_id
WHERE tp.is_ms_shipped = 0 AND tp.name NOT LIKE '%[_]%' AND rp.name NOT LIKE '%[_]%'
ORDER BY fk.name, fkc.constraint_column_id
"@

$fkGroups = $fkDetails | Group-Object { $_.fkname }
foreach ($grp in $fkGroups) {
    $first     = $grp.Group[0]
    $childTbl  = $first.childTbl
    $fkname    = $first.fkname
    $parentTbl = $first.parentTbl
    $delAct    = $first.del_act
    $updAct    = $first.upd_act
    $childCols  = ($grp.Group | ForEach-Object { "[" + $_.childCol  + "]" }) -join ", "
    $parentCols = ($grp.Group | ForEach-Object { "[" + $_.parentCol + "]" }) -join ", "
    $delClause  = if ($delAct -ne "NO_ACTION") { " ON DELETE $($delAct.Replace('_',' '))" } else { "" }
    $updClause  = if ($updAct -ne "NO_ACTION") { " ON UPDATE $($updAct.Replace('_',' '))" } else { "" }
    $sb.AppendLine("ALTER TABLE [dbo].[$childTbl] ADD CONSTRAINT [$fkname]") | Out-Null
    $sb.AppendLine("    FOREIGN KEY ($childCols) REFERENCES [dbo].[$parentTbl] ($parentCols)$delClause$updClause;") | Out-Null
    $sb.AppendLine("GO") | Out-Null
}
$sb.AppendLine("") | Out-Null

# ============================================================
Write-Host "Step 4/4: INSERT data..."
$sb.AppendLine("-- ============================================================") | Out-Null
$sb.AppendLine("-- INSERT DATA") | Out-Null
$sb.AppendLine("-- ============================================================") | Out-Null

foreach ($tableName in $tables) {
    $rowCount = [int](QScalar "SELECT COUNT(*) FROM [dbo].[$tableName]")
    Write-Host -NoNewline "  $tableName ($rowCount rows) ..."
    if ($rowCount -eq 0) { Write-Host " skip"; continue }

    # Check if has identity
    $hasId = [int](QScalar "SELECT COUNT(*) FROM sys.identity_columns WHERE object_id=OBJECT_ID('$tableName')")
    if ($hasId -gt 0) {
        $sb.AppendLine("SET IDENTITY_INSERT [dbo].[$tableName] ON;") | Out-Null
    }

    $dataRows = Q "SELECT * FROM [dbo].[$tableName]"
    if ($dataRows.Count -gt 0) {
        # Build column list from first row's properties
        $propNames = $dataRows[0].PSObject.Properties.Name
        $colList = ($propNames | ForEach-Object { "[$_]" }) -join ", "

        foreach ($row in $dataRows) {
            $vals = $propNames | ForEach-Object { FmtVal $row.$_ }
            $valList = $vals -join ", "
            $sb.AppendLine("INSERT INTO [dbo].[$tableName] ($colList) VALUES ($valList);") | Out-Null
        }
    }

    if ($hasId -gt 0) {
        $sb.AppendLine("SET IDENTITY_INSERT [dbo].[$tableName] OFF;") | Out-Null
    }
    $sb.AppendLine("GO") | Out-Null
    $sb.AppendLine("") | Out-Null
    Write-Host " done"
}

# ============================================================
$cn.Close()
Write-Host ""
Write-Host "Writing file..."
[System.IO.File]::WriteAllText($out, $sb.ToString(), [System.Text.Encoding]::UTF8)
$size = [math]::Round((Get-Item $out).Length / 1KB, 1)
Write-Host "DONE! Output: $out ($size KB)"
