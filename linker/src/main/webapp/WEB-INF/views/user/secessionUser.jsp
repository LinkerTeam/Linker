<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
*, *:after, *:before {
	/* -webkit-,-moz-등의 접두사는 특정브라우저를 따로 안정성을위해서 적어둔다.  */
	box-sizing: border-box;
}

#main {
	font-family: Dotum, sans-serif;
	font-size: 12px;
	position: relative;
	z-index: 20;
	max-width: 954px;
	height: 100%;
	margin: 0px auto;
}

#contain {
	position: relative;
	padding: 32px 51px 95px;
}

#content {
	height: 400px;
	line-height: 14px;
	width: 450px;
	margin: 100px auto;
	padding: 32px 29px 32px;
	border: 1px solid #dadada;
	background: #fff;
	border-radius: 5px;
}

.btn {
	margin-top: 20px;
	width: 400px;
	border: none;
	outline: none;
	height: 40px;
	background: #FA5883;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	width: 100%;
	border-radius: 5px;
}
  .h1{
     font-size: 30px;
     margin-bottom: 120px;
     text-align: center;
  }
  .label{
     font-size: 20px;
     
  }
  input[type="password"]{
     margin-top: 40px;
     margin-bottom : 30px;
     height: 30px;
     width: 100%;
  }
</style>
</head>
<body>
	<%@include file="header.jsp"%>
	<%@include file="mainMenu.jsp"%>
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