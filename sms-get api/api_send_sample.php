<?PHP


//This is a sample for prompt delivery
$username = "username";	//SMS-GET.COM account
$password = "password";	//SMS-GET.COM password
$method = "1";	//prompt or scheduled
$sms_msg = "This is a prompt delivery test SMS.";	//SMS content
$phone = "0911123123,0922123123,0933123123";	//cellphone number (250 max)
$urlencode_sms = urlencode($sms_msg);	//SMS content urlencode

$url="http://sms-get.com/api_send.php?";
$url.="username=".$username;
$url.="&password=".$password;
$url.="&method=".$method;
$url.="&sms_msg=".$urlencode_sms;
$url.="&phone=".$phone;

$result = file_get_contents($url);
echo $result;
exit;







//This is a sample for scheduled delivery
$username = "username";	//SMS-GET.COM account
$password = "password";	//SMS-GET.COM password
$method = "2";	//prompt or scheduled
$sms_msg = "This is a scheduled delivery test SMS.";	//SMS content
$phone = "0911123123,0922123123,0933123123";	//cellphone number (250 max)
$send_date = "2020/01/31";	//scheduled date(GMT+8)
$hour = "10";	//scheduled hour(GMT+8)
$min = "00";	//scheduled min(GMT+8)
$urlencode_sms = urlencode($sms_msg);	//SMS content urlencode

$url="http://sms-get.com/api_send.php?";
$url.="username=".$username;
$url.="&password=".$password;
$url.="&method=".$method;
$url.="&sms_msg=".$urlencode_sms;
$url.="&phone=".$phone;
$url.="&send_date=".$send_date;
$url.="&hour=".$hour;
$url.="&min=".$min;

$result = file_get_contents($url);
echo $result;
exit;

?>