<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Find My Trip</title>
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