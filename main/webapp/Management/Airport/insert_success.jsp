<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuAir - Management</title>
<link rel="stylesheet" href="../Management.css">
</head>
<body>
	<%@include file ="./header_management.jsp" %>
	<div class="container" style="padding:5% 10%;">
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
		// NULL check 다함
		String airportid = request.getParameter("airportid");
		String name = request.getParameter("airlineid");
		String city = request.getParameter("type");
		String total_gates = request.getParameter("economy_seats");
		
		if(airportid == "" || name == "" || city == "" || total_gates == "") {
			out.println("생성 실패하였습니다..");
			out.println("<br />");
			out.println("사유 - 비어있는 값 존재 (모두 다 입력해주세요.)");
			%><button type="button" class='bluebutton' onclick="location.href='airport.jsp'">돌아가기</button><%
		}  else {
			try {				
				String sql = "INSERT INTO airport VALUES ('" + airportid + "','" + name + "', '" + city + "', " + total_gates + ")";
				int result = stmt.executeUpdate(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			out.println("<h2>Insert Successfully.</h2>");
			response.sendRedirect("airport.jsp");
		}
		%>
	</article>
	</div>
</body>
</html>