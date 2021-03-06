<% res="kmsgid="&Request("kmsgid")&" dstaddr="&Request("dstaddr")&"
dlvtime="&Request("dlvtime")&" donetime="&Request("donetime")&"
statusstr="&Request("statusstr") FimeName=server.mappath("retccmoapi.txt") set
fso = server.CreateObject("Scripting.FileSystemObject") If
(fso.FileExists(FimeName)) Then Set f = fso.OpenTextFile(FimeName, 1)
ReadAllTextFile = f.ReadAll end if Set f =
fso.CreateTextFile(FimeName,True,False) f.Write ReadAllTextFile & res & vbcrlf
set fso = nothing set f = nothing %>
