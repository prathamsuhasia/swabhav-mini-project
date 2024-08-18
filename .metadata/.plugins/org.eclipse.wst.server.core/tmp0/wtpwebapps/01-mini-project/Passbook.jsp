<%@page import="com.aurionpro.entity.Transactions"%>
<%@ page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ include file="CustomerNavbar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Passbook</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
	display: flex;
	align-items: center;
	padding: 10px;
}

.card-profile img {
	width: 100px;
	height: 100px;
	object-fit: cover;
	margin-right: 20px;
}

.card-profile .card-body {
	flex: 1;
}
</style>

</head>
<body>
	<div class="container mt-5">
		<div class="card shadow-sm">
			<div class="card-header bg-dark text-white">
				<h2 class="mb-0">Your Passbook</h2>
			</div>
			<div class="card-body">
				<!-- Account Selection Form -->
				<form action="CustomerController" method="get">
					<div class="form-group mb-3">
						<label for="accountNumber">Select Account:</label> <select
							class="form-control" id="accountNumber" name="accountNumber">
							<%
								List<String> accountNumbers = (List<String>) session.getAttribute("accountNumbers");
								for (String accountNumber : accountNumbers) {
							%>
							<option value="<%=accountNumber%>"><%=accountNumber%></option>
							<%
								}
							%>
						</select>
					</div>
					<button type="submit" name="action" value="PrintPassbook"
						class="btn btn-primary mt-3">View Passbook</button>
				</form>


				<%
					List<Transactions> transactions = (List<Transactions>) request.getAttribute("transactions");
					if (transactions != null && !transactions.isEmpty()) {
				%>
				<table class="table table-bordered mt-4">
					<thead class="thead-dark">
						<tr>
							<th>Transaction ID</th>
							<th>Sender Account</th>
							<th>Receiver Account</th>
							<th>Transaction Type</th>
							<th>Amount</th>
							<th>Date</th>
							<th>Balance</th>
							
						</tr>
					</thead>
					<tbody>
						<%
							for (Transactions transaction : transactions) {
						%>
						<tr>
							<td><%=transaction.getTransactionID()%></td>
							<td><%=transaction.getSenderAccountNumber()%></td>
							<td><%=transaction.getRecieverAccountNumber()%></td>
							<td><%=transaction.getTransaction_type()%></td>
							<td><%=transaction.getAmount()%></td>
							<td><%=transaction.getDate()%></td>
							<td><%=transaction.getBalance()%></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<%
					} else {
				%>
				<p>No transactions found for the selected account.</p>
				<%
					}
				%>
			</div>
		</div>
	</div>

</body>
</html>
