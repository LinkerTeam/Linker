
<%-----------------------------------------------------------------------------
 * 파일명칭 : mainMenu.jsp	
 * 설    명 : header의 프로필사진을 누르면 출력되는 menu
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
------------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER</title>
<!-- CSS -->
<link href="/resources/css/mainMenu.css" type="text/css" rel="stylesheet" />
</head>

<body>
	<aside class="header-menu my-aside is-hidden">
		<span class="my-aside-close">&times;</span>
		<div class="header-menu my-aside-info">
		    <div class="header-menu my-aside-info-text">
				<p class="header-menu">${login.nickname}<br/>(${login.email})</p>
			</div>
			<div class="header-menu my-aside-info-img">
				<img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" class="header-menu" alt="프로필 사진" />
			</div>
		</div>
		<!--메뉴-->
		<div class="my-aside-menu">
			<div class="setting-menu team-modify">
				<a href="http://linker.zz.am/main/team">팀 정보 수정</a>
			</div>
			<div class="setting-menu board-status-modify">
				<a href="#" class="closeBoardList">종료된 프로젝트 관리</a>
			</div>
			<div class="setting-menu user-modify">
				<a href="http://linker.zz.am/user/userModify">회원정보수정</a>
			</div>
			<div class="setting-menu pwd-modify">
				<a href="http://linker.zz.am/user/passwordchange">비밀번호변경</a>
			</div>
			<div class="setting-menu logout">
				<a href="http://linker.zz.am/user/logout" class="logoutBtn">로그아웃</a>
			</div>
		</div>
	</aside>
	
	<script>
	var key = ${login.google};
	</script>
	<script src="../../resources/js/jquery-3.3.1.min.js"></script>
	<script src="../../resources/js/mainMenu.js"></script>
</body>
</html>