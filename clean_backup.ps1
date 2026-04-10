# Script to remove duplicate snake_case tables from backup SQL file
# The app uses PascalCase tables (JPA entities), snake_case tables are old duplicates

$inputFile = 'c:\Users\Admin\Desktop\hoanchinh\Certain-SHop-SD-60-master\backup_22_03_2026 (1).sql'
$outputFile = 'c:\Users\Admin\Desktop\hoanchinh\Certain-SHop-SD-60-master\backup_cleaned.sql'

# List of duplicate snake_case table names to remove
$duplicateTables = @(
    'bien_the',
    'chat_lieu',
    'chi_tiet_don_hang',
    'danh_muc',
    'don_hang',
    'khuyen_mai',
    'kich_thuoc',
    'mau_sac',
    'nguoi_dung',
    'san_pham',
    'thuong_hieu',
    'vai_tro'
)

# Read input file
$lines = Get-Content $inputFile

$output = @()
$skip = $false
$skipUntilGo = $false
$lineNum = 0
$removedSections = 0

foreach ($line in $lines) {
    $lineNum++
    $shouldSkip = $false

    # Check for /****** Object: Table [dbo].[snake_case_table] comments
    foreach ($table in $duplicateTables) {
        $escapedTable = [regex]::Escape($table)
        
        # Match the comment block that starts a table definition
        if ($line -match "^\s*/\*+\s*Object:\s*Table \[dbo\]\.\[$escapedTable\]") {
            $skip = $true
            $shouldSkip = $true
            $removedSections++
            Write-Host "Removing section at line $lineNum : $($line.Trim())"
            break
        }
        
        # Match CREATE TABLE for snake_case tables
        if ($line -match "^CREATE TABLE \[dbo\]\.\[$escapedTable\]\(") {
            $skip = $true
            $shouldSkip = $true
            break
        }
        
        # Match SET IDENTITY_INSERT for snake_case tables
        if ($line -match "SET IDENTITY_INSERT \[dbo\]\.\[$escapedTable\]") {
            $shouldSkip = $true
            break
        }
        
        # Match INSERT statements for snake_case tables
        if ($line -match "^INSERT \[dbo\]\.\[$escapedTable\]") {
            $shouldSkip = $true
            break
        }
        
        # Match ALTER TABLE for snake_case tables (constraints, indexes, defaults, FK)
        if ($line -match "^ALTER TABLE \[dbo\]\.\[$escapedTable\]") {
            $skip = $true
            $shouldSkip = $true
            break
        }
        
        # Match CREATE.*INDEX on snake_case tables
        if ($line -match "CREATE.*INDEX.*ON \[dbo\]\.\[$escapedTable\]") {
            $skip = $true
            $shouldSkip = $true
            break
        }
        
        # Match REFERENCES to snake_case tables (FK constraints)
        if ($line -match "^REFERENCES \[dbo\]\.\[$escapedTable\]") {
            $shouldSkip = $true
            break
        }
    }
    
    if ($shouldSkip) {
        continue
    }
    
    # If we're in a skip block, keep skipping until we hit GO
    if ($skip) {
        if ($line.Trim() -eq "GO") {
            $skip = $false
            # Skip the GO line too
            continue
        }
        continue
    }
    
    $output += $line
}

# Write cleaned file
$output | Set-Content -Path $outputFile -Encoding UTF8

Write-Host "`n=========================================="
Write-Host "Cleaning complete!"
Write-Host "Removed $removedSections sections related to snake_case duplicate tables."
Write-Host "Output file: $outputFile"
Write-Host "Original lines: $($lines.Count)"
Write-Host "Cleaned lines: $($output.Count)"
Write-Host "=========================================="

# Verify: list all tables in the cleaned file
Write-Host "`nTables in cleaned file:"
Select-String -Path $outputFile -Pattern "^CREATE TABLE \[dbo\]\.\[(.*?)\]" | ForEach-Object { 
    $_.Matches.Groups[1].Value 
}
