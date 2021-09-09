Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSend.Click
        Dim smsHttp As SMSHttp = New SMSHttp()
        If smsHttp.sendSMS(accountInputText.Value, passwordInputText.Value, subjectInputText.Value, contentInputText.Value, phonesInputText.Value, "") Then
            Page.Controls.Add(New LiteralControl(New StringBuilder("<script>alert('發送成功！點數剩餘").Append(smsHttp.getCreditValue().ToString()).Append("點。');</script>").ToString()))
        Else
            Page.Controls.Add(New LiteralControl("<script>alert('發送失敗！');</script>"))
        End If
    End Sub
End Class