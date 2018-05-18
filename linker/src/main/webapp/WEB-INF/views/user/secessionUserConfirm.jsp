<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKERe</title>
</head>
<link href="/resources/css/user/secessionUserConfirm.css" type="text/css" rel="stylesheet" /> 
<body>
	<%@include file="../header.jsp"%>
	<%@include file="../closeBoard.jsp"%>
		<div class="content">
			 <div id="main">
				  <div id="contain">
					   <div id="content">
						   <div class="head">회원 탈퇴 안내</div>
							   <div class="notes">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</div>
							   <h1 class='h1'> 1.탈퇴 시 30일간 재가입이 불가능하며, 제재 중 탈퇴 시에는 이력에 따라 최대 5년간 재가입이 제한될 수 있습니다.</h1>
							   <h1 class='h1'> 2.팀을 소유하신 유저 분께서는 팀 소유를 다른분에게 넘겨 주시고 탈퇴를 해주세요.</h1>
							   <form action="/user/secessionUserConfirm" method="post" onsubmit='return check();'>
									<div class='h1'>위사항을 다 읽고 동의하시면 <a class="agreetext">'탈퇴에 동의합니다.'</a>라고 적어주세요</div>
										<input type="text" name="agree" id="agree">
										<input type="submit" class="submit">
									<button class="btn">취소</button>
								</form>
					   </div>
				  </div>
			 </div>
		</div>
      <script src="/resources/js/user/secessionUserConfirm.js"></script>
</body>
</html>