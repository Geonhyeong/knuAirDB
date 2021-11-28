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
	<%@include file ="../header_management.jsp" %>
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
	
	<form action="info4.jsp" method="get">
		<input type="text" id="text_count" placeholder="N개 이상" name="count" autocomplete="off" style="margin:2px;">
		<button type="submit" id="searchBtn">조회</button>
	</form>

	<%
		String group_count = request.getParameter("count");
		if (group_count == null || group_count == "")
			group_count = "0";
	
		String sql = "SELECT E.LEGID, COUNT(*) AS NUMTICKETS FROM LEG L, ETICKET E "
				+ "WHERE L.LEGID = E.LEGID GROUP BY E.LEGID HAVING COUNT(*) >= " + group_count
				+ " ORDER BY NUMTICKETS DESC";
		rs = stmt.executeQuery(sql);
		
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
			out.println("<td>"+rs.getInt(2)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
</body>
</html>