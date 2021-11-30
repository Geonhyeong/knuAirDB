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
		// 다 NULL CHeck
		String dep_airportid = request.getParameter("dep_airportid");
		String arr_airportid = request.getParameter("arr_airportid");
		String dep_gate = request.getParameter("dep_gate");
		String scheduled_dep_time = request.getParameter("scheduled_dep_time");
		String scheduled_arr_time = request.getParameter("scheduled_arr_time");
		String adminno = request.getParameter("adminno");
		String price = request.getParameter("price");
		String legid = request.getParameter("legid");
		
		if(dep_airportid == "" || arr_airportid == "" || dep_gate == "" || scheduled_dep_time == "" || scheduled_arr_time == "" || adminno == ""|| price == ""|| legid == "") {
			out.println("수정 실패하였습니다..");
			out.println("<br />");
			out.println("사유 - 비어있는 값 존재 (모두 다 입력해주세요.)");
			%><button type="button" class='bluebutton' onclick="location.href='leg.jsp'">돌아가기</button><%
		}  else {
			try {
				String sql = "update leg set dep_airportid='" + request.getParameter("dep_airportid") + "', arr_airportid='" + request.getParameter("arr_airportid") + "', dep_gate=" + request.getParameter("dep_gate") 
				+ ", scheduled_dep_time=TO_DATE('" + request.getParameter("scheduled_dep_time") + "', 'YYYY-MM-DD HH24:MI:SS'), scheduled_arr_time=TO_DATE('" + request.getParameter("scheduled_arr_time") + "', 'YYYY-MM-DD HH24:MI:SS')"
				+ ", adminno=" + request.getParameter("adminno") + ", price=" + request.getParameter("price")
				+ " where legid='" + request.getParameter("legid") + "'";
				int result = stmt.executeUpdate(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			out.println("<h2>Update Successfully.</h2>");
			response.sendRedirect("leg.jsp");
		}
		%>
		
	</article>
	</div>
</body>
</html>