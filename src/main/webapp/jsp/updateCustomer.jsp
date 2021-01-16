<%@taglib uri="http://www.springframework.org/tags/form" prefix="sp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.io.*,java.util.*,com.model.User,com.model.Customer" %>

<%@ page import="javax.servlet.*,java.text.*" %>

<% User user = (User)session.getAttribute("user");%>

<%if(user!=null){ 
	Customer customer = (Customer)request.getAttribute("customer");  %>

<%if(customer!=null){ %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
 


<title>Update Customer</title>
<script type="text/javascript">

 function showhide(id) {
    var e = document.getElementById(id);
    e.style.display = (e.style.display == 'block') ? 'none' : 'block';
 }
 
 function hideshow(id) {
	    var e = document.getElementById(id);
	    e.style.display = (e.style.display == 'none') ? 'block' : 'none';
	 }
 
 function EmptyValidator(element){
		if(element.value.trim()== ""){
			alert('this text box is empty');
			element.focus();
			return false;
		}	
		else{
			return true;
		}
		}

 function emailValidator(element){
		var emailvalid = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		if(element.value.match(emailvalid))
		{
	
		}else{
			alert('not valid email');
			element.focus();
			return false;
		}
	}


 function alphabateValidator(element){
		var regexp = /^[a-zA-Z ]+$/;
		if(element.value.match(regexp))
		{

		}else{
			element.value = element.value.substring(0,element.value.length-1);
			alert('only alphabate accepted');
			element.focus();
		}
	}


 function numberValidator(element){
		var regexp = /^[0-9]+$/;
		if(element.value.match(regexp))
		{

		}else{
			element.value = element.value.substring(0,element.value.length-1);
			alert('only number accepted');
			element.focus();
		}
	}
 
 
 function alphanumericValidator(element){
		var regexp = /^[a-zA-Z0-9 ]+$/;
		if(element.value.match(regexp))
		{

		}else{
			element.value = element.value.substring(0,element.value.length-1);
			alert('only alphabate and numeric accepted');
			element.focus();
		}
	}
 
 
 function flagValidator(element){
		var regexp = /^[AI]+$/;
		if(element.value.match(regexp))
		{

		}else{
			element.value = element.value.substring(0,element.value.length-1);
			alert('only A OR I accepted');
			element.focus();
		}
	}
 
 
 
 
 

</script>




</head>
<body>
<form action="home" method="post">
<p>
WELCOME,${sessionScope.user.getUserName()}
<input type="submit" value="HOME" style="float: right;">
</p>
</form>
<br/>
<br/> 
<center>




<%
   Date dNow = new Date( );
   SimpleDateFormat ft = 
   new SimpleDateFormat ("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
   out.print( "<h2 align=\"center\">" + ft.format(dNow) + "</h2>");

%>
<%-- <textarea id="whatever" name="whatever"><jsp:text /></textarea> --%>

<sp:form action="updateCustomer" modelAttribute="customer">
Customer Code : <sp:input path="code" name="code" id="code" onkeyup="alphanumericValidator(code)" readonly="true"/><sp:errors path="code"/><br/>
Customer Name : <sp:input path="name" name="customer_name" id="customer_name" onkeyup="alphanumericValidator(customer_name)"/><sp:errors path="name"/><br/>
Customer Address 1 : <sp:textarea path="address1" name="customer_address1" id="customer_address1"/><sp:errors path="address1"/><br/>
Customer Address 2 : <sp:textarea path="address2" name="customer_address2" id="customer_address2" /><sp:errors path="address2"/><br/>
Customer Pin Code : <sp:input path="pincode" name="customer_pincode" id="customer_pincode" onkeyup="numberValidator(customer_pincode)"/><sp:errors path="pincode"/><br/>
E-mail address : <sp:input path="email" name="customer_email" id="customer_email" /><sp:errors path="email"/><br/>
Contact Number : <sp:input path="contact" name="customer_contact" id="customer_contact" onkeyup="numberValidator(customer_contact)"/><sp:errors path="contact"/><br/>
Primary Contact Person : <sp:input path="primaryPerson" name="customer_pcperson" id="customer_pcperson" onkeyup="alphabateValidator(customer_pcperson)"/><sp:errors path="primaryPerson"/><br/>
Record Status : <sp:input path="recordStatus" name="status" id="status" readonly="true"/><br/>
Active/Inactive Flag : <sp:input path="flag" name="customer_flag" id="customer_flag" onkeyup="flagValidator(customer_flag)"/><sp:errors path="flag"/><br/>
<input type="hidden" name="customer_recordstatus" id="customer_recordstatus" value="N"/>
<sp:input type = "hidden" path="id" name="customer_id" id="customer_id" /><sp:errors path="id"/><br/>
<br/>
<input type="submit" name="updatebutton" id="updatebutton" value="UPDATE"/>
</sp:form>


</center>
</body>





<script type="text/javascript">



$(document).ready(function(){
	
	
	
	// Update Customer Entry
	
	
	
	$("#updatebutton").click(function(){
	
		var email=$('#customer_email').val();
		
		if($.trim($('#code').val())==''){
			alert('Customer Code Cannot be empty');
			return false;
		}
		else if($.trim($('#customer_name').val())==''){
			alert('Customer Name Cannot be empty');
			return false;
		}
		else if($.trim($('#customer_address1').val())==''){
			alert('Customer Address Cannot be empty');
			return false;
		}		else if($.trim($('#customer_pincode').val())=='' || $('#customer_pincode').val().length < '6' || $('#customer_pincode').val().length >'6'){
			alert('Customer Pincode Cannot be empty or less than or greater than 6');
			return false;
		}
		else if($.trim($('#customer_email').val())==''){
			alert('Customer EMail Cannot be empty');
			return false;
		}
		else if($.trim($('#customer_contact').val())==''){
			alert('Customer Contact Cannot be empty');
			return false;
		}
		else if($.trim($('#customer_pcperson').val())==''){
			alert('Customer Primary Contact Person Cannot be empty');
			return false;
		}
		else if($.trim($('#customer_flag').val())==''){
			alert('Customer Flag Cannot be empty');
			return false;
		}
		else {
		
		
			if (validateEmail(email)) {
				return true;
	 	}
		else{
			alert('not valid mail address');
			return false;
		}
			
		
		}
		
		
	});

});



//Function that validates email address through a regular expression.
function validateEmail(email) {
var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
if (filter.test(email)) {
return true;
}
else {
return false;
}
}


</script>

</html>

<% } 
else{
	request.setAttribute("msg","First set the Data for Update");
	request.getRequestDispatcher("/Error").forward(request, response);
}%>

<% } 
else{
	request.setAttribute("msg","Please properlly Login");
	request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
}%>