using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

namespace Web_Sample_SOAP_ {
	public partial class _Default : System.Web.UI.Page {
		protected void Page_Load(object sender, EventArgs e) {

		}

		protected void btnSend_Click(object sender, EventArgs e) {
			SMSSoap smsSoap = new SMSSoap();
			if (smsSoap.getConnection(this.accountInputText.Value, this.passwordInputText.Value)) {
				if (smsSoap.sendSMS(this.subjectInputText.Value, this.contentInputText.Value, this.phonesInputText.Value, "")) {
					this.Page.Controls.Add(new LiteralControl(new StringBuilder("<script>alert('發送成功！點數剩餘").Append(smsSoap.Credit.ToString()).Append("點。');</script>").ToString()));
				} else {
					this.Page.Controls.Add(new LiteralControl("<script>alert('發送失敗！');</script>"));
				}
			} else {
				this.Page.Controls.Add(new LiteralControl("<script>alert('取得連線失敗！');</script>"));
			}
		}
	}
}
