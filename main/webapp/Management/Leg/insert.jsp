<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="../Management.css">
</head>
<body>
	<%@include file ="../header_management.jsp" %>
	
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
				out.println("<table>");
				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
				for(int i = 1; i<= cnt; i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				if(rs.next()) {
					out.println("<tr>");
					out.println("<td><input type=\"text\" name=\"legid\" value=\"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"dep_airportid\" value=\"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"arr_airportid\" value=\"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"dep_gate\" value=\"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"scheduled_dep_time\" value=\"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"scheduled_arr_time\" value=\"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"adminno\" value=\"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"price\" value=\"\"></input></td>");
					out.println("</tr>");
				}
				out.println("</table>");
				out.println("<button id=\"saveBtn\" type=\"submit\">save</button>");
				out.println("</form>");
				
			}  catch (SQLException e) {
				e.printStackTrace();
			}
		%>
	</article>
	
</body>
</html>
