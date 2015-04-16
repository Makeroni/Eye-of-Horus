<?php
	$x = (int)( $_GET["x"] * 1366 );
	$y = (int)( $_GET["y"] *  768 );
	var_dump(shell_exec('DISPLAY=:0 xdotool mousemove '.$x.' '.$y.' 2>&1'));
?>

