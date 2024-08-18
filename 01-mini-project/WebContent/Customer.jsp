<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ include file="CustomerNavbar.jsp" %>

<%
    int customerID = (Integer) session.getAttribute("customerID");
    String firstName = (String) session.getAttribute("firstName");
    String lastName = (String) session.getAttribute("lastName");
    String createdAt = (String) session.getAttribute("createdAt");
    
    List<String> accountNumbers = (List<String>) session.getAttribute("accountNumbers");
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card card-profile">
                    <img src="blank.png" class="card-img-top" alt="Profile Picture">
                    <div class="card-body">
                        <h5 class="card-title"><%= firstName %> <%= lastName %></h5>
                        <p class="card-text">Customer ID: <%= customerID %></p>
                        <p class="card-text">Customer Created At: <%= createdAt %></p>
                        <h6>Account Numbers:</h6>
                        <% if (accountNumbers == null || accountNumbers.isEmpty()) { %>
                            <p>Account not created yet. Contact admin to create an account.</p>
                        <% } else { %>
                            <ul>
                                <% for (String accountNumber : accountNumbers) { %>
                                    <li><%= accountNumber %></li>
                                <% } %>
                            </ul>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
