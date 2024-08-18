<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="CustomerNavbar.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Profile</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<style>
body {
	background-image: url('Bank.webp');
	background-size: cover;
	background-position: center;
	color: #fff;
	font-family: Arial, sans-serif;
	position: relative;
	z-index: 1;
}

.navbar {
	background-color: rgba(0, 0, 0, 0.5);
	margin-bottom: 20px;
}

.navbar-brand {
	color: #f8f9fa;
}

.navbar-nav .nav-link {
	color: #f8f9fa !important;
}

.navbar-nav .nav-link:hover {
	color: #e9ecef !important;
}

.btn-logout {
	background-color: #dc3545;
	border: none;
	color: #fff;
	margin-right: 10px;
}

.btn-logout:hover {
	background-color: #c82333;
	color: #fff;
}

.welcome-message {
	display: flex;
	align-items: center;
	color: white;
	height: 70vh;
	justify-content: flex-start;
	padding-left: 20px;
	font-size: 45px;
}

.navbar .btn-link {
	color: white;
	text-decoration: none;
}

.navbar .btn-link:hover {
	color: #ffc107;
}

.card-profile {
	background-color: rgba(255, 255, 255, 0.93);
	color: #000;
	
	margin-bottom: 20px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
}

.card-profile .card-header {
	background-color: #343a40;
	color: #fff;
	padding: 10px 20px;
	font-size: 1.25rem;
}

.card-profile .card-body {
	padding: 20px;
}

.card-profile .form-group {
	margin-bottom: 1rem;
}

.card-profile .btn {
	width: 15%;
}

</style>
</head>
<body>
	<div class="container mt-5">
		<div class="card card-profile shadow-sm">
			<div class="card-header">
				<h2 class="mb-0">Update Profile</h2>
			</div>
			<div class="card-body">

			
				<form action="CustomerController" method="post">
					<div class="form-group">
						<label for="firstName">First Name:</label> 
						<input type="text" class="form-control" pattern="[A-Za-z]+" id="firstName" name="firstName"
							value="${sessionScope.firstName}" required>
					</div>
					<button type="submit" name="action" value="UpdateFirstName"
						class="btn btn-primary">Update First Name</button>
				</form>

				<hr />

				<form action="CustomerController" method="post">
					<div class="form-group">
						<label for="lastName">Last Name:</label> 
						<input type="text" class="form-control" id="lastName" pattern="[A-Za-z]+" name="lastName"
							value="${sessionScope.lastName}" required>
					</div>
					<button type="submit" name="action" value="UpdateLastName"
						class="btn btn-primary">Update Last Name</button>
				</form>

				<hr />

				<form action="CustomerController" method="post">
					<div class="form-group">
						<label for="oldPassword">Old Password:</label> 
						<input type="password" class="form-control" id="oldPassword"
							name="oldPassword" required>
					</div>
					<div class="form-group">
						<label for="newPassword">New Password:</label> 
						<input type="password" class="form-control" id="newPassword"
							name="newPassword" required>
					</div>
					<div class="form-group">
						<label for="confirmNewPassword">Confirm New Password:</label> 
						<input type="password" class="form-control" id="confirmNewPassword"
							name="confirmNewPassword" required>
					</div>
					<button type="submit" name="action" value="UpdatePassword"
						class="btn btn-primary">Update Password</button>
				</form>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
