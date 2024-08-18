package com.aurionpro.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.aurionpro.data.BankDBUtil;
import com.aurionpro.entity.Customers;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    private BankDBUtil bankDBUtil;
    
    public LoginController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("user_type");

        bankDBUtil = new BankDBUtil();
        bankDBUtil.connectToDB();

        if (userType.equals("admin")) {
            if (bankDBUtil.validateAdmin(username, password)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("admin", "admin");
                response.sendRedirect("Admin.jsp");
                return;
            }
            response.sendRedirect("Index.jsp?error=InvalidAdminCredentials");
            return;
        }
        System.out.println(userType.equals("customer"));
        System.out.println(bankDBUtil.validateCustomers(username, password));
        if (userType.equals("customer")) {
            if (bankDBUtil.validateCustomers(username, password)) {
                int customerID = bankDBUtil.getCustomerID(username, password);
                List<Customers> customers = bankDBUtil.getCustomerDetails(customerID);

                HttpSession session = request.getSession();

                if (!customers.isEmpty()) {
                    Customers customer = customers.get(0);
                    session.setAttribute("customer", "customer");
                    session.setAttribute("customerID", customer.getCustomerID());
                    session.setAttribute("firstName", customer.getFirst_name());
                    session.setAttribute("lastName", customer.getLast_name());
                    session.setAttribute("createdAt", customer.getCreated_at());
                    
                    
                    List<String> accountNumbers = new ArrayList<>();
                    for (Customers cust : customers) {
                        accountNumbers.add(cust.getAccountNumber());
                    }
                    
                    session.setAttribute("accountNumbers", accountNumbers);

                    response.sendRedirect("Customer.jsp");
                    return;
                }
            }

            response.sendRedirect("Index.jsp?error=InvalidUserType");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
