<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
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
		int accoutNo = -1;
		try{				
			String query = "select accountNo, accountid, pwd, fname, lname, age, phone, email, sex, address from account where accountId ='" + SessionId + "'";
			rs = stmt.executeQuery(query);
			out.println("<table>");
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
		<button onclick="location.href='mypageview_update.jsp'">Update</button>
		<button onclick="location.href='mypage_delete.jsp'">Delete</button>
	<%
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		if(Type.equals("Passenger")){
			
	%>
		<h1>[Membership]</h1>

	<%
			try{				
				String query = "select * from membership where accountNo ='" + accoutNo + "'";
				rs = stmt.executeQuery(query);
				out.println("<table>");
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


</body>
</html>