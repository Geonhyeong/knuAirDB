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
				<li><a href="../Airport/airport.jsp">AIRPORT</a></li>
				<li><a href="../Airline/airline.jsp">AIRLINE</a></li>
				<li><a href="../Airplane/airplane.jsp">AIRPLANE</a></li>
				<li><a href="../Leg/leg.jsp">LEG</a></li>
				<li><a href="../Account/account.jsp">ACCOUNT</a></li>
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
			try {
				String sql = "update airline set name='" + request.getParameter("name") + "', diff_seat=" + request.getParameter("diff_seat") + ", diff_beggage=" + request.getParameter("diff_beggage") + " where airlineid='" + request.getParameter("airlineid") + "'";
				int result = stmt.executeUpdate(sql);
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		%>
		<h2>Update Successfully.</h2>
	</article>
	
</body>
</html>