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
				String sql = "update airplane set airlineid='" + request.getParameter("airlineid") + "', type='" + request.getParameter("type") + "', economy_seats=" + request.getParameter("economy_seats") + ", business_seats=" + request.getParameter("business_seats") + ", first_seats=" + request.getParameter("first_seats") + " where airplaneid='" + request.getParameter("airplaneid") + "'";
				int result = stmt.executeUpdate(sql);
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		%>
		<h2>Update Successfully.</h2>
	</article>
	
</body>
</html>