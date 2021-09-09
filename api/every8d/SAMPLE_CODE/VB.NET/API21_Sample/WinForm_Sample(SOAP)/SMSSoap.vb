Imports System.Xml

Public Class SMSSoap
    Private smsService As SMSService.SMS
    Private sessionKey As String
    Private batchID As String
    Private credit As Double
    Private processMsg As String

    Public Sub New()
        smsService = New SMSService.SMS()
    End Sub

    ''' <summary>
    ''' 提供啟動連結服務，傳送簡訊前必須先取得取得SessionKey，
    ''' 藉由此SessionKey進行後續簡訊傳送之服務，SessionKey有效期為單日，隔日即失效。
    ''' 建議於完成傳送作業後，執行closeConnection以確保安全。
    ''' </summary>
    ''' <param name="userID">登入帳號</param>
    ''' <param name="password">密碼</param>
    ''' <returns>true:取得連線成功；false:取得連線失敗</returns>
    ''' <remarks></remarks>
    Public Function getConnection(ByVal userID As String, ByVal password As String) As Boolean
        Dim success As Boolean = False
        Try
            Dim resultXml As String = smsService.getConnection(userID, password)
            Dim xmlDoc As XmlDocument = New XmlDocument()
            xmlDoc.LoadXml(resultXml)
            Dim returnCode As String = xmlDoc.SelectSingleNode("/SMS/GET_CONNECTION/CODE").InnerText
            If returnCode.Equals("0") Then
                sessionKey = xmlDoc.SelectSingleNode("/SMS/GET_CONNECTION/SESSION_KEY").InnerText
                processMsg = xmlDoc.SelectSingleNode("/SMS/GET_CONNECTION/DESCRIPTION").InnerText
                success = True
            Else
                processMsg = xmlDoc.SelectSingleNode("/SMS/GET_CONNECTION/DESCRIPTION").InnerText
            End If
        Catch ex As Exception
            processMsg = ex.ToString()
        End Try
        Return success
    End Function

    ''' <summary>
    ''' SessionKey有效期為單日，隔日即失效。建議於完成傳送作業後，執行closeConnection以確保安全
    ''' </summary>
    ''' <returns>true:關閉成功；false:關閉失敗</returns>
    ''' <remarks></remarks>
    Public Function closeConnection() As Boolean
        Dim success As Boolean = False
        Try
            Dim resultString As String = smsService.closeConnection(sessionKey)
            If Not resultString.StartsWith("-") Then
                sessionKey = ""
                success = True
            End If
        Catch ex As Exception
            processMsg = ex.ToString()
        End Try
        Return success
    End Function

    ''' <summary>
    ''' 傳送簡訊
    ''' </summary>
    ''' <param name="subject">簡訊主旨，主旨不會隨著簡訊內容發送出去。用以註記本次發送之用途。可傳入空字串。</param>
    ''' <param name="content">簡訊發送內容</param>
    ''' <param name="mobile">接收人之手機號碼。格式為: +886912345678或09123456789。多筆接收人時，請以半形逗點隔開( , )，如0912345678,0922333444。</param>
    ''' <param name="sendTime">簡訊預定發送時間。-立即發送：請傳入空字串。-預約發送：請傳入預計發送時間，若傳送時間小於系統接單時間，將不予傳送。格式為YYYYMMDDhhmnss；例如:預約2009/01/31 15:30:00發送，則傳入20090131153000。若傳遞時間已逾現在之時間，將立即發送。</param>
    ''' <returns>true:傳送成功；false:傳送失敗</returns>
    ''' <remarks></remarks>
    Public Function sendSMS(ByVal subject As String, ByVal content As String, ByVal mobile As String, ByVal sendTime As String) As Boolean
        Dim success As Boolean = False
        Try
            If Not String.IsNullOrEmpty(sendTime) Then
                Try
                    ''檢查傳送時間格式是否正確
                    Dim checkDt As DateTime = DateTime.ParseExact(sendTime, "yyyyMMddHHmmss", System.Globalization.CultureInfo.CurrentCulture)
                    If Not sendTime.Equals(checkDt.ToString("yyyyMMddHHmmss")) Then
                        processMsg = "傳送時間格式錯誤"
                        Return False
                    End If
                Catch ex As Exception
                    processMsg = "傳送時間格式錯誤"
                    Return False
                End Try
            End If

            Dim resultString As String = smsService.sendSMS(sessionKey, subject, content, mobile, sendTime)
            If Not resultString.StartsWith("-") Then
                ''傳送成功 回傳字串內容格式為：CREDIT,SENDED,COST,UNSEND,BATCH_ID，各值中間以逗號分隔。
                '' CREDIT：發送後剩餘點數。負值代表發送失敗，系統無法處理該命令
                '' SENDED：發送通數。
                '' COST：本次發送扣除點數
                '' UNSEND：無額度時發送的通數，當該值大於0而剩餘點數等於0時表示有部份的簡訊因無額度而無法被發送。
                '' BATCH_ID：批次識別代碼。為一唯一識別碼，可藉由本識別碼查詢發送狀態。格式範例：220478cc-8506-49b2-93b7-2505f651c12e
                Dim split() As String = resultString.Split(",")
                credit = Convert.ToDouble(split(0))
                batchID = split(4)
                success = True
            Else
                ''傳送失敗
                processMsg = resultString
            End If
        Catch ex As Exception
            processMsg = ex.ToString()
        End Try
        Return success
    End Function

    ''' <summary>
    ''' 取得帳號餘額
    ''' </summary>
    ''' <returns>true:取得成功；false:取得失敗</returns>
    ''' <remarks></remarks>
    Public Function getCredit() As Boolean
        Dim success As Boolean = False
        Try
            Dim resultString As String = smsService.getCredit(sessionKey)
            If Not resultString.StartsWith("-") Then
                credit = Convert.ToDouble(resultString)
                success = True
            Else
                processMsg = resultString
            End If
        Catch ex As Exception
            processMsg = ex.ToString()
        End Try
        Return success
    End Function

    Public Function isConnected() As Boolean
        If Not String.IsNullOrEmpty(sessionKey) Then
            Return True
        End If
        Return False
    End Function

    Public Function getProcessMsg() As String
        Return processMsg
    End Function

    Public Function getBatchID() As String
        Return batchID
    End Function

    Public Function getCreditValue() As Double
        Return credit
    End Function

End Class
