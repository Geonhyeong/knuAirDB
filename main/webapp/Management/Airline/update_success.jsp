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