<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% request.getSession(false); %>
<%@ page import="java.io.*,java.util.*,com.model.User,com.model.Customer" %>
    
<%@ page import="javax.servlet.*,java.text.*" %>

<% request.getSession(false);%>

<% if(session!=null){ %>

<% User user = (User)session.getAttribute("user"); %>

<%if(user!=null){ 

	//List<Customer> ulist=(List<Customer>)request.getAttribute("ulist"); 
	
	// if(ulist!=null){
		
	//	Customer customer;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
 
 <style>
 table, th, td {
    border: 01px solid black;
}
</style>


<title>CUSTOMER LIST</title>
</head>
<body>
<form action="home" method="post">
<p>
WELCOME,<%=user.getUserName()%>
<input type="submit" value="HOME" style="float: right;">
</p>
</form>
<br/>
<br/>
<center style="color:blue;font-size:150%;">${sessionScope.msg}</center>
<br/><br/>
<form action="checkerApproval?status=${param.status}" method="post">
<center>
<input type="submit" name="buttonapproval" id="buttonapproval" value="APPROVE"/>
<input type="submit" name="buttonapproval" id="buttonapproval" value="REJECT"/>
<br/><br/>
</center>
<c:choose>
<c:when test="${!empty ulist}">
<center>

<table>
<tr bgcolor="grey">
<td style="font:color=black;">ID</td>
<td style="font:color=black;">CODE</td>
<td style="font:color=black;">NAME</td>
<td style="font:color=black;">EMAIL</td>
<td style="font:color=black;">CONTACT</td>
<td style="font:color=black;">ADDRESS1</td>
<td style="font:color=black;">ADDRESS2</td>
<td style="font:color=black;">PINCODE</td>
<td style="font:color=black;">CONTACT PERSON</td>
<td style="font:color=black;">STATUS</td>
<td style="font:color=black;">FLAG</td>
<td style="font:color=black;">STATUS</td>
</tr>

<c:forEach items="${ulist}" var="customer">
<tr>
<td>${customer.getId()}</td>
<td>${customer.getCode()}</td>
<td>${customer.getName()}</td>
<td>${customer.getEmail()}</td>
<td>${customer.getContact()}</td>
<td>${customer.getAddress1()}</td>
<td>${customer.getAddress2()}</td>
<td>${customer.getPincode()}</td>
<td>${customer.getPrimaryPerson()}</td>
<td>${customer.getRecordStatus()}</td>
<td>${customer.getFlag()}</td>
<c:if test="${customer.getRecordStatus()!='A'}">
<td>
<input type="checkbox" name="customerCheck" value="${customer.getCode()},${customer.getRecordStatus()},${customer.getId()}">
</td>
</c:if>
</tr>

</c:forEach>

</table>

<br/><br/>



</center>
</c:when>
<c:otherwise>
No Record to View
</c:otherwise>
</c:choose>
</form>
</body>


<!-- <script type="text/javascript">



$(document).ready(function(){

	
	$("#buttonapproval").click(function(){
		
	
		if($.trim($('#customer_recordstatus').val())==''){
			alert('Please select status');
			return false;
		}
	
	});
	
});

	</script> -->
	
</html>








<% 

	} 
else{
	request.setAttribute("msg","Please properlly Login");
	request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
}%>

<% } 
else{
	request.setAttribute("msg","Please properlly Login");
	request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
}%>