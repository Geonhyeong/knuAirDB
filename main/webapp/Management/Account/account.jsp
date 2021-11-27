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
	<header>
		<div id="logo">
			<h1>LOGO</h1>
		</div>
		<div id="top_menu">
			<a href="#">HOME</a> |
			<a href="#">NOTICE</a> |
			<a href="#">LOGIN</a> |
			<a href="#">JOIN</a>
		</div>
		
		<nav>
			<ul>
				<li><a href="../Airport/airport.jsp">AIRPORT</a></li>
				<li><a href="../Airline/airline.jsp">AIRLINE</a></li>
				<li><a href="../Airplane/airplane.jsp">AIRPLANE</a></li>
				<li><a href="../Leg/leg.jsp">LEG</a></li>
				<li><a href="../Account/account.jsp">ACCOUNT</a></li>
			</ul>
		</nav>
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
			try{				
				String query = "select * from account order by accountno";
				rs = stmt.executeQuery(query);
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
					out.println("<td>"+rs.getInt(1)+"</td>");
					out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getString(3)+"</td>");
					out.println("<td>"+rs.getString(4)+"</td>");
					out.println("<td>"+rs.getString(5)+"</td>");
					out.println("<td>"+rs.getInt(6)+"</td>");
					out.println("<td>"+rs.getString(7)+"</td>");
					out.println("<td>"+rs.getString(8)+"</td>");
					out.println("<td>"+rs.getString(9)+"</td>");
					out.println("<td>"+rs.getString(10)+"</td>");
					out.println("<td>"+rs.getString(11)+"</td>");
					out.println("<td><form action=\"./update.jsp\" method=\"get\"><button type=\"submit\" name=\"accountno\" value="+rs.getInt(1)+">UPDATE</button></form></td>");
					out.println("<td><form action=\"./delete.jsp\" method=\"get\"><button type=\"submit\" name=\"accountno\" value="+rs.getInt(1)+">DELETE</button></form></td>");
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