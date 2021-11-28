<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
			String sql = "delete from account where accountid =" + SessionId;
			int result = stmt.executeUpdate(sql);				
		} catch (SQLException e) {
			e.printStackTrace();
		}

		session.invalidate();
		pageContext.forward("searchview.jsp");
	%>
</article>
</body>
</html>