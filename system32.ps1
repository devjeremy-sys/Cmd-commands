Write-Host "Made by Jeremy`n"

$system32Path = "$env:SystemRoot\System32"

# Get all files in System32 directory
$files = Get-ChildItem -Path $system32Path -File -Recurse -ErrorAction SilentlyContinue

foreach ($file in $files) {
    # Check if the file is an executable
    if ($file.Extension -eq ".exe") {
        # Check if the file has a digital signature
        $signature = $null
        try {
            $signature = (Get-AuthenticodeSignature $file.FullName).Status
        } catch {
            # Ignore errors caused by unsigned files
        }

        if ($signature -ne "Valid") {
            Write-Host "Unsigned: $($file.FullName)"
        }
    }
}