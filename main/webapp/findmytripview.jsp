<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuAir - FindMyTrip</title>
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
			</div>
			<input type="submit" value="확인">
		</form>
	</div>
</div>

</body>
</html>