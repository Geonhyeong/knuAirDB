<!-- login�̶� �����ؼ� �߰� �۾��ؾ���, travel_count�� ����� ���� ������ -->
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
	 
	header{
	    width: 100%;
	    height:95px;
	    background-color: #2d3a4b;
	    position: relative;
	}
	 
	#logo{
		position: absolute;
		top:30px;
		left:30px;
	}
	
	#top_menu{
	    position: absolute;
	    top: 20px;
	    right: 10px;
	    color: white;
	}
	#top_menu a{color: white; font-size: 14px;}
	 
	nav{
	    position:absolute;
	    bottom: 10px;
	    left:220px;
	    font-size:16px;
	}
	
	nav li{
		display: inline;
		margin-left:30px;
	}
	 
	nav li a{
	    color: white;
	}
	 
	nav li a:hover{
	    background-color: white;
	    color: black;
	}
	
	table {
		width: 100%;
		border: 2px solid #000000;
		border-collapse: collapse;
		}
	th, td {
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
		<div id="logo">
			<h1>LOGO</h1>
		</div>
		<div id="top_menu">
			<a href="#">HOME</a> |
			<a href="#">NOTICE</a> |
			<a href="#">LOGIN</a> |
			<a href="#">JOIN</a>
		</div>
		
		<nav>
			<ul>
				<!-- ��� ���� �ʿ� -->
				<li><a href="./Airport/airport.jsp">AIRPORT</a></li>
				<li><a href="./Airline/airline.jsp">AIRLINE</a></li>
				<li><a href="./Airplane/airplane.jsp">AIRPLANE</a></li>
				<li><a href="./Leg/leg.jsp">LEG</a></li>
				<li><a href="./Account/account.jsp">ACCOUNT</a></li>
			</ul>
		</nav>
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
	
	/* ���� Number ��ȸ */
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

	/* Membership ���� �������� */
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
	
	/* Concurrency control - �����ִ� �¼� �� �ѹ� �� üũ*/
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
		out.println("<h3>�¼��� �����մϴ�!</h3>");
		out.println("<form action='searchview.jsp' method='POST'>");
		out.println("<input type='submit' value='�װ��� �ٽ� ��ȸ�ϱ�' />");
		out.println("<input type='hidden' id='account_id' name='account_id' value='" + account_id + "' />");
		out.println("<input type='hidden' id='account_type' name='account_type' value='" + account_type + "' />");
		out.println("</form>");
	} else {
		/* e_ticketid�� ���ϱ� ���ؼ� ���� e_ticketid �� ���� ū �� ������ */
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
		
		/* Ƽ�� ���� - Insert */
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
			
		/* �����ִ� �¼� �� Update */
		try {
			sql = "update assigned_by set economy_avail_seats=" + (avail_eco - res_eco) + ", business_avail_seats = " + (avail_bus - res_bus) + ", first_avail_seats=" + (avail_fir - res_fir) + " where legid = '" + legid + "'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate(sql);
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		/* travel_count 1ȸ �����ϰ� �±� �ɻ� */
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
		
		/* ������ Ƽ�� View */
		try {
			sql = "select e_ticketid, leg_price as total_price, NUMBER_OF_ECONOMY, NUMBER_OF_BUSINESS, NUMBER_OF_FIRST, dep_airportid, arr_airportid, dep_gate, SCHEDULED_DEP_TIME, SCHEDULED_ARR_TIME "
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