<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<style type="text/css">
	body {
		background-color: #2D3A4B;
	}
	.all {
		border-radius: 10px;
		position: absolute;
		left: 50%;
		top: 50%;
		transform: translate(-50%, -50%);
		padding: 10px;
		background-color: #FFFFFF;
	}
	.selectbox { 
		position: relative; 
		width: 500px; /* 너비설정 */ 
		border: 1px solid #999; /* 테두리 설정 */ 
		z-index: 1; 
		margin-bottom: 10px;
	} 
	.selectbox:before { /* 화살표 대체 */ 
		content: ""; 
		position: absolute; 
		top: 50%; 
		right: 15px; 
		width: 0; 
		height: 0; 
		margin-top: -1px; 
		border-left: 5px solid transparent; 
		border-right: 5px solid transparent; 
		border-top: 5px solid #333; 
	} 
	.selectbox label { 
		position: absolute; 
		top: 1px; /* 위치정렬 */ 
		left: 5px; /* 위치정렬 */ 
		padding: .8em .5em; /* select의 여백 크기 만큼 */ 
		color: #000; 
		z-index: -1; /* IE8에서 label이 위치한 곳이 클릭되지 않는 것 해결 */ 
	} 
	.selectbox select { 
		width: 100%; 
		height: auto; /* 높이 초기화 */ 
		line-height: normal; /* line-height 초기화 */ 
		font-family: inherit; /* 폰트 상속 */ 
		padding: .8em .5em; /* 여백과 높이 결정 */ 
		border: 0; 
		opacity: 0; /* 숨기기 */ 
		filter:alpha(opacity=0); /* IE8 숨기기 */ 
		-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
		-moz-appearance: none; 
		appearance: none; 
	}

	</style>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script	src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	<script type="text/javascript">
	$(document).ready(
			function() {
				var selectTarget = $('.selectbox select');
				
				selectTarget.change(function() {
					var select_name = $(this).children('option:selected').text();
					$(this).siblings('label').text(select_name);
				});
				
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
									dateFormat : "yymmdd",
									showOn : "both"
								});
			});
</script>
	<title>KnuAir - Search View</title>
</head>
<body>
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
	
	String account_id = (String)session.getAttribute("id");
	String account_type = (String)session.getAttribute("type");
	
	%>
	<div class="all">
	<form action="legview.jsp" method="POST">
		<div class="selectbox">
			<label for="departure_airport">출발 공항</label>
			<select name="departure_airport" id="departure_airport">
				<%
				/* 출발 공항의 정보를 select box의 option으로 출력 */
				try {
					sql = "select city, name, airportid from airport order by city";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
		
					rsmd = rs.getMetaData();
					cnt = rsmd.getColumnCount();
		
					while (rs.next()) {
						out.println("<option value=\"" + rs.getString(1) + "\">" + rs.getString(1) + ", " + rs.getString(2) + ", [" + rs.getString(3) + "]</option>");
					}
					rs.close();
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				%>
			</select>
		</div>
		<div class="selectbox">
			<label for="arrival_airport">도착 공항</label>
			<select name="arrival_airport" id="arrival_airport">
				<%
				/* 도착 공항의 정보를 select box의 option으로 출력 */
				try {
					sql = "select city, name, airportid from airport order by city";
					pstmt = conn.prepareStatement(sql);
					rs = pstmt.executeQuery();
		
					rsmd = rs.getMetaData();
					cnt = rsmd.getColumnCount();
		
					while (rs.next()) {
						out.println("<option value=\"" + rs.getString(1) + "\">" + rs.getString(1) + ", " + rs.getString(2) + ", [" + rs.getString(3) + "]</option>");
					}
					rs.close();
					pstmt.close();	
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				%>
			</select>
		</div> 
		<input type="text" id="start_date" name="start_date">
		<input type="reset" value="초기화" /> 
		<input type="submit" value="조회" />
		<%
		out.println("<input type='hidden' id='account_id' name='account_id' value='" + account_id + "' />");
		out.println("<input type='hidden' id='account_type' name='account_type' value='" + account_type + "' />");
		%>
	</form>
	</div>
</body>
</html>