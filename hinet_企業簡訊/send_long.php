<?php

/* �W�١GhiAir Send Text For PHP�d�ҵ{��
 * ���g�� : HiNet - hiAir , Chih-Ming Liao
 * ���g��� : 2006/06/27
 * �ק�� : HiNet - hiAir , Mike
 * �ק��� : 2020/09/24
 * �Ƶ� : 
 * ���n���� : �нT�{²�T���e�s�X
 */

include "sms2.inc";

error_reporting (E_ALL);

echo "<h2> hiAir �ǰe��²�T </h2>\n";

/* Socket to Air Server IP ,Port */
$server_ip = '202.39.54.130';
$server_port = 8000;
$TimeOut=10;

$user_acc  = "�b��";
$user_pwd  = "�K�X";
$mobile_number= "����";
$message= "²�T���e�A���^�V�X�̪��i�F670�Ӧr";
$message_encodeFrom = "utf-8"; //�нT�{²�T���e�s�X "utf-8" or "big5" or "ucs-2" or other encodings

/*�إ߳s�u*/
$mysms = new sms2();
$ret_code = $mysms->create_conn($server_ip, $server_port, $TimeOut, $user_acc, $user_pwd);
$ret_msg = $mysms->get_ret_msg();

if($ret_code==0){ 
      echo "�s�u���\"."<br>\n";
       /*�p���ǰe�h��²�T�A�s�u���\��ϥΰj�����$mysms->send_long()�Y�i*/
      //send_long(����, ���A:[1=�ߧY, 2=�ߧY+���e�O��, 3=�w��, 4=�w��+���e�O��], �w���ɶ�, ���e�O��, ²�T���e)
      $ret_code = $mysms->send_long($mobile_number, 1 , "" , 0 ,$message, $message_encodeFrom);
      // $ret_code = $mysms->send_long($mobile_number, 2 , "" , 1440 ,$message);
      // $ret_code = $mysms->send_long($mobile_number, 3 , "200903081500" , 0 ,$message); //yyMMddHHmmss
      // $ret_code = $mysms->send_long($mobile_number, 4 , "200903081500" , 1440 ,$message);
      $ret_msg = $mysms->get_ret_msg();
      if($ret_code==0){
      	 echo "²�T�ǰe���\"."<br>";
         echo "ret_code=".$ret_code."<br>\n";
         echo "ret_msg=".$ret_msg."<br>\n";
      }else{
      	 echo "²�T�ǰe����"."<br>\n";
         echo "ret_code=".$ret_code."<br>\n";
         echo "ret_msg=".$ret_msg."<br>\n";
      }
} else {  
      echo "�s�u����"."<br>\n";
      echo "ret_code=".$ret_code."<br>\n";
      echo "ret_msg=".$ret_msg."<br>\n";
}

/*�����s�u*/
$mysms->close_conn();
?>

