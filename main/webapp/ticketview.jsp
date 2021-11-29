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
	.ticket-container {
		width: 70%;
		display:block;
		padding: 10px 15px;
		margin: 5% auto;
		border: 1.5px solid #555555;
		border-collapse: collapse;
	}
	</style>
	<link rel="stylesheet" href="./styles/styles.css">
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
	Statement stmt;
	
	ResultSet rs;
	String sql = "";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	 stmt= conn.createStatement();
	
	String account_id = request.getParameter("account_id");
	String account_type = request.getParameter("account_type");
	String account_no = "";
	String eticket_id = "";
	String fname = "";
	String lname = "";
	
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
	
	if(res_eco == 0 && res_bus == 0 && res_fir == 0) {
		out.println("<h3>좌석을 선택해주세요</h3>");
		%> <button onclick="location.href='searchview.jsp'">조회 메뉴로 가기</button> <%
	} else {
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
			
			price_all *= (1-disc);
			
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
			try{				
				String query = "select fname, lname from account where accountId ='" + account_id + "'";
				rs = stmt.executeQuery(query);
				while(rs.next()){
					fname = rs.getString(1);
					lname = rs.getString(2);
				}
					
				query = "select l.dep_airportid, l.arr_airportid, l.dep_gate, l.scheduled_dep_time, l.scheduled_arr_time,"
						+ " e.e_ticketid, e.leg_price, e.seat_price, e.beggage_price, e.membership_disc, e.number_of_economy, e.number_of_business, e.number_of_first"
						+ " from leg l, eticket e"
						+ " where l.legid = e.legid and e.e_ticketid ='" + eticket_id + "'";
				rs = stmt.executeQuery(query);

				ResultSetMetaData rsmd = rs.getMetaData();
				int cnt = rsmd.getColumnCount();
				while(rs.next()){
					String dep_airportid = rs.getString(1);
					String arr_airportid = rs.getString(2);
					int dep_gate = rs.getInt(3);
					String scheduled_dep_time = rs.getString(4);
					String scheduled_arr_time = rs.getString(5);
					String e_ticketid = rs.getString(6);
					int total_price = rs.getInt(7);
					int seat_price = rs.getInt(8);
					int beggage_price = rs.getInt(9);
					int membership_disc = rs.getInt(10);
					int number_of_economy = rs.getInt(11);
					int number_of_business = rs.getInt(12);
					int number_of_first = rs.getInt(13);
				%>
				
				<div class="ticket-container">
					<div style="display:flex; ">
						<div style="flex:3; border: 1.5px dotted #808080;">
							<div style="display:block; overflow:auto;">
								<div style="display:inline; float:left; margin-left:10px;">
									<h5>E-TICKETID : <%=e_ticketid %></h5>
								</div>
								<div style="display:inline; float:right; margin-right:10px;">
									<h5>PASSENGER NAME : <%=fname %> <%= lname %></h5>
								</div>
							</div>
							<div style="display:flex;margin-top:30px;">
								<div style="flex:auto; text-align:center;">
									<img src="./images/plane_takeoff.png" width="50" height="50">
									<div>
										<h3><%=dep_airportid %></h3>
										<h4>Depart Time: <%=scheduled_dep_time %></h4>
										<h4>Gate No: <%=dep_gate%></h4>
									</div>
								</div>
								<div style="flex:auto;text-align:center;">
									<img src="./images/arrow.png" width="25" height="25">
								</div>
								<div style="flex:auto;text-align:center;">
									<img src="./images/plane_landon.png" width="50" height="50">
									<div>
										<h3><%=arr_airportid %></h3>
										<h4>Arrival Time: <%=scheduled_arr_time %></h4>
									</div>
								</div>
							</div>
						</div>
						<div style="flex:1; border: 1.5px dotted #808080; margin-left:10px;">
							<div style="text-align:center;">
								<h5>[ NUMBER OF SEATS ]</h5>
								<h5>ECONOMY : <%=number_of_economy%></h5>
								<h5>BUSINESS : <%=number_of_business%></h5>
								<h5>FIRST : <%=number_of_first%></h5>
								<h5>--------------------------------</h5>
								<h5>[ FEE COMPOSITION ]</h5>
								<h5>SEAT PRICE: <%=seat_price%></h5>
								<h5>BEGGAGE PRICE: <%=beggage_price%></h5>
								<h5>DISCOUNT: <%=membership_disc%>%</h5>
								<h5>TOTAL FEE: <%=total_price%></h5>
							</div>
						</div>
					</div>
				</div>
				<% 
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	%>
	</div>
</body>
</html>