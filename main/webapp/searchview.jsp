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
	
	#content {
		padding:10px;
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
		width: 500px; /* �ʺ��� */ 
		border: 1px solid #999; /* �׵θ� ���� */ 
		z-index: 1; 
		margin-bottom: 10px;
	} 
	.selectbox:before { /* ȭ��ǥ ��ü */ 
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
		top: 1px; /* ��ġ���� */ 
		left: 5px; /* ��ġ���� */ 
		padding: .8em .5em; /* select�� ���� ũ�� ��ŭ */ 
		color: #000; 
		z-index: -1; /* IE8���� label�� ��ġ�� ���� Ŭ������ �ʴ� �� �ذ� */ 
	} 
	.selectbox select { 
		width: 100%; 
		height: auto; /* ���� �ʱ�ȭ */ 
		line-height: normal; /* line-height �ʱ�ȭ */ 
		font-family: inherit; /* ��Ʈ ��� */ 
		padding: .8em .5em; /* ����� ���� ���� */ 
		border: 0; 
		opacity: 0; /* ����� */ 
		filter:alpha(opacity=0); /* IE8 ����� */ 
		-webkit-appearance: none; /* ����Ƽ�� ���� ���߱� */ 
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
									nextText : '���� ��',
									prevText : '���� ��',
									dayNames : [ '�Ͽ���', '������', 'ȭ����', '������',
											'�����', '�ݿ���', '�����' ],
									dayNamesMin : [ '��', '��', 'ȭ', '��', '��',
											'��', '��' ],
									monthNamesShort : [ '1��', '2��', '3��', '4��',
											'5��', '6��', '7��', '8��', '9��',
											'10��', '11��', '12��' ],
									monthNames : [ '1��', '2��', '3��', '4��',
											'5��', '6��', '7��', '8��', '9��',
											'10��', '11��', '12��' ],
									dateFormat : "yymmdd",
									showOn : "both"
								});
			});
</script>
	<title>KnuAir - Search View</title>
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
			<label for="departure_airport">��� ����</label>
			<select name="departure_airport" id="departure_airport">
				<%
				/* ��� ������ ������ select box�� option���� ��� */
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
			<label for="arrival_airport">���� ����</label>
			<select name="arrival_airport" id="arrival_airport">
				<%
				/* ���� ������ ������ select box�� option���� ��� */
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
		<input type="reset" value="�ʱ�ȭ" /> 
		<input type="submit" value="��ȸ" />
		<%
		out.println("<input type='hidden' id='account_id' name='account_id' value='" + account_id + "' />");
		out.println("<input type='hidden' id='account_type' name='account_type' value='" + account_type + "' />");
		%>
	</form>
	</div>
</body>
</html>