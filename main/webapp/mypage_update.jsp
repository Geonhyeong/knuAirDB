<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuAir - Mypage</title>
</head>
<body>
<header>
<%@include file ="../header_mypage.jsp" %>
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
		String sql = "update account set accountid='" + request.getParameter("accountid") + "', pwd='" + request.getParameter("pwd") + "', fname='" + request.getParameter("fname") + "', lname='" + request.getParameter("lname") + "', age=" + request.getParameter("age") 
		+ ", phone='" + request.getParameter("phone") + "', email='" + request.getParameter("email") + "', sex='" + request.getParameter("sex") + "', address='" + request.getParameter("address") + "' where accountid='" + SessionId+"'";
		int result = stmt.executeUpdate(sql);
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	response.sendRedirect("mypageview_info.jsp");
	%>
</article>
</body>
</html>