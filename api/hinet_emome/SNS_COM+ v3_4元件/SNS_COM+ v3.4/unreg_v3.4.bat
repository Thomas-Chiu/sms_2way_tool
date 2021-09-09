echo off
echo.

set INSTALL_DIR=C:\SNS_COM+ v3.4

dir "%INSTALL_DIR%\SnsComServer_v3.4.*"

echo.
echo *** Uninstall SnsComServer_v3.4.dll from .NET Framework 2.0
echo.
%windir%\Microsoft.NET\Framework\v2.0.50727\regsvcs.exe /u "%INSTALL_DIR%\SnsComServer_v3.4.dll"

del SnsComServer_v3.4.tlb

echo.
echo *** 請再下達 iisreset 使 Windows IIS 不再使用 SNS COM+ v3.4 DLL
echo.

dir "%INSTALL_DIR%\SnsComServer_v3.4.*"

echo.
echo *** 若沒有看到 SnsComServer_v3.4.tlb 檔，表示完成 SNS COM+ v3.4 移除安裝作業！
echo.

pause