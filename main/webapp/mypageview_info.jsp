<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
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
	<h1>[Personal information]</h1>
	<%
		int accoutNo = -1;
		try{				
			String query = "select accountNo, accountid, pwd, fname, lname, age, phone, email, sex, address from account where accountId ='" + SessionId + "'";
			rs = stmt.executeQuery(query);
			out.println("<table class='bluetop'>");
			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();
			out.println("<th>Category</th><th>Value</th>");
			while(rs.next()){
				accoutNo = rs.getInt(1);
				for(int i = 2; i<= cnt; i++) {
					out.println("<tr>");
					out.println("<td>" + rsmd.getColumnName(i) + "</td>");
					out.println("<td>"+ rs.getString(i) + "</td>");
					out.println("</tr>");
				}
			}
			out.println("</table>");
	%>
		<button onclick="location.href='mypageview_update.jsp'" class='bluebutton' style='margin:10px;'>수정</button>
		<button onclick="location.href='mypage_delete.jsp'" class='bluebutton' style='margin:10px; float: right;'>탈퇴</button>
	<%
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		if(Type.equals("Passenger")){
			
	%>
		<br/>
		<br/>
		
		<h1>[Membership]</h1>

	<%
			try{				
				String query = "select * from membership where accountNo ='" + accoutNo + "'";
				rs = stmt.executeQuery(query);
				out.println("<table class='bluetop'>");
				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
				for(int i = 1; i<= cnt-1; i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				while(rs.next()) {
					out.println("<tr>");
					out.println("<td>"+rs.getString(1)+"</td>");
					out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getInt(3)+"</td>");
					out.println("</tr>");
				}
				out.println("</table>");
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		}

	%>
</article>
</div>
</body>
</html>