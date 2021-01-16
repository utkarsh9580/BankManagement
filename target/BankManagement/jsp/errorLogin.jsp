<%@taglib uri="http://www.springframework.org/tags/form" prefix="sp"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>
 <%
Cookie[] cookies=request.getCookies();

String name="",pass="";

if (cookies != null) {

	for (Cookie cookie : cookies) {
    
		if (cookie.getName().equals("username")) {
           name=cookie.getValue();
       }
       
		if(cookie.getName().equals("password")){
           pass=cookie.getValue();
       
		}
    
	}
}
%>
<center>
<p>
${msg}
</p>
</center>
<br/>
<br/>
<sp:form action="login" modelAttribute="user">
<p>
<center>
Enter User Code  : <sp:input path="userCode" value="<%=name%>"/><sp:errors path="userCode"/><br/>
Enter Password : <sp:password path="userPassword" value="<%=pass%>"/><sp:errors path="userPassword"/><br/>
<p>
<input type="checkbox" name="rememberMe">
<label for="checkbox">Keep me logged in</label>
</p>
<p><input type="submit" value="LOGIN"/>
</center>
</sp:form>
</body>
</html>