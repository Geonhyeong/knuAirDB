<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
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
									
									showOn : "both",
									buttonImage : "images/calendar.gif",
									buttonImageOnly : true,
									buttonText : "Select date"
								});
			});
</script>
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
	%>
	<form action="legview.jsp" method="POST">
		��� ���� : 
		<select name="departure_airport">
			<%
			String query = "select city, name, airportid from airport order by city";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();

			ResultSetMetaData rsmd = rs.getMetaData();
			int cnt = rsmd.getColumnCount();

			while (rs.next()) {
				out.println("<option value=\"" + rs.getString(1) + "\">" + rs.getString(1) + ", " + rs.getString(2) + ", [" + rs.getString(3) + "]</option>");
			}
			rs.close();
			pstmt.close();
			%>
		</select> <br /> 
		���� ���� : 
		<select name="arrival_airport">
			<%
			query = "select city, name, airportid from airport order by city";
			pstmt = conn.prepareStatement(query);
			rs = pstmt.executeQuery();

			rsmd = rs.getMetaData();
			cnt = rsmd.getColumnCount();

			while (rs.next()) {
				out.println("<option value=\"" + rs.getString(1) + "\">" + rs.getString(1) + ", " + rs.getString(2) + ", [" + rs.getString(3) + "]</option>");
			}
			rs.close();
			pstmt.close();
			%>
		</select> <br /> 
		��� ��¥ : 
		<input type="text" id="start_date" name="start_date"> <br /> 
		<input type="reset" value="Reset" /> 
		<input type="submit" value="Submit" />
	</form>
</body>
</html>