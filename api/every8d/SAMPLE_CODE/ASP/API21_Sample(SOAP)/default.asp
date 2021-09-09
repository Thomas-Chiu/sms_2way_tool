<!-- #INCLUDE virtual="/SMSSoap.asp" -->
<html>
<head>
	<title>EVERY8D SMS API2.1 ASP Sample (SOAP)</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>

<body>
<%
	Dim sms
	Set sms = New SMSSoap
	Dim userID
	Dim password
	Dim subject
	Dim content
	Dim phones
	Dim sendTime
	userID = "0963139051"	'發送帳號
	password ="1qaz" '發送密碼
	subject = "ASP test"	'簡訊主旨，主旨不會隨著簡訊內容發送出去。用以註記本次發送之用途。可傳入空字串。
	content = "API2.1 test  ASP Sample SOAP"	'簡訊內容
	phones = "0963139051"	'接收人之手機號碼。格式為: +886912345678或09123456789。多筆接收人時，請以半形逗點隔開( , )，如0912345678,0922333444。
	sendTime = ""	'簡訊預定發送時間。-立即發送：請傳入空字串。-預約發送：請傳入預計發送時間，若傳送時間小於系統接單時間，將不予傳送。格式為YYYYMMDDhhmnss；例如:預約2009/01/31 15:30:00發送，則傳入20090131153000。若傳遞時間已逾現在之時間，將立即發送。
	
	'取得連線
	If sms.getConnection(userID, password) Then
		'取得連線成功
		Response.Write "取得連線成功，SessionKey=" & sms.getSessionKey() & "<br />"
	Else
		Response.Write "取得連線失敗，" & sms.getProcessMsg() & "<br />"
	End If
	
	'取餘額
	If sms.getCredit() Then
		'取得餘額成功
		Response.Write "取得餘額成功，餘額：" & CStr(sms.getCreditValue()) & "<br />"
	Else
		Response.Write "取得餘額失敗，" & sms.getProcessMsg() & "<br />"
	End If
	
	'傳送簡訊
	If sms.sendSMS(subject, content, phones, sendTime) Then
		'傳送簡訊成功
		Response.Write "傳送簡訊成功，餘額：" & CStr(sms.getCreditValue()) & "，此次簡訊批號為：" & sms.getBatchID() & "<br />"
	Else
		Response.Write "傳送簡訊失敗，" & sms.getProcessMsg() & "<br />"
	End If
%>
</body>

</html>
