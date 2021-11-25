<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../Management.css">
</head>
<body>
	<header>
		<div id="logo">
			<h1>LOGO</h1>
		</div>
		<div id="top_menu">
			<a href="#">HOME</a> |
			<a href="#">NOTICE</a> |
			<a href="#">LOGIN</a> |
			<a href="#">JOIN</a>
		</div>
		
		<nav>
			<ul>
				<li><a href="./airport.jsp">AIRPORT</a></li>
				<li><a href="./airline.jsp">AIRLINE</a></li>
				<li><a href="./airplane.jsp">AIRPLANE</a></li>
				<li><a href="./leg.jsp">LEG</a></li>
				<li><a href="./account.jsp">ACCOUNT</a></li>
			</ul>
		</nav>
	</header>
	
	<article id="content">
		<%
		   String serverIP = "localhost";
		   String strSID = "orcl";
		   String portNum = "1521";
		   String user = "knuAirDB";
		   String pass = "knu";
		   String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
		   
		   Connection conn = null;
		   Statement stmt;
		   ResultSet rs;
		   Class.forName("oracle.jdbc.driver.OracleDriver");
		   conn = DriverManager.getConnection(url, user, pass);
		   stmt = conn.createStatement();
		%>
		
		<%
			String sql = "INSERT INTO AIRPORT VALUES ('" + request.getParameter("airportid") + "','" + request.getParameter("name") + "', '" + request.getParameter("city") + "', " + request.getParameter("total_gates") + ")";
			int result = stmt.executeUpdate(sql);
		%>
		<h2>Insert Successfully.</h2>
	</article>
	
</body>
</html>