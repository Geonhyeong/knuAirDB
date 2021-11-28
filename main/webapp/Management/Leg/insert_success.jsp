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
	<%@include file ="../header_management.jsp" %>
	
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
				String sql = "INSERT INTO leg VALUES ('" + request.getParameter("legid") + "','" + request.getParameter("dep_airportid") + "', '" + request.getParameter("arr_airportid") + "', " + request.getParameter("dep_gate")
					+ ", TO_DATE('" + request.getParameter("scheduled_dep_time") + "', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('" + request.getParameter("scheduled_arr_time") + "', 'YYYY-MM-DD HH24:MI:SS'), " + request.getParameter("adminno") + ", " + request.getParameter("price") + ")";
				int result = stmt.executeUpdate(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		%>
		<h2>Insert Successfully.</h2>
	</article>
	
</body>
</html>