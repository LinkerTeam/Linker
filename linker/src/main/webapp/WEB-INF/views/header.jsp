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
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<!-- fontawesome -->
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
</head>

<body>
	<!--header-->
	<header id="header">
	    <!--로고부분-->
	    <a href="#" class="logo-background">
	        <span class="logo-full"><img src="/resources/image/logo.png" width="100" /></span>
	        <span class="logo-mini"><img src="/resources/image/logo_mini.png" width="15" /></span>
	    </a>
	    <!--왼쪽메뉴 단추-->
	    <span class="ltMenu-button" style="cursor:pointer" onclick="openNav()">&#9776;</span>
	    <!--오른쪽메뉴 설정단추-->
	    <span class="rtMenu-button" style="cursor:pointer" onclick="openAside()">
	        <img src="/resources/image/icon_gear.png" width="23" />
	    </span>
	    
	    <!--헤더 검색창-->
	    <div class="header-search">
	        <form>
	            <input type="text" id="search" placeholder="Search" />
	            <button type="submit"><span><i class="fas fa-search"></i></span></button>
	        </form>
	    </div>
	</header>
</body>
</html>