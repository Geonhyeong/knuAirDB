<!-- login이랑 연동해서 추가 작업해야함, travel_count랑 멤버십 할인 같은거 -->
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
	
	String legid = request.getParameter("legid");
	int res_eco = Integer.parseInt(request.getParameter("hidden_economy"));
	int res_bus = Integer.parseInt(request.getParameter("hidden_business"));
	int res_fir = Integer.parseInt(request.getParameter("hidden_first"));
	int price_eco = Integer.parseInt(request.getParameter("hidden_price_economy"));
	int price_bus = Integer.parseInt(request.getParameter("hidden_price_business"));
	int price_fir = Integer.parseInt(request.getParameter("hidden_price_first"));
	int price_beg = 300000;
	String beggage = request.getParameter("leg_radio");
	int avail_eco = Integer.parseInt(request.getParameter("avail_economy"));
	int avail_bus = Integer.parseInt(request.getParameter("avail_business"));
	int avail_fir = Integer.parseInt(request.getParameter("avail_first"));
	int price_all = price_eco + price_bus + price_fir + price_beg;
	
	String accountNo = "151";
	
	String disc = "0";
	
	String sql = "INSERT INTO ETICKET VALUES ('" + (1000000000 + 155) + "', '" + legid + "', " + accountNo
			+ ", " + price_all + ", " + (price_eco + price_bus + price_fir) + ", " + price_beg + ", " + disc + ", " + res_eco + ", "
			+ res_bus + ", " + res_fir + ")";
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate(sql);
	pstmt.close();
	
	sql = "update assigned_by set economy_avail_seats=" + (avail_eco - res_eco) + ", business_avail_seats = " + (avail_bus - res_bus) + ", first_avail_seats=" + (avail_fir - res_fir) + " where legid = '" + legid + "'";
	pstmt = conn.prepareStatement(sql);
	pstmt.executeUpdate(sql);
	pstmt.close();
	
/* 	travel_count += 1;
	if (travel_count == 11) {
		membership_title = "Gold";
	} else if (travel_count == 21) {
		membership_title = "Diamond";
	} else if (travel_count == 36) {
		membership_title = "Rubi";
	}
	
	sql = "update membership set travel_count=" + travel_count + ", title='" + membership_title + "' where membershipid='" + membershipId + "'";
	stmt.executeUpdate(sql);

	conn.commit();
	System.out.println("구매를 완료했습니다."); */
	
	sql = "select * from eticket where e_ticketid='" + (1000000000 + 155) + "'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery(sql);
	
	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	for (int i = 1; i <= cnt; i++) {
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	while(rs.next()) {
		out.println("<tr>");
		out.println("<td>" + rs.getString(1) + "</td>");
		out.println("<td>" + rs.getString(2) + "</td>");
		out.println("<td>" + rs.getString(3) + "</td>");
		out.println("<td>" + rs.getString(4) + "</td>");
		out.println("<td>" + rs.getString(5) + "</td>");
		out.println("<td>" + rs.getString(6) + "</td>");
		out.println("<td>" + rs.getString(7) + "</td>");
		out.println("<td>" + rs.getString(8) + "</td>");
		out.println("<td>" + rs.getString(9) + "</td>");
		out.println("<td>" + rs.getString(10) + "</td>");
		out.println("</tr>");
	} 
	%>
</body>
</html>