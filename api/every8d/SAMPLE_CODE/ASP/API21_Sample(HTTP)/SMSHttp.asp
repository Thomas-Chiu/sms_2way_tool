<%
Class SMSHttp
	Private sendSMSUrl
	Private getCreditUrl
	Private batchID
	Private credit
	Private processMsg
	
	Sub Class_Initialize()
		sendSMSUrl = "http://api.every8d.com/API21/HTTP/sendSMS.ashx"
		getCreditUrl = "http://api.every8d.com/API21/HTTP/getCredit.ashx"
		batchID = ""
		credit = 0.0
		processMsg = ""
	End Sub
	
	''' <summary>
	''' 傳送簡訊
	''' </summary>
	''' <param name="userID">帳號</param>
	''' <param name="password">密碼</param>
	''' <param name="subject">簡訊主旨，主旨不會隨著簡訊內容發送出去。用以註記本次發送之用途。可傳入空字串。</param>
	''' <param name="content">簡訊發送內容</param>
	''' <param name="mobile">接收人之手機號碼。格式為: +886912345678或09123456789。多筆接收人時，請以半形逗點隔開( , )，如0912345678,0922333444。</param>
	''' <param name="sendTime">簡訊預定發送時間。-立即發送：請傳入空字串。-預約發送：請傳入預計發送時間，若傳送時間小於系統接單時間，將不予傳送。格式為YYYYMMDDhhmnss；例如:預約2009/01/31 15:30:00發送，則傳入20090131153000。若傳遞時間已逾現在之時間，將立即發送。</param>
	''' <returns>true:傳送成功；false:傳送失敗</returns>
	''' <remarks></remarks>
	Public Function sendSMS(userID, password, subject, content, mobile, sendTime)
		Dim success
		success = False
		Dim postDataString
		postDataString = "UID=" & userID & "&PWD=" & password & "&SB=" & subject & "&MSG=" & content & "&DEST=" & mobile & "&ST=" & sendTime
		 
		Dim resultString
		resultString = httpPost(sendSMSUrl, postDataString)
		 
		If Not Mid(resultString, 1, 1) = "-" Then
			''傳送成功 回傳字串內容格式為：CREDIT,SENDED,COST,UNSEND,BATCH_ID，各值中間以逗號分隔。
			'' CREDIT：發送後剩餘點數。負值代表發送失敗，系統無法處理該命令
			'' SENDED：發送通數。
			'' COST：本次發送扣除點數
			'' UNSEND：無額度時發送的通數，當該值大於0而剩餘點數等於0時表示有部份的簡訊因無額度而無法被發送。
			'' BATCH_ID：批次識別代碼。為一唯一識別碼，可藉由本識別碼查詢發送狀態。格式範例：220478cc-8506-49b2-93b7-2505f651c12e
			Dim splitStr
			splitStr = Split(resultString, ",")
			credit = CDbl(splitStr(0))
			batchID = splitStr(4)
			success = True
		Else
			''傳送失敗
			processMsg = resultString
		End If
		sendSMS = success
		 
	End Function
	
	''' <summary>
	''' 取得帳號餘額
	''' </summary>
	''' <param name="userID">帳號</param>
	''' <param name="password">密碼</param>
	''' <returns>true:取得成功；false:取得失敗</returns>
	''' <remarks></remarks>
	Public Function getCredit(userID, password)
		Dim success
		success = False
			Dim postDataString
			postDataString = "UID=" & userID & "&PWD=" & password
	
			Dim resultString
			resultString = httpPost(getCreditUrl, postDataString)
			If Not Mid(resultString, 1, 1) = "-" Then
				credit = CDbl(resultString)
				success = True
			Else
				processMsg = resultString
			End If
		getCredit = success
	End Function
	
	
	Private Function httpPost(url, postData)
		Dim result
		result = ""
		Dim winHttp
		Set winHttp = CreateObject("WinHttp.WinHttpRequest.5.1")
		winHttp.Open "POST", url, False
		winHttp.SetRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		winHttp.SetRequestHeader "Content-Length", CStr(Len(postData))
		winHttp.Send (postData)
		result = winHttp.ResponseText
		httpPost = result
	End Function

	Public Function getProcessMsg()
		getProcessMsg = processMsg
	End Function
	
	Public Function getBatchID()
		getBatchID = batchID
	End Function
	
	Public Function getCreditValue()
		getCreditValue = credit
	End Function

End Class
%>