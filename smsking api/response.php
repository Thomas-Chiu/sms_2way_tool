<?php
$res="kmsgid=".$_REQUEST["kmsgid"]."\tdstaddr=".$_REQUEST["dstaddr"]."\tdlvtime=".$_REQUEST["dlvtime"]."\tdonetime=".$_REQUEST["donetime"]."\tstatusstr=".$_REQUEST["statusstr"]."\r\n";
$fp = fopen("retccmoapi.txt","a+");
fwrite( $fp, $res);
fclose($fp);
?> 
