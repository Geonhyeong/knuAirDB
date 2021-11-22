<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
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
	  resultElement.innerText = number;
	}

</script>
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
	
	String legid = request.getParameter("leg_radio");

 	String sql = "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport " 
 			+ "where legid = '" + legid + "' and airportid=dep_airportid)\r\n" + "intersect\r\n"
			+ "(select legid, dep_airportid as dep, arr_airportid as arr, dep_gate as gate, scheduled_dep_time as dep_time, scheduled_arr_time as arr_time, price from leg, airport where legid = '" + legid + "' and airportid=arr_airportid)";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	out.println("<table border=\"1\">");
	ResultSetMetaData rsmd = rs.getMetaData();
	int cnt = rsmd.getColumnCount();
	for (int i = 1; i <= cnt; i++) {
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	String eco_price = "";
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
	
	out.println("</table>");
	rs.close();
	pstmt.close();

	out.println("<p> 남은 좌석 수 </p>");
	sql = "select economy_avail_seats as Economy, business_avail_seats as Business, first_avail_seats as First from assigned_by where legid = '"
			+ legid + "'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();

	out.println("<table border=\"1\">");
	rsmd = rs.getMetaData();
	cnt = rsmd.getColumnCount();
	for (int i = 1; i <= cnt; i++) {
		out.println("<th>" + rsmd.getColumnName(i) + "</th>");
	}
	
	String avail_economy = "", avail_business = "", avail_first = "";
	
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
	
	out.println("</table>");
	rs.close();
	pstmt.close();
	
	sql = "select airplaneid from assigned_by where legid = '" + legid + "'";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery(sql);
	String airplaneid = "";

	if (rs.next()) {
		airplaneid = rs.getString(1);
	}

	rs.close();
	pstmt.close();
	
	sql = "select diff_seat, diff_beggage from airline al, airplane ap where airplaneid = '" + airplaneid
			+ "' and al.airlineid = ap.airlineid";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery(sql);
	
	float diff_seat = 0;
	float diff_beggage = 0;

	if (rs.next()) {
		diff_seat = rs.getFloat(1);
		diff_beggage = rs.getFloat(2);
	}
	rs.close();
	pstmt.close();
	%>
	<table>
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
	</table>
	
	가격
	<table border='1'>
		<th>ECONOMY</th>		
		<th>BUSINESS</th>		
		<th>FIRST</th>
		<tr>
			<td> <div id='price_economy'>0</div> </td>
			<td> <div id='price_business'>0</div> </td>
			<td> <div id='price_first'>0</div> </td>
		</tr>
	</table>
	<form action='ticketview.jsp' method='POST'>
		짐이 있습니까?
		<input type='radio' name='beggage' value='Y'/>Y
		<input type='radio' name='beggage' value='N'/>N
		<br />
		<input type='hidden' id='hidden_economy' name='hidden_economy' value='0' />
		<input type='hidden' id='hidden_business' name='hidden_business' value='0' />
		<input type='hidden' id='hidden_first' name='hidden_first' value='0' />
		<input type='hidden' id='hidden_price_economy' name='hidden_price_economy' value='0' />
		<input type='hidden' id='hidden_price_business' name='hidden_price_business' value='0' />
		<input type='hidden' id='hidden_price_first' name='hidden_price_first' value='0' />
		<%
		out.println("<input type='hidden' id='avail_economy' name='avail_economy' value='" + avail_economy + "' />");
		out.println("<input type='hidden' id='avail_business' name='avail_business' value='" + avail_business + "' />");
		out.println("<input type='hidden' id='avail_first' name='avail_first' value='" + avail_first + "' />");
		out.println("<input type='hidden' id='legid' name='legid' value='" + legid + "' />");
		%>
		<input type="submit" value="구매" />
	</form>
</body>
</html>