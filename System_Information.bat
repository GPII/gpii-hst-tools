@echo off

pushd %~dp0

:: Create directory "System Information" if doesn't exist
echo Create folder: System Information
IF NOT EXIST "System Information" md "System Information"

SET filePath="System Information\System_Information.txt"

:: Run Dxdiag
echo Collecting hardware information
echo ------- Hardware Information --------- > %filePath%
dxdiag /T dxdiag.txt
type dxdiag.txt >> %filePath%
del dxdiag.txt

:: Retrieve software information
echo Collecting software information
echo ------- Software Information --------- >> %filePath%
powershell "Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize | Out-String -Width 5000 | Out-File software.txt"
type software.txt >> %filePath%

powershell "Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table -AutoSize | Out-String -Width 5000 | Out-File software32.txt" 2>nul
type software32.txt >> %filePath%

del software.txt software32.txt

popd
