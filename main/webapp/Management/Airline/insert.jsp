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
			try {
				String query = "select * from airline";
				rs = stmt.executeQuery(query);
				
				out.println("<form action=\"./insert_success.jsp\" method=\"get\">");
				out.println("<table class='bluetop'>");
				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
				for(int i = 1; i<= cnt; i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				if(rs.next()) {
					out.println("<tr>");
					out.println("<td><input type=\"text\" name=\"airlineid\" value=\"\" placeholder=\"ex) AL0000\"></input></td>");
					out.println("<td><input type=\"text\" name=\"name\" value=\"\" placeholder=\"ex) Korean Air\"></input></td>");
					out.println("<td><input type=\"text\" name=\"diff_seat\" value=\"\" placeholder=\"ex) 1.20\"></input></td>");
					out.println("<td><input type=\"text\" name=\"diff_beggage\" value=\"\" placeholder=\"ex) 0.031\"></input></td>");
					out.println("</tr>");
				}
				out.println("</table>");
				out.println("<button class='bluebuttonbig' sytle='margin-top:10px;' type=\"submit\">save</button>");
				out.println("</form>");
				
			}  catch (SQLException e) {
				e.printStackTrace();
			}
		%>
	</article>
	</div>
</body>
</html>