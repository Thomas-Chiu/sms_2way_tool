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
echo *** �ЦA�U�F iisreset �� Windows IIS ���A�ϥ� SNS COM+ v3.4 DLL
echo.

dir "%INSTALL_DIR%\SnsComServer_v3.4.*"

echo.
echo *** �Y�S���ݨ� SnsComServer_v3.4.tlb �ɡA��ܧ��� SNS COM+ v3.4 �����w�˧@�~�I
echo.

pause