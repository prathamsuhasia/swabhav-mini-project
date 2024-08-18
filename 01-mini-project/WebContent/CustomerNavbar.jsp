<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>

    <%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
	HttpSession sessions = request.getSession(false);
	if (session == null || !"customer".equals(session.getAttribute("customer"))) {

		response.sendRedirect("Index.jsp");
		return;
	}
%>
    <nav class="navbar navbar-expand-lg">
        <a class="navbar-brand" href="Customer.jsp" style="color: white;">Customer Dashboard</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <form action="CustomerController" method="get" class="nav-item">
                        <button type="submit" name="action" value="Passbook" class="btn btn-link">Passbook</button>
                    </form>
                </li>
                <li class="nav-item">
                    <form action="CustomerController" method="get" class="nav-item">
                        <button type="submit" name="action" value="NewTransaction" class="btn btn-link">New Transaction</button>
                    </form>
                </li>
                <li class="nav-item">
                    <form action="CustomerController" method="get" class="nav-item">
                        <button type="submit" name="action" value="Update Profile" class="btn btn-link">Update Profile</button>
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