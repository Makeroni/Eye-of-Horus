<?php
	header('Content-Type: image/png');
	echo file_get_contents('http://192.168.61.1:8080/?action=snapshot');
?>
