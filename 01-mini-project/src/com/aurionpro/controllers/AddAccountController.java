package com.aurionpro.controllers;

import java.io.IOException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.data.BankDBUtil;


@WebServlet("/AddAccountController")
public class AddAccountController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BankDBUtil bankDBUtil;
       

    public AddAccountController() {
        super();

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        bankDBUtil = new BankDBUtil();
        bankDBUtil.connectToDB();
        Random random = new Random();
        int randomNum = 100000 + random.nextInt(900000);
        
        
        String accountNumber = "ACC" + randomNum;
        double initialBalance = Double.parseDouble(request.getParameter("initialBalance"));

        bankDBUtil.addBankAccount(customerId, accountNumber, initialBalance);

        response.sendRedirect("Admin.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
