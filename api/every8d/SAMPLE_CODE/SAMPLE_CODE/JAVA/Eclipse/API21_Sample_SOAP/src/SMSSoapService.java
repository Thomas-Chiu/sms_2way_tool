import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.tempuri.SMSSoapProxy;


public class SMSSoapService {
	private SMSSoapProxy smsService;
	private String sessionKey="";
	private String batchID="";
	private String processMsg="";
	private double credit=0;
	
	public SMSSoapService(){
		this.smsService=new SMSSoapProxy();
	}

	/// <summary>
	/// 提供啟動連結服務，傳送簡訊前必須先取得取得SessionKey，
	/// 藉由此SessionKey進行後續簡訊傳送之服務，SessionKey有效期為單日，隔日即失效。
	/// 建議於完成傳送作業後，執行closeConnection以確保安全。
	/// </summary>
	/// <param name="userID">登入帳號</param>
	/// <param name="password">密碼</param>
	/// <returns>true:取得連線成功；false:取得連線失敗</returns>
	public boolean getConnection(String userID, String password) {
		boolean success = false;
		try {
			String resultXml = this.smsService.getConnection(userID, password);
			Document xmlDoc= DocumentHelper.parseText(resultXml);
			String returnCode = xmlDoc.selectSingleNode("/SMS/GET_CONNECTION/CODE").getText();
			if (returnCode.equals("0")) {
				this.sessionKey = xmlDoc.selectSingleNode("/SMS/GET_CONNECTION/SESSION_KEY").getText();
				this.processMsg = xmlDoc.selectSingleNode("/SMS/GET_CONNECTION/DESCRIPTION").getText();
				success = true;
			} else {
				this.processMsg = xmlDoc.selectSingleNode("/SMS/GET_CONNECTION/DESCRIPTION").getText();
			}
		} catch (Exception ex) {
			this.processMsg = ex.getMessage();
		}
		return success;
	}
	
	/// <summary>
	/// SessionKey有效期為單日，隔日即失效。建議於完成傳送作業後，執行closeConnection以確保安全
	/// </summary>
	/// <returns>true:關閉成功；false:關閉失敗</returns>
	public boolean closeConnection() {
		boolean success = false;
		try {
			String resultString = this.smsService.closeConnection(this.sessionKey);
			if (!resultString.startsWith("-")) {
				this.sessionKey = "";
				success = true;
			}
		} catch (Exception ex) {
			this.processMsg = ex.getMessage();
		}
		return success;
	}
	
	/// <summary>
	/// 傳送簡訊
	/// </summary>
	/// <param name="subject">簡訊主旨，主旨不會隨著簡訊內容發送出去。用以註記本次發送之用途。可傳入空字串。</param>
	/// <param name="content">簡訊發送內容</param>
	/// <param name="mobile">接收人之手機號碼。格式為: +886912345678或09123456789。多筆接收人時，請以半形逗點隔開( , )，如0912345678,0922333444。</param>
	/// <param name="sendTime">簡訊預定發送時間。-立即發送：請傳入空字串。-預約發送：請傳入預計發送時間，若傳送時間小於系統接單時間，將不予傳送。格式為YYYYMMDDhhmnss；例如:預約2009/01/31 15:30:00發送，則傳入20090131153000。若傳遞時間已逾現在之時間，將立即發送。</param>
	/// <returns>true:傳送成功；false:傳送失敗</returns>
	public boolean sendSMS(String subject, String content, String mobile, String sendTime) {
		boolean success = false;
		try {
			String resultString = this.smsService.sendSMS(this.sessionKey, subject, content, mobile, sendTime);
			if (!resultString.startsWith("-")) {
				/* 
				 * 傳送成功 回傳字串內容格式為：CREDIT,SENDED,COST,UNSEND,BATCH_ID，各值中間以逗號分隔。
				 * CREDIT：發送後剩餘點數。負值代表發送失敗，系統無法處理該命令
				 * SENDED：發送通數。
				 * COST：本次發送扣除點數
				 * UNSEND：無額度時發送的通數，當該值大於0而剩餘點數等於0時表示有部份的簡訊因無額度而無法被發送。
				 * BATCH_ID：批次識別代碼。為一唯一識別碼，可藉由本識別碼查詢發送狀態。格式範例：220478cc-8506-49b2-93b7-2505f651c12e
				 */
				String[] split = resultString.split(",");
				this.credit = Double.parseDouble(split[0]);
				this.batchID = split[4];
				success = true;
			} else {
				//傳送失敗
				this.processMsg = resultString;
			}

		} catch (Exception ex) {
			this.processMsg = ex.getMessage();
		}
		return success;
	}
	
	/// <summary>
	/// 取得帳號餘額
	/// </summary>
	/// <returns>true:取得成功；false:取得失敗</returns>
	public boolean getCredit() {
		boolean success = false;
		try {
			String resultString = this.smsService.getCredit(this.sessionKey);
			if (!resultString.startsWith("-")) {
				this.credit = Double.parseDouble(resultString);
				success = true;
			} else {
				this.processMsg = resultString;
			}
		} catch (Exception ex) {
			this.processMsg = ex.getMessage();
		}
		return success;
	}
	
	public String getSessionKey() {
		return sessionKey;
	}

	public String getBatchID() {
		return batchID;
	}

	public String getProcessMsg() {
		return processMsg;
	}

	public double getCreditValue() {
		return credit;
	}

}
