Public Class Form1
    Private smsSoap As SMSSoap = New SMSSoap()

    Private Sub btnLogin_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        If smsSoap.getConnection(txtUserID.Text, txtPassword.Text) Then
            If smsSoap.getCredit() Then
                lblCredit.Text = smsSoap.getCreditValue().ToString()
            End If
            MessageBox.Show("登入成功")
        Else
            MessageBox.Show("登入失敗")
        End If
    End Sub

    Private Sub btnSend_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSend.Click
        Dim isConnected As Boolean = smsSoap.isConnected()
        If Not isConnected Then
            If smsSoap.getConnection(txtUserID.Text, txtPassword.Text) Then
                isConnected = True
            Else
                MessageBox.Show("登入失敗")
            End If
        End If

        If isConnected Then
            If smsSoap.sendSMS(txtSubject.Text, txtContent.Text, txtPhones.Text, "") Then
                lblCredit.Text = smsSoap.getCreditValue().ToString()
                MessageBox.Show("傳送成功")
            Else
                MessageBox.Show("傳送失敗")
            End If
        End If
    End Sub
End Class
