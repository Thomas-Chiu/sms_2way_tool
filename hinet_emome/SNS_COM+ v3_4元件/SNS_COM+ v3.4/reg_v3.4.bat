echo off
echo.

set INSTALL_DIR=C:\SNS_COM+ v3.4

dir "%INSTALL_DIR%\SnsComServer_v3.4.*"

echo.
echo *** Install SnsComServer_v3.4.dll to .NET Framework 2.0
echo.
%windir%\Microsoft.NET\Framework\v2.0.50727\regsvcs.exe "%INSTALL_DIR%\SnsComServer_v3.4.dll"

echo.
dir "%INSTALL_DIR%\SnsComServer_v3.4.*"

echo.
echo *** 若有看到 SnsComServer_v3.4.tlb 檔，表示完成 SNS COM+ v3.4 安裝作業！
echo.

pause