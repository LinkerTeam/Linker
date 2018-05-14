
<%-----------------------------------------------------------------------------
 * 파일명칭 : header.jsp	
 * 설    명 : 모든 화면에 고정되는 header
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
<link href="/resources/css/common.css" type="text/css" rel="stylesheet" />
<link href="/resources/css/header.css" type="text/css" rel="stylesheet" />
<!-- fontawesome -->
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
</head>
 
<body>
<%@include file="mainMenu.jsp"%>
	<!--header-->
	<header id="header">
	    <!--로고부분-->
	    <div class="header-background">
	    	<a href="http://localhost:9090/main" class="logo-link">
	        	<span class="logo-full"><img src="/resources/image/logo.png" width="100" /></span>
	        </a>
	        
		    <!--오른쪽메뉴 설정단추-->
		    <span class="rtMenu-button" style="cursor:pointer">
		        <img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" class="header-profile" alt="프로필 사진" />
		    </span>
	    </div>
	    
	    <!--헤더 검색창-->
	    <div class="header-search">
	        <form action="/main/search" method="get">
	            <input type="text" id="search" name="keyword" />
	            <button type="submit"><span><i class="fas fa-search"></i></span></button>
	        </form>
	    </div>
	</header>
	
</body>

<script src="../../resources/js/jquery-3.3.1.min.js"></script>
<script src="../../resources/js/header.js" type="text/javascript"></script>

</html>