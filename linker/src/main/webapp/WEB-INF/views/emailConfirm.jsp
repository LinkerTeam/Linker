<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<div> ${vo3.nickname}님 성공적으로 ${vo3.name}에 초대되셨습니다.<br>
	Linker에 다시 들어가서 로그인 해주시기 바랍니다.<br>
	<button id="intoSiteBtn">Linker 사이트 바로가기</button></div>

<script type="text/javascript">
	var intoSiteBtn = document.getElementById("intoSiteBtn");
	intoSiteBtn.onclick=function(){
		window.open("http://localhost:8080/controller");
	}
</script>
</body>
</html>