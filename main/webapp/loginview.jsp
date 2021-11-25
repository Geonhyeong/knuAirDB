<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

<h1>Login</h1>
<form action="login.jsp" method="post">
	<label for="id">ID: </label>
	<input type="text" id="id" name="id"><br>
	
	<label for="pwd">PW: </label> 
	<input type="text" id="pwd" name="pwd"><br>
	
	<input type="submit" value="Sign In"><br>
	
	Don't have an account?<br>
	<a href="joinview.jsp">Create Account</a>
	
</form>
</body>
</html>