package com.aurionpro.controllers;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.data.BankDBUtil;
import com.aurionpro.entity.Customers;
import com.aurionpro.entity.Transactions;

@WebServlet("/AdminController")
public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private BankDBUtil bankDBUtil;
	private RequestDispatcher dispatcher;

	public AdminController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		bankDBUtil = new BankDBUtil();
		bankDBUtil.connectToDB();

		String action = request.getParameter("action");

		switch (action) {
		case "AddCustomers":
			System.out.println(action);
			response.sendRedirect("AddNewCustomer.jsp");
			break;
		case "AddAccount":
			System.out.println(action);
			List<Customers> accountList = bankDBUtil.createAccount();
			request.setAttribute("accountList", accountList);
			dispatcher = request.getRequestDispatcher("AddCustomers.jsp");
			dispatcher.forward(request, response);
			break;
		case "ViewCustomers":
			System.out.println(action);
			List<Customers> customersList = bankDBUtil.viewCustomer();
			request.setAttribute("customerList", customersList);
			dispatcher = request.getRequestDispatcher("ViewCustomers.jsp");
			dispatcher.forward(request, response);
			break;
		case "ViewTransactions":
			System.out.println(action);
			List<Transactions> transactions = bankDBUtil.viewTransactions();
			request.setAttribute("transactionList", transactions);
			dispatcher = request.getRequestDispatcher("ViewTransactions.jsp");
			dispatcher.forward(request, response);
			break;

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);

	}
}
