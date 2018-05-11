<!-- 작성자 : 김소영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Linker</title>
</head>
<body>
	<script type="text/javascript">
		var email = '${email}';
		var name = '${name}';
		  
		alert(email + '님 ' + name + '에 팀원으로 등록되셨습니다. 로그인 창으로 돌아갑니다.');
 
		window.open('', '_self', ''); // 브라우저창 닫기
		self.location = '/user/login';
	</script>
</body>
</html>