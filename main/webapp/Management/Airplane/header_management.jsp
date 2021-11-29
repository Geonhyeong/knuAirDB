<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
	<div id="logo">
		<a href="../../searchview.jsp"><img src="../../images/logo2.png" width="150" height="70"></a>
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
		<a href="../../Management/main.jsp">MANAGEMENT</a> | 
		<a href="../../searchview.jsp">HOME</a> | 
		<a href="../../mypageview_info.jsp">MY PAGE</a> | 
		<a href="../../logout.jsp">LOGOUT</a>
	</div>
	
	<nav>
		<ul>
			<li><a href="../../Management/Airport/airport.jsp">AIRPORT</a></li>
			<li><a href="../../Management/Airline/airline.jsp">AIRLINE</a></li>
			<li><a href="../../Management/Airplane/airplane.jsp">AIRPLANE</a></li>
			<li><a href="../../Management/Leg/leg.jsp">LEG</a></li>
			<li><a href="../../Management/Account/account.jsp">ACCOUNT</a></li>
			<li><a href="../../Management/Analysis/analysis.jsp">ANALYSIS</a></li>
		</ul>
	</nav>
</header>