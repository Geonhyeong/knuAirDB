<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style type="text/css">
	.ticket-container {
		width: 60%;
		border: 2px solid #555555;
		border-collapse: collapse;
	}
	
	th, td {
		border: 1px solid #444444;
		padding:10px;
		text-align: center;
	}
</style>
<title>Find My Trip</title>
</head>
<body>
<header>
	<%@include file ="../header.jsp" %>
</header>
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
		String query = "select * from eticket where e_ticketid ='" + request.getParameter("findid")+"'";
		rs = stmt.executeQuery(query);

		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		while(rs.next()){
			String eticketid = rs.getString(1);
			int passengerno = rs.getInt(3);
			int leg_price = rs.getInt(4);
			int seat_price = rs.getInt(5);
			int beggage_price = rs.getInt(6);
			int number_of_economy = rs.getInt(8);
			int number_of_business = rs.getInt(9);
			int number_of_first = rs.getInt(10);
			int total_price = leg_price + seat_price + beggage_price;
%>
	<div class="ticket-container">
		<ul>
		<li>ETICKETID: <%= eticketid %></li>
		<li>PASSENGER No: <%=passengerno%></li>
		<li>TOTAL PRICE: <%= leg_price %>$ + <%= seat_price%>$ + <%= beggage_price%>$ = <%= total_price %>$</li>
		<li></li>
		<li></li>
		</ul>
	</div>

<% 
		}
		out.println("</table>");

	} catch (SQLException e) {
		e.printStackTrace();
	}
	%>
</body>
</html>