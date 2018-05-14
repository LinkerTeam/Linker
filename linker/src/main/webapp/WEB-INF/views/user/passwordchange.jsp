<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/resources/css/user/passwordchange.css" type="text/css" rel="stylesheet" /> 
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<title>회원 비밀번호 수정</title>
</head>
<body>
   <%@include file="../header.jsp"%>
   <%@include file="../closeBoard.jsp"%>
		<div class="content">
			<div id="main">
				<div id="contain">
					<div id="content">
						<h1 class="title">비밀번호 변경</h1>
						<span>안전한 비밀번호로 내정보를 보호하세요</span>
						<p>
							<em class="pwWaring">다른 아이디/사이트에서 사용한 적 없는 비밀번호 </em>
						</p>
						<p>
							<em class="pwWaring">이전에 사용한 적 없는 비밀번호</em>가 안전합니다.
						</p>
						<p>
						패스워드는 <em class="pwWaring">8자이상 특수문자와 숫자를 조합하여  </em>입력해야합니다.
						</p>
						<form role='form' method="post">
							<p>
								<input type="password" class="password" name="password0"
									id="password0" placeholder="현재 비밀번호">
							</p>
	
							<p>
								<input type="password" class="password" name="password"
									id="password" placeholder="새 비밀번호">
							</p>
	
							<p>
								<input type="password" class="password" name="password2"
									id="password2" placeholder="새 비밀번호확인">
							</p>
	
							<button type="button" id="btw" class="btn" value="전송">확인</button>
							<br>
							<button type="reset" class="btn" vlaue="취소">취소</button>
	
						</form>
					</div>
				</div>
			</div>
		</div>

</body>
<script src="/resources/js/user/passwordchange.js"></script>
</html>