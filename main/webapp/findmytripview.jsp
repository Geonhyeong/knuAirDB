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

<form action="findmytrip.jsp" method="post">
	Input Your E-Ticket ID: <input type="text" name="findid">
	
	<input type="submit" value="확인">
</form>

</body>
</html>