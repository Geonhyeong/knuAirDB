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
				String query = "select * from leg";
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
					out.println("<td><input type=\"text\" name=\"legid\" value=\"\" placeholder=\"ex) LEG00000\"></input></td>");
					out.println("<td><input type=\"text\" name=\"dep_airportid\" value=\"\" placeholder=\"ex) AAV\"></input></td>");
					out.println("<td><input type=\"text\" name=\"arr_airportid\" value=\"\" placeholder=\"ex) MMV\"></input></td>");
					out.println("<td><input type=\"text\" name=\"dep_gate\" value=\"\" placeholder=\"ex) 6\"></input></td>");
					out.println("<td><input type=\"text\" name=\"scheduled_dep_time\" value=\"\" placeholder=\"ex) 2021-12-07 11:23:50\"></input></td>");
					out.println("<td><input type=\"text\" name=\"scheduled_arr_time\" value=\"\" placeholder=\"ex) 2021-12-07 11:23:50\"></input></td>");
					out.println("<td><input type=\"text\" name=\"adminno\" value=\"\" placeholder=\"ex) 50\"></input></td>");
					out.println("<td><input type=\"text\" name=\"price\" value=\"\" placeholder=\"ex) 1512300\"></input></td>");
					out.println("</tr>");
				}
				out.println("</table>");
				out.println("<button class='bluebuttonbig' type=\"submit\">save</button>");
				out.println("</form>");
				
			}  catch (SQLException e) {
				e.printStackTrace();
			}
		%>
	</article>
	</div>	
</body>
</html>
