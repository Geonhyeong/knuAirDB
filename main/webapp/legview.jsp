<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<style type="text/css">
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
 			<input type="submit" value="예약" />
 			<%
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