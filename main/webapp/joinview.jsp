<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Join</title>
</head>
<body>
<h1>Join</h1>
<form action="join.jsp" method="post">
	<label for="id">ID: </label>
	<input type="text" id="id" name="id"><br>
	
	<label for="pwd">PW: </label> 
	<input type="text" id="pwd" name="pwd"><br>
	
	<label for="fname">Fname(15자 이내): </label>
	<input type="text" id="fname" name="fname"><br>
	
	<label for="lname">Lname(15자 이내): </label> 
	<input type="text" id="lname" name="lname"><br>
	
	<label for="age">Age: </label>
	<input type="text" id="age" name="age"><br>
	
	<label for="phone">Phone Number[xxx-xxxx-xxxx]: </label> 
	<input type="text" id="phone" name="phone"><br>
	
	<label for="email">Email: </label>
	<input type="text" id="email" name="email"><br>
	
	<label for="sex">Sex </label> 
	<input type="radio" name="sex" value="M" checked>Male
	<input type="radio" name="sex" value="F" checked>Female<br>
	
	<label for="address">Address(50자 이내): </label> 
	<input type="text" id="address" name="address"><br>
	
	<label for="type">Type </label> 
	<input type="radio" name="type" value="Passenger" checked>Passenger
	<input type="radio" name="type" value="Admin" checked>Admin<br>
	
	<input type="submit" value="Join"><br>
	
</form>
</body>
</html>