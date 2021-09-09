echo off
echo.

set INSTALL_DIR=C:\SNS_COM+ v3.3

dir "%INSTALL_DIR%\SnsComServer_v3.3.*"

echo.
echo *** Install SnsComServer_v3.3.dll to .NET Framework 2.0
echo.
%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe "%INSTALL_DIR%\SnsComServer_v3.3.dll" /register /codebase /tlb:"%INSTALL_DIR%\SnsComServer_v3.3.tlb"

dir "%INSTALL_DIR%\SnsComServer_v3.3.*"

echo.
echo *** 若有看到 SnsComServer_v3.3.tlb 檔，表示完成 SNS COM+ v3.3 安裝作業！
echo.

pause