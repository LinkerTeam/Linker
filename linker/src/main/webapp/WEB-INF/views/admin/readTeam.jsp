<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER 팀 관리</title>
<!-- My CSS -->
<link href="/resources/css/admin/adminUser.css?ver=11" type="text/css" rel="stylesheet" />
<!-- Bootstrap core CSS     -->
<link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet" />
<!-- Animation library for notifications   -->
<link href="/resources/css/admin/animate.min.css?ver=1" rel="stylesheet"/>
<!--  Paper Dashboard core CSS    -->
<link href="/resources/css/admin/paper-dashboard.css?ver=1" rel="stylesheet"/>
<!--  Fonts and icons -->
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
<link href="/resources/css/admin/themify-icons.css?ver=1" rel="stylesheet">
</head>
 
<body>
<div class="wrapper">
	<div class="sidebar" data-background-color="white" data-active-color="danger">
		<div class="sidebar-wrapper">
			<div class="logo">
			    <a href="http://localhost:9090/main" class="simple-text">
			        LINKER
			    </a>
			</div>
			
			<ul class="nav">
			    <li>
			        <a href="userList">
			            <i class="ti-user"></i>
			            <p>회원 관리</p>
			        </a>
			    </li>
			    <li class="active">
			        <a href="teamList">
			            <i class="ti-view-list-alt"></i>
			            <p>팀 관리</p>
			        </a>
			    </li>
			</ul>
		</div>
	</div>
			
			<%@include file="adminFooter.jsp"%>
			
		</div>
	</div>
</body>

<script src="../../resources/js/jquery-3.3.1.min.js"></script>
<script src="../../resources/js/admin/bootstrap.min.js" type="text/javascript"></script>
<!-- <script src="../../resources/js/admin/readTeam.js?ver=1" type="text/javascript"></script> -->

</html>