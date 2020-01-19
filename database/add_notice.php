<?php
	require_once('connection.php');
	session_start();
	
	$title = $body = '';
	if(isset($_POST['submit'])){
		$title = $_POST['title'];
		$body = $_POST['body'];

		// $query = "SELECT * FROM users";
		// $result = mysqli_query($conn, $query);
		
		$sql = "INSERT INTO notices (title,body) VALUES ('$title','$body')";
	    $result = mysqli_query($conn,$sql);
	    
	    $_SESSION['info'] = "Notice Added";

		header('location:/dashboard_admin.php/?type=notices');
	}
?>