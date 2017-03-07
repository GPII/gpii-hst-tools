@echo off

pushd %~dp0

:: Create directory "System Information" if doesn't exist
echo Create folder: System Information
IF NOT EXIST "System Information" md "System Information"

SET filePath="System Information\System_Information.txt"

:: Run SYSTEMINFO
echo Running command: systeminfo
echo ------- Output of command: systeminfo --------- > %filePath%
systeminfo >> %filePath%

:: Run WMIC
echo Running command: WMIC
echo ------- Output of command: WMIC --------- >> %filePath%
wmic /APPEND:%filePath% product get name,vendor,version >> nul

::Run Dxdiag and append data to System_Information.txt
echo Running command: dxdiag
echo ------- Output of command: dxdiag --------- >> %filePath%
dxdiag /T dxdiag.txt
type dxdiag.txt >> %filePath%
del dxdiag.txt

::Run PsInfo and append data to System_Information.txt
echo Running command: PsInfo
echo ------- Output of command: PsInfo --------- >> %filePath%
psinfo  >> %filePath%

popd
