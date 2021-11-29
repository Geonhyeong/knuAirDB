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
	
	<article id="content">
	<h2>Management - Leg</h2>
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
				String query = "select * from leg order by legid";
				rs = stmt.executeQuery(query);
				out.println("<button class='bluebuttonbig' style='margin-bottom:10px; float:right;' type=\"submit\" onclick=\"location.href='./insert.jsp'\">NEW</button>");
				out.println("<table class='bluetop'>");
				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
				out.println("<th>NO</th>");
				for(int i = 1; i<= cnt; i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				int count=1;
				out.println("<th>UPDATE</th>");
				out.println("<th>DELETE</th>");
				while(rs.next()) {
					out.println("<tr>");
					out.println("<td>"+ count++ +"</td>");
					out.println("<td>"+rs.getString(1)+"</td>");
					out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getString(3)+"</td>");
					out.println("<td>"+rs.getInt(4)+"</td>");
					out.println("<td>"+rs.getString(5)+"</td>");
					out.println("<td>"+rs.getString(6)+"</td>");
					out.println("<td>"+rs.getInt(7)+"</td>");
					out.println("<td>"+rs.getInt(8)+"</td>");
					out.println("<td><form action=\"./update.jsp\" method=\"get\"><button type=\"submit\" name=\"legid\" class='bluebutton' value="+rs.getString(1)+">UPDATE</button></form></td>");
					out.println("<td><form action=\"./delete.jsp\" method=\"get\"><button type=\"submit\" name=\"legid\" class='bluebutton' value="+rs.getString(1)+">DELETE</button></form></td>");
					out.println("</tr>");
				}
				out.println("</table>");
			} catch (SQLException e) {
				e.printStackTrace();
			}
		%>
		
	</article>
</body>
</html>