<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.io.BufferedReader,java.io.InputStreamReader"
	import="java.util.Arrays,java.util.HashMap,java.text.SimpleDateFormat"%>
<%@ page
	import="javax.servlet.http.*,javax.servlet.*,java.io.PrintWriter"%>
<%@ page
	import="java.net.URL,java.net.HttpURLConnection,java.io.DataOutputStream"
	import="java.io.FileInputStream,java.io.IOException"
	import="java.net.URLEncoder,java.net.URLDecoder"%>
<%@ page
	import="javax.net.ssl.HostnameVerifier,javax.net.ssl.HttpsURLConnection"
	import="javax.net.ssl.SSLContext,javax.net.ssl.TrustManager,javax.net.ssl.SSLEngine"%>
<%@ page
	import="javax.net.ssl.SSLPeerUnverifiedException,javax.net.ssl.SSLSession"
	import="javax.net.ssl.X509TrustManager"%>
<%@ page
	import="java.security.SecureRandom,java.security.cert.Certificate"
	import="java.security.cert.X509Certificate"%>
<%
	request.setCharacterEncoding("utf-8");

	String strSubmitURL = "https://imsp.emome.net:4443/imsp/sms/servlet/SubmitSM";

	int nMethod = 0;
	{
		String strMethod = xss(request.getParameter("idMethod"));

		if ((strMethod != null) && strMethod.matches("^[0-9]$")) {
			nMethod = Integer.parseInt(strMethod);
		}
	}

	String strAccount = null;
	{
		String strValue = request.getParameter("idAccount"); //請設定您申請的帳號

		if ((strValue != null) && strValue.matches("^1[0-9]{2,10}$")) {
			strAccount = Integer.toString(Integer.parseInt(strValue));
		} else {
			strAccount = null;
		}
	}
	String strKeycode = null;
	{
		String strValue = request.getParameter("idKeycode"); //請設定您申請的密碼

		if ((strValue != null) && (strValue.length() < 20)) {
			strKeycode = getNonChineseValue(strValue);
		} else {
			strKeycode = null;
		}
	}
	int nFromAddrType = 0; //發訊方限國內號碼
	String strFromAddr = xss(request.getParameter("idFromAddr"));
	{
		String strValue = request.getParameter("idFromAddr");

		if ((strValue != null)
				&& strValue.matches("^[+]?[0-9]{0,20}+$")) {
			strFromAddr = getNonChineseValue(strValue);
		} else {
			strFromAddr = null;
		}
	}
	int nToAddrType = 0; //受訊手機號碼可為國內或國外門號
	String strToAddr = null;
	{
		String strValue = request.getParameter("idToAddr"); //請設定您的收訊號碼

		if ((strValue != null)
				&& strValue.replaceAll(" ", "").matches(
						"^[[+]?[0-9]{9,20},]+$")) {
			strToAddr = getNonChineseValue(strValue);
		} else {
			strToAddr = null;
		}
	}
	int nMsgExpireTime = 30; //分鐘
	{
		String strMsgExpireTime = request.getParameter("idMsgExpireTime");

		if ((strMsgExpireTime != null)
				&& strMsgExpireTime.matches("^[0-9]{1,4}$")) {
			nMsgExpireTime = Integer.parseInt(strMsgExpireTime);
		}
	}

	final int TEXT_DCS_CONVERT_BIG5 = 0;
	final int TEXT_DCS_CONVERT_ASCII = 1;
	final int TEXT_DCS_CONVERT_ISO_8859_1 = 3;
	final int TEXT_DCS_CONVERT_UTF16BE = 8;

	String strTextInput = null;
	int nTextSernoBytes = 1;
	int nTextImspVer = 0;
	int nTextMsgType = -1;
	int nTextDcsConvert = -1;
	{
		String strValue = request.getParameter("textInput");

		if ((strValue != null) && (strValue.length() < 500)) {
			strTextInput = getMyselfString(strValue);
		}

		String strTextSernoBytes = request.getParameter("textSernoBytes");
		String strTextImspVer = request.getParameter("textImspVer");
		String strTextMsgType = request.getParameter("textMsgType");
		String strDcsConvert = request.getParameter("textDcsConvert");

		if ((strTextSernoBytes != null)
				&& strTextSernoBytes.matches("^[1-2]$")) {
			nTextSernoBytes = Integer.parseInt(strTextSernoBytes);
		}

		if ((strTextImspVer != null)
				&& strTextImspVer.matches("^-?[0-9]$")) {
			nTextImspVer = Integer.parseInt(strTextImspVer);
		}

		if ((strTextMsgType != null)
				&& strTextMsgType.matches("^-?[0-9]$")) {
			nTextMsgType = Integer.parseInt(strTextMsgType);
		}

		if ((strDcsConvert != null)
				&& strDcsConvert.matches("^-?[0-9]$")) {
			nTextDcsConvert = Integer.parseInt(strDcsConvert);
		}
	}
