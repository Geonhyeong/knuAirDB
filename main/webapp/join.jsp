<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuAir - Join</title>
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
	Statement stmt;
	ResultSet rs;
	String query = "";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);
	stmt = conn.createStatement();

	int accountNo = -1;
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String age = request.getParameter("age");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String sex = request.getParameter("sex");
	String address = request.getParameter("address");
	String type = request.getParameter("type");
	
	
	query = "select max(accountNo) from account";
	try {
		rs = stmt.executeQuery(query);
		if (rs.next()) {
			accountNo = rs.getInt(1) + 1;
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	
	try {
		if(type.compareTo("Admin") == 0) {
			query = "INSERT INTO ACCOUNT VALUES ('" + accountNo + "','" + id + "', '" + pwd + "', '" + fname + "','" + lname
					+ "','" + age + "', '" + phone + "','" + email + "', '" + sex + "', '" + address + "','" + type + "')";
			int result = stmt.executeUpdate(query);
		} else if(type.compareTo("Passenger") == 0) {
			query = "INSERT INTO ACCOUNT VALUES ('" + accountNo + "','" + id + "', '" + pwd + "', '" + fname + "','" + lname
					+ "','" + age + "', '" + phone + "','" + email + "', '" + sex + "', '" + address + "','" + type + "')";
			stmt.addBatch(query);
			int membership_id = 20000000 + accountNo;
			query = "INSERT INTO MEMBERSHIP VALUES ('" + membership_id + "','Silver', 0, '" + accountNo + "')";
			stmt.addBatch(query);
			
			int count[] = stmt.executeBatch();
		}
		out.println("회원가입이 완료되었습니다!!!");
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		out.println("회원가입에 실패하였습니다..");
		out.println("<br />");
		out.println("사유 - 글자 수 길이 초과 or 비어있는 값 존재 or 이미 존재하는 ID");
	}
	out.println("<br />");
%>
	<button type="button" onclick="location.href='searchview.jsp'">확인</button>

</body>
</html>