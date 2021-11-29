<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuAir - FindMyTrip</title>
<link rel="stylesheet" href="./styles/styles.css">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
<header>
	<%@include file ="../header.jsp" %>
</header>
<div class="container" style="padding:10% 20%;">
	<div class="jumbotron">
		<form action="findmytrip.jsp" method="post">
			<h2 style="text-align:center;">Search Your E-Ticket</h2>
			<div class="form-group">
					<input type="text" class="form-control" placeholder="E-Ticket ID" name="findid" maxlength="10">
					<input type="submit" value="확인" class='bluebutton' style='margin: 10px; float: right;'>
			</div>
		</form>
	</div>
</div>

</body>
</html>