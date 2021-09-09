Partial Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Protected Sub btnSend_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnSend.Click
        Dim smsSoap As SMSSoap = New SMSSoap()
        If smsSoap.getConnection(accountInputText.Value, passwordInputText.Value) Then
            If smsSoap.sendSMS(subjectInputText.Value, contentInputText.Value, phonesInputText.Value, "") Then
                Page.Controls.Add(New LiteralControl(New StringBuilder("<script>alert('發送成功！點數剩餘").Append(smsSoap.getCreditValue().ToString()).Append("點。');</script>").ToString()))
            Else
                Page.Controls.Add(New LiteralControl("<script>alert('發送失敗！');</script>"))
            End If
        Else
            Page.Controls.Add(New LiteralControl("<script>alert('取得連線失敗！');</script>"))
        End If
    End Sub
End Class