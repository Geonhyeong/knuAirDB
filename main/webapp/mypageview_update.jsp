<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<link rel="stylesheet" href="./styles/styles.css">
<title>KnuAir - Mypage</title>
</head>
<body>
<header>
<%@include file ="../header_mypage.jsp" %>
</header>
<div class="container" style="padding:5% 10%;">
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
			
			out.println("<form action=\"./mypage_update.jsp\" method=\"get\" accept-charset=\"UTF-8\">");
			out.println("<table class='bluetop'>");
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			out.println("<th>Category</th><th>Value</th>");
			while(rs.next()){
				out.println("<tr><td>" + rsmd.getColumnName(1) + "</td>");
				out.println("<td><input type=\"hidden\" name=\"accountid\" value=\""+rs.getString(1)+"\"></input>"+rs.getString(1)+"</tr>");
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
		<input type='submit' id="saveBtn" value='??????' class='bluebutton' style='margin:10px; float: right;'/>
	<%
			out.println("</form>");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
</article>
</div>
</body>
</html>