%>
<%!public String xss(String strSource) {
		String strResult = null;

		if (strSource != null) {
			strResult = org.owasp.encoder.Encode.forHtml(strSource);
		}

		return strResult;
	}

	public String unXss(String strEscape) {
		String strText = null;

		if (strEscape != null) {
			strText = org.apache.commons.lang3.StringEscapeUtils
					.unescapeHtml4(strEscape); //for JDK 1.6
		}

		return strText;
	}

	private static final char[]	hexArray	= "0123456789ABCDEF".toCharArray();

	public String bytesToHex(byte[] bytes) {
		String strHex = null;

		if ((bytes != null) && (bytes.length > 0)) {
			char[] hexChars = new char[bytes.length * 2];
			for (int j = 0; j < bytes.length; j++) {
				int v = bytes[j] & 0xFF;
				hexChars[j * 2] = hexArray[v >>> 4];
				hexChars[j * 2 + 1] = hexArray[v & 0x0F];
			}
			strHex = new String(hexChars);
		}

		return strHex;
	}

	public byte[] hexStringToByteArray(String s) {
	    int len = s.length();
	    byte[] data = new byte[len / 2];
	    for (int i = 0; i < len; i += 2) {
	        data[i / 2] = (byte) ((Character.digit(s.charAt(i), 16) << 4)
	                             + Character.digit(s.charAt(i+1), 16));
	    }
	    return data;
	}
	
	static HashMap<Character, Character> m_map = new HashMap<Character, Character>();

	static {
		String s1 = "abcdefghijklmnopqrstuvwxyz";
		String s2 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

		for (int i = 0; i < s1.length(); i++) { //a ~ z, A ~ Z
			m_map.put(s1.charAt(i), s1.charAt(i));
			m_map.put(s2.charAt(i), s2.charAt(i));
		}

		String s3 = "0123456789";

		for (int i = 0; i < s3.length(); i++) {
			m_map.put(s3.charAt(i), s3.charAt(i));
		}

		String s4 = "!@#$%^&*()_+-={}|[ ]\\:\";'<>?,./~`'";

		for (int i = 0; i < s4.length(); i++) {
			m_map.put(s4.charAt(i), s4.charAt(i));
		}
	}

	//get non-chinese parameter value
	public String getNonChineseValue(char[] value) { //不接受含中文
		String strNonChineseValue = null;

		if ((value != null) && (value.length > 0)) {
			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < value.length; i++) {
				char c = (char) value[i];

				if (m_map.get(c) != null) {
					sb.append(m_map.get(c));
				} else if(c == '\r') {
					sb.append("\r");
				} else if(c == '\n') {
					sb.append("\n");
				} else {
					sb.append("[?]");
					System.err.println("getNonChineseValue(): not accepted char '" + c + "'");
				}
			}

			strNonChineseValue = sb.toString();
		}

		return strNonChineseValue;
	}

	public String getNonChineseValue(byte[] value) { //不接受含中文
		if (value != null) {
			String str = null;

			try {
				str = new String(value, "Big5");
			} catch (Exception e) {
				str = new String(value); //using the platform's default charset
			}

			char[] v = str.toCharArray();

			return getNonChineseValue(v);
		} else {
			return null;
		}
	}

	public String getNonChineseValue(String value) { //不接受含中文
		if (value != null) {
			char[] v = value.toCharArray();

			return getNonChineseValue(v);
		} else {
			return null;
		}
	}

	public String getMyselfString(String s) {
		String str = null;

		if ((s != null) &&(s.length() > 0)) {
			try {
				byte[] ba = s.getBytes("UTF-8");

				String sHex = bytesToHex(ba);
				String sFilter = getNonChineseValue(sHex);
				byte[] b2 = hexStringToByteArray(sFilter);

				str = new String(b2, "UTF-8");
			} catch (Exception e) {
				System.err.println("*** FAILED to getMySelfString(): [" + e.getClass().getName() + "] "
						+ e.getMessage());
			}
		}
		
		return str;
	}

	public class ImspTools {
		StringBuffer m_sbIMSP = new StringBuffer();

		public String getImspResult() {
			return m_sbIMSP.toString();
		}

		public void appendImspResult(String s) {
			m_sbIMSP.append(s);
		}

		private boolean isPureEnglish(String strMsgInput) {
			if (strMsgInput != null) {
				char[] c = strMsgInput.toCharArray();
				for (int i = 0; i < c.length; i++) {
					char code = c[i];
					if ((code < 0) || (code > 128)) { //中文 (Ex: "長度" 之 code 值分別為 -27273 及 24230)
						if (code != '€') {
							return false;
						}
					}
				}
			}

			return true;
		}

		private int countSpecialAscii(String strMsgInput) { //純英文訊息用 (部份特殊碼使用兩個 bytes 表示)
			int nSpecialAscii = 0;

			if (strMsgInput != null) {
				char[] ca = strMsgInput.toCharArray();

				for (int i = 0; i < ca.length; i++) {
					char c = ca[i];

					if ((c == '\n') || (c == '^') || (c == '{') || (c == '}')
							|| (c == '\\') || (c == '[') || (c == '~')
							|| (c == ']') || (c == '|') || (c == '€')) {
						++nSpecialAscii;
					}
				}
			}

			return nSpecialAscii;
		}

		private int countSpecialAscii(byte[] byteMsg) { //純英文訊息用 (部份特殊碼使用兩個 bytes 表示)
			int nSpecialAscii = 0;

			if (byteMsg != null) {
				for (int i = 0; i < byteMsg.length; i++) {
					if (i < byteMsg.length - 1) {
						byte b1 = byteMsg[i];
						byte b2 = byteMsg[i + 1];

						if (b1 == (byte) (0x1B & 0xFF)) {
							if (b2 == (byte) (0x1A & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x14 & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x28 & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x29 & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x2F & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x3C & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x3D & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x3E & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x40 & 0xFF)) {
								nSpecialAscii++;
							} else if (b2 == (byte) (0x65 & 0xFF)) {
								nSpecialAscii++;
							}
						}
					}
				}
			}

			return nSpecialAscii;
		}

		int m_nStart = 0;
		int m_nEnd = 0;

		private void initSplit() {
			m_nStart = 0;
			m_nEnd = 0;
		}

		private int min(int n1, int n2) {
			if (n1 > n2) {
				return n2;
			} else {
				return n1;
			}
		}

		/* 
		 * a. 若不是長簡訊，最多可送 160 個英文字 (共最多 160 bytes)、70 個中文字 (140 bytes)；
		 * b. 使用一個 byte 長簡訊序號，最多可送 153 個英文字 (共最多 159 bytes = 318 hex)、67 個中文字 (共最多 140 bytes = 280 hex)；
		 * c. 使用兩個 byte 長簡訊序號，最多可送 152 個英文字 (共最多 159 bytes = 318 hex)、66 個中文字 (共最多 139 bytes = 278 hex)。
		 */
		private boolean nextSplit(boolean bEnglish, boolean bISO,
				int nSernoBytes, String strMsgInput) {
			int nLen = strMsgInput.length();
			boolean b = false;

			m_nStart = m_nEnd;

			if (m_nEnd < nLen) {
				if (bEnglish) {
					int nAllow = (nSernoBytes == 1) ? 153 : 152;

					m_nEnd = min(
							m_nStart + ((nSernoBytes == 0) ? 160 : nAllow),
							nLen);

					while (true) {
						String strMyContent = strMsgInput.substring(m_nStart,
								m_nEnd);

						int nSpecialAscii = bISO
								? countSpecialAscii(strMyContent)
								: 0;

						if (m_nEnd - m_nStart + nSpecialAscii > nAllow) {
							m_nEnd--;
						} else {
							break;
						}
					}
				} else {
					m_nEnd = min(m_nStart
							+ ((nSernoBytes == 0) ? 70 : ((nSernoBytes == 1)
									? 67
									: 66)), nLen);
				}

				b = true;
			}

			return b;
		}

		private byte[] getGsmBytes(String strMyContent) throws Exception {
			byte[] baMsg = null;
			int nSpecialAscii = countSpecialAscii(strMyContent);

			if (nSpecialAscii == 0) {
				baMsg = strMyContent.getBytes("ISO-8859-1");
			} else {
				char[] ca = strMyContent.toCharArray();
				baMsg = new byte[ca.length + nSpecialAscii];

				int n = 0;
				for (int i = 0; i < ca.length; i++) {
					char c = ca[i];

					if (c == '\n') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x1A & 0xFF);
					} else if (c == '^') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x14 & 0xFF);
					} else if (c == '{') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x28 & 0xFF);
					} else if (c == '}') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x29 & 0xFF);
					} else if (c == '\\') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x2F & 0xFF);
					} else if (c == '[') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x3C & 0xFF);
					} else if (c == '~') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x3D & 0xFF);
					} else if (c == ']') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x3E & 0xFF);
					} else if (c == '|') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x40 & 0xFF);
					} else if (c == '€') {
						baMsg[n++] = (byte) (0x1B & 0xFF);
						baMsg[n++] = (byte) (0x65 & 0xFF);
					} else {
						baMsg[n++] = (byte) (c & 0xFF);
					}
				}
			}

			return baMsg;
		}

		private byte[] gsmToAsciiBytes(byte[] baMsg, int nStartIdx, int nLen) {
			byte[] baAscii = new byte[baMsg.length - nStartIdx];
			int n = 0;

			for (int i = nStartIdx; i < nStartIdx + nLen; i++) {
				if (i < baMsg.length - 1) {
					byte b1 = baMsg[i];
					byte b2 = baMsg[i + 1];

					if (b1 == (byte) (0x1B & 0xFF)) {
						if (b2 == (byte) (0x1A & 0xFF)) {
							baAscii[n++] = (byte) '\n';
							i++;
						} else if (b2 == (byte) (0x14 & 0xFF)) {
							baAscii[n++] = (byte) '^';
							i++;
						} else if (b2 == (byte) (0x28 & 0xFF)) {
							baAscii[n++] = (byte) '{';
							i++;
						} else if (b2 == (byte) (0x29 & 0xFF)) {
							baAscii[n++] = (byte) '}';
							i++;
						} else if (b2 == (byte) (0x2F & 0xFF)) {
							baAscii[n++] = (byte) '\\';
							i++;
						} else if (b2 == (byte) (0x3C & 0xFF)) {
							baAscii[n++] = (byte) '[';
							i++;
						} else if (b2 == (byte) (0x3D & 0xFF)) {
							baAscii[n++] = (byte) '~';
							i++;
						} else if (b2 == (byte) (0x3E & 0xFF)) {
							baAscii[n++] = (byte) ']';
							i++;
						} else if (b2 == (byte) (0x40 & 0xFF)) {
							baAscii[n++] = (byte) '|';
							i++;
						} else if (b2 == (byte) (0x65 & 0xFF)) {
							baAscii[n++] = (byte) '€';
							i++;
						} else {
							baMsg[n++] = (byte) (b2 & 0xFF);
						}
					} else {
						baAscii[n++] = (byte) baMsg[i];
					}
				} else {
					baAscii[n++] = (byte) baMsg[i];
				}
			}

			if (n == nLen) {
				return baAscii;
			} else {
				byte[] baNew = new byte[n];

				for (int i = 0; i < n; i++) {
					baNew[i] = baAscii[i];
				}

				return baNew;
			}
		}

		private byte[] getMyContentBytes(String strMyContent, int nDescConvert)
				throws Exception {
			byte[] baMsg = null;

			if (nDescConvert == 1) { //1: ASCII => HEX String
				baMsg = strMyContent.getBytes("US-ASCII");
			} else if (nDescConvert == 3) { //3: ISO-8859-1 GSM 7-bit => HEX String
				baMsg = getGsmBytes(strMyContent);
			} else if (nDescConvert == 8) { //8: Unicode UTF-16BE => HEX String
				baMsg = strMyContent.getBytes("UTF-16BE");
			}

			return baMsg;
		}

		private int getTotalSplit(boolean bEnglish, boolean bISO,
				int nSernoBytes, String strMsgInput) {
			int nTotalSplit = 0;
			int nLen = strMsgInput.length();

			if (bEnglish && (nLen <= 160)) {
				int nSpecialAscii = bISO ? countSpecialAscii(strMsgInput) : 0;

				if (nLen + nSpecialAscii <= 160) {
					return 1;
				}
			} else if (!bEnglish && (nLen <= 70)) {
				return 1;
			}

			initSplit();

			while (nextSplit(bEnglish, bISO, nSernoBytes, strMsgInput)) {
				nTotalSplit++;
			}

			return nTotalSplit;
		}

		public String getMyContent(boolean bEnglish, boolean bISO,
				int nSernoBytes, int nCurrSplit, int nTotalSplit,
				String strMsgInput) {
			if ((nCurrSplit == 1) && (nTotalSplit == 1)) {
				return strMsgInput;
			}

			initSplit();

			int n = 0;
			while (nextSplit(bEnglish, bISO, nSernoBytes, strMsgInput)) {
				n++;
				if (n == nCurrSplit) {
					break;
				}
			}

			return strMsgInput.substring(m_nStart, m_nEnd);
		}

		private TrustManager[] get_trust_mgr() {
			TrustManager[] certs = new TrustManager[]{new X509TrustManager() {
				public X509Certificate[] getAcceptedIssuers() {
					return null;
				}

				public void checkClientTrusted(X509Certificate[] certs, String t) {
				}

				public void checkServerTrusted(X509Certificate[] certs, String t) {
				}
			}};

			return certs;
		}

		private void debugEncodedMsg(int nMsgDcs, int nMsgUdhi,
				String strEncodedMsg) {
			if ((strEncodedMsg == null) || (strEncodedMsg.length() == 0)) {
				m_sbIMSP.append("<font size=\"-1\" face=\"Arial\">msg 之長度為 "
						+ strEncodedMsg.length()
						+ " URL Encoded characters</font><br/>");

				return;
			}

			try {
				String strDebug = null;

				if (nMsgDcs == 0) {
					String strBig5 = URLDecoder.decode(strEncodedMsg, "big5");

					m_sbIMSP.append("<font size=\"-1\" face=\"Arial\">msg 之長度為 "
							+ strEncodedMsg.length()
							+ " URL Encoded characters, 解碼得 "
							+ strBig5.length() + " 個 big5 中文或英文字</font><br/>");

					strDebug = "Big5 => " + strBig5;
				}

				if (strDebug != null) {
					m_sbIMSP.append("<font size=\"-1\" face=\"Arial\" color=\"blue\">[msg_udhi="
							+ nMsgUdhi
							+ ", msg_dcs="
							+ nMsgDcs
							+ "] "
							+ strDebug + "</font><br/>");
				}
			} catch (Exception e) {
				m_sbIMSP.append("<font size=\"-1\" face=\"Arial\" color=\"red\">*** debugEncodedMsg() 發生不明例外 ["
						+ e.getClass().getName() + "] "
						+ getMyselfString(e.getMessage().replace("\n", "<br/>")) 
						+ "</font><br/>\n");

				e.printStackTrace();
			}
		}

		private void debugHexMsg(int nMsgDcs, int nMsgUdhi, String strHexMsg) {
			m_sbIMSP.append("<font size=\"-1\" face=\"Arial\">msg 之長度為 "
					+ strHexMsg.length() + " hex characters</font><br/>");

			if ((strHexMsg == null) || (strHexMsg.length() % 2 != 0)) {
				return;
			}

			byte[] byteMsg = null;

			if (strHexMsg != null) {
				byteMsg = new byte[strHexMsg.length() / 2];

				for (int i = 0; i < byteMsg.length; i++) {
					String strHex = strHexMsg.substring(i * 2, i * 2 + 2);

					try {
						byteMsg[i] = (byte) (Integer.parseInt(strHex, 16) & 0xFF);
					} catch (Exception e) {
						m_sbIMSP.append("<font size=\"-1\" face=\"Arial\" color=\"red\">*** msg= 之第 "
								+ i
								+ " 個位置含不正確的 HEX 字元 "
								+ " ["
								+ e.getClass().getName()
								+ "] "
								+ getMyselfString(e.getMessage()) + "</font><br/>");
						return;
					}
				}
			}

			int nCURR_SPLIT = 0;
			int nTOTAL_SPLIT = 0;
			int nStartIdx = 0;
			int nSerno = 0;

			if (nMsgUdhi != 0) {
				if ((byteMsg.length > 6) && (byteMsg[0] == 0x05)
						&& (byteMsg[1] == 0x00) && (byteMsg[2] == 0x03)) { //[3] 為長簡訊序號, [4] 為總則數, [5] 為第幾則
					byte b3 = byteMsg[3];
					byte b4 = byteMsg[4];
					byte b5 = byteMsg[5];

					nSerno = (int) (b3 & 0xFF);
					nTOTAL_SPLIT = (int) (b4 & 0xFF);
					nCURR_SPLIT = (int) (b5 & 0xFF);
					nStartIdx = 6;
				} else if ((byteMsg.length > 7) && (byteMsg[0] == 0x06)
						&& (byteMsg[1] == 0x08) && (byteMsg[2] == 0x04)) { //[3] & [4] 為長簡訊序號, [5] 為總則數, [6] 為第幾則
					byte b3 = byteMsg[3];
					byte b4 = byteMsg[4];
					byte b5 = byteMsg[5];
					byte b6 = byteMsg[6];

					nSerno = ((int) (b3 & 0xFF)) * 256 + (int) (b4 & 0xFF);
					nTOTAL_SPLIT = (int) (b5 & 0xFF);
					nCURR_SPLIT = (int) (b6 & 0xFF);
					nStartIdx = 7;
				}
			}

			try {
				String strDebug = null;

				if (nMsgDcs == 1) {
					String strEnglish = new String(byteMsg, nStartIdx,
							byteMsg.length - nStartIdx, "US-ASCII");

					if (nStartIdx == 0) {
						strDebug = "US-ASCII (傳送 " + strEnglish.length()
								+ " 個英文字) => " + strEnglish;
					} else {
						strDebug = "<font color=\"red\">[" + nCURR_SPLIT + "/"
								+ nTOTAL_SPLIT + "]</font> US-ASCII (傳送 "
								+ strEnglish.length() + " 個英文字) => "
								+ strEnglish;
					}
				} else if (nMsgDcs == 3) {
					byte[] baASCII = gsmToAsciiBytes(byteMsg, nStartIdx,
							byteMsg.length - nStartIdx);
					String strEnglish = new String(baASCII, "ISO-8859-1");
					int nSpecialCount = countSpecialAscii(byteMsg);

					if (nStartIdx == 0) {
						strDebug = "ISO-8859-1 (含 " + nSpecialCount
								+ " 個 1B 延伸碼，傳送 " + strEnglish.length()
								+ " 個 GSM-7 英文字) => " + strEnglish;
					} else {
						strDebug = "<font color=\"red\">[" + nCURR_SPLIT + "/"
								+ nTOTAL_SPLIT + "]</font> ISO-8859-1 (含 "
								+ nSpecialCount + " 個 1B 延伸碼，傳送 "
								+ strEnglish.length() + " 個 GSM-7 英文字) => "
								+ strEnglish;
					}
				} else if (nMsgDcs == 8) {
					String strChinese = new String(byteMsg, nStartIdx,
							byteMsg.length - nStartIdx, "UTF-16BE");

					if (nStartIdx == 0) {
						strDebug = "UTF-16BE (傳送 " + strChinese.length()
								+ " 個字) => " + strChinese;
					} else {
						strDebug = "<font color=\"red\">[" + nCURR_SPLIT + "/"
								+ nTOTAL_SPLIT + "]</font> UTF-16BE (傳送 "
								+ strChinese.length() + " 個字) => " + strChinese;
					}
				}

				if (strDebug != null) {
					m_sbIMSP.append("<font size=\"-1\" face=\"Arial\" color=\"blue\">[msg_udhi="
							+ nMsgUdhi
							+ ", msg_dcs="
							+ nMsgDcs
							+ "] "
							+ strDebug + "</font><br/>");
				}
			} catch (Exception e) {
				m_sbIMSP.append("<font size=\"-1\" face=\"Arial\" color=\"red\">*** debugHexMsg() 發生不明例外 ["
						+ e.getClass().getName() + "] " 
						+ getMyselfString(e.getMessage().replace("\n", "<br/>"))
						+ "</font><br/>\n");

				e.printStackTrace();
			}
		}

		private void debugParameters(String strParameters) {
			int nIdx = strParameters.indexOf("msg=");

			if (nIdx != -1) {
				String strHexMsg = strParameters.substring(nIdx + 4);

				int nMsgDcs = 0;
				{
					int nIdx2 = strParameters.indexOf("&msg_dcs=");

					if (nIdx2 != -1) {
						String strRemain = strParameters.substring(nIdx2
								+ "&msg_dcs=".length());

						int nIdx3 = strRemain.indexOf("&");

						if (nIdx != -1) {
							nMsgDcs = Integer.parseInt(
									strRemain.substring(0, nIdx3), 16);
						}
					}
				}

				int nMsgUdhi = 0;
				{
					int nIdx2 = strParameters.indexOf("&msg_udhi=");

					if (nIdx2 != -1) {
						String strRemain = strParameters.substring(nIdx2
								+ "&msg_udhi=".length());

						int nIdx3 = strRemain.indexOf("&");

						if (nIdx != -1) {
							nMsgUdhi = Integer.parseInt(
									strRemain.substring(0, nIdx3), 16);
						}
					}
				}

				if (nMsgDcs == 0) {
					debugEncodedMsg(nMsgDcs, nMsgUdhi, strHexMsg);
				} else {
					debugHexMsg(nMsgDcs, nMsgUdhi, strHexMsg);
				}
			}
		}

		private final char[] hexArray = "0123456789ABCDEF".toCharArray();

		public String bytesToHex(byte[] bytes) {
			String strHex = null;

			if ((bytes != null) && (bytes.length > 0)) {
				char[] hexChars = new char[bytes.length * 2];
				for (int j = 0; j < bytes.length; j++) {
					int v = bytes[j] & 0xFF;
					hexChars[j * 2] = hexArray[v >>> 4];
					hexChars[j * 2 + 1] = hexArray[v & 0x0F];
				}
				strHex = new String(hexChars);
			}

			return strHex;
		}

		// HTTPS POST/GET request
		private void sendHttpSSLMethod(String strSubmitURL, String strMethod,
				String strParameters) throws Exception {

			m_sbIMSP.append("<font size=\"-1\" face=\"Arial\">===========================================</font><br/>");

			//JDK 1.6_121 才支援 v1.2; JDK 1.7 有支援 v1.2; JDK1.8 內定啟用 v1.2, 請使用 TLSv1.2 或更高加密等級連線
			SSLContext ssl_ctx = SSLContext.getInstance("TLSv1.2");
			TrustManager[] trust_mgr = get_trust_mgr();

			ssl_ctx.init(null, // key manager
					trust_mgr, // trust manager
					new SecureRandom()); // random number generator

			SSLContext.setDefault(ssl_ctx);
					
			HttpsURLConnection.setDefaultSSLSocketFactory(ssl_ctx
					.getSocketFactory());

			m_sbIMSP.append("<font size=\"-1\" face=\"Arial\">Sending SSL "
					+ ssl_ctx.getProtocol() + " " + strMethod
					+ " Parameters: <br/><font color=\"maroon\">"
					+ strSubmitURL + "?" + strParameters
					+ "</font></font><br/>");

			debugParameters(strParameters);

			URL url = new URL(strSubmitURL);
			HttpsURLConnection conn = (HttpsURLConnection) url.openConnection();

			conn.setSSLSocketFactory(ssl_ctx.getSocketFactory());
			conn.setConnectTimeout(5000);

			conn.setHostnameVerifier(new HostnameVerifier() {
				public boolean verify(String host, SSLSession sess) {
					if (host.equals("imsp.emome.net")) {
						return true;
					} else {
						return false;
					}
				}
			});

			//add request header
			conn.setRequestMethod(strMethod);

			// Send post request
			conn.setDoOutput(true);

			DataOutputStream wsr = null;
			BufferedReader isr = null;

			try {
				wsr = new DataOutputStream(conn.getOutputStream());

				wsr.writeBytes(strParameters);
				wsr.flush();
				wsr.close();
				wsr = null;

				int responseCode = conn.getResponseCode();

				isr = new BufferedReader(new InputStreamReader(
						conn.getInputStream()/*, "UTF-8"*/));
				String inputLine;
				StringBuffer resp = new StringBuffer();

				while ((inputLine = isr.readLine()) != null) {
					resp.append(inputLine);
				}

				isr.close();
				isr = null;

				conn.disconnect();

				m_sbIMSP.append("<font size=\"-1\" face=\"Arial\">Response Code: "
						+ responseCode
						+ ", IMSP SMS Result: <font color=\"maroon\">"
						+ getMyselfString(resp.toString()) + "</font></font><br/>");
			} catch (Exception e) {
				m_sbIMSP.append("<font size=\"-1\" face=\"Arial\" color=\"red\">*** sendHttpSSLMethod(): "
						+ strSubmitURL
						+ " ["
						+ e.getClass().getName()
						+ "] "
						+ getMyselfString(e.getMessage().replace("\n", "<br/>"))
						+ "</font><br/>\n");

				e.printStackTrace();
			} finally {
				if (isr != null) {
					try {
						isr.close();
					} catch (Exception e) {
					}
					isr = null;
				}
				if (wsr != null) {
					try {
						wsr.close();
					} catch (Exception e) {
					}
					wsr = null;
				}
			}
		}
	}%>
