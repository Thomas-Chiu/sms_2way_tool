echo off
echo.

set INSTALL_DIR=C:\SNS_COM+ v3.3

dir "%INSTALL_DIR%\SnsComServer_v3.3.*"

echo.
echo *** Uninstall SnsComServer_v3.3.dll from .NET Framework 2.0
echo.
%windir%\Microsoft.NET\Framework\v2.0.50727\regasm.exe "%INSTALL_DIR%\SnsComServer_v3.3.dll" /unregister /tlb:"%INSTALL_DIR%\SnsComServer_v3.3.tlb"

del SnsComServer_v3.3.tlb

echo.
echo *** �ЦA�U�F iisreset �� Windows IIS ���A�ϥ� SNS COM+ v3.3 DLL
echo.

dir "%INSTALL_DIR%\SnsComServer_v3.3.*"

echo.
echo *** �Y�S���ݨ� SnsComServer_v3.3.tlb �ɡA��ܧ��� SNS COM+ v3.3 �����w�˧@�~�I
echo.

pause