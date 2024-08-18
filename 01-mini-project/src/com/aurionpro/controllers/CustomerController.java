package com.aurionpro.controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.data.BankDBUtil;
import com.aurionpro.entity.Transactions;

@WebServlet("/CustomerController")
public class CustomerController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankDBUtil bankDBUtil;

	public CustomerController() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		bankDBUtil = new BankDBUtil();
		bankDBUtil.connectToDB();
		int customerId;
		
		switch (action) {
		case "Passbook":
			response.sendRedirect("Passbook.jsp");
			break;

		case "NewTransaction":
			response.sendRedirect("NewTransaction.jsp");
			break;

		case "Update Profile":
			response.sendRedirect("UpdateProfile.jsp");
			break;

		case "UpdateFirstName":
			String firstName = request.getParameter("firstName");
			customerId = (Integer) request.getSession().getAttribute("customerID");

			bankDBUtil.updateFirstName(customerId, firstName);
			response.sendRedirect("LogoutServlet");
			break;

		case "UpdateLastName":
			String lastName = request.getParameter("lastName");
			customerId = (int) request.getSession().getAttribute("customerID");

			bankDBUtil.updateLastName(customerId, lastName);
			response.sendRedirect("LogoutServlet");
			break;

		case "UpdatePassword":
			String oldPassword = request.getParameter("oldPassword");
			String newPassword = request.getParameter("newPassword");
			String confirmNewPassword = request.getParameter("confirmNewPassword");
			customerId = (int) request.getSession().getAttribute("customerID");

			boolean isOldPasswordCorrect = bankDBUtil.verifyPassword(customerId, oldPassword);
			if (isOldPasswordCorrect && newPassword.equals(confirmNewPassword)) {
				bankDBUtil.updatePassword(customerId, newPassword);
				response.sendRedirect("LogoutServlet");
				response.sendRedirect("UpdateProfile.jsp?message=Password updated successfully");
			} else {
				response.sendRedirect("UpdateProfile.jsp?error=Password update failed. Please try again.");
			}
			break;

		case "PrintPassbook":
			String accountNumber = request.getParameter("accountNumber");
			List<Transactions> transactions = bankDBUtil.printPassbook(accountNumber);
			request.setAttribute("transactions", transactions);
			request.getRequestDispatcher("Passbook.jsp").forward(request, response);
			break;

		case "CreateTransaction":
			
			String senderAccountNumber = request.getParameter("accountNumber");
			String transactionType = request.getParameter("transactionType");
			String receiverAccountNumber = request.getParameter("receiverAccountNumber");
			String amountStr = request.getParameter("amount");

			if ("credit".equalsIgnoreCase(transactionType) || "debit".equalsIgnoreCase(transactionType)) {
				receiverAccountNumber = "SELF";
			}
			else if  ("transfer".equalsIgnoreCase(transactionType)){
				transactionType ="debit";
			}

			double amount = Double.parseDouble(amountStr);
			System.out.println(transactionType);
			bankDBUtil.createTransaction(senderAccountNumber, receiverAccountNumber, amount, transactionType);
			response.sendRedirect("Customer.jsp");
			break;

		default:
			response.sendRedirect("Customer.jsp");
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
