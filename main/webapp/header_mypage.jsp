<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<style type="text/css">
	*{margin: 0px; padding: 0px;}
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
</style>
<title>Header</title>
</head>
<body>
	<div id="logo">
		<h1>LOGO</h1>
	</div>
	
	<div id="top_menu">
	<%
	String SessionId = "";
	String Type = "";
	
	session = request.getSession();
	if (session == null || session.getAttribute("id") == null || session.getAttribute("id").equals("")){
	%>
	<a href="loginview.jsp">SIGN IN</a> |
	<a href="searchview.jsp">HOME</a> |
	<a href="findmytripview.jsp">FIND MY TRIP</a>
	<%
	}
	else{

		SessionId = (String)session.getAttribute("id");
		Type = (String)session.getAttribute("type");
		
		out.print(SessionId+"님 환영합니다!");

		if(Type.equals("Admin")){
	%>
		<a href="./Management/main.jsp">MANAGEMENT</a> | 
		<a href="./searchview.jsp">HOME</a> | 
		<a href="mypageview_info.jsp">MY PAGE</a> | 
		<a href="./logout.jsp">LOGOUT</a>
	</div>
	<nav>
		<ul>
			<li><a href="./mypageview_info.jsp">MY INFO</a></li>
		</ul>
	</nav>
			
	<%
		}
		else{
	%>
		<a href="./searchview.jsp">HOME</a> | 
		<a href="mypageview_info.jsp">MY PAGE</a> | 
		<a href="./logout.jsp">LOGOUT</a>
	</div>
	<nav>
		<ul>
			<li><a href="./mypageview_info.jsp">MY INFO</a></li>
			<li><a href="./mypageview_ticket.jsp">MY TICKET</a></li>
		</ul>
	</nav>
	
	<%
		}
	}
	%>
	
</body>
</html>