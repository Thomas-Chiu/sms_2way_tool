<?php

/* 名稱：hiAir Send Text For PHP範例程式
 * 撰寫者 : HiNet - hiAir , Chih-Ming Liao
 * 日期 : 2006/06/27
 */

include "sms2.inc";

error_reporting (E_ALL);

echo "<h2> hiAir 查詢文字簡訊傳送結果 </h2>\n";

/* Socket to Air Server IP ,Port */
$server_ip = '202.39.54.130';
$server_port = 8000;
$TimeOut=60;

$user_acc  = "帳號";
$user_pwd  = "密碼";
$messageid= "填入messageID";


/*建立連線*/
$mysms = new sms2();
$ret_code = $mysms->create_conn($server_ip, $server_port, $TimeOut, $user_acc, $user_pwd);
$ret_msg = $mysms->get_ret_msg();

if($ret_code==0){ 
      echo "連線成功"."<br>\n";
      //長簡訊取消用cancel_long(), 短簡訊取消用 cancel_text()
      $ret_code = $mysms->cancel_long($messageid);
      // $ret_code = $mysms->cancel_text($messageid);
      $ret_msg = $mysms->get_ret_msg();
      echo "查詢結果:"."<br>\n";
      echo "ret_code=".$ret_code."<br>\n";
      echo "ret_msg=".$ret_msg."<br>\n";
} else {  
      echo "連線失敗"."<br>\n";
      echo "ret_code=".$ret_code."<br>\n";
      echo "ret_msg=".$ret_msg."<br>\n";
}

/*關閉連線*/
$mysms->close_conn();
?>

