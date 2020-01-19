<?php
	$uid = $_SESSION['user'];
	$sql = "SELECT * FROM users WHERE id = $uid";
	$result = mysqli_query($conn,$sql);
	$row = mysqli_fetch_assoc($result);
?>



<div class="card-body">
	<form class="form col-md-4" method="post" action="\database\edit_profile.php" enctype="multipart/form-data">
		<div class="form-group">
			<label for="email" class="control-label">Email</label>
			<input class="form-control" name="email" value = "<?=$row['email']?>" required>
		</div>
		<div class="form-group">
			<label for="name" class="control-label">Name</label>
			<input class="form-control" name="name" value = "<?=$row['name']?>" required>
		</div>
		<div class="form-group">
  			<img id="blah" src="<?=$row['image_path']?>" alt="your image" width="100" height="100" class="rounded-circle" />
  			<span class="btn btn-danger"> Upload </span>
		  	<label class="control-label" for="image"> Select your image</label>
			<input type="file" name="image" onchange="document.getElementById('blah').src = window.URL.createObjectURL(this.files[0])">

  		</div>
		<div class="form-group">
			<button type="submit" class="btn btn-success" name="submit">Update</button>
		</div>
	</form>
</div>