<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ include file="CustomerNavbar.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Create New Transaction</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script>
        function toggleReceiverAccount() {
            var transactionType = document.getElementById('transactionType').value;
            var receiverAccountDiv = document.getElementById('receiverAccountDiv');
            receiverAccountDiv.style.display = (transactionType === 'transfer') ? 'block' : 'none';
        }
    </script>
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
                <h2 class="mb-0">New Transaction</h2>
            </div>
            <div class="card-body">
                <form action="CustomerController" method="post">
                    <div class="form-group">
                        <label for="accountNumber">Select Account:</label>
                        <select class="form-control" id="accountNumber" name="accountNumber">
                            <% 
                                // Assume accountNumbers is a list of available account numbers stored in the session
                                List<String> accountNumbers = (List<String>) session.getAttribute("accountNumbers");
                                for (String accountNumber : accountNumbers) {
                            %>
                                <option value="<%= accountNumber %>"><%= accountNumber %></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="transactionType">Transaction Type:</label>
                        <select class="form-control" id="transactionType" name="transactionType" onchange="toggleReceiverAccount()">
                            <option value="credit">Credit</option>
                            <option value="debit">Debit</option>
                            <option value="transfer">Transfer</option>
                        </select>
                    </div>

                    <div class="form-group" id="receiverAccountDiv" style="display:none;">
                        <label for="receiverAccountNumber">Receiver Account Number:</label>
                        <input type="text" class="form-control" id="receiverAccountNumber" name="receiverAccountNumber">
                    </div>

                    <div class="form-group">
                        <label for="amount">Amount:</label>
                        <input type="number" class="form-control" id="amount" name="amount" min="1" step="0.01" required>
                    </div>

                    <button type="submit" name="action" value="CreateTransaction" class="btn btn-primary mt-3">Submit Transaction</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
