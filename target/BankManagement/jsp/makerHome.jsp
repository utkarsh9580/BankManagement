<%@taglib uri="http://www.springframework.org/tags/form" prefix="sp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.io.*,java.util.*,com.model.User"%>

<%@ page import="javax.servlet.*,java.text.*"%>

<%
	request.getSession(false);

	if (session != null) {

		User user = (User) session.getAttribute("user");

		if (user != null) {
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">


<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>



<title>Maker Home</title>

<script type="text/javascript">
	function showhide(id) {
		var e = document.getElementById(id);
		e.style.display = (e.style.display == 'block') ? 'none' : 'block';
	}

	function hideshow(id) {
		var e = document.getElementById(id);
		e.style.display = (e.style.display == 'none') ? 'block' : 'none';
	}

	function EmptyValidator(element) {
		if (element.value.trim() == "") {
			alert('this text box is empty');
			element.focus();
			return false;
		} else {
			return true;
		}
	}

	function emailValidator(element) {
		var emailvalid = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
		if (element.value.match(emailvalid)) {

		} else {
			alert('not valid email');
			element.focus();
			return false;
		}
	}

	function alphabateValidator(element) {
		var regexp = /^[a-zA-Z ]+$/;
		if (element.value.match(regexp)) {

		} else {
			element.value = element.value
					.substring(0, element.value.length - 1);
			alert('only alphabate accepted');
			element.focus();
		}
	}

	function numberValidator(element) {
		var regexp = /^[0-9]+$/;
		if (element.value.match(regexp)) {

		} else {
			element.value = element.value
					.substring(0, element.value.length - 1);
			alert('only number accepted');
			element.focus();
		}
	}

	function alphanumericValidator(element) {
		var regexp = /^[a-zA-Z0-9 ]+$/;
		if (element.value.match(regexp)) {

		} else {
			element.value = element.value
					.substring(0, element.value.length - 1);
			alert('only alphabate and numeric accepted');
			element.focus();
		}
	}
</script>



</head>
<body>
	<sp:form action="logout" modelAttribute="user">
		<p>
			WELCOME,<%=user.getUserName()%>
			<input type="submit" value="LOGOUT" style="float: right;">
		</p>
	</sp:form>
	<%
		if (request.getParameter("logout") != null) {
					response.setHeader("Cache-Control", "no-cache");
					response.setHeader("Pragma", "no-cache");
					response.setDateHeader("Expires", 0);
					session.setAttribute("user", null);
				}
	%>
	<br />
	<br />
	<center>
		<h2 style="background-color: lightBlue">${msg}</h2>
	</center>
	<br />
	<center>
		<table BORDER=0 CELLPADDING=10 CELLSPACING=10 WIDTH=100%>

			<tr bgcolor="grey">

				<td id="newcustomer" onclick="showhide('div_newcustomer');"><a
					href="#"> NEW CUSTOMER </a></td>

				<td id="view" onclick="showhide('div_view');"><a href="#">VIEW
						CUSTOMER</a></td>

				<td id="update" onclick="showhide('div_update');"><a href="#">UPDATE
						CUSTOMER</a></td>

				<td id="delete" onclick="showhide('div_delete');"><a href="#">DELETE
						CUSTOMER</a></td>

			</tr>
		</table>






		<div id="div_newcustomer" style="display: none; margin-top: 100px;">

			<%
				Date dNow = new Date();
						SimpleDateFormat ft = new SimpleDateFormat("E yyyy.MM.dd 'at' hh:mm:ss a zzz");
						out.print("<h2 align=\"center\">" + ft.format(dNow) + "</h2>");
			%>

			<sp:form action="saveCustomer" modelAttribute="customer">

Customer Code : <sp:input path="code" name="code" id="code"
					onkeyup="alphanumericValidator(code)" />
				<sp:errors path="code" />
				<br />
Customer Name : <sp:input path="name" name="customer_name"
					id="customer_name" onkeyup="alphanumericValidator(customer_name)" />
				<sp:errors path="name" />
				<br />
Customer Address 1 : <sp:textarea path="address1"
					name="customer_address1" id="customer_address1" />
				<sp:errors path="address1" />
				<br />
Customer Address 2 : <sp:textarea path="address2"
					name="customer_address2" id="customer_address2" />
				<sp:errors path="address2" />
				<br />
Customer Pin Code : <sp:input path="pincode" name="customer_pincode"
					id="customer_pincode" onkeyup="numberValidator(customer_pincode)" />
				<sp:errors path="pincode" />
				<br />
E-mail address : <sp:input path="email" name="customer_email"
					id="customer_email" />
				<sp:errors path="email" />
				<br />
Contact Number : <sp:input path="contact" name="customer_contact"
					id="customer_contact" onkeyup="numberValidator(customer_contact)" />
				<sp:errors path="contact" />
				<br />
Primary Contact Person : <sp:input path="primaryPerson"
					name="customer_pcperson" id="customer_pcperson"
					onkeyup="alphabateValidator(customer_pcperson)" />
				<sp:errors path="primaryPerson" />
				<br />
Active/Inactive Flag : <sp:select path="flag" name="customer_flag"
					id="customer_flag">
					<sp:option value="">!...select Flag</sp:option>
					<sp:option value="A">A - Active</sp:option>
					<sp:option value="I">I - InActive</sp:option>
				</sp:select>
				<sp:errors path="flag" />
				<sp:hidden path="recordStatus" name="customer_recordstatus"
					id="customer_recordstatus" value="N" />
				<br />
				<input type="submit" name="savebutton" id="savebutton" value="SAVE" />
			</sp:form>
		</div>




		<div id="div_view" style="display: none; margin-top: 100px;">
			<table BORDER=0 CELLPADDING=0 CELLSPACING=10 WIDTH=100%>
				<tr>
					<td>View Individual Record : - <br /> <br /> <sp:form
							action="viewCustomer" modelAttribute="customer">
Enter Customer Code : <sp:input path="code" name="viewcustomer_code"
								id="viewcustomer_code"
								onkeyup="alphanumericValidator(viewcustomer_code)" />
							<sp:errors path="code" />
							<br />
							<br />
							<input type="submit" name="viewbutton" id="viewbutton"
								value="VIEW" />
						</sp:form>
					</td>
					<td>View All Record : - <br /> <br /> <sp:form
							action="viewAllCustomer" modelAttribute="customer">
							<input type="submit" value="VIEW ALL" />
						</sp:form>
					</td>
				</tr>
			</table>
		</div>





		<div id="div_update" style="display: none; margin-top: 100px;">
			<p>ON CODE</p>
			<sp:form action="customerUpdate" modelAttribute="customer">

Enter Customer Code : <sp:input path="code" name="updatecustomer_code"
					id="updatecustomer_code"
					onkeyup="alphanumericValidator(updatecustomer_code)" />
				<sp:errors path="code" />
				<br />
				<br />
				<input type="submit" name="updatebutton" id="updatebutton"
					value="FIND" />
			</sp:form>
			<p>ON NAME</p>
			<form action="findCustomerNameUpdate" method="pAost">
				Enter Customer Name : <input type="text" name="customer_name"
					id="updatecustomer_name" onkeyup="alphanumericValidator(this)" /><br />
				<br /> <input type="submit" name="nameupdatebutton"
					id="nameupdatebutton" value="FIND" />
			</form>
		</div>





		<div id="div_delete" style="display: none; margin-top: 100px;">

			<sp:form action="deleteCustomer" modelAttribute="customer">
Enter Customer Code : <sp:input path="code" name="deletecustomer_code"
					id="deletecustomer_code"
					onkeyup="alphanumericValidator(deletecustomer_code)" />
				<sp:errors path="code" />
				<sp:input path="id" type="hidden" name="deletecustomer_id"
					id="deletecustomer_id" />
				<br />
				<br />
				<input type="submit" name="deletebutton" id="deletebutton"
					value="DELETE" />
			</sp:form>
		</div>

	</center>
</body>






<script type="text/javascript">
	$(document)
			.ready(
					function() {

						// New Customer Entry

						$("#savebutton")
								.click(
										function() {

											var email = $('#customer_email')
													.val();

											if ($.trim($('#code').val()) == '') {
												alert('Customer Code Cannot be empty');
												return false;
											} else if ($.trim($(
													'#customer_name').val()) == '') {
												alert('Customer Name Cannot be empty');
												return false;
											} else if ($
													.trim($(
															'#customer_address1')
															.val()) == '') {
												alert('Customer Address Cannot be empty');
												return false;
											} else if ($.trim($(
													'#customer_pincode').val()) == ''
													|| $('#customer_pincode')
															.val().length < '6'
													|| $('#customer_pincode')
															.val().length > '6') {
												alert('Customer Pincode Cannot be empty or less than or greater than 6');
												return false;
											} else if ($.trim($(
													'#customer_email').val()) == '') {
												alert('Customer EMail Cannot be empty');
												return false;
											} else if ($.trim($(
													'#customer_contact').val()) == '') {
												alert('Customer Contact Cannot be empty');
												return false;
											} else if ($
													.trim($(
															'#customer_pcperson')
															.val()) == '') {
												alert('Customer Primary Contact Person Cannot be empty');
												return false;
											} else if ($.trim($(
													'#customer_flag').val()) == '') {
												alert('Customer Flag Cannot be empty');
												return false;
											} else {

												//var frmData = $("#savefrm").serialize();

												//$.post("saveCustomer",frmData,function(data){

												// });

												if (validateEmail(email)) {
													return true;
												} else {
													alert('not valid mail address');
													return false;
												}

											}

										});

						// View of Customer

						$("#viewbutton")
								.click(
										function() {

											if ($.trim($('#viewcustomer_code')
													.val()) == '') {
												alert('Customer Code Cannot be empty for view');
												return false;
											} else {
											}

										});

						//DELETE CUSTOMER

						$("#deletebutton")
								.click(
										function() {

											if ($
													.trim($(
															'#deletecustomer_code')
															.val()) == '') {
												alert('Customer Code Cannot be empty for view');
												return false;
											} else {
											}

										});

						//UPDATE CUSTOMER

						$("#updatebutton")
								.click(
										function() {

											if ($
													.trim($(
															'#updatecustomer_code')
															.val()) == '') {
												alert('Customer Code Cannot be empty for view');
												return false;
											} else {
											}

										});

						$("#nameupdatebutton")
								.click(
										function() {

											if ($
													.trim($(
															'#updatecustomer_name')
															.val()) == '') {
												alert('Customer Name Cannot be empty for view');
												return false;
											} else {
											}

										});

					});

	//Function that validates email address through a regular expression.
	function validateEmail(email) {
		var filter = /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/;
		if (filter.test(email)) {
			return true;
		} else {
			return false;
		}
	}
</script>

</html>


<%
	} else {
			request.setAttribute("msg", "Please properlly Login");
			request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
		}
%>

<%
	} else {
		request.setAttribute("msg", "Please properlly Login");
		request.getRequestDispatcher("/errorLogin.jsp").include(request, response);
	}
%>