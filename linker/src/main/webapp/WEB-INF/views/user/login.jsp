<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="/user/loginPost" method="post">
 <div class="form-group has-feedback">
   <input type="text" name="email" class="form-control" placeholder="USER ID"/>
   <input type="password" name="password" class="form-control" placeholder="password"/>
   <input type="checkbox" name="userCookie">Rember Me
   
   <button type="submit" class="btn">Sign In</button>
 
 
 
 
 
 </div>


</form>


</body>
</html>