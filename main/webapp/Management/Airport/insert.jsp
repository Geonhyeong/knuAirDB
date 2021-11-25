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
			String query = "select * from airport";
			rs = stmt.executeQuery(query);
			
			out.println("<form action=\"./insert_success.jsp\" method=\"get\">");
			out.println("<table border=\"1\">");
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			for(int i = 1; i<= cnt; i++) {
				out.println("<th>" + rsmd.getColumnName(i) + "</th>");
			}
			if(rs.next()) {
				out.println("<tr>");
				out.println("<td><input type=\"text\" name=\"airportid\" value=\"\"></input></td>");
				out.println("<td><input type=\"text\" name=\"name\" value=\"\"></input></td>");
				out.println("<td><input type=\"text\" name=\"city\" value=\"\"></input></td>");
				out.println("<td><input type=\"text\" name=\"total_gates\" value=\"\"></input></td>");
				out.println("</tr>");
			}
			out.println("</table>");
			out.println("<button type=\"submit\">save</button>");
			out.println("</form>");
		%>
	</article>
	
</body>
</html>