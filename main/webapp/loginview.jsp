<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Login</title>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body>
<header>
<%@include file ="header.jsp" %>
</header>

<div class="container" style="padding:10% 20%;">
	<div class="jumbotron">
		<form action="login.jsp" method="post">
			<h2 style="text-align:center;">Login</h2>
			
			<div class="form-group">
					<input type="text" class="form-control" placeholder="아이디" name="id" maxlength="15">
			</div>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="비밀번호" name="pwd" maxlength="15">
			</div>
			
			<input type="submit" class="btn btn-primary form-control" value="로그인">
		</form>
		<div style="text-align:center; padding-top:10px">
			<h5>Don't have an account?<br><a href="joinview.jsp">Create Account</a></h5>
		</div>
	</div>
</div>
</body>
</html>