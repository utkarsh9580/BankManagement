<%@taglib uri="http://www.springframework.org/tags/form" prefix="sp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% request.getSession(false); %>   
<c:if test="${not empty sessionScope.user}">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
table, th, td {
    border: 01px solid black;
}
</style>
<title>Customer View</title>
</head>
<form action="home" method="post">
<p>
WELCOME,${sessionScope.user.getUserName()}
<input type="submit" value="HOME" style="float: right;">
</p>
</form>
<br/>
<br/>
<c:choose>
<c:when test="${!empty ulist}">
<center>
<table>
<tr>
<th>ID</th>
<th>CODE</th>
<th>NAME</th>
<th>EMAIL</th>
<th>CONTACT</th>
<th>ADDRESS1</th>
<th>ADDRESS2</th>
<th>PINCODE</th>
<th>CONTACT PERSON</th>
<th>RECORD STATUS</th>
<th>FLAG</th>
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
</tr>
</c:forEach>
</table>
<br/>
<br/>
<sp:form action="customerUpdate" modelAttribute="customer">
Enter Customer Code : <sp:input path="code" name="updatecustomer_code" id="updatecustomer_code" onkeyup="alphanumericValidator(updatecustomer_code)"/><sp:errors path="code"/><br/>
<br/>
<input type="submit" name="updatebutton" id="updatebutton" value="FIND"/>
</sp:form>
</center>
</c:when>
<c:otherwise>
No Record to View
</c:otherwise>
</c:choose>
</c:if> 
<c:if test="${empty sessionScope.user}">
<%
	request.setAttribute("msg","Please properlly Login");
	request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
%>
</c:if>