namespace WinForm_Sample_HTTP_ {
	partial class Form1 {
		/// <summary>
		/// 設計工具所需的變數。
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// 清除任何使用中的資源。
		/// </summary>
		/// <param name="disposing">如果應該處置 Managed 資源則為 true，否則為 false。</param>
		protected override void Dispose(bool disposing) {
			if (disposing && (components != null)) {
				components.Dispose();
			}
			base.Dispose(disposing);
		}

		#region Windows Form 設計工具產生的程式碼

		/// <summary>
		/// 此為設計工具支援所需的方法 - 請勿使用程式碼編輯器修改這個方法的內容。
		///
		/// </summary>
		private void InitializeComponent() {
			this.groupBox1 = new System.Windows.Forms.GroupBox();
			this.label3 = new System.Windows.Forms.Label();
			this.txtPassword = new System.Windows.Forms.TextBox();
			this.label2 = new System.Windows.Forms.Label();
			this.txtUserID = new System.Windows.Forms.TextBox();
			this.label1 = new System.Windows.Forms.Label();
			this.btnLogin = new System.Windows.Forms.Button();
			this.groupBox2 = new System.Windows.Forms.GroupBox();
			this.txtSubject = new System.Windows.Forms.TextBox();
			this.label8 = new System.Windows.Forms.Label();
			this.btnSend = new System.Windows.Forms.Button();
			this.txtPhones = new System.Windows.Forms.TextBox();
			this.label7 = new System.Windows.Forms.Label();
			this.txtContent = new System.Windows.Forms.TextBox();
			this.label6 = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.lblCredit = new System.Windows.Forms.Label();
			this.label4 = new System.Windows.Forms.Label();
			this.groupBox1.SuspendLayout();
			this.groupBox2.SuspendLayout();
			this.SuspendLayout();
			// 
			// groupBox1
			// 
			this.groupBox1.Controls.Add(this.label3);
			this.groupBox1.Controls.Add(this.txtPassword);
			this.groupBox1.Controls.Add(this.label2);
			this.groupBox1.Controls.Add(this.txtUserID);
			this.groupBox1.Controls.Add(this.label1);
			this.groupBox1.Controls.Add(this.btnLogin);
			this.groupBox1.Location = new System.Drawing.Point(12, 12);
			this.groupBox1.Name = "groupBox1";
			this.groupBox1.Size = new System.Drawing.Size(523, 63);
			this.groupBox1.TabIndex = 6;
			this.groupBox1.TabStop = false;
			this.groupBox1.Text = "登入EVERY8D";
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.ForeColor = System.Drawing.Color.Blue;
			this.label3.Location = new System.Drawing.Point(16, 45);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(221, 12);
			this.label3.TabIndex = 10;
			this.label3.Text = "(請輸入您在EVERY8D上註冊之帳號密碼)";
			// 
			// txtPassword
			// 
			this.txtPassword.Location = new System.Drawing.Point(239, 21);
			this.txtPassword.Name = "txtPassword";
			this.txtPassword.PasswordChar = '*';
			this.txtPassword.Size = new System.Drawing.Size(141, 22);
			this.txtPassword.TabIndex = 9;
			// 
			// label2
			// 
			this.label2.AutoSize = true;
			this.label2.Location = new System.Drawing.Point(182, 25);
			this.label2.Name = "label2";
			this.label2.Size = new System.Drawing.Size(51, 12);
			this.label2.TabIndex = 8;
			this.label2.Text = "Password:";
			// 
			// txtUserID
			// 
			this.txtUserID.Location = new System.Drawing.Point(43, 20);
			this.txtUserID.Name = "txtUserID";
			this.txtUserID.Size = new System.Drawing.Size(104, 22);
			this.txtUserID.TabIndex = 7;
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(17, 25);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(20, 12);
			this.label1.TabIndex = 6;
			this.label1.Text = "ID:";
			// 
			// btnLogin
			// 
			this.btnLogin.Location = new System.Drawing.Point(397, 20);
			this.btnLogin.Name = "btnLogin";
			this.btnLogin.Size = new System.Drawing.Size(95, 22);
			this.btnLogin.TabIndex = 5;
			this.btnLogin.Text = "登入";
			this.btnLogin.UseVisualStyleBackColor = true;
			this.btnLogin.Click += new System.EventHandler(this.btnLogin_Click);
			// 
			// groupBox2
			// 
			this.groupBox2.Controls.Add(this.txtSubject);
			this.groupBox2.Controls.Add(this.label8);
			this.groupBox2.Controls.Add(this.btnSend);
			this.groupBox2.Controls.Add(this.txtPhones);
			this.groupBox2.Controls.Add(this.label7);
			this.groupBox2.Controls.Add(this.txtContent);
			this.groupBox2.Controls.Add(this.label6);
			this.groupBox2.Controls.Add(this.label5);
			this.groupBox2.Controls.Add(this.lblCredit);
			this.groupBox2.Controls.Add(this.label4);
			this.groupBox2.Location = new System.Drawing.Point(12, 81);
			this.groupBox2.Name = "groupBox2";
			this.groupBox2.Size = new System.Drawing.Size(523, 299);
			this.groupBox2.TabIndex = 7;
			this.groupBox2.TabStop = false;
			this.groupBox2.Text = "簡訊發送";
			// 
			// txtSubject
			// 
			this.txtSubject.Location = new System.Drawing.Point(13, 53);
			this.txtSubject.Name = "txtSubject";
			this.txtSubject.Size = new System.Drawing.Size(479, 22);
			this.txtSubject.TabIndex = 9;
			// 
			// label8
			// 
			this.label8.AutoSize = true;
			this.label8.Location = new System.Drawing.Point(11, 38);
			this.label8.Name = "label8";
			this.label8.Size = new System.Drawing.Size(460, 12);
			this.label8.TabIndex = 8;
			this.label8.Text = "訊息主旨(不會隨著簡訊內容發送出去，僅會在報表中出現，方便您管理每一次的發送):";
			// 
			// btnSend
			// 
			this.btnSend.Location = new System.Drawing.Point(386, 266);
			this.btnSend.Name = "btnSend";
			this.btnSend.Size = new System.Drawing.Size(106, 27);
			this.btnSend.TabIndex = 7;
			this.btnSend.Text = "傳送簡訊";
			this.btnSend.UseVisualStyleBackColor = true;
			this.btnSend.Click += new System.EventHandler(this.btnSend_Click);
			// 
			// txtPhones
			// 
			this.txtPhones.Location = new System.Drawing.Point(15, 234);
			this.txtPhones.Name = "txtPhones";
			this.txtPhones.Size = new System.Drawing.Size(477, 22);
			this.txtPhones.TabIndex = 6;
			// 
			// label7
			// 
			this.label7.AutoSize = true;
			this.label7.Location = new System.Drawing.Point(11, 212);
			this.label7.Name = "label7";
			this.label7.Size = new System.Drawing.Size(172, 12);
			this.label7.TabIndex = 5;
			this.label7.Text = "收訊人手機(多筆請用逗點隔開):";
			// 
			// txtContent
			// 
			this.txtContent.Location = new System.Drawing.Point(13, 94);
			this.txtContent.Multiline = true;
			this.txtContent.Name = "txtContent";
			this.txtContent.Size = new System.Drawing.Size(479, 105);
			this.txtContent.TabIndex = 4;
			// 
			// label6
			// 
			this.label6.AutoSize = true;
			this.label6.Location = new System.Drawing.Point(16, 78);
			this.label6.Name = "label6";
			this.label6.Size = new System.Drawing.Size(56, 12);
			this.label6.TabIndex = 3;
			this.label6.Text = "發送內容:";
			// 
			// label5
			// 
			this.label5.AutoSize = true;
			this.label5.Location = new System.Drawing.Point(475, 18);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(17, 12);
			this.label5.TabIndex = 2;
			this.label5.Text = "點";
			// 
			// lblCredit
			// 
			this.lblCredit.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
			this.lblCredit.AutoSize = true;
			this.lblCredit.ForeColor = System.Drawing.Color.Red;
			this.lblCredit.Location = new System.Drawing.Point(417, 18);
			this.lblCredit.Name = "lblCredit";
			this.lblCredit.Size = new System.Drawing.Size(53, 12);
			this.lblCredit.TabIndex = 1;
			this.lblCredit.Text = "------------";
			// 
			// label4
			// 
			this.label4.AutoSize = true;
			this.label4.Location = new System.Drawing.Point(346, 18);
			this.label4.Name = "label4";
			this.label4.Size = new System.Drawing.Size(65, 12);
			this.label4.TabIndex = 0;
			this.label4.Text = "您目前尚有";
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(547, 392);
			this.Controls.Add(this.groupBox2);
			this.Controls.Add(this.groupBox1);
			this.MaximizeBox = false;
			this.Name = "Form1";
			this.Text = "EVERY8D SMS API2.1 WinForm Sample (HTTP)";
			this.groupBox1.ResumeLayout(false);
			this.groupBox1.PerformLayout();
			this.groupBox2.ResumeLayout(false);
			this.groupBox2.PerformLayout();
			this.ResumeLayout(false);

		}

		#endregion

		private System.Windows.Forms.GroupBox groupBox1;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.TextBox txtPassword;
		private System.Windows.Forms.Label label2;
		private System.Windows.Forms.TextBox txtUserID;
		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Button btnLogin;
		private System.Windows.Forms.GroupBox groupBox2;
		private System.Windows.Forms.TextBox txtSubject;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.Button btnSend;
		private System.Windows.Forms.TextBox txtPhones;
		private System.Windows.Forms.Label label7;
		private System.Windows.Forms.TextBox txtContent;
		private System.Windows.Forms.Label label6;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Label lblCredit;
		private System.Windows.Forms.Label label4;
	}
}

