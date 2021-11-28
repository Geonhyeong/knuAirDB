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
	 
	table class='bluetop' {
		width: 100%;
		border: 2px solid #000000;
		border-collapse: collapse;
		table class='bluetop'-layout: fixed;
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
	<title>KnuAir - Reservation View</title>
	<link rel="stylesheet" href="./styles/styles.css">
	<script>
		function count(type, result, eco_price, diff_seat)  {
		  // 결과를 표시할 element
		  const resultElement = document.getElementById(result);
		  
		  // 현재 화면에 표시된 값
		  let number = resultElement.innerText;
		  
		  // 더하기/빼기
		  if(type === 'plus') {
		    number = parseInt(number) + 1;
		  }else if(type === 'minus')  {
			  if(number != 0) {
				  number = parseInt(number) - 1;  
			  }
		  }
		  
		  if(result === 'num_economy') {
			  document.getElementById('hidden_economy').value = number;
			  document.getElementById('hidden_price_economy').value = parseInt(number * eco_price);
			  document.getElementById('price_economy').innerText = parseInt(number * eco_price);
		  } else if(result === 'num_business') {
			  document.getElementById('hidden_business').value = number;
			  document.getElementById('hidden_price_business').value = parseInt(number * eco_price * diff_seat);
			  document.getElementById('price_business').innerText = parseInt(number * eco_price * diff_seat);
		  } else if(result === 'num_first') {
			  document.getElementById('hidden_first').value = number;
			  document.getElementById('hidden_price_first').value = parseInt(number * eco_price * diff_seat * diff_seat);
			  document.getElementById('price_first').innerText = parseInt(number * eco_price * diff_seat * diff_seat);
		  }
		  
		  // 결과 출력
		  document.getElementById('price_total').innerText = parseInt(document.getElementById('price_economy').innerText) 
		  	+  parseInt(document.getElementById('price_business').innerText)
		  	+  parseInt(document.getElementById('price_first').innerText);
		  resultElement.innerText = number;
		}
	
	</script>
</head>
<body>
<header>
<%@include file ="header.jsp" %>
</header>
	<div class="container" style="padding:10% 10%;">
	<div class="all">
	<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "knuAirDB";
	String pass = "knu";
	String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;

	String sql = "";
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	ResultSetMetaData rsmd;
	int cnt;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	
	String account_id = request.getParameter("account_id");
	String account_type = request.getParameter("account_type");
	String legid = request.getParameter("leg_radio");

	String eco_price = "";
	
	/* 선택한 leg의 정보를 출력 */
	try {
		sql = "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport " 
	 			+ "where legid = '" + legid + "' and airportid=dep_airportid)\r\n" + "intersect\r\n"
				+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where legid = '" + legid + "' and airportid=arr_airportid)";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		out.println("<h4>[선택한 티켓]</h4>");
		out.println("<table class='bluetop'>");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
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
			out.println("</tr>");
			eco_price = rs.getString(7);
		}
		
		out.println("</table class='bluetop'>");
		rs.close();
		pstmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
 	
	out.println("<br/>");
	out.println("<h4>[남은 좌석 수]</h4>");
	String avail_economy = "", avail_business = "", avail_first = "";
	/* 선택한 leg의 남은 좌석 수를 출력 */
	try {
		sql = "select economy_avail_seats as Economy, business_avail_seats as Business, first_avail_seats as First from assigned_by where legid = '"
				+ legid + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();

		out.println("<table class='bluetop' border=\"1\">");
		rsmd = rs.getMetaData();
		cnt = rsmd.getColumnCount();
		for (int i = 1; i <= cnt; i++) {
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
		}
		
		while (rs.next()) {
			out.println("<tr>");
			out.println("<td>" + rs.getString(1) + "</td>");
			out.println("<td>" + rs.getString(2) + "</td>");
			out.println("<td>" + rs.getString(3) + "</td>");
			out.println("</tr>");
			avail_economy = rs.getString(1);
			avail_business = rs.getString(2);
			avail_first = rs.getString(3);
		}
		
		out.println("</table class='bluetop'>");
		rs.close();
		pstmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	/* 선택한 leg의 비행기 정보 중 남은 좌석 수를 가져오기 위해 airplain id를 검색 */
	String airplaneid = "";
	try {
		sql = "select airplaneid from assigned_by where legid = '" + legid + "'";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);

		if (rs.next()) {
			airplaneid = rs.getString(1);
		}

		rs.close();
		pstmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	float diff_seat = 0;
	float diff_beggage = 0;
	/* airplain id로 남은 좌석 수를 검색 */
	try {
		sql = "select diff_seat, diff_beggage from airline al, airplane ap where airplaneid = '" + airplaneid
				+ "' and al.airlineid = ap.airlineid";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);

		if (rs.next()) {
			diff_seat = rs.getFloat(1);
			diff_beggage = rs.getFloat(2);
		}
		rs.close();
		pstmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	%>
	<br />
	<h4>[좌석 수 선택]</h4>
	<table class='bluetop'>
		<tr>
			<td> Economy </td>
			<%
			out.println("<td> <input type='button' onclick='count(\"minus\", \"num_economy\", \"" + eco_price + "\", \"" + diff_seat + "\")' value='-'/> </td>");
			out.println("<td> <div id='num_economy'>0</div> </td>");
			out.println("<td> <input type='button' onclick='count(\"plus\", \"num_economy\", \"" + eco_price + "\", \"" + diff_seat + "\")' value='+'/> </td>");
			%>
		</tr>
		<tr>
			<td> Business </td>
			<%
			out.println("<td> <input type='button' onclick='count(\"minus\", \"num_business\", \"" + eco_price + "\", \"" + diff_seat + "\")' value='-'/> </td>");
			out.println("<td> <div id='num_business'>0</div> </td>");
			out.println("<td> <input type='button' onclick='count(\"plus\", \"num_business\", \"" + eco_price + "\", \"" + diff_seat + "\")' value='+'/> </td>");
			%>
		</tr>
		<tr>
			<td> First </td>
			<%
			out.println("<td> <input type='button' onclick='count(\"minus\", \"num_first\", \"" + eco_price + "\", \"" + diff_seat + "\")' value='-'/> </td>");
			out.println("<td> <div id='num_first'>0</div> </td>");
			out.println("<td> <input type='button' onclick='count(\"plus\", \"num_first\", \"" + eco_price + "\", \"" + diff_seat + "\")' value='+'/> </td>");
			%>
		</tr>
	</table class='bluetop'>
	
	<br />
	<h4>[가격]</h4>
	
	<table class='bluetop'>
		<th>ECONOMY</th>		
		<th>BUSINESS</th>		
		<th>FIRST</th>
		<th>TOTAL</th>
		<tr>
			<td> <div id='price_economy'>0</div> </td>
			<td> <div id='price_business'>0</div> </td>
			<td> <div id='price_first'>0</div> </td>
			<td> <div id='price_total'>0</div> </td>
		</tr>
	</table class='bluetop'>
	<form action='ticketview.jsp' method='POST'>
		<h4>[짐이 있습니까?]</h4>
		<input type='radio' name='beggage' value='Y'/>Y
		<input type='radio' name='beggage' value='N' checked/>N
		<br />
		<input type='hidden' id='hidden_economy' name='hidden_economy' value='0' />
		<input type='hidden' id='hidden_business' name='hidden_business' value='0' />
		<input type='hidden' id='hidden_first' name='hidden_first' value='0' />
		<input type='hidden' id='hidden_price_economy' name='hidden_price_economy' value='0' />
		<input type='hidden' id='hidden_price_business' name='hidden_price_business' value='0' />
		<input type='hidden' id='hidden_price_first' name='hidden_price_first' value='0' />
		<%
		out.println("<input type='hidden' id='legid' name='legid' value='" + legid + "' />");
		%>
		<br />
		<input type="submit" value="구매" class="btn btn-primary btn-lg btn-block"/>
		<%
		out.println("<input type='hidden' id='account_id' name='account_id' value='" + account_id + "' />");
		out.println("<input type='hidden' id='account_type' name='account_type' value='" + account_type + "' />");
		 %>
	</form>
	</div>
	</div>
</body>
</html>