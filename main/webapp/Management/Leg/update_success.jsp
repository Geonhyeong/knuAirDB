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
				String sql = "update leg set dep_airportid='" + request.getParameter("dep_airportid") + "', arr_airportid='" + request.getParameter("arr_airportid") + "', dep_gate=" + request.getParameter("dep_gate") 
				+ ", scheduled_dep_time=TO_DATE('" + request.getParameter("scheduled_dep_time") + "', 'YYYY-MM-DD HH24:MI:SS'), scheduled_arr_time=TO_DATE('" + request.getParameter("scheduled_arr_time") + "', 'YYYY-MM-DD HH24:MI:SS')"
				+ ", adminno=" + request.getParameter("adminno") + ", price=" + request.getParameter("price")
				+ " where legid='" + request.getParameter("legid") + "'";
				int result = stmt.executeUpdate(sql);
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		%>
		<h2>Update Successfully.</h2>
	</article>
	
</body>
</html>