<%
	if ((strAccount != null) && (strAccount.length() > 0)
			&& (strKeycode != null) && (strKeycode.length() > 0)
			&& (strFromAddr != null) && (strFromAddr.length() > 0)
			&& (strToAddr != null) && (strToAddr.length() > 0)) {
		ImspTools t = new ImspTools();

		try {
			if ((strTextInput == null) || (strTextInput.length() == 0)) {
				t.appendImspResult("<font size=\"-1\" face=\"Arial\" color=\"red\">*** 請輸入要送出的文字訊息內容！</font>");
			} else if (nTextMsgType == -1) {
				t.appendImspResult("<font size=\"-1\" face=\"Arial\" color=\"red\">*** 請選擇要送出的 msg_type 參數！</font>");
			} else if (nTextDcsConvert == -1) {
				t.appendImspResult("<font size=\"-1\" face=\"Arial\" color=\"red\">*** 請選擇要轉換的文字訊息種植參數！</font>");
			} else {
				boolean bEnglish = t.isPureEnglish(strTextInput);
				boolean bISO = (nTextDcsConvert == TEXT_DCS_CONVERT_ISO_8859_1/*3*/)
						? true
						: false;

				if (!bEnglish
						&& ((nTextDcsConvert == TEXT_DCS_CONVERT_ASCII/*1*/) || (nTextDcsConvert == TEXT_DCS_CONVERT_ISO_8859_1/*3*/))) {
					t.appendImspResult("<font size=\"-1\" face=\"Arial\" color=\"red\">*** 注意：您選擇 ASCII 或 ISO-8859-1 編碼，但訊息內容含非英文，受訊手機將會收到亂碼！<br/></font>");
				}

				String strHexSerno = null;

				if (nTextDcsConvert != TEXT_DCS_CONVERT_BIG5/*0*/) {
					if (nTextSernoBytes == 1) {
						strHexSerno = String.format("%02X",
								(System.nanoTime() % 0xFF));
					} else {
						strHexSerno = String.format("%04X",
								(System.nanoTime() % 0xFFFF));
					}
				}

				int nSernoBytes = (strHexSerno == null)
						? 0
						: strHexSerno.length() / 2;

				int nTotalSplit = t.getTotalSplit(bEnglish, bISO,
						nSernoBytes, strTextInput);
				int nMsgUdhi = (nTotalSplit > 1) ? 1 : 0;

				if (nTotalSplit > 1) {
					if (strHexSerno == null) {
						t.appendImspResult("<font size=\"-1\" color=\"red\" face=\"Arial\">*** 注意：您選擇 msg_dcs=0 (big5 URL Encoded) 編碼，因不支援長簡訊，改為 msg_udhi=0 (共分割 "
								+ nTotalSplit + " 則)</font><br/><br/>");
						nMsgUdhi = 0;
					} else {
						t.appendImspResult("<font size=\"-1\" color=\"red\" face=\"Arial\">用到長簡訊序號=0x"
								+ strHexSerno
								+ " (共分割 "
								+ nTotalSplit
								+ " 則)</font><br/><br/>");
					}
				}

				if (nTextMsgType == 1) {
					t.appendImspResult("<font size=\"-1\" face=\"Arial\" color=\"red\">注意：使用 POP-UP SMS！</font><br/>");
				}

				for (int nCurrSplit = 1; nCurrSplit <= nTotalSplit; nCurrSplit++) {
					String strUrlOrHexMsg = null;

					if (nTextDcsConvert == TEXT_DCS_CONVERT_BIG5/*0*/) {
						String strMyContent = t.getMyContent(bEnglish,
								bISO, 0, nCurrSplit, nTotalSplit,
								strTextInput);

						strUrlOrHexMsg = URLEncoder.encode(
								strMyContent, "big5");
					} else {
						String strMyContent = t.getMyContent(bEnglish,
								bISO, nSernoBytes, nCurrSplit,
								nTotalSplit, strTextInput);

						byte[] baMsg = t.getMyContentBytes(
								strMyContent, nTextDcsConvert);

						StringBuffer sbMsg = new StringBuffer();

						if (nTotalSplit > 1) {
							if (nSernoBytes == 1) {
								sbMsg.append("050003"
										+ strHexSerno
										+ String.format("%02X",
												nTotalSplit)
										+ String.format("%02X",
												nCurrSplit));
							} else {
								sbMsg.append("060804"
										+ strHexSerno
										+ String.format("%02X",
												nTotalSplit)
										+ String.format("%02X",
												nCurrSplit));
							}
						}

						sbMsg.append(t.bytesToHex(baMsg));

						strUrlOrHexMsg = sbMsg.toString();
					}

					StringBuffer sbPostData = new StringBuffer();

					sbPostData.append("account=" + strAccount);
					sbPostData.append("&password=" + strKeycode);
					sbPostData.append("&from_addr_type="
							+ nFromAddrType);
					sbPostData.append("&from_addr="
							+ URLEncoder.encode(strFromAddr, "big5")
									.toUpperCase());
					sbPostData.append("&to_addr_type=" + nToAddrType);
					sbPostData.append("&to_addr="
							+ URLEncoder.encode(strToAddr, "big5")
									.toUpperCase());
					sbPostData.append("&msg_expire_time="
							+ nMsgExpireTime);
					sbPostData.append("&msg_type=" + nTextMsgType);
					sbPostData.append("&msg_udhi=" + nMsgUdhi);
					sbPostData.append("&msg_dcs=" + nTextDcsConvert);
					sbPostData.append("&msg=" + strUrlOrHexMsg);

					if (nMethod == 0) {
						t.sendHttpSSLMethod(strSubmitURL, "POST",
								sbPostData.toString());
					} else {
						t.sendHttpSSLMethod(strSubmitURL, "GET",
								sbPostData.toString());
					}
				}
			}
		} catch (Exception e) {
			t.appendImspResult("<font size=\"-1\" face=\"Arial\" color=\"red\">*** 發生不明例外 ["
					+ e.getClass().getName() + "] " 
					+ getMyselfString(e.getMessage().replace("\n", "<br/>"))
					+ "</font>");

			e.printStackTrace();
		}

		out.println(unXss(xss(t.getImspResult())));
		out.println("<hr/><br/>\n");
	} else if (((strAccount != null) && (strAccount.length() > 0))
			|| ((strKeycode != null) && (strKeycode.length() > 0))
			|| ((strFromAddr != null) && (strFromAddr.length() > 0))
			|| ((strToAddr != null) && (strToAddr.length() > 0))) {
		out.println("<font color=\"red\">請選擇及輸入 IMSP SMS 測試資料，須填所有欄位參數！</font><br/><br/>現在時間: "
				+ new SimpleDateFormat("yyyy/MM/dd HH:mm:ss")
						.format(new java.util.Date()) + "\n");
		out.println("<hr/><br/>\n");
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>IMSP SMS Tester</title>
</head>
<body bgColor="#f2fff2"
	style="font-family: 微軟正黑體, Arial, Helvetica, sans-serif, Times New Roman, 標楷體, 新細明體;">
	<form name="form1" method="post" action="sms_sample.jsp">
		<table BGCOLOR='WhiteSmoke' CELLSPACING='0' BORDER='1' CELLPADDING='1'
			align='center'>
			<tr>
				<th colspan="2" align="center" bgcolor="silver"><font size="+1"
					color="maroon"><b>IMSP SMS 測試程式 (UTF-8 編碼測試網頁) </b></font></th>
			</tr>
			<tr align="left">
				<td align="right"><b>介接網址：</b></td>
				<td>https://imsp.emome.net:4443/imsp/sms/servlet/SubmitSM</td>
			</tr>
			<tr align="left">
				<td align="right"><b>傳送方式：</b></td>
				<td><select id="idMethod" name="idMethod" class="text-form">
						<option value="0"
							<%if (nMethod == 0) {
				out.write(" selected=\"selected\"");
			}%>>
							POST</option>
						<option value="1"
							<%if (nMethod == 1) {
				out.write(" selected=\"selected\"");
			}%>>
							GET</option>
				</select></td>
			</tr>
			<tr align="left">
				<td align="right"><b>帳號 (account)：</b></td>
				<td><input type="text" id="idAccount" name="idAccount"
					value="<%=(strAccount != null) ? strAccount : ""%>"
					autocomplete="off" size="15"></td>
			</tr>
			<tr align="left">
				<td align="right"><b>密碼 (password)：</b></td>
				<td><input type="text" id="idKeycode" name="idKeycode"
					value="<%=(strKeycode != null) ? strKeycode : ""%>"
					autocomplete="off" size="16"></td>
			</tr>
			<tr align="left">
				<td align="right"><b>發訊方種類 (from_addr_type)：</b></td>
				<td>0:手機門號</td>
			</tr>
			<tr align="left">
				<td align="right"><b>發訊方號碼 (from_addr)：</b></td>
				<td><input type="text" id="idFromAddr" name="idFromAddr"
					value="<%=(strFromAddr != null) ? strFromAddr : ""%>"
					autocomplete="off" size="15"><font color="maroon" size="-1">
						<br />(限國內 09 或 8869 開頭門號；若無變更發訊方號碼權限者可用 8869115xxxxx，其中 xxxxx
						為特碼)
				</font></td>
			</tr>
			<tr align="left">
				<td align="right"><b>受訊方種類 (to_addr_type)：</b></td>
				<td>0:手機門號</td>
			</tr>
			<tr align="left">
				<td align="right"><b>受訊號碼 (to_addr)：</b></td>
				<td><input type="text" id="idToAddr" name="idToAddr"
					value="<%=(strToAddr != null) ? strToAddr : ""%>"
					autocomplete="off" size="90"><font color="maroon" size="-1">
						<br />(限國內 09 或 8869 開頭門號、國際門號須以 + 開頭門號；最多可填20組號碼，多個號碼之間請以,分隔) <br />(發送國內其它業者、或國際門號者，須先申請其帳號權限)
				</font></td>
			</tr>
			<tr align="left">
				<td align="right"><b>重送期限 (msg_expire_time)：</b></td>
				<td><input type="text" id="idMsgExpireTime"
					name="idMsgExpireTime" value="<%=nMsgExpireTime%>"
					autocomplete="off" size="4"> 分鐘</td>
			</tr>
			<tr align="left">
				<td align="right"><b>自行輸入 TEXT 文字訊息，<br />並自動轉換及送出：
				</b><br /> <br /></td>
				<td align="left">
					<table border="0" align="left">
						<tr>
							<td alig="left">
								<%
									out.print("<textarea id=\"textInput\" name=\"textInput\" cols=\"80\" rows=\"4\">");
									if (strTextInput != null) {
										out.print(strTextInput);
									}
									out.println("</textarea>");
								%>
							</td>
						</tr>
						<tr>
							<td align="left">選擇 msg_type：<input type="radio"
								id="textMsgType" name="textMsgType" value="0"
								<%if ((nTextMsgType == -1) || (nTextMsgType == 0)) {
				out.write(" checked");
			}%>>0:normal
								SMS<input type="radio" id="textMsgType" name="textMsgType"
								value="1"
								<%if (nTextMsgType == 1) {
				out.write(" checked");
			}%>>1:POP-UP
								SMS
							</td>
						</tr>
						<tr>
							<td align="left">
								<table border="0" cellspacing="0" cellpadding="0" align="left">
									<tr>
										<td>轉換至：</td>
										<td align="left"><select id="textDcsConvert"
											name="textDcsConvert" class="text-form">
												<option value="-1"
													<%if (nTextDcsConvert == -1) {
				out.write(" selected=\"selected\"");
			}%>>(請選擇)
												</option>
												<option value="<%=TEXT_DCS_CONVERT_BIG5%>"
													<%if (nTextDcsConvert == TEXT_DCS_CONVERT_BIG5/*0*/) {
				out.write(" selected=\"selected\"");
			}%>>0:
													Big5 (URL Encoded 中英訊息，已不建議)</option>
												<option value="<%=TEXT_DCS_CONVERT_ASCII%>"
													<%if (nTextDcsConvert == TEXT_DCS_CONVERT_ASCII/*1*/) {
				out.write(" selected=\"selected\"");
			}%>>1:
													ASCII (HEX 訊息)</option>
												<option value="<%=TEXT_DCS_CONVERT_ISO_8859_1%>"
													<%if (nTextDcsConvert == TEXT_DCS_CONVERT_ISO_8859_1/*3*/) {
				out.write(" selected=\"selected\"");
			}%>>3:
													ISO-8859-1 (HEX 訊息)</option>
												<option value="<%=TEXT_DCS_CONVERT_UTF16BE%>"
													<%if (nTextDcsConvert == TEXT_DCS_CONVERT_UTF16BE/*8*/) {
				out.write(" selected=\"selected\"");
			}%>>8:
													Unicode (HEX 訊息，適用中文及非英文)</option>
										</select></td>
										<td>&nbsp;<font size="-1">(將轉換至一或多則對應的
												msg_udhi、msg_dcs、msg 參數)</font></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td align="left"><table border="0" cellspacing="0"
									cellpadding="0" align="left">
									<tr>
										<td>長簡訊：</td>
										<td align="left"><select id="textSernoBytes"
											name="textSernoBytes" class="text-form">
												<option value="1"
													<%if (nTextSernoBytes == 1) {
				out.write(" selected=\"selected\"");
			}%>>
													一個 byte 序號 0x00 ~ 0xFF (各則最多 67 個中文字、或 153 個英文字)</option>
												<option value="2"
													<%if (nTextSernoBytes == 2) {
				out.write(" selected=\"selected\"");
			}%>>兩個
													bytes 序號 0x0000 ~ 0xFFFF (各則最多 66 個中文字、或 152 個英文字)</option>
										</select><font color="maroon" size="-1"> (須申請其權限)</font></td>
									</tr>
								</table></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br />
		<p align="center">
			<input type="submit" value=" 測 試 "><br />
		</p>
	</form>
	<table border="0" cellspacing="5" cellpadding="3" align="center">
		<tr>
			<td valign="top" nowrap>註 1：</td>
			<td>只有 msg_dcs=0 之 msg= 才使用 URL 編碼訊息，其他為 HEX 編碼訊息。</td>
		</tr>
		<tr>
			<td valign="top" nowrap>註 2：</td>
			<td>msg_dcs=0 表 msg= 為 BIG-5 編碼訊息，由 IMSP 自動轉換中或英文；<br />
				msg_dcs=1 表 ASCII 英文訊息；msg_dcs=3 表示 ISO-8859-1 GSM 7-bit <br />
				英文訊息；msg_dcs=8 表 UTF-16BE 編碼訊息。
			</td>
		</tr>
		<tr>
			<td valign="top" nowrap>註 3：</td>
			<td>msg_dcs=3 需用 1B 延伸碼才可正常顯示十個 GSM 7-bit 特殊字元，包括：<br /> 1B0A
				(0C, 換行)、1B14 (5E, ^)、1B28 (7B, {)、1B29 (7D, })、1B2F (5C, \)、<br />
				1B3C (5B, [)、1B3D (7E, ~)、1B3E (5D, ])、1B40 (7C, |)、1B65 (無, €) 等。
			</td>
		</tr>
	</table>
	<br />
</body>
</html>
