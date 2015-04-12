<?php

$a_allowed_pages = array('home','eye_mouse','eye_mouse_offline','test_streaming');
$page = 'eye_mouse_offline';

if(in_array($_GET['page'],$a_allowed_pages)){
    $page = $_GET['page'];
}

?>
<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <style>
        body {
            padding-top: 50px;
            padding-bottom: 20px;
        }
    </style>
    <link rel="stylesheet" href="css/bootstrap-theme.min.css">
    <link href="css/bootstrap-switch.css" rel="stylesheet">
    <link rel="stylesheet" href="css/main.css">
    <script src="js/vendor/modernizr-2.8.3-respond-1.4.2.min.js"></script>

</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <img src="img/logo.png" class="logo pull-left"> <a class="logo_title navbar-brand" href="#">Eye of Horus</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
        </div>
        <!--/.navbar-collapse -->
    </div>
</nav>
<div id="main_container" class="container">
    <?php
    include("page-".$page.".php");
    ?>
</div>
<div class="container">
    <hr>
    <footer class="text-center">
        <p>Developed by <a href="http://www.makeronilabs.com" target="_blank">MAKERONI LABS</a> during <a href="http://2015.spaceappschallenge.org" target="_blank">NASA Space Apps challenge 2015</a></p>
    </footer>
</div>
<!-- /container -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="js/vendor/jquery-1.11.2.min.js"><\/script>')</script>
<script src="js/vendor/bootstrap.min.js"></script>
<script src="js/vendor/bootstrap-switch.min.js"></script>

<script src="js/main.js"></script>


<?php
    if($page == 'eye_mouse' || $page == 'eye_mouse_offline'){
        echo "<script src=\"js/eye-tracking.js\"></script>";
    }
?>

</body>
</html>
