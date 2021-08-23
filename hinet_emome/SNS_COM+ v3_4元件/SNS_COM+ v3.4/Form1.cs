using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Globalization;

#if (DEBUG)
using log4net;
using log4net.Config;
using log4net.Repository;
using log4net.Appender;
using log4net.Layout;
using log4net.Layout.Pattern;
using System.IO;
using System.Threading;
#endif

namespace SnsCom3Tester
{
	public partial class Form1 : Form
	{
#if (DEBUG)
		private static ILog m_logger = null;
#endif

		//宣告一物件變數為 SnsComObject3 元件
		private CHT.SNSCOMSERVER.SnsComObject3 m_sns = new CHT.SNSCOMSERVER.SnsComObject3();

		//提供五種發訊及查詢功能測試
		private static readonly int TEST_DEFAULT = 0;
		private static readonly int TEST_RECV_SUBNO = 1;
		private static readonly int TEST_SUBNO = 2;
		private static readonly int TEST_ALL_SUBNO = 3;
		private static readonly int TEST_BINARY = 4;

		//選用的功能測試項目
		private int nType = TEST_DEFAULT;
		private String strSendType = "SERV_SEND";

		//發送長簡訊之參考序號
		private int nSerno = new Random().Next(0x100);  //範圍: 0x00 ~ 0xFF

		public Form1() {
			InitializeComponent();
#if (DEBUG)
			//初始化 log4net 參數
			{
				String strLog4NetCfgFile = Directory.GetCurrentDirectory() + @"\log4net.xml";
				String strLog4NetCfgFile2 = Directory.GetCurrentDirectory() + @"\..\log4net.xml";

				if(File.Exists(strLog4NetCfgFile)) {
					XmlConfigurator.ConfigureAndWatch(new FileInfo(strLog4NetCfgFile));

					m_logger = LogManager.GetLogger(typeof(Program));
					Console.WriteLine("OK to load Log4Net config file: " + strLog4NetCfgFile);
				} else if(File.Exists(strLog4NetCfgFile2)) {
					XmlConfigurator.ConfigureAndWatch(new FileInfo(strLog4NetCfgFile2));

					m_logger = LogManager.GetLogger(typeof(Program));
					Console.WriteLine("OK to load Log4Net config file: " + strLog4NetCfgFile2);
				} else {
					Console.WriteLine("錯誤：找不到 Log4Net 參數檔: " + strLog4NetCfgFile);
					Thread.Sleep(1500);
					return;
				}
			}
#endif
		}

		private void CheckButtonState() {
			bool b = m_sns.IsBind();

			LoginButton.Enabled = !b;
			LinkButton.Enabled = b;
			LogoutButton.Enabled = b;
			EditPasswdButton.Enabled = b;
			SubmitButton.Enabled = b;
			QueryButton.Enabled = b;
			GetButton.Enabled = b;
		}

		private void Form1_Load(object sender, EventArgs e) {
			SubmitMessage_TextChanged(sender, e);

			CheckButtonState();
			TestDefault();
		}

