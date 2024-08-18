<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bank MVC Application</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
    body {
        background: url('Bank.webp') no-repeat center center fixed;
        background-size: cover;
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .card {
        max-width: 400px;
        width: 100%;
        background: rgba(255, 255, 255, 0.9);
    }
</style>
</head>
<body>

<div class="card shadow">
    <div class="card-body">
        <h4 class="card-title text-center mb-4">Bank Login</h4>
        
        <!-- Error Message Display Placeholder -->
        <div id="error-message" class="alert alert-danger" role="alert" style="display: none;"></div>
        
        <form action="LoginController">
            <div class="form-group mb-3">
                <label for="username">Email:</label>
                <input type="email" class="form-control" id="username" name="username" required>
            </div>
            <div class="form-group mb-3">
                <label for="password">Password:</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="form-group mb-3">
                <label>Login as:</label><br>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="user_type" id="admin" value="admin" required>
                    <label class="form-check-label" for="admin">Admin</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="user_type" id="customer" value="customer" required>
                    <label class="form-check-label" for="customer">Customer</label>
                </div>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary w-100">Submit</button>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
    
        const urlParams = new URLSearchParams(window.location.search);
        const error = urlParams.get('error');

        const errorMessageDiv = document.getElementById('error-message');

        if (error === 'InvalidAdminCredentials') {
            errorMessageDiv.innerText = 'Invalid admin credentials. Please try again.';
            errorMessageDiv.style.display = 'block';
        } else if (error === 'InvalidCustomerCredentials') {
            errorMessageDiv.innerText = 'Invalid customer credentials. Please try again.';
            errorMessageDiv.style.display = 'block';
        }


        if (window.history.replaceState) {
            const newUrl = window.location.protocol + "//" + window.location.host + window.location.pathname;
            window.history.replaceState({}, document.title, newUrl);
        }
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
