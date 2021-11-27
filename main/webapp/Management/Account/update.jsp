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
			try {
				out.println("<h2>"+ request.getParameter("accountno") +"</h2>");
				String query = "select accountid, pwd, fname, lname, age, phone, email, sex, address, type from account where accountno='" + request.getParameter("accountno") +"'";
				rs = stmt.executeQuery(query);
				
				out.println("<form action=\"./update_success.jsp\" method=\"get\">");
				out.println("<table>");
				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
				for(int i = 1; i<= cnt; i++) {
					out.println("<th>" + rsmd.getColumnName(i) + "</th>");
				}
				if(rs.next()) {
					out.println("<tr>");
					out.println("<td>"+rs.getString(1)+"</td>");
					out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getString(3)+"</td>");
					out.println("<td>"+rs.getString(4)+"</td>");
					out.println("<td>"+rs.getInt(5)+"</td>");
					out.println("<td>"+rs.getString(6)+"</td>");
					out.println("<td>"+rs.getString(7)+"</td>");
					out.println("<td>"+rs.getString(8)+"</td>");
					out.println("<td>"+rs.getString(9)+"</td>");
					out.println("<td>"+rs.getString(10)+"</td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td><input type=\"text\" name=\"accountid\" value=\""+rs.getString(1)+"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"pwd\" value=\""+rs.getString(2)+"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"fname\" value="+rs.getString(3)+"></input></td>");
					out.println("<td><input type=\"text\" name=\"lname\" value=\""+rs.getString(4)+"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"age\" value=\""+rs.getInt(5)+"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"phone\" value="+rs.getString(6)+"></input></td>");
					out.println("<td><input type=\"text\" name=\"email\" value="+rs.getString(7)+"></input></td>");
					out.println("<td><input type=\"text\" name=\"sex\" value="+rs.getString(8)+"></input></td>");
					out.println("<td><input type=\"text\" name=\"address\" value=\""+rs.getString(9)+"\"></input></td>");
					out.println("<td><input type=\"text\" name=\"type\" value="+rs.getString(10)+"></input></td>");
					out.println("</tr>");
				}
				else
				{
					out.println("<h2>No Data.</h2>");
				}
				out.println("</table>");
				out.println("<button id=\"saveBtn\" type=\"submit\" name=\"accountno\" value="+request.getParameter("accountno")+">save</button>");
				out.println("</form>");
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
		%>
	</article>
	
</body>
</html>