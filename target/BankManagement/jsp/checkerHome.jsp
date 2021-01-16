<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% request.getSession(false); %>
<%@ page import="java.io.*,java.util.*,com.model.User" %>
    
<%@ page import="javax.servlet.*,java.text.*" %>

<% request.getSession(false);%>

<% if(session!=null){ %>

<% User user = (User)session.getAttribute("user"); %>

<%if(user!=null){ %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CHECKER Home</title>
</head>
<body>
<form action="logout" method="post">
<p>
WELCOME,<%=user.getUserName() %>
<input type="submit" name="logout" value="LOGOUT" style="float: right;">
</p>
</form>
<%
if(request.getParameter("logout")!=null)
{
response.setHeader("Cache-Control","no-cache");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
session.setAttribute("user",null);
}
%> 
<br/>
<br/>
<center>
<p style="color:blue">VIEW</p>
<table BORDER=0 CELLPADDING=10 CELLSPACING=10 WIDTH=100% >

<tr bgcolor="grey">

<td id="newcustomer"><a href="customerOnStatus?status=N">NEW CUSTOMER</a></td>

<td id="modifiedcustomer"><a href="customerOnStatus?status=M">MODIFIED CUSTOMER</a></td>

<td id="deletedcustomer"><a href="customerOnStatus?status=D">DELETED CUSTOMER</a></td>

<td id="approvedcustomer"><a href="customerOnStatus?status=A">APPROVED CUSTOMER</a></td>

<td id="rejectedcustomer"><a href="customerOnStatus?status=R">REJECTED CUSTOMER</a></td>

 <td id="allcustomer"><a href="customerOnStatus?status=ALL">All CUSTOMER</a></td>  

</tr>

</table>

</center>
</body>
</html>



<% } 
else{
	request.setAttribute("msg","Please properlly Login");
	request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
}%>

<% } 
else{
	request.setAttribute("msg","Please properlly Login");
	request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
}%>