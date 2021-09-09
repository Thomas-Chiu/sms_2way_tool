<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Web_Sample_SOAP_._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>EVERY8D SMS API2.1 ASP.NET Sample (SOAP)</title>
	<style type="text/css">
		#subjectInputText
		{
			width: 617px;
		}
		#contentInputText
		{
			width: 614px;
			height: 60px;
		}
		#phonesInputText
		{
			width: 611px;
		}
	</style>
</head>
<body>
    <form id="form1" runat="server">
    <h2>EVERY8D SMS API2.1 ASP.NET Sample (SOAP)</h2>
    <div>
	帳號：<input id="accountInputText" type="text" runat="server"/>密碼：<input id="passwordInputText" type="password" runat="server"/>
    </div>
    <br />
    <div>
    	訊息主旨(不會隨著簡訊內容發送出去，僅會在報表中出現，方便您管理每一次的發送)：<br />
		<input id="subjectInputText" type="text" runat="server"/>
    </div>
    <div>
    	發送內容：<br />
		<textarea id="contentInputText" runat="server"></textarea>
    </div>
    <div>
		收訊人手機(多筆請用逗點隔開)：<br />
		<input id="phonesInputText" type="text" runat="server" />
    </div>
    <asp:Button ID="btnSend" runat="server" onclick="btnSend_Click" Text="發送" />
    </form>
</body>
</html>
