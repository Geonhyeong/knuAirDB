<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page language="java" import="java.text.*, java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
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
	String query = "";
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url, user, pass);

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	
	try{
		query = "select AccountId, Pwd, Type from account where AccountID = '" + id + "'and Pwd = '" + pwd + "'";
		pstmt = conn.prepareStatement(query);
		rs = pstmt.executeQuery();
		if (rs != null) {
			if (rs.next()) {
				String AccountId = rs.getString(1);
				String Pwd = rs.getString(2);
				String Type = rs.getString(3);
				
				session.setAttribute("id", AccountId);
				session.setAttribute("type", Type);
				
				//response.sendRedirect("searchview.jsp");
				pageContext.forward("searchview.jsp");
			}
			else {
				out.println("회원정보가 존재하지 않습니다!!!");
%>
			<button type="button" onclick="location.href='loginview.jsp'">확인</button>
<%
			}
		}
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	
	
%>
</body>
</html>