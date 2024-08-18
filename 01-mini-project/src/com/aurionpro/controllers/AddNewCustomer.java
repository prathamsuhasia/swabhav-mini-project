package com.aurionpro.controllers;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.data.BankDBUtil;

@WebServlet("/AddNewCustomer")
public class AddNewCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BankDBUtil bankDBUtil;
    private RequestDispatcher dispatcher;
       
    public AddNewCustomer() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		bankDBUtil = new BankDBUtil(); 
		bankDBUtil.connectToDB();


		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		bankDBUtil.addCustomer(firstName, lastName, email, password);

		dispatcher = request.getRequestDispatcher("Admin.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}
}
