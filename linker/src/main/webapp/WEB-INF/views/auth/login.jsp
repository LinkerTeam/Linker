<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login Page</title>
</head>
<body>

<form action="/login-check", method="POST">
email: <input type="text" name="email"><br>
password: <input type="password" name="password"><br>
<input type="submit">

<!-- 스프링시큐리티는 spring security는 form 전송시 csrf 공격 방어를 아래의 토큰값을 사용하도록 규정하고 있다. -->
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form>
</body>
</html>