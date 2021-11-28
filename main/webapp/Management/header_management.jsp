<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="./Management.css">
</head>
<body>
	<header>
		<div id="logo">
			<h1>LOGO</h1>
		</div>
		<div id="top_menu">
			<%
			String SessionId = "";
			String Type = "";
			
			session = request.getSession();
		
			SessionId = (String)session.getAttribute("id");
			Type = (String)session.getAttribute("type");
				
			out.print(SessionId+"님 환영합니다!");
		
			%>
			<a href="/knuAirWeb/Management/main.jsp">MANAGEMENT</a> | 
			<a href="../searchview.jsp">HOME</a> | 
			<a href="../mypageview_info.jsp">MY PAGE</a> | 
			<a href="../logout.jsp">LOGOUT</a>
		</div>
		
		<nav>
			<ul>
				<li><a href="/knuAirWeb/Management/Airport/airport.jsp">AIRPORT</a></li>
				<li><a href="/knuAirWeb/Management/Airline/airline.jsp">AIRLINE</a></li>
				<li><a href="/knuAirWeb/Management/Airplane/airplane.jsp">AIRPLANE</a></li>
				<li><a href="/knuAirWeb/Management/Leg/leg.jsp">LEG</a></li>
				<li><a href="/knuAirWeb/Management/Account/account.jsp">ACCOUNT</a></li>
			</ul>
		</nav>
	</header>
</body>
</html>