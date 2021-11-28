<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../Management.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script type="text/javascript">
	$(document).ready(
			function() {
				$.datepicker.setDefaults($.datepicker.regional['ko']);
				$("#start_date")
						.datepicker(
								{
									changeMonth : true,
									changeYear : true,
									nextText : '다음 달',
									prevText : '이전 달',
									dayNames : [ '일요일', '월요일', '화요일', '수요일',
											'목요일', '금요일', '토요일' ],
									dayNamesMin : [ '일', '월', '화', '수', '목',
											'금', '토' ],
									monthNamesShort : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									monthNames : [ '1월', '2월', '3월', '4월',
											'5월', '6월', '7월', '8월', '9월',
											'10월', '11월', '12월' ],
									dateFormat : "yymmdd"
									
								});
			});
</script>
</head>
<body>
	<%@include file ="../header_management.jsp" %>
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
	<form action="info3.jsp" method="get" style="margin:8px;">
		<h3 style="float:left; padding:4px;">날짜를 선택하세요 : </h3>
		<input type="text" id="start_date" name="dep_time" autocomplete="off">
		<button type="submit" id="searchBtn">조회</button>
	</form>
	<%
		String dep_time = request.getParameter("dep_time");
		if (dep_time == null || dep_time == "")
			dep_time = "20210101";
			
		String sql = "WITH " + "DEP AS" + "(" + "    SELECT L.LEGID, L.DEP_AIRPORTID, L.ARR_AIRPORTID, AP.NAME "
				+ "    FROM LEG L, AIRPORT AP " + "    WHERE AP.AIRPORTID = L.DEP_AIRPORTID " + "), " + "ARR AS "
				+ "( " + "    SELECT L.LEGID, L.DEP_AIRPORTID, L.ARR_AIRPORTID, AP.NAME "
				+ "    FROM LEG L, AIRPORT AP " + "    WHERE AP.AIRPORTID = L.ARR_AIRPORTID " + ") "
				+ "SELECT A.ACCOUNTID, A.fname, A.lname, TO_CHAR(L.SCHEDULED_DEP_TIME, 'YYYY-MM-DD HH24:MI:SS') AS DEP_TIME, DEP.NAME AS DEP_AIRPORT, ARR.NAME AS ARR_AIRPORT "
				+ "FROM ACCOUNT A, ETICKET E, LEG L, DEP, ARR " + "WHERE L.SCHEDULED_DEP_TIME >= TO_DATE('"
				+ dep_time + " 000000', 'YYYY-MM-DD HH24:MI:SS')  " + "    AND E.PASSENGERNO = A.ACCOUNTNO  "
				+ "    AND E.LEGID = L.LEGID  " + "    AND DEP.DEP_AIRPORTID = L.DEP_AIRPORTID "
				+ "    AND ARR.ARR_AIRPORTID = L.ARR_AIRPORTID " + "    AND DEP.LEGID = L.LEGID "
				+ "    AND ARR.LEGID = L.LEGID " + "ORDER BY DEP_TIME ASC ";
		rs = stmt.executeQuery(sql);
		
		out.println("<table>");
		ResultSetMetaData rsmd = rs.getMetaData();
		int cnt = rsmd.getColumnCount();
		out.println("<th>NO</th>");
		for(int i = 1; i<= cnt; i++) {
			out.println("<th>" + rsmd.getColumnName(i) + "</th>");
		}
		int count=1;
		while(rs.next()) {
			out.println("<tr>");
			out.println("<td>"+ count++ +"</td>");
			out.println("<td>"+rs.getString(1)+"</td>");
			out.println("<td>"+rs.getString(2)+"</td>");
			out.println("<td>"+rs.getString(3)+"</td>");
			out.println("<td>"+rs.getString(4)+"</td>");
			out.println("<td>"+rs.getString(5)+"</td>");
			out.println("<td>"+rs.getString(6)+"</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	%>
</body>
</html>