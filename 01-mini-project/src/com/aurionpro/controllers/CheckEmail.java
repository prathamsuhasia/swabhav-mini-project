package com.aurionpro.controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.aurionpro.data.BankDBUtil;

@WebServlet("/CheckEmailServlet")
public class CheckEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private BankDBUtil bankDBUtil;
       
    public CheckEmail() {
        super();
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		bankDBUtil = new BankDBUtil(); 
		bankDBUtil.connectToDB();

		String email = request.getParameter("email");


		boolean emailExists = bankDBUtil.isEmailPresent(email);
		System.out.println(emailExists);

		if (emailExists) {
			response.getWriter().write("false");  
		} else {
			response.getWriter().write("true");   
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
