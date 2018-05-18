<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER</title>
</head>
<body>
	<script type="text/javascript">
	    var userEmail = '${email}';

		alert(userEmail + '님 회원가입을 축하합니다. 가입 Email로가 인증을 부탁드립니다.');

		self.location = '/user/login';
	</script>
</body>
</html>