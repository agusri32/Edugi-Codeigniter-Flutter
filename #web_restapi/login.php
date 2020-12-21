<?php
include "conn.php";

$json = file_get_contents('php://input');
$obj  = json_decode($json,true);

$email = $obj['email'];
$password = $obj['password'];
$login_query = "select * from admin where admin_username = '$email' and admin_password = md5('$password')";

$check_auth = mysqli_fetch_array(mysqli_query($con,$login_query));
if(isset($check_auth))
{
	$message = json_encode('Berhasil Login');
	echo $message ; 
}else{
	$message = json_encode('Gagal Login!');
	echo $message ;
}

mysqli_close($con);
?>