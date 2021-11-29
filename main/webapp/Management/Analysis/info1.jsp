<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Management.css">
</head>
<body>
	<%@include file ="./header_management.jsp" %>
	<div class="container" style="padding:5% 10%;">
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
		String sql = "SELECT M.Title AS title, AVG(M.Travel_count) AS avg_trv "
				+ "FROM MEMBERSHIP M GROUP BY M.Title";
		rs = stmt.executeQuery(sql);
		
		out.println("<table class='bluetop'>");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		for(int i = 1; i<= cnt; i++) {
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
		}
		while(rs.next()) {
			out.println("<tr>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getInt(2)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
		<br />
		<br />

	<%
		sql = "SELECT M.Title, A.FName, A.Lname, M.travel_count FROM ACCOUNT A, MEMBERSHIP M, (SELECT M.Title AS title, AVG(M.Travel_count) AS trv "
				+ "FROM MEMBERSHIP M GROUP BY M.Title) Avg_Travel "
				+ "WHERE A.AccountNo = M.AccountNo AND M.Title = Avg_Travel.title AND M.Travel_count < Avg_Travel.trv";
		rs = stmt.executeQuery(sql);
		
		out.println("<table class='bluetop'>");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		out.println("<th>NO</th>");
		for(int i = 1; i<= cnt; i++) {
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
		}
		int count=1;
		while(rs.next()) {
			out.println("<tr>");
			out.println("<td>"+ count++ +"</td>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("<td>"+rs.getInt(4)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
	</div>
</body>
</html>