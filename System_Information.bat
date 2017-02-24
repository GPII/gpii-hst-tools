@echo off

::Set Path to the directory to create Hardware/Software Text document
md "System Information"

:: Run SYSTEMINFO
systeminfo > "System Information\System_Information1.txt"
echo -------System Hardware Information_SYSTEMINFO--------- > "System Information\System_Information.txt"

:: Run WMIC
wmic product get name,vendor,version > "System Information\System_Information2.txt"

::Append Data to System_Information.txt file
type "System Information\System_Information1.txt" >> "System Information\System_Information.txt"
echo -------System Software Information_WMIC--------- >> "System Information\System_Information.txt"
type "System Information\System_Information2.txt" >> "System Information\System_Information.txt"
del "System Information\System_Information1.txt"
del "System Information\System_Information2.txt"

::Run Dxdiag and append data to System_Information.txt
echo Running Dxdiag
echo -------System Software Information_DxDiag--------- >> "System Information\System_Information.txt"

dxdiag /T dxdiag.txt
type dxdiag.txt >> "System Information\System_Information.txt"
del dxdiag.txt

::Run PSinfo and append data to System_Information.txt
echo Running psinfo
echo -------System Software Information_PsInfo--------- >> "System Information\System_Information.txt"
PSINFO  >> "System Information\System_Information.txt"
