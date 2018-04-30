<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- My CSS -->
<link href="/resources/css/admin/adminUser.css?ver=11" type="text/css" rel="stylesheet" />
<!-- Bootstrap core CSS     -->
<link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet" />
<!-- Animation library for notifications   -->
<link href="/resources/css/admin/animate.min.css" rel="stylesheet"/>
<!--  Paper Dashboard core CSS    -->
<link href="/resources/css/admin/paper-dashboard.css?ver=11" rel="stylesheet"/>

<!--  Fonts and icons -->
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
<link href="/resources/css/admin/themify-icons.css?ver=11" rel="stylesheet">
</head>
<body>
	<div class="sidebar-wrapper">
		<div class="logo">
		    <a href="http://localhost:9090/main" class="simple-text">
		        LINKER
		    </a>
		</div>
		
		<ul class="nav">
		    <li class="active">
		        <a href="userList">
		            <i class="ti-user"></i>
		            <p>회원 관리</p>
		        </a>
		    </li>
		    <li>
		        <a href="dashboard.html">
		            <i class="ti-view-list-alt"></i>
		            <p>팀 관리</p>
		        </a>
		    </li>
		</ul>
	</div>
</div>
	
	<div class="main-panel">
		<nav class="navbar navbar-default">
		    <div class="container-fluid">
		        <div class="navbar-header">
		            <button type="button" class="navbar-toggle">
		                <span class="sr-only">Toggle navigation</span>
		                <span class="icon-bar bar1"></span>
		                <span class="icon-bar bar2"></span>
		                <span class="icon-bar bar3"></span>
		            </button>
		            <a class="navbar-brand" href="#">LINKER 관리자 페이지</a>
		        </div>
		        <div class="collapse navbar-collapse">
		            <ul class="nav navbar-nav navbar-right">
						<li>
		                    <a href="http://localhost:9090/main">
								<i class="ti-settings"></i>
								<p>관리자모드 나가기</p>
		                    </a>
		                </li>
		            </ul>
			
		        </div>
		    </div>
		</nav>
</body>
</html>