<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/resources/css/user/secessionUser.css" type="text/css" rel="stylesheet" /> 
<title>로컬 회원 탈퇴페이지</title>
</head>
<body>
	<%@include file="../header.jsp"%>
	<%@include file="../closeBoard.jsp"%>
	<div class="content">
		<div id="main">
			<div id="contain">
				<div id="content">
				  <h1 class="h1">회원 탈퇴 페이지</h1>
					<form name="form" role="form" method="post">
						<label class="label">현재비밀번호</label><br>
						 <input type="password" name="password" placeholder="현재 비밀번호를 입력해주세요."> 
						 <input type="submit" class="btn" value="확인">
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>