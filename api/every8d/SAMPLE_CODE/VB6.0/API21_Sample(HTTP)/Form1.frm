VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "API21 Sample(HTTP)"
   ClientHeight    =   5910
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   7815
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5910
   ScaleWidth      =   7815
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Caption         =   "簡訊發送"
      Height          =   4575
      Left            =   120
      TabIndex        =   11
      Top             =   1200
      Width           =   7575
      Begin VB.CommandButton btnSend 
         Caption         =   "傳送簡訊"
         Height          =   375
         Left            =   5760
         TabIndex        =   6
         Top             =   3960
         Width           =   1575
      End
      Begin VB.TextBox txtPhones 
         Height          =   285
         Left            =   240
         TabIndex        =   5
         Top             =   3480
         Width           =   7095
      End
      Begin VB.TextBox txtContent 
         Height          =   1695
         Left            =   240
         MultiLine       =   -1  'True
         TabIndex        =   4
         Top             =   1440
         Width           =   7095
      End
      Begin VB.TextBox txtSubject 
         Height          =   285
         Left            =   240
         TabIndex        =   3
         Top             =   840
         Width           =   7095
      End
      Begin VB.Label Label8 
         Caption         =   "點"
         Height          =   255
         Left            =   7080
         TabIndex        =   17
         Top             =   240
         Width           =   255
      End
      Begin VB.Label lblCredit 
         Caption         =   "------------"
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   6000
         TabIndex        =   16
         Top             =   240
         Width           =   975
      End
      Begin VB.Label Label7 
         Caption         =   "您目前尚有"
         Height          =   255
         Left            =   5040
         TabIndex        =   15
         Top             =   240
         Width           =   1095
      End
      Begin VB.Label Label5 
         Caption         =   "收訊人手機(多筆請用逗點隔開):"
         Height          =   255
         Left            =   240
         TabIndex        =   14
         Top             =   3240
         Width           =   2775
      End
      Begin VB.Label Label6 
         Caption         =   "發送內容:"
         Height          =   255
         Left            =   240
         TabIndex        =   13
         Top             =   1200
         Width           =   1455
      End
      Begin VB.Label Label4 
         Caption         =   "訊息主旨(不會隨著簡訊內容發送出去，僅會在報表中出現，方便您管理每一次的發送):"
         Height          =   375
         Left            =   240
         TabIndex        =   12
         Top             =   600
         Width           =   7215
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "登入EVERY8D"
      Height          =   975
      Left            =   120
      TabIndex        =   7
      Top             =   120
      Width           =   7575
      Begin VB.CommandButton btnLogin 
         Caption         =   "登入"
         Height          =   375
         Left            =   5760
         TabIndex        =   2
         Top             =   240
         Width           =   1575
      End
      Begin VB.TextBox txtPassword 
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   3600
         PasswordChar    =   "*"
         TabIndex        =   1
         Top             =   240
         Width           =   1815
      End
      Begin VB.TextBox txtUserID 
         Height          =   285
         Left            =   720
         TabIndex        =   0
         Top             =   240
         Width           =   1575
      End
      Begin VB.Label Label3 
         Caption         =   "(請輸入您在EVERY8D上註冊之帳號密碼)"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   360
         TabIndex        =   10
         Top             =   600
         Width           =   3255
      End
      Begin VB.Label Label2 
         Caption         =   "Password:"
         Height          =   255
         Left            =   2760
         TabIndex        =   9
         Top             =   240
         Width           =   855
      End
      Begin VB.Label Label1 
         Caption         =   "ID:"
         Height          =   375
         Left            =   360
         TabIndex        =   8
         Top             =   240
         Width           =   375
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private sms As SMSHttp

Private Sub btnLogin_Click()
    If sms.getCredit(Me.txtUserID.Text, Me.txtPassword.Text) Then
        lblCredit.Caption = CStr(sms.getCreditValue())
        MsgBox ("登入成功")
    Else
        MsgBox ("登入失敗")
    End If
    
End Sub

Private Sub btnSend_Click()
    If sms.sendSMS(txtUserID.Text, txtPassword.Text, txtSubject.Text, txtContent.Text, txtPhones.Text, "") Then
        lblCredit.Caption = CStr(sms.getCreditValue())
        MsgBox ("傳送成功")
    Else
        MsgBox ("傳送失敗")
    End If
End Sub

Private Sub Form_Load()
    Set sms = New SMSHttp
End Sub

