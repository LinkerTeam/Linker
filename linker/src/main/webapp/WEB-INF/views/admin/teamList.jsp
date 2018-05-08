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
	<div class="main-panel">
		<nav class="navbar navbar-default">
		    <div class="container-fluid">
		        <div class="navbar-header">
		            <button type="button" id="toggle" class="navbar-toggle">
		                <span class="sr-only">Toggle navigation</span>
		                <span class="icon-bar"></span>
		                <span class="icon-bar"></span>
		                <span class="icon-bar"></span>
		            </button>
		            <a class="navbar-brand" href="/admin/userList">LINKER 관리자 페이지</a>
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
	
		<div class="content">
		    <div class="container-fluid">
		        <div class="row">
		            
		            <div class="col-md-12">
		                <div class="card card-plain">
		                    <div class="header">
		                        <h4 class="title">팀 관리</h4>
		                        <p class="category">LINKER의 모든 팀 관리</p>
		                    </div>
		                    <div class="content table-responsive table-full-width">
		                        <table class="table table-hover">
		                            <thead style="background-color:#fff;">
		                                <th><!-- <input id="all-checked" class="form-check-input" type="checkbox"> --></th>
		                                <th>팀이름</th>
		                                <th>총관리자</th>
		                                <th>생성일</th>
		                                <!-- <th>상태</th>
		                                <th>가입일</th>
		                                <th>정보수정일</th>
		                                <th>탈퇴일</th> -->
		                            </thead>
		                            <tbody>
		                                <c:forEach items="${allTeamList}" var="team">
											<tr onClick="location.href='/admin/readTeam?id=${team.t_id}'" style="cursor:pointer;">
												<td onclick="event.cancelBubble = true;" style="cursor:default;"><!-- <input class="form-check-input" type="checkbox"> --></td>
												<td>${team.name}</td>
												<td>${team.nickname}</td>
												<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${team.cdate}"/></td>
												<%-- <td>${team.cdate}</td>
												<td>${team.google}</td>
												<td>${team.viewStatus}</td>
												<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${team.udate}"/></td>
												<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${team.ddate}"/></td> --%>
											</tr>
										</c:forEach>
		                            </tbody>
		                        </table>
			
		                    </div>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	
<%@include file="adminFooter.jsp"%>
	
</body>
</html>