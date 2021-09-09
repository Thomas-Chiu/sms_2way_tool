
public class MainClass {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		SMSHttpService sms=new SMSHttpService();
		String userID="0963139051";	//帳號
		String password="1qaz";	//密碼
		String subject="測試API2.1";	//簡訊主旨，主旨不會隨著簡訊內容發送出去。用以註記本次發送之用途。可傳入空字串。
		String content="測試API2.1 JAVA(eclipse)";	//簡訊發送內容
		String mobile="0963139051";	//接收人之手機號碼。格式為: +886912345678或09123456789。多筆接收人時，請以半形逗點隔開( , )，如0912345678,0922333444。
		String sendTime="";	//簡訊預定發送時間。-立即發送：請傳入空字串。-預約發送：請傳入預計發送時間，若傳送時間小於系統接單時間，將不予傳送。格式為YYYYMMDDhhmnss；例如:預約2009/01/31 15:30:00發送，則傳入20090131153000。若傳遞時間已逾現在之時間，將立即發送。
		
		if(sms.getCredit(userID, password)){
			System.out.println(new StringBuffer("取得餘額成功，餘額：").append(String.valueOf(sms.getCreditValue())).toString());
		}else{
			System.out.println(new StringBuffer("取得餘額失敗，失敗原因：").append(sms.getProcessMsg()).toString());
		}
		if(sms.sendSMS(userID, password, subject, content, mobile, sendTime)){
			System.out.println(new StringBuffer("發送簡訊成功，餘額：").append(String.valueOf(sms.getCreditValue())).append("，簡訊批號：").append(sms.getBatchID()).toString());
		}else{
			System.out.println(new StringBuffer("發送簡訊失敗，失敗原因：").append(sms.getProcessMsg()).toString());
		}
	}

}
