<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style type="text/css">
	ul{list-style: none;}
	a{text-decoration: none;}
	 
	header{
	    width: 100%;
	    height:95px;
	    background-color: #2d3a4b;
	    position: relative;
	}
	 
	#logo{
		position: absolute;
		top:30px;
		left:30px;
	}
	
	#top_menu{
	    position: absolute;
	    top: 20px;
	    right: 10px;
	    color: white;
	}
	#top_menu a{color: white; font-size: 14px;}
	 
	nav{
	    position:absolute;
	    bottom: 10px;
	    left:220px;
	    font-size:16px;
	}
	
	nav li{
		display: inline;
		margin-left:30px;
	}
	 
	nav li a{
	    color: white;
	}
	 
	nav li a:hover{
	    background-color: white;
	    color: black;
	}
	.all {
		position: absolute;
		left: 50%;
		top: 50%;
		transform: translate(-50%, -50%)
	}
	table {
		width: 100%;
		border: 2px solid #000000;
		border-collapse: collapse;
	}
	th, td {
		border: 2px solid #000000;
		padding: 10px;
		text-align: center;
		vertical-align: middle;
	}
	th {
		background-color: #CACACA;
	}
	</style>
	<title>KnuAir - Leg View</title>
</head>
<body>
<header>
<%@include file ="header.jsp" %>
</header>
	<div class="all">
	<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "knuAirDB";
	String pass = "knu";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	String sql = "";
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	ResultSetMetaData rsmd;
	int cnt;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String account_id = request.getParameter("account_id");
	String account_type = request.getParameter("account_type");
	
	String dep_port = request.getParameter("departure_airport");
	String arr_port = request.getParameter("arrival_airport");
	String date = request.getParameter("start_date");

	/* Leg를 조회 */
 	try {
 		sql = "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where city = '"
 				+ dep_port + "' and airportid=dep_airportid)\r\n" + "intersect\r\n"
 				+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where city = '"
 				+ arr_port + "' and airportid=arr_airportid)\r\n" + "intersect\r\n"
 				+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where scheduled_dep_time like to_date('"
 				+ date + "', 'yyyy-mm-dd'))";
 		pstmt = conn.prepareStatement(sql);
 		rs = pstmt.executeQuery();

 		rsmd = rs.getMetaData();
 		cnt = rsmd.getColumnCount();
 		
 		if(rs.next()) {
 			%>
 			<form action="reservationview.jsp" method="POST">
 			<%
 			if (account_id.compareTo("null") == 0) {	
 				out.println("<h3>로그인이 필요합니다.</h3>");
 			} else {
 				%>
 				<input type="submit" value="예약" />
 				<%
 			}
 			out.println("<input type='hidden' id='account_id' name='account_id' value='" + account_id + "' />");
 			out.println("<input type='hidden' id='account_type' name='account_type' value='" + account_type + "' />");

 			out.println("<table>");
 			for (int i = 1; i <= cnt; i++) {
 				if(i == 7) {
 					out.println("<th>" + rsmd.getColumnName(i) + " (￦)</th>");
 				} else {
 					out.println("<th>" + rsmd.getColumnName(i) + "</th>");				
 				}
 			}
 			out.println("<th> RESERVATION </th>");
 			out.println("<tr>");
 			out.println("<td>" + rs.getString(1) + "</td>");
 			out.println("<td>" + rs.getString(2) + "</td>");
 			out.println("<td>" + rs.getString(3) + "</td>");
 			out.println("<td>" + rs.getString(4) + "</td>");
 			out.println("<td>" + rs.getString(5) + "</td>");
 			out.println("<td>" + rs.getString(6) + "</td>");
 			out.println("<td>" + rs.getString(7) + "</td>");
 			out.println("<td>" + "<input type='radio' name='leg_radio' value='" + rs.getString(1) + "'/>" + "</td>");
 			out.println("</tr>");
 			while (rs.next()) {
 				out.println("<tr>");
 				out.println("<td>" + rs.getString(1) + "</td>");
 				out.println("<td>" + rs.getString(2) + "</td>");
 				out.println("<td>" + rs.getString(3) + "</td>");
 				out.println("<td>" + rs.getString(4) + "</td>");
 				out.println("<td>" + rs.getString(5) + "</td>");
 				out.println("<td>" + rs.getString(6) + "</td>");
 				out.println("<td>" + rs.getString(7) + "</td>");
 				out.println("<td>" + "<input type='radio' name='leg_radio' value='" + rs.getString(1) + "'/>" + "</td>");
 				out.println("</tr>");
 			}
 		
	 		out.println("</table>");
	 		rs.close();
	 		pstmt.close();
 		}
 	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	%>
	</form>
	</div>
</body>
</html>