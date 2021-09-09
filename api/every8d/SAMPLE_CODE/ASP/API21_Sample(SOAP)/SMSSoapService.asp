<%
Class SMSSoapService
	Private soapUrl

	Private Sub Class_Initialize()
		 soapUrl = "http://api.every8d.com/API21/SOAP/SMS.asmx"
	End Sub
	
	Public Function getConnection(userID, password)
		Dim result
		Dim soapData
		Dim soapResponse
		Dim xmlDoc
		Set xmlDoc = CreateObject("Microsoft.XMLDOM")
		'參考『http://api.every8d.com/API21/SOAP/SMS.asmx?op=getConnection』組合SOAP資料
		soapData = "<?xml version='1.0' encoding='utf-8'?>"
		soapData = soapData & "<soap12:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap12='http://www.w3.org/2003/05/soap-envelope'>"
		soapData = soapData & "<soap12:Body>"
		soapData = soapData & "<getConnection xmlns='http://tempuri.org/'>"
		soapData = soapData & "<userID>" & userID & "</userID>"
		soapData = soapData & "<password>" & password & "</password>"
		soapData = soapData & "</getConnection>"
		soapData = soapData & "</soap12:Body>"
		soapData = soapData & "</soap12:Envelope>"
		soapResponse = httpPostSoap12(soapUrl, soapData)
		xmlDoc.loadXML soapResponse
		result = xmlDoc.selectSingleNode("//getConnectionResult").Text
		 
		getConnection = result
	End Function
	
	Public Function closeConnection(sessionKey)
		Dim result
		Dim soapData
		Dim soapResponse
		Dim xmlDoc
		Set xmlDoc = CreateObject("Microsoft.XMLDOM")
		'參考『http://api.every8d.com/API21/SOAP/SMS.asmx?op=closeConnection』組合SOAP資料
		soapData = "<?xml version='1.0' encoding='utf-8'?>"
		soapData = soapData & "<soap12:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap12='http://www.w3.org/2003/05/soap-envelope'>"
		soapData = soapData & "<soap12:Body>"
		soapData = soapData & "<closeConnection xmlns='http://tempuri.org/'>"
		soapData = soapData & "<sessionKey>" & sessionKey & "</sessionKey>"
		soapData = soapData & "</closeConnection>"
		soapData = soapData & "</soap12:Body>"
		soapData = soapData & "</soap12:Envelope>"
		soapResponse = httpPostSoap12(soapUrl, soapData)
		xmlDoc.loadXML soapResponse
		result = xmlDoc.selectSingleNode("//closeConnectionResult").Text
		closeConnection = result
	End Function
	
	Public Function sendSMS(sessionKey, subject, content, mobile, sendTime)
		Dim result
		Dim soapData
		Dim soapResponse
		Dim xmlDoc
		Set xmlDoc = CreateObject("Microsoft.XMLDOM")
		'參考『http://api.every8d.com/API21/SOAP/SMS.asmx?op=sendSMS』組合SOAP資料
		soapData = "<?xml version='1.0' encoding='utf-8'?>"
		soapData = soapData & "<soap12:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap12='http://www.w3.org/2003/05/soap-envelope'>"
		soapData = soapData & "<soap12:Body>"
		soapData = soapData & "<sendSMS xmlns='http://tempuri.org/'>"
		soapData = soapData & "<sessionKey>" & sessionKey & "</sessionKey>"
		soapData = soapData & "<subject>" & subject & "</subject>"
		soapData = soapData & "<content>" & content & "</content>"
		soapData = soapData & "<mobile>" & mobile & "</mobile>"
		soapData = soapData & "<sendTime>" & sendTime & "</sendTime>"
		soapData = soapData & "</sendSMS>"
		soapData = soapData & "</soap12:Body>"
		soapData = soapData & "</soap12:Envelope>"
		soapResponse = httpPostSoap12(soapUrl, soapData)
		xmlDoc.loadXML soapResponse
		result = xmlDoc.selectSingleNode("//sendSMSResult").Text
		sendSMS = result
	End Function
	
	Public Function getCredit(sessionKey)
		Dim result
		Dim soapData
		Dim soapResponse
		Dim xmlDoc
		Set xmlDoc = CreateObject("Microsoft.XMLDOM")
		'參考『http://api.every8d.com/API21/SOAP/SMS.asmx?op=getCredit』組合SOAP資料
		soapData = "<?xml version='1.0' encoding='utf-8'?>"
		soapData = soapData & "<soap12:Envelope xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:xsd='http://www.w3.org/2001/XMLSchema' xmlns:soap12='http://www.w3.org/2003/05/soap-envelope'>"
		soapData = soapData & "<soap12:Body>"
		soapData = soapData & "<getCredit xmlns='http://tempuri.org/'>"
		soapData = soapData & "<sessionKey>" & sessionKey & "</sessionKey>"
		soapData = soapData & "</getCredit>"
		soapData = soapData & "</soap12:Body>"
		soapData = soapData & "</soap12:Envelope>"
		soapResponse = httpPostSoap12(soapUrl, soapData)
		xmlDoc.loadXML soapResponse
		result = xmlDoc.selectSingleNode("//getCreditResult").Text
		getCredit = result
	End Function
	
	Private Function httpPostSoap12(url, postData)
		Dim result
		result = ""
		Dim winHttp
		Set winHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
		winHttp.Open "POST", url, False
		winHttp.SetRequestHeader "Content-Type", "application/soap+xml; charset=utf-8"
		winHttp.SetRequestHeader "Content-Length", Len(postData)
		winHttp.Send (postData)
		result = winHttp.ResponseText
		httpPostSoap12 = result
	End Function
End Class
%>
