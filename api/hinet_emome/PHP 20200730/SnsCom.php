<html>

<head>
  <script language="JavaScript">
    function Show(n) {

      if (n == 1) {
        document.all["SendForm"].style.display = "block";
        document.all["QueryForm"].style.display = "none";
        document.all["RecvForm"].style.display = "none";

      }


      if (n == 2) {
        document.all["SendForm"].style.display = "none";
        document.all["QueryForm"].style.display = "block";
        document.all["RecvForm"].style.display = "none";
      }

      if (n == 3) {
        document.all["SendForm"].style.display = "none";
        document.all["QueryForm"].style.display = "none";
        document.all["RecvForm"].style.display = "block";
      }

    }
  </script>
  <title>SNS範例程式</title>
</head>

<body>
  <?php

  //宣告一物件變數為SNSComServer元件
  $testCom = new COM("CHT.SNSCOMSERVER.SnsComObject3");



  //預設登入IP為203.66.172.133, Port為8001
  $SNS_IP = "203.66.172.133";
  $SNS_Port = 8001;


  //輸入您的帳號和密碼 
  $Account = "";
  $Password = "";

  //預設為傳送訊息的畫面
  $ShowSendForm = "display:block";
  $ShowQryForm = "display:none";
  $ShowRecvForm = "display:none";

  //預設使用者點選功能為傳送訊息
  $Func = "1";

  //宣告變數的初始值
  $MsgId = "";
  $QryPhone = "";
  $SendMsisdn = "";
  $RecvMsisdn = "";
  $RecvMsg = "";

  $ResponseMsg = "";  //傳送訊息或查詢狀態的結果
  if (count($_POST) > 0) {
    $Func = $_POST["Func"];

    if ($Func == "1") {   //選擇傳送訊息的功能
      $SendPhone = $_POST["SendPhoneNum"];
      $Message = $_POST["Message"];


      //參數初始化
      $testCom->InitRemoteServer($_POST["IP"], $_POST["Port"], $_POST["Account"], $_POST["Password"]);

      //登入SNS Server
      $retCode_1 = $testCom->Login();

      //如果登入成功,才繼續執行傳送簡訊
      if ($retCode_1 = 1) {
        //傳送手機號碼, 訊息內容     
        $retCode_2 = $testCom->SubmitMessage(null, $SendPhone, $Message, 1440);

        //依據回應碼判斷傳送結果
        switch ($retCode_2) {
          case -1:
            $ResponseMsg = $testCom->GetRespDesc();
            break;
          case 0:
            $ResponseMsg = "傳送成功;Message_id=" . $testCom->GetRespDesc();
            //查詢狀態中的手機號碼預設為傳送手機號碼
            $QryPhone = $SendPhone;
            //查詢狀態中的Message_Id預設為回傳的訊息，以備查詢
            $MsgId = $testCom->GetRespDesc();
            break;
          default:
            $ResponseMsg = "傳送失敗(" . $retCode_2 . ");原因=" . $testCom->GetRespDesc();
        }

        //登出
        $testCom->Logout();
        //登入失敗
      } else {
        $ResponseMsg = "登入失敗 :" . $testCom->GetRespDesc();
      }

      //控制在傳送訊息的畫面
      $ShowSendForm = "display:block";
      $ShowQryForm = "display:none";
      $ShowRecvForm = "display:none";
    }


    if ($Func == "2") { //選擇查詢狀態的功能

      $QryPhone = $_POST["QryPhoneNum"];
      $MsgId = $_POST["MsgId"];

      //參數初始化
      $testCom->InitRemoteServer($_POST["IP"], $_POST["Port"], $_POST["Account"], $_POST["Password"]);

      //登入SNS Server
      $retCode_1 = $testCom->Login();

      //如果登入成功,才繼續執行簡訊狀態查詢
      if ($retCode_1 = 1) {
        //查詢手機號碼, Message_Id
        $retCode_2 = $testCom->QueryMessageStatus(null, $QryPhone, $MsgId);

        //依據回應碼判斷查詢結果
        if ($retCode_2 = -1) {
          $ResponseMsg = "查詢失敗 :" . $testCom->GetRespDesc();
        } else {
          $ResponseMsg = "訊息代碼=" .  $retCode_2 . ";狀態=" . $testCom->GetRespDesc();
        }

        //登出
        $testCom->Logout();
        //登入失敗
      } else {
        $ResponseMsg = "登入失敗 :" . $testCom->GetRespDesc();
      }

      //控制在查詢狀態的畫面
      $ShowSendForm = "display:none";
      $ShowQryForm = "display:block";
      $ShowRecvForm = "display:none";
    }


    if ($Func == "3") { //選擇接收訊息的功能

      //參數初始化
      $testCom->InitRemoteServer($_POST["IP"], $_POST["Port"], $_POST["Account"], $_POST["Password"]);

      //登入SNS Server
      $retCode_1 = $testCom->Login();

      //如果登入成功,才繼續執行簡訊狀態查詢
      if ($retCode_1 = 1) {
        //呼叫接收訊息
        $retCode_2 = $testCom->GetMessage();

        //依據回應碼判斷傳送結果
        switch ($retCode_2) {
          case -1:
            $ResponseMsg = $testCom->GetRespDesc();
            break;
          case 0:
            //接收訊息其傳送手機號碼
            $SendMsisdn = $testCom->GetFromMsisdn();

            //接收訊息其接收手機號碼
            $RecvMsisdn = $testCom->GetToMsisdn();

            //接收訊息其接收訊息內容
            $RecvMsg = $testCom->GetRecvSMS();
            break;
          default:
            $ResponseMsg = "接收失敗(" . $retCode_2 . ");原因=" . $testCom->GetRespDesc();
        }

        //登出
        $testCom->Logout();
        //登入失敗
      } else {
        $ResponseMsg = "登入失敗 :" . $testCom->GetRespDesc();
      }

      //控制在查詢狀態的畫面
      $ShowSendForm = "display:none";
      $ShowQryForm = "display:none";
      $ShowRecvForm = "display:block";
    }
  }

  ?>

  <form method="POST" name="form1" action="">
    <div style="width:60%" align="center">
      <input type="radio" value="1" <?php if ($Func == "1") {
                                      echo "checked";
                                    } ?> name="Func" onclick="Show(1)">傳送訊息&nbsp;&nbsp;
      <input type="radio" value="2" <?php if ($Func == "2") {
                                      echo "checked";
                                    } ?> name="Func" onclick="Show(2)">查詢狀態&nbsp;&nbsp;
      <input type="radio" value="3" <?php if ($Func == "3") {
                                      echo "checked";
                                    } ?> name="Func" onclick="Show(3)">接收訊息
    </div>

    <hr>
    <table border="0" width="60%" align="center" style="background-color: #FFFFCC">
      <caption>
        <font size="4" color="#0000FF"><b>登入帳號</b></font>
      </caption>
      <tr>
        <td width="15%" align="right">IP：</td>
        <td width="25%" align="left">
          <input type="text" name="IP" size="20" value="<?php echo $SNS_IP; ?>">
        </td>
        <td width="14%" align="right">Port：</td>
        <td width="44%" align="left"><input type="text" name="Port" size="20" value="<?php echo $SNS_Port; ?>" maxlength="4"></td>
      </tr>
      <tr>
        <td width="15%" align="right">帳號：
        </td>
        <td width="25%" align="left">
          <input type="text" name="Account" size="20" maxlength="5" value="<?php echo $Account; ?>">
        </td>
        <td width="14%" align="right">
          密碼：</td>
        <td width="44%" align="left">
          <input type="text" name="Password" size="20" maxlength="5" value="<?php echo $Password; ?>">
        </td>
      </tr>
      <tr>
        <td width="99%" align="center" colspan="4">
          　</td>
      </tr>
    </table>
    <p>

    <div id="SendForm" style="<?php echo $ShowSendForm ?>">
      <table border="0" width="60%" align="center" style="background-color: #FFFFCC">
        <caption>
          <font size="4" color="#0000FF"><b>傳送訊息</b></font>
        </caption>
        <tr>
          <td width="15%">手機號碼：</td>
          <td width="85%" align="left"><input type="text" name="SendPhoneNum" size="20"></td>
        </tr>
        <tr>
          <td width="15%">訊息內容：
          </td>
          <td width="85%" align="left">
            <textarea rows="4" name="Message" cols="50"></textarea>
          </td>
        </tr>
        <tr>
          <td width="100%" align="center" colspan="2">
            <input type="submit" value="確定傳送" name="submit">
          </td>
        </tr>
      </table>
    </div>

    <div id="QueryForm" style="<?php echo $ShowQryForm ?>">
      <table border="0" width="60%" align="center" style="background-color: #FFFFCC">
        <caption>
          <font color="#0000FF" size="4"><b>查詢狀態</b></font>
        </caption>
        <tr>
          <td width="15%">手機號碼：</td>
          <td width="85%" align="left"><input type="text" name="QryPhoneNum" size="20" value="<?php echo $QryPhone; ?>"></td>
        </tr>
        <tr>
          <td width="15%">Message_Id：</td>
          <td width="85%" align="left"><input type="text" name="MsgId" size="20" value="<?php echo $MsgId; ?>"></td>
        </tr>
        <tr>
          <td width="100%" align="center" colspan="2">
            <input type="submit" value="確定查詢" name="submit">
          </td>
        </tr>
      </table>
    </div>

    <div id="RecvForm" style="<?php echo $ShowRecvForm ?>">
      <table border="0" width="60%" align="center" style="background-color: #FFFFCC" id="table1">
        <caption>
          <font size="4" color="#0000FF"><b>接收訊息</b></font>
        </caption>
        <tr>
          <td width="20%">傳送手機號碼：</td>
          <td width="79%" align="left">
            <input type="text" name="SendMsisdn" size="20" value="<?php echo $SendMsisdn; ?>" readonly>
          </td>
        </tr>
        <tr>
          <td width="20%">接收手機號碼：</td>
          <td width="79%" align="left">
            <input type="text" name="RecvMsisdn" size="20" value="<?php echo $RecvMsisdn; ?>" readonly>
          </td>
        </tr>
        <tr>
          <td width="20%">接收訊息內容：
          </td>
          <td width="79%" align="left">
            <textarea rows="4" name="RecvMsg" cols="50" readonly><?php echo $RecvMsg; ?></textarea>
          </td>
        </tr>
        <tr>
          <td width="100%" align="center" colspan="2">
            <input type="submit" value="確定接收" name="submit">
          </td>
        </tr>
      </table>
    </div>

  </form>
  <hr>
  <?php
  //輸出結果

  if ($ResponseMsg <> "") {
  ?>
    <script language="JavaScript">
      <!--
      alert("<?php echo $ResponseMsg; ?>");
      //
      -->
    </script>
  <?php  } ?>



</body>

</html>