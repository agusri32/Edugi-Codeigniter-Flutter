<?php
include "conn.php";

if ($con->connect_error) {
	die("Connection failed: " . $con->connect_error);
}

$action = $_POST['action'];
if('GET_DATA' == $action)
{
	$dbdata = array();
	$sql = "SELECT user_id, user_nama, user_nik FROM user ORDER BY user_id DESC";
	$result = $con->query($sql);
	
	if($result->num_rows > 0){
		while($row = $result->fetch_assoc()){
			$dbdata[]=$row;
		}
		echo json_encode($dbdata);
	}else{
		echo "error";
	}
	$con->close();
	return;
}

if('ADD_DATA' == $action)
{
	$user_nama = $_POST['user_nama'];
	$user_nik  = $_POST['user_nik'];
	$user_username = $user_nik;
	$user_password = md5($user_nik);
	$user_tanggal  = date('Y-m-d');
	
	$sql = "INSERT INTO user (user_nama, user_nik, user_username, user_password, user_tanggal) VALUES('$user_nama', '$user_nik', '$user_username', '$user_password', '$user_tanggal')";
	$result = $con->query($sql);
	echo 'success';
	return;
}

if('UPDATE_DATA' == $action)
{
	$user_id   = $_POST['user_id'];
	$user_nama = $_POST['user_nama'];
	$user_nik  = $_POST['user_nik'];
	$sql = "UPDATE user SET user_nama = '$user_nama', user_nik = '$user_nik' WHERE user_id = $user_id";
	
	if($con->query($sql) === TRUE){
		echo "success";
	}else{
		echo "error";
	}
	$con->close();
	return;
}

if('DELETE_DATA' == $action)
{
	$user_id = $_POST['user_id'];
	$sql = "DELETE FROM user WHERE user_id = $user_id";
	
	if($con->query($sql) === TRUE){
		echo "success";
	}else{
		echo "error";
	}
	$con->close();
	return;
}
?>
