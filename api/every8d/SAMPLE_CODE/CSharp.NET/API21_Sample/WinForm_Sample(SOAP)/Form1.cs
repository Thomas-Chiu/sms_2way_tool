using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace WinForm_Sample_SOAP_ {
	public partial class Form1 : Form {
		private SMSSoap smsSoap = new SMSSoap();

		public Form1() {
			InitializeComponent();
		}

		private void btnLogin_Click(object sender, EventArgs e) {
			if (this.smsSoap.getConnection(this.txtUserID.Text, this.txtPassword.Text)) {
				if (this.smsSoap.getCredit()) {
					//取得點數成功
					this.lblCredit.Text = this.smsSoap.Credit.ToString();
				}
				MessageBox.Show("登入成功");
			} else {
				MessageBox.Show("登入失敗");
			}
		}

		private void btnSend_Click(object sender, EventArgs e) {
			bool isConnected = this.smsSoap.isConnected();
			if (!isConnected) {
				if (this.smsSoap.getConnection(this.txtUserID.Text, this.txtPassword.Text)) {
					isConnected = true;
				} else {
					MessageBox.Show("登入失敗");
				}
			}
			if (isConnected) {
				if (this.smsSoap.sendSMS(this.txtSubject.Text, this.txtContent.Text, this.txtPhones.Text, "")) {
					this.lblCredit.Text = this.smsSoap.Credit.ToString();
					MessageBox.Show("傳送成功");
				} else {
					MessageBox.Show("傳送失敗");
				}
			}
		}
	}
}
