<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuAir - Management</title>
<link rel="stylesheet" href="../Management.css">
</head>
<body>
	<%@include file ="./header_management.jsp" %>
	<h2>Management - Analysis</h2>
	<div class="container" style="padding:5% 10%;">
	<table class='bluetop'>
		<th>Information</th>
		
		<tr>
			<td><a href="info1.jsp">여행 횟수가 평균보다 적은 계정 정보 조회</a></td>
		</tr>
		<tr>
			<td><a href="info2.jsp">예약된 티켓 현황을 도시 이름으로 조회</a></td>
		</tr>
		<tr>
			<td><a href="info3.jsp">특정 날짜 이후에 출발하는 모든 사람을 조회</a></td>
		</tr>
		<tr>
			<td><a href="info4.jsp">N개 이상 예약된 항공권 정보 조회</a></td>
		</tr>
	</table>
	</div>
	
</body>
</html>