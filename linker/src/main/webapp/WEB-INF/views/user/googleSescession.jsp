<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link href="/resources/css/user/googleSescession.css" type="text/css" rel="stylesheet" /> 
<body>
  <%@include file="../header.jsp"%>
  <%@include file="../closeBoard.jsp"%>
	
	<div class="content">
		<div id="main">
			<div id="contain">
				<div id="content">
					<h1 class="h1">Google회원 탈퇴 페이지</h1>
					<div class="notes">
						구글회원은 가입 탈퇴를 하기위해선 <span class="point">GOOGLE Email 인증</span>이
						팔요합니다.
					</div>
					<form name="form" role="form" method="post">
						<label class="label">인증 번호 입력</label><br> <input type="text"
							name="confirm" class="confirm"
							placeholder="60분이내에 인증번호를 입력해주세요. ">
						<button value="인증번호" id="emailsend" class="send">인증 번호
							발송</button>
						<input type="submit" class="btn" value="확인">
					</form>
				</div>
			</div>
		</div>
	</div>

	
</body>
<script src="/resources/js/user/googleSescession.js"></script>
</html>