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
				out.println("<h2>Airplane ID : "+ request.getParameter("airplaneid") +"</h2>");
				String query = "select airlineid, type, economy_seats, business_seats, first_seats from airplane where airplaneid='" + request.getParameter("airplaneid") +"'";
				rs = stmt.executeQuery(query);
				
				out.println("<form action=\"./update_success.jsp\" method=\"get\">");
				out.println("<table class='bluetop'>");
				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
				for(int i = 1; i<= cnt; i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				if(rs.next()) {
					out.println("<tr>");
					out.println("<td>"+rs.getString(1)+"</td>");
					out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getInt(3)+"</td>");
					out.println("<td>"+rs.getInt(4)+"</td>");
					out.println("<td>"+rs.getInt(5)+"</td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td><input type=\"text\" name=\"airlineid\" value=\""+rs.getString(1)+"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"type\" value=\""+rs.getString(2)+"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"economy_seats\" value="+rs.getInt(3)+"></input></td>");
					out.println("<td><input type=\"text\" name=\"business_seats\" value="+rs.getInt(4)+"></input></td>");
					out.println("<td><input type=\"text\" name=\"first_seats\" value="+rs.getInt(5)+"></input></td>");
					out.println("</tr>");
				}
				else
				{
					out.println("<h2>No Data.</h2>");
				}
				out.println("</table>");
				out.println("<button class='bluebuttonbig' sytle='margin-top:10px;' type=\"submit\" name=\"airplaneid\" value="+request.getParameter("airplaneid")+">save</button>");
				out.println("</form>");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		%>
	</article>
	</div>
</body>
</html>