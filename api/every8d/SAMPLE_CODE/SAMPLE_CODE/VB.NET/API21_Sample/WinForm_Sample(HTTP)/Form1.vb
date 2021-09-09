Public Class Form1
    Private smsHttp As SMSHttp = New SMSHttp()

    Private Sub btnLogin_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        If smsHttp.getCredit(txtUserID.Text, txtPassword.Text) Then
            ''取得點數成功
            lblCredit.Text = smsHttp.getCreditValue().ToString()
            MessageBox.Show("登入成功")
        Else
            MessageBox.Show("登入失敗")
        End If
    End Sub

    Private Sub btnSend_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSend.Click
        If smsHttp.sendSMS(txtUserID.Text, txtPassword.Text, txtSubject.Text, txtContent.Text, txtPhones.Text, "") Then
            lblCredit.Text = smsHttp.getCreditValue().ToString()
            MessageBox.Show("傳送成功")
        Else
            MessageBox.Show("傳送失敗")
        End If
    End Sub
End Class
