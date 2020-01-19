<?php 
	include 'connection.php';
	session_start();
	if(isset($_POST['confirm'])){
		$password1 = mysqli_real_escape_string($conn,$_POST['password1']);
		$password2 = mysqli_real_escape_string($conn,$_POST['password2']);
		$email = $_GET['email'];
		if(($password1 == $password2) && (strlen($password1) >= 8)){
			$password = md5($password2);
			$sql = "UPDATE users SET password = '$password' WHERE email='$email'";
			$result = mysqli_query($conn,$sql);
			$_SESSION['message'] = "Reset successful. You can now Log In.";
			header('location:/login.php');
		}else{
			$_SESSION['error'] = "The password is not long enough or they dont match";
	        header("location:/resetpassword.php?email=$email&hash=$hash");
		}
	}
		
?>