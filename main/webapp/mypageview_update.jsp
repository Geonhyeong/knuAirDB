<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style type="text/css">
	table {
		width: 100%;
		border: 1px solid #444444;
		border-collapse: collapse;
	}
	
	th, td {
		border: 1px solid #444444;
		padding:10px;
		text-align: center;
	}
</style>
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
		try{				
			String query = "select accountid, pwd, fname, lname, age, phone, email, sex, address from account where accountId ='" + SessionId + "'";
			rs = stmt.executeQuery(query);
			
			out.println("<form action=\"./mypage_update.jsp\" method=\"post\" accept-charset=\"EUC-KR\">");
			out.println("<table>");
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			out.println("<th>Category</th><th>Value</th>");
			while(rs.next()){
				out.println("<tr><td>" + rsmd.getColumnName(1) + "</td>");
				out.println("<td><input type=\"text\" name=\"accountid\" value=\""+rs.getString(1)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(2) + "</td>");
				out.println("<td><input type=\"text\" name=\"pwd\" value=\""+rs.getString(2)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(3) + "</td>");
				out.println("<td><input type=\"text\" name=\"fname\" value=\""+rs.getString(3)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(4) + "</td>");
				out.println("<td><input type=\"text\" name=\"lname\" value=\""+rs.getString(4)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(5) + "</td>");
				out.println("<td><input type=\"text\" name=\"age\" value=\""+rs.getInt(5)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(6) + "</td>");
				out.println("<td><input type=\"text\" name=\"phone\" value=\""+rs.getString(6)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(7) + "</td>");
				out.println("<td><input type=\"text\" name=\"email\" value=\""+rs.getString(7)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(8) + "</td>");
				out.println("<td><input type=\"text\" name=\"sex\" value=\""+rs.getString(8)+"\"></input></tr>");
				out.println("<tr><td>" + rsmd.getColumnName(9) + "</td>");
				out.println("<td><input type=\"text\" name=\"address\" value=\""+rs.getString(9)+"\"></input></tr>");
				
			}
			out.println("</table>");
	%>
		<button id="saveBtn" onclick="location.href='mypage_update.jsp'">Save</button>
	<%
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</article>
</body>
</html>