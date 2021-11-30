<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KnuAir - Mypage</title>
</head>
<body>
<header>
<%@include file ="../header_mypage.jsp" %>
</header>
<div class="container" style="padding:5% 10%;">
<article id="content">
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
	// lname이랑 address는 NULL 가능이라 체크안함
	String id = request.getParameter("accountid");
	String pwd = request.getParameter("pwd");
	String fname = request.getParameter("fname");
	String lname = request.getParameter("lname");
	String age = request.getParameter("age");
	String phone = request.getParameter("phone");
	String email = request.getParameter("email");
	String sex = request.getParameter("sex");
	String address = request.getParameter("address");
	
	if(id == "" || pwd == "" || fname == "" || age == "" || phone == "" || email == "" || sex == "") {
		out.println("수정 실패하였습니다..");
		out.println("<br />");
		out.println("사유 - 비어있는 값 존재 (Last name과 Address 빼고는 다 입력해주세요.)");
		%><button type="button" onclick="location.href='mypageview_update.jsp'">돌아가기</button><%
	}  else {
		try {
			String sql = "update account set accountid='" + id + "', pwd='" + pwd + "', fname='" + fname + "', lname='" + lname + "', age=" + age 
			+ ", phone='" + phone + "', email='" + email + "', sex='" + sex + "', address='" + address + "' where accountid='" + SessionId+"'";
			int result = stmt.executeUpdate(sql);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		response.sendRedirect("mypageview_info.jsp");
	}
	%>
</article>
</div>
</body>
</html>