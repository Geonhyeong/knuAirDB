<!-- login이랑 연동해서 추가 작업해야함, travel_count랑 멤버십 할인 같은거 -->
<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<style type="text/css">
	ul{list-style: none;}
	a{text-decoration: none;}

	table {
		width: 100%;
		border: 2px solid #000000;
		border-collapse: collapse;
		table-layout: fixed;
	}
	th, td {
		word-wrap: break-word;
		border: 2px solid #000000;
		padding: 10px;
		text-align: center;
		vertical-align: middle;
	}
	th {
		background-color: #CACACA;
	}	
	</style>
	<title>KnuAir - Ticket View</title>
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

	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	String sql = "";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String account_id = request.getParameter("account_id");
	String account_type = request.getParameter("account_type");
	String account_no = "";
	String eticket_id = "";
	
	String legid = request.getParameter("legid");
	int res_eco = Integer.parseInt(request.getParameter("hidden_economy"));
	int res_bus = Integer.parseInt(request.getParameter("hidden_business"));
	int res_fir = Integer.parseInt(request.getParameter("hidden_first"));
	int price_eco = Integer.parseInt(request.getParameter("hidden_price_economy"));
	int price_bus = Integer.parseInt(request.getParameter("hidden_price_business"));
	int price_fir = Integer.parseInt(request.getParameter("hidden_price_first"));
	int price_beg = 300000;
	String beggage = request.getParameter("leg_radio");
	int avail_eco = 0;
	int avail_bus = 0;
	int avail_fir = 0;
	int price_all = price_eco + price_bus + price_fir + price_beg;
	
	/* 계정 Number 조회 */
	try {
		sql = "select accountno from account where accountid = '" + account_id + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
		
		if(rs.next())
			account_no = rs.getString(1);
		
		rs.close();
		pstmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	/* Membership 정보 가져오기 */
	int travel_count = 0;
	String membership_title = "";
	try {
		sql = "select travel_count, title from membership where accountno = " + account_no;
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
				
		if(rs.next()) {
			travel_count = rs.getInt(1);
			membership_title = rs.getString(2);
		}
		rs.close();
		pstmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} 
	
	/* Concurrency control - 남아있는 좌석 수 한번 더 체크*/
	try {
		sql = "select ECONOMY_AVAIL_SEATS, BUSINESS_AVAIL_SEATS, FIRST_AVAIL_SEATS from assigned_by where legid = '" + legid + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
		
		if(rs.next()) {
			avail_eco = rs.getInt(1);
			avail_bus = rs.getInt(2);
			avail_fir = rs.getInt(3);
		}
		rs.close();
		pstmt.close();
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	if(avail_eco - res_eco < 0 || avail_bus - res_bus < 0 || avail_fir - res_fir < 0) {
		out.println("<h3>좌석이 부족합니다!</h3>");
		out.println("<form action='searchview.jsp' method='POST'>");
		out.println("<input type='submit' value='항공권 다시 조회하기' />");
		out.println("<input type='hidden' id='account_id' name='account_id' value='" + account_id + "' />");
		out.println("<input type='hidden' id='account_type' name='account_type' value='" + account_type + "' />");
		out.println("</form>");
	} else {
		/* e_ticketid를 정하기 위해서 현재 e_ticketid 중 가장 큰 값 가져옴 */
		try {
			sql = "select max(e_ticketid) from eticket";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			
			if(rs.next())
				eticket_id = String.format("%010d", rs.getLong(1) + 1) ;
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		float disc = 0.05f;
		
		if(membership_title.compareTo("Gold") == 0) {
			disc = 0.10f;	
		} else if(membership_title.compareTo("Diamond") == 0) {
			disc = 0.15f;
		} else if(membership_title.compareTo("Rubi") == 0) {
			disc = 0.20f;
		};
		
		/* 티켓 구매 - Insert */
		try {
			sql = "INSERT INTO ETICKET VALUES ('" + eticket_id + "', '" + legid + "', " + account_no
					+ ", " + price_all + ", " + (price_eco + price_bus + price_fir) + ", " + price_beg + ", " + disc * 100 + ", " + res_eco + ", "
					+ res_bus + ", " + res_fir + ")";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate(sql);
			pstmt.close();
		} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}
			
		/* 남아있는 좌석 수 Update */
		try {
			sql = "update assigned_by set economy_avail_seats=" + (avail_eco - res_eco) + ", business_avail_seats = " + (avail_bus - res_bus) + ", first_avail_seats=" + (avail_fir - res_fir) + " where legid = '" + legid + "'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate(sql);
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/* travel_count 1회 증가하고 승급 심사 */
		travel_count++;
		
		if (travel_count == 11) {
			membership_title = "Gold";
		} else if (travel_count == 21) {
			membership_title = "Diamond";
		} else if (travel_count == 36) {
			membership_title = "Rubi";
		}

		try {
			sql = "update membership set travel_count=" + travel_count + ", title='" + membership_title + "' where accountno = " + account_no;
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate(sql);
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/* 구매한 티켓 View */
		try {
			sql = "select e_ticketid, leg_price as total_price, NUMBER_OF_ECONOMY as economy, NUMBER_OF_BUSINESS as business, NUMBER_OF_FIRST as first, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, SCHEDULED_DEP_TIME as dep_time, SCHEDULED_ARR_TIME as arr_time "
				+ "from eticket e, leg l where e_ticketid='" + eticket_id + "' and l.legid='" + legid + "' and e.legid = l.legid";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery(sql);
			
			out.println("<table>");
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
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	%>
	</div>
</body>
</html>