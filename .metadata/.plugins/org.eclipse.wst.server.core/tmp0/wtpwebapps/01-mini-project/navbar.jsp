<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<% 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%
    HttpSession sessions = request.getSession(false);
    if (session == null || session.getAttribute("username") == null || !"admin".equals(session.getAttribute("admin"))) {
        // No session or user not logged in, redirect to the login page
        response.sendRedirect("Index.jsp");
        return;
    }
%>
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
    .navbar .btn-link {
        color: white;
        text-decoration: none;
    }

    .navbar .btn-link:hover {
        color: #ffc107; /* Change to your desired hover color */
    }
</style>
<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="Admin.jsp" style="color: white;">Admin Dashboard</a>
    <div class="collapse navbar-collapse justify-content-end">
        <ul class="navbar-nav">
            <li class="nav-item">
                <form action="AdminController" method="post" class="nav-item">
                    <button type="submit" name="action" value="AddCustomers" class="btn btn-link">Add Customers</button>
                </form>
            </li>
            <li class="nav-item">
                <form action="AdminController" method="post" class="nav-item">
                    <button type="submit" name="action" value="AddAccount" class="btn btn-link">Add Account</button>
                </form>
            </li>
            <li class="nav-item">
                <form action="AdminController" method="post" class="nav-item">
                    <button type="submit" name="action" value="ViewCustomers" class="btn btn-link">View Customers</button>
                </form>
            </li>
            <li class="nav-item">
                <form action="AdminController" method="post" class="nav-item">
                    <button type="submit" name="action" value="ViewTransactions" class="btn btn-link">View Transactions</button>
                </form>
            </li>
            <li class="nav-item">
                <form action="LogoutServlet">
                    <button type="submit" class="btn btn-danger" style="margin-right:12px;">Logout</button>
                </form>
            </li>
        </ul>
    </div>
</nav>
