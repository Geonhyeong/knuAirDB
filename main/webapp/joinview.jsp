<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<title>Join</title>
</head>
<body>
<header>
<%@include file ="header.jsp" %>
</header>

<div class="container" style="padding:10% 20%;">
	<div class="jumbotron">
		<form action="join.jsp" method="post">
			<h2 style="text-align:center;">Join</h2>
			
			<div class="form-group">
					<input type="text" class="form-control" placeholder="ID" name="id" maxlength="15">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Password" name="pwd" maxlength="15">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="First Name" name="fname" maxlength="15">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Last Name" name="lname" maxlength="15">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Age" name="age" maxlength="3">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Phone number(xxx-xxxx-xxxx)" name="phone" maxlength="15">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Email" name="email" maxlength="30">
			</div>
			<div class="form-group">
				Sex :
				<input type="radio" name="sex" value="M" checked>Male
				<input type="radio" name="sex" value="F" checked>Female
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="Address" name="address" maxlength="50">
			</div>
			<div class="form-group">
				Type :
				<input type="radio" name="type" value="Passenger" checked>Passenger
				<input type="radio" name="type" value="Admin" checked>Admin
			</div>
			
			<input type="submit" class="btn btn-primary form-control" value="Sign In">
		</form>
	</div>
</div>
</body>
</html>