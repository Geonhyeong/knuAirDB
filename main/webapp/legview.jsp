<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%
	session = request.getSession();
	if (session == null || session.getAttribute("id") == null || session.getAttribute("id").equals("")){
	%>
	<button type="button" onclick="location.href='loginview.jsp'">Sign In</button><!-- 나나 -->
	<%
	}
	else{

		String SessionId = (String)session.getAttribute("id");
		String Type = (String)session.getAttribute("type");
		
		out.print(SessionId+"님 환영합니다!");
		if(Type.equals("Admin")){
	%>
			<button type=button onclick="location.href='Management.html'">Management</button>
	<%
		}
	%>
	<button type=button onclick="location.href='mypageview.jsp'">My Page</button>
	<button type=button onclick="location.href='logout.jsp'">Logout</button>
	<%
	}
	%>
	<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "knuAirDB";
	String pass = "knu";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	%>
	
	<form action="reservationview.jsp" method="POST">
	<input type="submit" value="Submit" />
	<%	
	String dep_port = request.getParameter("departure_airport");
	String arr_port = request.getParameter("arrival_airport");
	String date = request.getParameter("start_date");

 	String sql = "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where city = '"
			+ dep_port + "' and airportid=dep_airportid)\r\n" + "intersect\r\n"
			+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where city = '"
			+ arr_port + "' and airportid=arr_airportid)\r\n" + "intersect\r\n"
			+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where scheduled_dep_time like to_date('"
			+ date + "', 'yyyy-mm-dd'))";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	for (int i = 1; i <= cnt; i++) {
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	
	while (rs.next()) {
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
		out.println("<td>" + rs.getString(7) + "</td>");
		out.println("<td>" + "<input type='radio' name='leg_radio' value='" + rs.getString(1) + "'/> 예약" + "</td>");
		out.println("</tr>");
	}
	
	out.println("</table>");
	rs.close();
	pstmt.close();
	%>
	</form>
</body>
</html>