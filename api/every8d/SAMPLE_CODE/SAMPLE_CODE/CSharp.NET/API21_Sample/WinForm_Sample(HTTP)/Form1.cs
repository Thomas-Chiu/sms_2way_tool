using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WinForm_Sample_HTTP_ {
	public partial class Form1 : Form {
		private SMSHttp smsHttp = new SMSHttp();

		public Form1() {
			InitializeComponent();
		}

		private void btnLogin_Click(object sender, EventArgs e) {
			if (this.smsHttp.getCredit(this.txtUserID.Text, this.txtPassword.Text)) {
				//取得點數成功
				this.lblCredit.Text = this.smsHttp.Credit.ToString();
				MessageBox.Show("登入成功");
			} else {
				MessageBox.Show("登入失敗");
			}
		}

		private void btnSend_Click(object sender, EventArgs e) {
			if (this.smsHttp.sendSMS(this.txtUserID.Text, this.txtPassword.Text, this.txtSubject.Text, this.txtContent.Text, this.txtPhones.Text, "")) {
				this.lblCredit.Text = this.smsHttp.Credit.ToString();
				MessageBox.Show("傳送成功");
			} else {
				MessageBox.Show("傳送失敗");
			}
		}
	}
}
