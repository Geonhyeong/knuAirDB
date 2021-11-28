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
		<button type="submit" id="searchBtn">조회</button>
	</form>

	<%
		String sql = "SELECT E_TICKETID, PASSENGERNO FROM ETICKET E, LEG L "
				+ "WHERE E.LEGID = L.LEGID AND DEP_AIRPORTID IN (SELECT AIRPORTID FROM AIRPORT WHERE airportid = '"
				+ request.getParameter("departure_airport") + "') " + "AND ARR_AIRPORTID IN (SELECT AIRPORTID FROM AIRPORT WHERE airportid = '" + request.getParameter("arrival_airport")
				+ "') ORDER BY PASSENGERNO";
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