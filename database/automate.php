<?php
	require_once('connection.php');

	if (session_status() == PHP_SESSION_NONE) {
    session_start();
	}

	$uid = $_SESSION['user'];
	$current_time = date("Y-m-d");

	$cur_month =date("m");
	$total_income = 0;
	$total_expense = 0;

	$sql="SELECT amount,finance_type_id FROM finances WHERE user_id='$uid' AND MONTH(transaction_date) = '$cur_month'";
	$result=mysqli_query($conn,$sql);
	while($row = mysqli_fetch_assoc($result)){
		if($row['finance_type_id'] == 1){
			$total_income += $row['amount'];
		}else{
			$total_expense += $row['amount'];
		}
	}
	$current_savings = $total_income - $total_expense;
	$sql = "UPDATE savings SET calculated_savings='$current_savings' WHERE user_id='$uid' AND month_of_transaction ='$cur_month'";
	$res = mysqli_query($conn,$sql);

	if(isset($_POST['set'])){
		$expected_savings = mysqli_real_escape_string($conn,$_POST['expected_savings']);
		$result = mysqli_query($conn, "SELECT *FROM savings");
		while($row=mysqli_fetch_assoc($result)){
			if($row['month_of_transaction'] == $cur_month && $row['user_id'] == $uid){
				$sql1 = "UPDATE savings SET expected_savings='$expected_savings' WHERE user_id='$uid' AND month_of_transaction ='$cur_month'";
				mysqli_query($conn,$sql1);
			}
			else{
				$sql1 = "INSERT INTO savings(user_id,month_of_transaction,expected_savings,calculated_savings)
					VALUES('$uid','$cur_month','$expected_savings','$current_savings')";
				mysqli_query($conn,$sql1);
			}
		}

		header('location:/overview.php');
	}

	$result = mysqli_query($conn, "SELECT * FROM finances WHERE user_id = $uid ORDER BY transaction_date DESC, amount DESC");
	if($result){
		while($row = mysqli_fetch_assoc($result)){
			$id = $row['id'];
			$time = $row['last_transaction_date'];
			$amount = $row['amount'];
			$freq = $row['frequency'];
			$f_id = $row['finance_type_id'];
			$c_id = $row['category_id'];
			$description =$row['description'];
			if($current_time > $time){
				if($freq == 2){
					$time = date ("Y-m-d", strtotime ($time ."+1 days"));
					while($current_time>$time){
						$sql = "INSERT INTO finances (user_id, finance_type_id, amount, transaction_date, category_id, frequency,description)
						 	VALUES ('$uid', '$f_id', '$amount', '$time', '$c_id', 5,'$description')";
						mysqli_query($conn,$sql);
						$time = date ("Y-m-d", strtotime ($time ."+1 days"));
					}
				}
				if($freq == 3){
					$time = date ("Y-m-d", strtotime ($time ."+7 days"));
					while($current_time>$time){
						$sql = "INSERT INTO finances (user_id, finance_type_id, amount, transaction_date, category_id, frequency,description)
						 	VALUES ('$uid', '$f_id', '$amount', '$time', '$c_id', 5,'$description')";
						mysqli_query($conn,$sql);
						$time = date ("Y-m-d", strtotime ($time ."+7 days"));
					}
				}
				if($freq == 4){
					$time = date ("Y-m-d", strtotime ($time ."+30 days"));
					while($current_time>$time){
						$sql = "INSERT INTO finances (user_id, finance_type_id, amount, transaction_date, category_id, frequency,description)
						 	VALUES ('$uid', '$f_id', '$amount', '$time', '$c_id', 5,'$description')";
						mysqli_query($conn,$sql);
						$time = date ("Y-m-d", strtotime ($time ."+30 days"));
					}
				}
				mysqli_query($conn,"UPDATE finances SET last_transaction_date='$time' WHERE id='$id'");

			}
		}
	}
	else{
		echo mysqli_error($conn);
	}

	$result=mysqli_query($conn,"SELECT *FROM savings WHERE month_of_transaction ='$cur_month' AND user_id = '$uid'");

	while($row = mysqli_fetch_assoc($result)){
		if(2*$row['expected_savings'] <= $row['calculated_savings']){
			$_SESSION['auto_message'] =
				  "You expected to save Rs. ".$row['expected_savings']. ".<br>You saved Rs." .$row['calculated_savings'].
				  ".<br>
				  You have saved more than double the amount you expected to save.
				  ";
		}
		else if($row['expected_savings'] < $row['calculated_savings']){
			$_SESSION['auto_message'] =
				  "You expected to save Rs. ".$row['expected_savings']. ".<br>You saved Rs." .$row['calculated_savings'].
				  ".<br>
				  Your expected and actual savings are close.
				  ";
		}
		else{
			$_SESSION['auto_message'] =
				  "You expected to save Rs. ".$row['expected_savings']. ".<br>You saved Rs." .$row['calculated_savings'].
				  ".<br>
					Keep track of your expenses. Your actual savings are less than your expected savings.
				  ";
		}
	}
?>