		//當按下「登入連線」鍵
		private void LoginButton_Click(object sender, EventArgs e) {
			//連線參數初始化
			m_sns.InitRemoteServer(SnsIPList.Text, SnsPortList.Text, SnsAccount.Text, SnsPassword.Text);

			//登入 SNS 伺服器
			int nSnsCode = m_sns.Login();

			switch(nSnsCode) {
				case -2:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "參數錯誤");
					break;
				case -1:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "無法連線 SNS");
					break;
				case 0:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "登入驗證成功");
					break;
				case 1:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "帳號/密碼輸入錯誤");
					break;
				default:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "請參考 SNS Protocol 文件");
					break;
			}

			CheckButtonState();
		}

		//當按下「變更密碼」鍵
		private void EditPasswdButton_Click(object sender, EventArgs e) {
			if(!NewPassword.Text.Equals(ConfNewPassword.Text)) {
				MessageBox.Show("兩個密碼內容不一致，請重新輸入！", "錯誤");
				return;
			}

			//變更密碼
			int nSnsCode = m_sns.EditPassword(NewPassword.Text);

			switch(nSnsCode) {
				case -2:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "參數錯誤");
					break;
				case -1:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "無法連線 SNS");
					break;
				case 0:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc() + "\n\n下次請用此新密碼登入！",
									"變更密碼成功");
					break;
				default:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "請參考 SNS Protocol 文件");
					break;
			}

			CheckButtonState();
		}

		private void TestDefault() {
			nType = TEST_DEFAULT;
			strSendType = "SERV_SEND";
			LabelQuery.Text = "SERV_QUERY";

			radioButton5.Visible = false;
			radioButton6.Visible = false;
			LabelCoding.Visible = false;
			Coding.Visible = false;
			udhi.Text = "長簡訊";
			udhi.Checked = true;

			SubmitMessage_TextChanged(null, null);
		}

		//當點選第一個測試項目：行動電話號碼 (含特碼) 至一般行動電話號碼
		private void radioButton0_Click(object sender, EventArgs e) {
			MessageBox.Show("傳送：SERV_SEND 及\n\n查詢：SERV_QUERY", "測試項目");

			TestDefault();
		}

		//當點選第二個測試項目：Emome ID 發訊至一般行動電話號碼
		private void radioButton1_Click(object sender, EventArgs e) {
			MessageBox.Show("傳送：SERV_SEND_WITH_SUBNO 及\n\n查詢：SERV_QUERY_WITH_SUBNO", "測試項目");

			nType = TEST_SUBNO;
			strSendType = "SERV_SEND_WITH_SUBNO";
			LabelQuery.Text = "SERV_QUERY_WITH_SUBNO";

			radioButton5.Visible = false;
			radioButton6.Visible = false;
			LabelCoding.Visible = false;
			Coding.Visible = false;
			udhi.Text = "長簡訊";
			udhi.Checked = true;

			SubmitMessage_TextChanged(sender, e);
		}

		//當點選第三個測試項目：行動電話號碼 (含特碼) 發訊至 Emome ID
		private void radioButton2_Click(object sender, EventArgs e) {
			MessageBox.Show("傳送：SERV_SEND_WITH_RECV_SUBNO 及\n\n查詢：SERV_QUERY_WITH_RECV_SUBNO", "測試項目");

			nType = TEST_RECV_SUBNO;
			strSendType = "SERV_SEND_WITH_RECV_SUBNO";
			LabelQuery.Text = "SERV_QUERY_WITH_RECV_SUBNO";

			radioButton5.Visible = false;
			radioButton6.Visible = false;
			LabelCoding.Visible = false;
			Coding.Visible = false;
			udhi.Text = "長簡訊";
			udhi.Checked = true;

			SubmitMessage_TextChanged(sender, e);
		}

		//當點選第四個測試項目：Emome ID 發訊至 Emome ID
		private void radioButton3_Click(object sender, EventArgs e) {
			MessageBox.Show("傳送：SERV_SEND_WITH_ALL_SUBNO 及\n\n查詢：SERV_QUERY_WITH_ALL_SUBNO", "測試項目");

			nType = TEST_ALL_SUBNO;
			strSendType = "SERV_SEND_WITH_ALL_SUBNO";
			LabelQuery.Text = "SERV_QUERY_WITH_ALL_SUBNO";

			radioButton5.Visible = false;
			radioButton6.Visible = false;
			LabelCoding.Visible = false;
			Coding.Visible = false;
			udhi.Text = "長簡訊";
			udhi.Checked = true;

			SubmitMessage_TextChanged(sender, e);
		}

		//當點選第五個測試項目：二位元 Binary 訊息
		private void radioButton4_Click(object sender, EventArgs e) {
			MessageBox.Show("傳送：SERV_SEND_WITH_BINARY 及\n\n查詢：SERV_QUERY", "測試項目");

			nType = TEST_BINARY;
			strSendType = "SERV_SEND_WITH_BINARY";
			LabelQuery.Text = "SERV_QUERY";

			radioButton5.Visible = true;
			radioButton6.Visible = true;
			LabelCoding.Visible = true;
			Coding.Visible = true;
			udhi.Text = "UDHI";
			udhi.Enabled = true;
			udhi.Checked = false;

			SubmitMessage_TextChanged(sender, e);
		}

		//當點選傳送訊息：「中文轉 Unicode」或「英文轉 ASCII」之輔助轉換
		private void radioButton5_Click(object sender, EventArgs e) {
			byte[] byteMessage = null;

			if(m_sns.IsPureEnglishMessage(SubmitMessage.Text)) {
				byteMessage = m_sns.ToAsciiByteArray(SubmitMessage.Text);

				Coding.Text = "01";
			} else {
				byteMessage = m_sns.ToUcs16BeByteArray(SubmitMessage.Text);

				Coding.Text = "08";
			}

			int nLen = (byteMessage != null) ? byteMessage.Length : 0;

			SubmitMessage.Text = m_sns.GetHexStringFromByteArray(byteMessage);

			//是否超過一則訊息之最大長度
			udhi.Checked = (nLen > 160) ? true : false;

			radioButton5.Enabled = false;
			radioButton6.Enabled = true;
		}

		//當點選傳送訊息：「Unicode 轉中文」或「ASCII 轉英文」之輔助轉換
		private void radioButton6_Click(object sender, EventArgs e) {
			byte[] byteMessage = m_sns.GetByteArrayFromHexString(SubmitMessage.Text);

			if(m_sns.IsPureEnglishByteArray(byteMessage)) {
				SubmitMessage.Text = m_sns.GetStringFromAsciiByteArray(byteMessage);
			} else {
				SubmitMessage.Text = m_sns.GetStringFromUcs16BeByteArray(byteMessage);
			}

			radioButton6.Enabled = false;
			radioButton5.Enabled = true;
		}

		//輸入傳送訊息即時判斷作業
		private void SubmitMessage_TextChanged(object sender, EventArgs e) {
			//若是第五個測試項目：二位元 Binary 訊息
			if(nType == TEST_BINARY) {
				byte[] byteMessage = null;
				bool bEnglish = true;

				//當之前已點 英文轉 ASCII 或 中文轉 UCS-16-BE；或為以空白分隔之 Hex 字串
				if(radioButton5.Checked || (SubmitMessage.Text.Length > 2)) {
					byteMessage = m_sns.GetByteArrayFromHexString(SubmitMessage.Text);  //輸入訊息為 Hex 字串
				}

				if(byteMessage == null) {  //表示 SubmitMessage 不是真正的 Hex 字串
					if(m_sns.IsPureEnglishMessage(SubmitMessage.Text)) {
						byteMessage = m_sns.ToAsciiByteArray(SubmitMessage.Text);  //輸入訊息為英文
						bEnglish = true;
					} else {
						byteMessage = m_sns.ToUcs16BeByteArray(SubmitMessage.Text);  //輸入訊息為中文
						bEnglish = false;
					}

					if(bEnglish) {
						radioButton5.Text = "英文轉 ASCII";
						radioButton6.Text = "ASCII 轉英文";
					} else {
						radioButton5.Text = "中文轉 UCS-16-BE";
						radioButton6.Text = "UCS-16-BE 轉中文";
					}

					radioButton5.Enabled = true;
					radioButton6.Enabled = false;

					radioButton5.Checked = false;
				} else {  //否則為前四個一般文字訊息測試項目
					bEnglish = m_sns.IsPureEnglishByteArray(byteMessage);  //自動判斷輸入為中文或英文訊息

					radioButton5.Enabled = false;
					radioButton6.Enabled = true;
				}

				LabelLength.Text = "(二位元長度: " + ((byteMessage != null) ? byteMessage.Length : 0) + ")";

				udhi.Enabled = true;

			} else {
				int nLen = SubmitMessage.Text.Length;
				bool bEnglish = m_sns.IsPureEnglishMessage(SubmitMessage.Text);  //自動判斷輸入為中文或英文訊息
				int nTotalSplit = m_sns.GetTotalSplit(SubmitMessage.Text, udhi.Checked, bEnglish);  //可切割多少則簡訊

				LabelLength.Text = "(文字長度: " + nLen + ")";

				udhi.Enabled = (nTotalSplit > 1) ? true : false;  //若超過一則簡訊，則顯示 UDHI 選項 (多則整合至單一長簡訊)
			}
		}

		//當按下「傳送訊息」鍵以發送單則或多則簡訊
		private void SubmitButton_Click(object sender, EventArgs e) {

			//重送期限 (0 ~ 1440 分鐘)
			int nExpiredMinutes = 0;  //表示系統最長 1440 分鐘

			if(SubmitExpired.Text.Length > 0) {
				if(!Int32.TryParse(SubmitExpired.Text, out nExpiredMinutes)) {
					MessageBox.Show("重送期限須為數字，範圍為 0 ~ 1440 分鐘！", "無法發送");
					return;
				}
			}

			bool bEnglish = false;
			int nTotalSplit = 1;

			DialogResult dr;
			if(nType == TEST_BINARY) {  //輸入訊息須為 HEX 字串
				String strLongHexMessage = SubmitMessage.Text;
				int nLongHexMessageLen = strLongHexMessage.Length;
				int nUDHI = udhi.Checked ? 1 : 0;
				nTotalSplit = m_sns.GetTotalSplitHexMessage(nUDHI, strLongHexMessage, nLongHexMessageLen);

				if(nTotalSplit > 0) {
					int nCoding = 0;
					if(!Int32.TryParse(Coding.Text, NumberStyles.HexNumber, null, out nCoding) ||
									(nCoding < 0x00) || (nCoding > 0xFF)) {
						MessageBox.Show("請輸入正確的編碼資訊，範圍 00 ~ FF。", "無法發送");
						return;
					} else if(nTotalSplit > 1) {
						dr = MessageBox.Show("即將發送含 " + nTotalSplit + " 則二位元訊息：\n\n使用的編碼為 0x" 
											+ Coding.Text + "\n\n確認送出？", strSendType, 
											MessageBoxButtons.OKCancel);
					} else {
						dr = MessageBox.Show("即將發送二位元訊息：\n\n使用的編碼為 0x" + Coding.Text 
										   + "\n\n確認送出？", strSendType, MessageBoxButtons.OKCancel);
					}
				} else {
					MessageBox.Show("沒有輸入或錯誤的 HEX 字串資料！", "無法發送");
					return;
				}
			} else {
				bEnglish = m_sns.IsPureEnglishMessage(SubmitMessage.Text);
				nTotalSplit = m_sns.GetTotalSplit(SubmitMessage.Text, udhi.Checked, bEnglish);

				if(nTotalSplit == 1) {
					dr = MessageBox.Show("即將發送單通簡訊？", strSendType, MessageBoxButtons.OKCancel);
				} else {
					if(udhi.Checked) {
						dr = MessageBox.Show("即將發送含 " + nTotalSplit + " 則之單通長簡訊？", strSendType,
												MessageBoxButtons.OKCancel);
					} else {
						dr = MessageBox.Show("即將發送含 " + nTotalSplit + " 則簡訊？", strSendType,
												MessageBoxButtons.OKCancel);
					}
				}
			}

			if(dr != DialogResult.OK) {
				return;
			}

			String strFromMsisdn = SubmitFromMsisdn.Text;
			String strToMsisdn = SubmitToMsisdn.Text;
			StringBuilder sbMsgidList = new StringBuilder();

			nSerno = (nSerno + 1) % 0x100;

			//傳送則數為 1-based
			for(int nCurrSplit = 1; nCurrSplit <= nTotalSplit; nCurrSplit++) {
				int nSnsCode = 0;

				if(nTotalSplit == 1) {
					if(nType == TEST_BINARY) {
						String strHexMessage = SubmitMessage.Text;
						int nHexLen = strHexMessage.Length;
						int nUDHI = udhi.Checked ? 1 : 0;
						int nCoding = Convert.ToInt32(Coding.Text, 16);

						nSnsCode = m_sns.SubmitBinaryMessage(strFromMsisdn, strToMsisdn, nUDHI, nCoding,
													strHexMessage, nHexLen, nExpiredMinutes);
					} else {
						String strMessage = SubmitMessage.Text;

						if(nType == TEST_DEFAULT) {
							nSnsCode = m_sns.SubmitMessage(strFromMsisdn, strToMsisdn, strMessage, nExpiredMinutes);
						} else if(nType == TEST_SUBNO) {
							nSnsCode = m_sns.SubmitMessageWithSubno(strFromMsisdn, strToMsisdn, strMessage,
														nExpiredMinutes);
						} else if(nType == TEST_RECV_SUBNO) {
							nSnsCode = m_sns.SubmitMessageWithRecvSubno(strFromMsisdn, strToMsisdn, strMessage,
														nExpiredMinutes);
						} else if(nType == TEST_ALL_SUBNO) {
							nSnsCode = m_sns.SubmitMessageWithAllSubno(strFromMsisdn, strToMsisdn, strMessage,
														nExpiredMinutes);
						}
					}
				} else {
					bool bUDHI = udhi.Checked;

					if(nType == TEST_BINARY) {
						String strLongHexMessage = SubmitMessage.Text;
						int nLongHexLen = strLongHexMessage.Length;
						int nUDHI = bUDHI ? 1 : 0;

						String strSplitHexMessage = m_sns.GetSplitHexMessage(nUDHI, strLongHexMessage,
													nLongHexLen, nSerno, nCurrSplit, nTotalSplit);
						int nHexLen = (strSplitHexMessage != null) ? strSplitHexMessage.Length : 0;
						int nCoding = Convert.ToInt32(Coding.Text, 16);

#if (DEBUG)
						m_logger.Info("strLongHexMessage= (Len " + ((nLongHexLen + 1) / 3) + ") " + strLongHexMessage);
						m_logger.Info("#" + nCurrSplit + ": (Len " + nHexLen + ") " + strSplitHexMessage);
#endif
						nSnsCode = m_sns.SubmitBinaryMessage(strFromMsisdn, strToMsisdn, nUDHI,
												nCoding, strSplitHexMessage, nHexLen, nExpiredMinutes);
					} else {
						String strLongMessage = SubmitMessage.Text;
						String strSplitSMS = m_sns.GetSplitSMS(strLongMessage, bUDHI, nCurrSplit, nTotalSplit,
													bEnglish);

						if(nType == TEST_DEFAULT) {
							nSnsCode = m_sns.SubmitLongMessage(strFromMsisdn, strToMsisdn, bUDHI,
													bEnglish, strSplitSMS, nSerno, nCurrSplit, nTotalSplit,
													nExpiredMinutes);
						} else if(nType == TEST_SUBNO) {
							nSnsCode = m_sns.SubmitLongMessageWithSubno(strFromMsisdn, strToMsisdn, bUDHI,
													bEnglish, strSplitSMS, nSerno, nCurrSplit, nTotalSplit,
													nExpiredMinutes);
						} else if(nType == TEST_RECV_SUBNO) {
							nSnsCode = m_sns.SubmitLongMessageWithRecvSubno(strFromMsisdn, strToMsisdn, bUDHI,
													bEnglish, strSplitSMS, nSerno, nCurrSplit, nTotalSplit,
													nExpiredMinutes);
						} else if(nType == TEST_ALL_SUBNO) {
							nSnsCode = m_sns.SubmitLongMessageWithAllSubno(strFromMsisdn, strToMsisdn, bUDHI,
													bEnglish, strSplitSMS, nSerno, nCurrSplit, nTotalSplit,
													nExpiredMinutes);
						}
					}
				}

				String strSnsDesc = m_sns.GetRespDesc();

				String strPrefix = (nTotalSplit == 1) ? "" : ("第 " + nCurrSplit + " 則：");

				switch(nSnsCode) {
					case -2:
						MessageBox.Show(strPrefix + "[" + nSnsCode + "] " + strSnsDesc, "參數錯誤");
						break;
					case -1:
						MessageBox.Show(strPrefix + "[" + nSnsCode + "] " + strSnsDesc, "無法連線 SNS");
						break;
					case 0:
						MessageBox.Show(strPrefix + "(得簡訊識別碼) " + strSnsDesc, "簡訊傳送成功");

						if(sbMsgidList.Length > 0) {
							sbMsgidList.Append(", ");
						}

						sbMsgidList.Append(m_sns.GetMsgID());  //同 strSnsDesc
						break;
					default:
						MessageBox.Show(strPrefix + "[" + nSnsCode + "] " + strSnsDesc, "請參考 SNS Protocol 文件");
						break;
				}
			}

			if(sbMsgidList.Length > 0) {
				QueryFromMsisdn.Text = SubmitFromMsisdn.Text;
				QueryToMsisdn.Text = SubmitToMsisdn.Text;
				MsgidList.Text = sbMsgidList.ToString();
			}

			CheckButtonState();
		}

		private static String GetCategory(int nSnsCode, String strSnsDesc) {

			/*
			 * 當系統已到達最終狀態時 (code 為 0、3、8、9、11、12、13、32)，將會包含訊息最終狀態之時間，
			 * 並以 : 做為區隔字元，時間格式為 yyyymmddHHMMSS。
			 */
			String strStatusType = null;

			switch(nSnsCode) {
				case 0:   //Successful:yyyymmddHHMMSS
					strStatusType = "發訊成功";
					break;
				case 1:  	//Message is processing
				case 31:  //Message is submitting
					strStatusType = "發訊中 (稍後再查)";
					break;
				case 2:  	//System contains no data
				case 4:   //System error
				case 5: 	//Message status unknown
				case 21:	//System error
					strStatusType = "無法得知 (建議多查幾次確認)";
					break;
				case 3:   //Message can not send to GSM/Pager:yyyymmddHHMMSS
				case 8:   //SIM card memory full:yyyymmddHHMMSS
				case 9:   //Destination number is unavailable:yyyymmddHHMMSS
				case 11:  //Destination number is error:yyyymmddHHMMSS
				case 12:  //Mobile equipment can not receive SMS:yyyymmddHHMMSS
				case 13:  //Mobile equipment error:yyyymmddHHMMSS
				case 32:  //Message send to SMSC fail:yyyymmddHHMMSS
				default:
					strStatusType = "發訊失敗";
					break;
			}

			return strStatusType;
		}

		//當按下「狀態查詢」鍵以查詢已送簡訊傳送狀態
		private void QueryButton_Click(object sender, EventArgs e) {
			String[] saMsgID = MsgidList.Text.Split(",".ToCharArray());

			for(int i = 0; i < saMsgID.Length; i++) {
				if(saMsgID[i].Trim().Trim().Length > 0) {
					int nSnsCode = 0;

					if((nType == TEST_DEFAULT) || (nType == TEST_BINARY)) {
						nSnsCode = m_sns.QueryMessageStatus(QueryFromMsisdn.Text, QueryToMsisdn.Text, saMsgID[i].Trim());
					} else if(nType == TEST_SUBNO) {
						nSnsCode = m_sns.QueryMessageStatusWithSubno(QueryFromMsisdn.Text, QueryToMsisdn.Text, saMsgID[i].Trim());
					} else if(nType == TEST_RECV_SUBNO) {
						nSnsCode = m_sns.QueryMessageStatusWithRecvSubno(QueryFromMsisdn.Text, QueryToMsisdn.Text, saMsgID[i].Trim());
					} else {  //TEST_ALL_SUBNO
						nSnsCode = m_sns.QueryMessageStatusWithAllSubno(QueryFromMsisdn.Text, QueryToMsisdn.Text, saMsgID[i].Trim());
					}

					String strSnsDesc = m_sns.GetRespDesc();

					String strPrefix = (saMsgID.Length == 1) ? "" : ("第 " + (i + 1) + " 則：");

					switch(nSnsCode) {
						case -2:
							MessageBox.Show(strPrefix + "[" + nSnsCode + "] " + strSnsDesc, "參數錯誤");
							break;
						case -1:
							MessageBox.Show(strPrefix + "[" + nSnsCode + "] " + strSnsDesc, "無法連線 SNS");
							break;
						default:
							String strResult = GetCategory(nSnsCode, strSnsDesc);
							MessageBox.Show(strPrefix + "[" + nSnsCode + "] " + strSnsDesc, strResult);
							break;
					}
				}
			}

			CheckButtonState();
		}

		//當按下「接收訊息」鍵以接收手機上傳的簡訊
		private void GetButton_Click(object sender, EventArgs e) {
			int nSnsCode = m_sns.GetMessage();

			switch(nSnsCode) {
				case -2:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "參數錯誤");
					break;
				case -1:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "無法連線 SNS");
					break;
				case 0:
					MessageBox.Show("接收到上傳簡訊", "收訊成功");

					RecvFromMsisdn.Text = m_sns.GetFromMsisdn();
					RecvToMsisdn.Text = m_sns.GetToMsisdn();
					RecvMessage.Text = m_sns.GetRespDesc();
					
                    //若要取得長簡訊真正的分則訊息內容
                    {
                        bool bUDHI = false;  //若為 true 表示是長簡訊
                        int nSerno = 0;  //若是長簡訊，則單一長簡訊之多則簡訊序號應相同。
                        int nCurrSplit = 0;  //若是長簡訊，則此為第幾則簡訊 (1-based)
                        int nTotalSplit = 0;  //若是長簡訊，則共含多少則簡訊。
                        byte[] byteArray = null;
                        int nStartIdx = 0;

                        if (m_sns.GetIsEnglish())
                        {
                            byteArray = m_sns.ToAsciiByteArray(RecvMessage.Text);
                        }
                        else
                        {
                            byteArray = m_sns.ToUcs16BeByteArray(RecvMessage.Text);
                        }

                        if (byteArray != null)
                        {
                            if (!bUDHI && (byteArray.Length > 6) &&
                                    (byteArray[0] == 0x05) && (byteArray[1] == 0x00) && (byteArray[2] == 0x03))
                            {
                                byte b3 = byteArray[3];
                                byte b4 = byteArray[4];
                                byte b5 = byteArray[5];
                                nSerno = (int)b3;
                                nTotalSplit = (int)b4;
                                nCurrSplit = (int)b5;
                                bUDHI = true;
                                nStartIdx = 6;  //byteArray[6] 之後為該分則簡訊之二位元編碼訊息內容
                            }
                            if (!bUDHI && (byteArray.Length > 7) &&
                                    (byteArray[0] == 0x06) && (byteArray[1] == 0x08) && (byteArray[2] == 0x04))
                            {
                                byte b3 = byteArray[3];
                                byte b4 = byteArray[4];
                                byte b5 = byteArray[5];
                                byte b6 = byteArray[6];
                                nSerno = (int)(b3 * 0xFF) + (int)b4;
                                nTotalSplit = (int)b5;
                                nCurrSplit = (int)b6;
                                bUDHI = true;
                                nStartIdx = 7;  //byteArray[7] 之後為該分則簡訊之二位元編碼訊息內容
                            }
                        }

                        if (bUDHI)
                        {
                            byte[] byteSplit = null;  //取得所要的分則簡訊二位元編碼訊息內容

                            byteSplit = new byte[byteArray.Length - nStartIdx];
                            Array.Copy(byteArray, nStartIdx, byteSplit, 0, byteArray.Length - nStartIdx);

                            StringBuilder sb = new StringBuilder();

                            for (int i = 0; i < byteArray.Length; i++)
                            {
                                if ((i > 0) && (i % 20 == 0))
                                {
                                    sb.Append("\n");
                                }

                                sb.Append(byteArray[i].ToString("X2"));
                                sb.Append(" ");
                            }
                            sb.Append("\n\n");

                            //實際應用應是根據 nCurrSplit，依序整合同個 nSerno 所有則數 byteSplit 至較大的 byte 串列，
                            //再續下列 API 取得完整的長簡訊內容。 					
                            String strSplitSMS = null;

                            if (m_sns.IsPureEnglishByteArray(byteSplit))
                            {
                               strSplitSMS = m_sns.GetStringFromAsciiByteArray(byteSplit);
                            }
                            else
                            {
                                strSplitSMS = m_sns.GetStringFromUcs16BeByteArray(byteSplit);
                            }

                            sb.Append(strSplitSMS);

                            MessageBox.Show(sb.ToString(), "收到序號 0x" + nSerno.ToString("X2") + " 長簡訊之第 "
                                            + nCurrSplit + "/" + nTotalSplit + " 則簡訊");
                        }
                    }
					break;
				default:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "請參考 SNS Protocol 文件");
					break;
			}

			CheckButtonState();
		}

		//當按下「保持連線」鍵
		private void LinkButton_Click(object sender, EventArgs e) {
			int nSnsCode = m_sns.EnquireLink();

			switch(nSnsCode) {
				case -1:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "無法連線 SNS");
					break;
				case 0:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "保持連線成功");
					break;
				default:
					MessageBox.Show("[" + nSnsCode + "] " + m_sns.GetRespDesc(), "請參考 SNS Protocol 文件");
					break;
			}

			CheckButtonState();
		}

		//當按下「登出連線」鍵
		private void LogoutButton_Click(object sender, EventArgs e) {
			m_sns.Logout();

			MessageBox.Show("切斷與 SNS Server 的連線", "結束作業");

			CheckButtonState();
		}
	}
}