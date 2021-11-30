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
		// type만 NULL check 안함
		String airplaneid = request.getParameter("airplaneid");
		String airlineid = request.getParameter("airlineid");
		String type = request.getParameter("type");
		String economy_seats = request.getParameter("economy_seats");
		String business_seats = request.getParameter("business_seats");
		String first_seats = request.getParameter("first_seats");
		
		if(airplaneid == "" || airlineid == "" || economy_seats == "" || business_seats == "" || first_seats == "") {
			out.println("생성 실패하였습니다..");
			out.println("<br />");
			out.println("사유 - 비어있는 값 존재 (type 빼고 다 입력해주세요.)");
			%><button type="button" class='bluebutton' onclick="location.href='airplane.jsp'">돌아가기</button><%
		}  else {
			try {				
				String sql = "INSERT INTO airplane VALUES ('" + airplaneid + "','" + airlineid + "', '" + type + "', " + economy_seats + ", " + business_seats + ", " + first_seats + ")";
				int result = stmt.executeUpdate(sql);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			out.println("<h2>Insert Successfully.</h2>");
			response.sendRedirect("airplane.jsp");
		}
			
		%>
	</article>
	</div>
</body>
</html>