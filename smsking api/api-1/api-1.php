<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=big5" />
  <title>²�T��216API-1²�T����</title>
  <style type="text/css">
    .style1 {
      font-size: 24px;
      font-weight: bold;
      letter-spacing: 1px;
    }
  </style>
</head>

<body>


  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>
  <p align="center" class="style1">²�T��216API-1²�T����</p>
  <table width="345" border="0" align="center">
    <form id="form1" name="form1" method="post" action="api-1.php">
      <tr>
        <td colspan="2">
          <?
          if (strlen(trim($_REQUEST["sUserName"])) > 0 && strlen(trim($_REQUEST["sPassword"])) > 0 && strlen(trim($_REQUEST["sTelNo"])) > 0 && strlen(trim($_REQUEST["sMessage"])) > 0) {
            //$msg="username=".$_REQUEST["sUserName"]."&password=".$_REQUEST["sPassword"]."&dstaddr=".$_REQUEST["sTelNo"]."&smbody=".$_REQUEST["sMessage"];
            $msg = "username=testapi01&password=testapi&dstaddr=" . $_REQUEST["sTelNo"] . "&smbody=" . $_REQUEST["sMessage"];

            $host = "202.39.48.216";

            $to_url = "http://" . $host . "/kotsmsapi-1.php?" . $msg;

            if (!$getfile = file($to_url)) {
              echo "<br><br><br><br><center>ERROR:�L�k�s��</center>";
              exit;
            }
            $term_tmp = implode('', $getfile);
            $term = $term_tmp;
            echo $term;
          }
          ?></td>
      </tr>
      <tr>
        <td width="69">&nbsp;</td>
        <td width="260">
          <input name="sUserName" type="hidden" id="sUserName" value="testapi01" readonly="readonly" />
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><input name="sPassword" type="hidden" id="sPassword" value="testapi" readonly="readonly" /></td>
      </tr>
      <tr>
        <td>��������</td>
        <td><input type="text" name="sTelNo" id="sTelNo" /></td>
      </tr>
      <tr>
        <td>²�T���e</td>
        <td><textarea name="sMessage" rows="5" id="sMessage"></textarea></td>
      </tr>
      <tr>
        <td colspan="2" align="center"><input type="button" name="button" id="button" value="�e�X" onclick="document.form1.submit();this.disabled=true" /><input type="submit" name="button" value="send" style="display:none"></td>
      </tr>
    </form>
  </table>
  <table width="360" border="0" align="center" cellpadding="5" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>
</body>

</html>