<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="../Management.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script type="text/javascript">
		$(document).ready(
			function() {
				var selectTarget = $('.selectbox select');
				
				selectTarget.change(function() {
					var select_name = $(this).children('option:selected').text();
					$(this).siblings('label').text(select_name);
				});
			});
	</script>
</head>
<body>
	<%@include file ="./header_management.jsp" %>
	<div class="container" style="padding:5% 10%;">
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

	<div style='margin-bottom:10px;'>
	<form action="info2.jsp" method="get">
		<div class="selectbox">
			<label for="departure_airport">출발 공항</label>
			<select name="departure_airport" id="departure_airport">
				<%
				/* 출발 공항의 정보를 select box의 option으로 출력 */
				try {
					String sql = "select city, name, airportid from airport order by city";
					PreparedStatement pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
		
					ResultSetMetaData rsmd = rs.getMetaData();
					int cnt = rsmd.getColumnCount();
		
					while (rs.next()) {
						out.println("<option value=\"" + rs.getString(3) + "\">" + rs.getString(1) + ", " + rs.getString(2) + ", [" + rs.getString(3) + "]</option>");
					}
					rs.close();
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				%>
			</select>
		</div>
		<div class="selectbox">
			<label for="arrival_airport">도착 공항</label>
			<select name="arrival_airport" id="arrival_airport">
				<%
				/* 도착 공항의 정보를 select box의 option으로 출력 */
				try {
					String sql = "select city, name, airportid from airport order by city";
					PreparedStatement pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
		
					ResultSetMetaData rsmd = rs.getMetaData();
					int cnt = rsmd.getColumnCount();
		
					while (rs.next()) {
						out.println("<option value=\"" + rs.getString(3) + "\">" + rs.getString(1) + ", " + rs.getString(2) + ", [" + rs.getString(3) + "]</option>");
					}
					rs.close();
					pstmt.close();	
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				%>
			</select>
		</div>
		<button type="submit" class='bluebuttonverybig'>조회</button>
	</form>
		<button type="submit" class='bluebuttonverybig' onclick="location.href='./info2.jsp'">초기화</button>
	</div>
	<%
		String departure_airport = request.getParameter("departure_airport");
		String arrival_airport = request.getParameter("arrival_airport");
		String sql = "";
		
		if (departure_airport == null || arrival_airport == null)
		{
			sql = "SELECT E_TICKETID, PASSENGERNO, L.dep_airportid, L.arr_airportid, L.dep_gate, L.scheduled_dep_time, L.scheduled_arr_time FROM ETICKET E, LEG L "
				+ "WHERE E.LEGID = L.LEGID ORDER BY PASSENGERNO"; 	
		}
		else
		{
			sql = "SELECT E_TICKETID, PASSENGERNO, L.dep_airportid, L.arr_airportid, L.dep_gate, L.scheduled_dep_time, L.scheduled_arr_time FROM ETICKET E, LEG L "
				+ "WHERE E.LEGID = L.LEGID AND DEP_AIRPORTID IN (SELECT AIRPORTID FROM AIRPORT WHERE airportid = '"
				+ departure_airport + "') " + "AND ARR_AIRPORTID IN (SELECT AIRPORTID FROM AIRPORT WHERE airportid = '" + arrival_airport
				+ "') ORDER BY PASSENGERNO";	
		}
		
		
		rs = stmt.executeQuery(sql);
		
		out.println("<table class='bluetop'>");
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
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("<td>"+rs.getString(4)+"</td>");
			out.println("<td>"+rs.getInt(5)+"</td>");
			out.println("<td>"+rs.getString(6)+"</td>");
			out.println("<td>"+rs.getString(7)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
	</div>
</body>
</html>