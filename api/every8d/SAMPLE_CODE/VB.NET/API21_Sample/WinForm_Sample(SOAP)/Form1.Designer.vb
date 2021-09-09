<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form 覆寫 Dispose 以清除元件清單。
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    '為 Windows Form 設計工具的必要項
    Private components As System.ComponentModel.IContainer

    '注意: 以下為 Windows Form 設計工具所需的程序
    '可以使用 Windows Form 設計工具進行修改。
    '請不要使用程式碼編輯器進行修改。
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.groupBox1 = New System.Windows.Forms.GroupBox
        Me.label3 = New System.Windows.Forms.Label
        Me.txtPassword = New System.Windows.Forms.TextBox
        Me.label2 = New System.Windows.Forms.Label
        Me.txtUserID = New System.Windows.Forms.TextBox
        Me.label1 = New System.Windows.Forms.Label
        Me.btnLogin = New System.Windows.Forms.Button
        Me.groupBox2 = New System.Windows.Forms.GroupBox
        Me.txtSubject = New System.Windows.Forms.TextBox
        Me.label8 = New System.Windows.Forms.Label
        Me.btnSend = New System.Windows.Forms.Button
        Me.txtPhones = New System.Windows.Forms.TextBox
        Me.label7 = New System.Windows.Forms.Label
        Me.txtContent = New System.Windows.Forms.TextBox
        Me.label6 = New System.Windows.Forms.Label
        Me.label5 = New System.Windows.Forms.Label
        Me.lblCredit = New System.Windows.Forms.Label
        Me.label4 = New System.Windows.Forms.Label
        Me.groupBox1.SuspendLayout()
        Me.groupBox2.SuspendLayout()
        Me.SuspendLayout()
        '
        'groupBox1
        '
        Me.groupBox1.Controls.Add(Me.label3)
        Me.groupBox1.Controls.Add(Me.txtPassword)
        Me.groupBox1.Controls.Add(Me.label2)
        Me.groupBox1.Controls.Add(Me.txtUserID)
        Me.groupBox1.Controls.Add(Me.label1)
        Me.groupBox1.Controls.Add(Me.btnLogin)
        Me.groupBox1.Location = New System.Drawing.Point(12, 12)
        Me.groupBox1.Name = "groupBox1"
        Me.groupBox1.Size = New System.Drawing.Size(523, 63)
        Me.groupBox1.TabIndex = 7
        Me.groupBox1.TabStop = False
        Me.groupBox1.Text = "登入EVERY8D"
        '
        'label3
        '
        Me.label3.AutoSize = True
        Me.label3.ForeColor = System.Drawing.Color.Blue
        Me.label3.Location = New System.Drawing.Point(16, 45)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(221, 12)
        Me.label3.TabIndex = 10
        Me.label3.Text = "(請輸入您在EVERY8D上註冊之帳號密碼)"
        '
        'txtPassword
        '
        Me.txtPassword.Location = New System.Drawing.Point(239, 21)
        Me.txtPassword.Name = "txtPassword"
        Me.txtPassword.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPassword.Size = New System.Drawing.Size(141, 22)
        Me.txtPassword.TabIndex = 9
        '
        'label2
        '
        Me.label2.AutoSize = True
        Me.label2.Location = New System.Drawing.Point(182, 25)
        Me.label2.Name = "label2"
        Me.label2.Size = New System.Drawing.Size(51, 12)
        Me.label2.TabIndex = 8
        Me.label2.Text = "Password:"
        '
        'txtUserID
        '
        Me.txtUserID.Location = New System.Drawing.Point(43, 20)
        Me.txtUserID.Name = "txtUserID"
        Me.txtUserID.Size = New System.Drawing.Size(104, 22)
        Me.txtUserID.TabIndex = 7
        '
        'label1
        '
        Me.label1.AutoSize = True
        Me.label1.Location = New System.Drawing.Point(17, 25)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(20, 12)
        Me.label1.TabIndex = 6
        Me.label1.Text = "ID:"
        '
        'btnLogin
        '
        Me.btnLogin.Location = New System.Drawing.Point(397, 20)
        Me.btnLogin.Name = "btnLogin"
        Me.btnLogin.Size = New System.Drawing.Size(95, 22)
        Me.btnLogin.TabIndex = 5
        Me.btnLogin.Text = "登入"
        Me.btnLogin.UseVisualStyleBackColor = True
        '
        'groupBox2
        '
        Me.groupBox2.Controls.Add(Me.txtSubject)
        Me.groupBox2.Controls.Add(Me.label8)
        Me.groupBox2.Controls.Add(Me.btnSend)
        Me.groupBox2.Controls.Add(Me.txtPhones)
        Me.groupBox2.Controls.Add(Me.label7)
        Me.groupBox2.Controls.Add(Me.txtContent)
        Me.groupBox2.Controls.Add(Me.label6)
        Me.groupBox2.Controls.Add(Me.label5)
        Me.groupBox2.Controls.Add(Me.lblCredit)
        Me.groupBox2.Controls.Add(Me.label4)
        Me.groupBox2.Location = New System.Drawing.Point(12, 81)
        Me.groupBox2.Name = "groupBox2"
        Me.groupBox2.Size = New System.Drawing.Size(523, 299)
        Me.groupBox2.TabIndex = 8
        Me.groupBox2.TabStop = False
        Me.groupBox2.Text = "簡訊發送"
        '
        'txtSubject
        '
        Me.txtSubject.Location = New System.Drawing.Point(13, 53)
        Me.txtSubject.Name = "txtSubject"
        Me.txtSubject.Size = New System.Drawing.Size(479, 22)
        Me.txtSubject.TabIndex = 9
        '
        'label8
        '
        Me.label8.AutoSize = True
        Me.label8.Location = New System.Drawing.Point(11, 38)
        Me.label8.Name = "label8"
        Me.label8.Size = New System.Drawing.Size(460, 12)
        Me.label8.TabIndex = 8
        Me.label8.Text = "訊息主旨(不會隨著簡訊內容發送出去，僅會在報表中出現，方便您管理每一次的發送):"
        '
        'btnSend
        '
        Me.btnSend.Location = New System.Drawing.Point(386, 266)
        Me.btnSend.Name = "btnSend"
        Me.btnSend.Size = New System.Drawing.Size(106, 27)
        Me.btnSend.TabIndex = 7
        Me.btnSend.Text = "傳送簡訊"
        Me.btnSend.UseVisualStyleBackColor = True
        '
        'txtPhones
        '
        Me.txtPhones.Location = New System.Drawing.Point(15, 234)
        Me.txtPhones.Name = "txtPhones"
        Me.txtPhones.Size = New System.Drawing.Size(477, 22)
        Me.txtPhones.TabIndex = 6
        '
        'label7
        '
        Me.label7.AutoSize = True
        Me.label7.Location = New System.Drawing.Point(11, 212)
        Me.label7.Name = "label7"
        Me.label7.Size = New System.Drawing.Size(172, 12)
        Me.label7.TabIndex = 5
        Me.label7.Text = "收訊人手機(多筆請用逗點隔開):"
        '
        'txtContent
        '
        Me.txtContent.Location = New System.Drawing.Point(13, 94)
        Me.txtContent.Multiline = True
        Me.txtContent.Name = "txtContent"
        Me.txtContent.Size = New System.Drawing.Size(479, 105)
        Me.txtContent.TabIndex = 4
        '
        'label6
        '
        Me.label6.AutoSize = True
        Me.label6.Location = New System.Drawing.Point(16, 78)
        Me.label6.Name = "label6"
        Me.label6.Size = New System.Drawing.Size(56, 12)
        Me.label6.TabIndex = 3
        Me.label6.Text = "發送內容:"
        '
        'label5
        '
        Me.label5.AutoSize = True
        Me.label5.Location = New System.Drawing.Point(475, 18)
        Me.label5.Name = "label5"
        Me.label5.Size = New System.Drawing.Size(17, 12)
        Me.label5.TabIndex = 2
        Me.label5.Text = "點"
        '
        'lblCredit
        '
        Me.lblCredit.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.lblCredit.AutoSize = True
        Me.lblCredit.ForeColor = System.Drawing.Color.Red
        Me.lblCredit.Location = New System.Drawing.Point(417, 18)
        Me.lblCredit.Name = "lblCredit"
        Me.lblCredit.Size = New System.Drawing.Size(53, 12)
        Me.lblCredit.TabIndex = 1
        Me.lblCredit.Text = "------------"
        '
        'label4
        '
        Me.label4.AutoSize = True
        Me.label4.Location = New System.Drawing.Point(346, 18)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(65, 12)
        Me.label4.TabIndex = 0
        Me.label4.Text = "您目前尚有"
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(542, 386)
        Me.Controls.Add(Me.groupBox2)
        Me.Controls.Add(Me.groupBox1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Fixed3D
        Me.MaximizeBox = False
        Me.Name = "Form1"
        Me.Text = "EVERY8D SMS API2.1 WinForm Sample (SOAP)"
        Me.groupBox1.ResumeLayout(False)
        Me.groupBox1.PerformLayout()
        Me.groupBox2.ResumeLayout(False)
        Me.groupBox2.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Private WithEvents groupBox1 As System.Windows.Forms.GroupBox
    Private WithEvents label3 As System.Windows.Forms.Label
    Private WithEvents txtPassword As System.Windows.Forms.TextBox
    Private WithEvents label2 As System.Windows.Forms.Label
    Private WithEvents txtUserID As System.Windows.Forms.TextBox
    Private WithEvents label1 As System.Windows.Forms.Label
    Private WithEvents btnLogin As System.Windows.Forms.Button
    Private WithEvents groupBox2 As System.Windows.Forms.GroupBox
    Private WithEvents txtSubject As System.Windows.Forms.TextBox
    Private WithEvents label8 As System.Windows.Forms.Label
    Private WithEvents btnSend As System.Windows.Forms.Button
    Private WithEvents txtPhones As System.Windows.Forms.TextBox
    Private WithEvents label7 As System.Windows.Forms.Label
    Private WithEvents txtContent As System.Windows.Forms.TextBox
    Private WithEvents label6 As System.Windows.Forms.Label
    Private WithEvents label5 As System.Windows.Forms.Label
    Private WithEvents lblCredit As System.Windows.Forms.Label
    Private WithEvents label4 As System.Windows.Forms.Label

End Class
