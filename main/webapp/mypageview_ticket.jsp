<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
	.ticket-container {
		width: 70%;
		display:block;
		padding: 10px 15px;
		margin: 5% auto;
		border: 1.5px solid #555555;
		border-collapse: collapse;
	}
	
</style>
<meta charset="UTF-8">
<title>KnuAir - Mypage</title>
</head>
<body>
<header>
	<%@include file ="../header_mypage.jsp" %>
</header>
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
	String accountNo = "";
	String fname = "";
	String lname = "";

	try{				
		String query = "select accountNo, fname, lname from account where accountId ='" + SessionId + "'";
		rs = stmt.executeQuery(query);
		while(rs.next()){
			accountNo = rs.getString(1);
			fname = rs.getString(2);
			lname = rs.getString(3);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	try{				
		String query = "select l.dep_airportid, l.arr_airportid, l.dep_gate, l.scheduled_dep_time, l.scheduled_arr_time,"
				+ " e.e_ticketid, e.leg_price, e.seat_price, e.beggage_price, e.membership_disc, e.number_of_economy, e.number_of_business, e.number_of_first"
				+ " from leg l, eticket e"
				+ " where l.legid = e.legid and l.legid in (select ee.legid from eticket ee where ee.passengerno ='" + accountNo + "')";
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
			int leg_price = rs.getInt(7);
			int seat_price = rs.getInt(8);
			int beggage_price = rs.getInt(9);
			int number_of_economy = rs.getInt(10);
			int number_of_business = rs.getInt(11);
			int number_of_first = rs.getInt(12);
			int total_price = leg_price + seat_price + beggage_price;
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
						<h5>LEG PRICE: <%=leg_price%></h5>
						<h5>SEAT PRICE: <%=seat_price%></h5>
						<h5>BEGGAGE PRICE: <%=beggage_price%></h5>
						<h5>TOTAL FEE: <%=leg_price%></h5>

					</div>
				</div>
			</div>
		</div>
		<% 
		}

	} catch (SQLException e) {
		e.printStackTrace();
	}
	%>
</body>
</html>