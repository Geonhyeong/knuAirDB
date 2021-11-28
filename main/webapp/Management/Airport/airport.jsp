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
			try{				
				String query = "select * from airport order by name";
				rs = stmt.executeQuery(query);
				out.println("<button id=\"newBtn\" type=\"submit\" onclick=\"location.href='./insert.jsp'\">NEW</button>");
				out.println("<table>");
				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
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
					out.println("<td><form action=\"./update.jsp\" method=\"get\"><button type=\"submit\" name=\"airlineid\" value="+rs.getString(1)+">UPDATE</button></form></td>");
					out.println("<td><form action=\"./delete.jsp\" method=\"get\"><button type=\"submit\" name=\"airlineid\" value="+rs.getString(1)+">DELETE</button></form></td>");
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