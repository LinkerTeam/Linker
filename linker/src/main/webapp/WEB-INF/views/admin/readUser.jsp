<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER 회원 관리</title>
<!-- My CSS -->
<link href="/resources/css/admin/adminUser.css" type="text/css" rel="stylesheet" />
<!-- Bootstrap core CSS     -->
<link href="/resources/css/admin/bootstrap.min.css" rel="stylesheet" />
<!-- Animation library for notifications   -->
<link href="/resources/css/admin/animate.min.css" rel="stylesheet"/>
<!--  Paper Dashboard core CSS    -->
<link href="/resources/css/admin/paper-dashboard.css" rel="stylesheet"/>
<!--  Fonts and icons -->
<link href="http://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Muli:400,300' rel='stylesheet' type='text/css'>
<link href="/resources/css/admin/themify-icons.css" rel="stylesheet">
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
			    <li class="active">
			        <a href="userList">
			            <i class="ti-user"></i>
			            <p>회원 관리</p>
			        </a>
			    </li>
			    <!-- <li>
			        <a href="teamList">
			            <i class="ti-view-list-alt"></i>
			            <p>팀 관리</p>
			        </a>
			    </li> -->
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
                    <div class="col-lg-8 col-md-7">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">회원정보수정</h4>
                                <input type="text" style="display: none;" name="id" value="${adminUserDTO.id}">
                            </div>
                            <div class="content">
                                <form role="form" method="post" enctype="multipart/form-data" onsubmit="return check()">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="author">
                                            	<img class="avatar border-white" src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${adminUserDTO.profile}" alt="프로필 사진" />
                                                <input type="text" class="form-control border-input" disabled placeholder="file name" value="${adminUserDTO.profileName}">
                                            	<p class='error'></p>
                                            </div>
                                            <div class="text-center">
                                            	<input class="upfileInput" type="file" name="file" value="upload" onchange="upfileInput(this)"/>
		                                        <button type="button" class="btn btn-info btn-fill btn-wd profile" style="color:gray">사진 변경</button>
		                                        <button type="button" class="btn btn-info btn-fill btn-wd profile" style="color:gray">사진 삭제</button>
		                                    </div>
                                        </div>  
                                    </div>

                                    <div class="row">
                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label>가입</label>
                                                <input type="text" class="form-control border-input" name="google" disabled placeholder="google" value="${adminUserDTO.google}">
                                            </div>
                                        </div>
                                        <div class="col-md-10">
                                            <div class="form-group">
                                                <label>닉네임</label>
                                                <input type="text" class="form-control border-input" name="nickname" placeholder="Nickname" value="${adminUserDTO.nickname}">
                                                <p class="error nickname"></p>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-9">
                                            <div class="form-group">
                                                <label for="exampleInputEmail1">이메일</label>
                                                <input type="email" class="form-control border-input" disabled placeholder="Email" value="${adminUserDTO.email}">
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label>상태</label>
                                                <c:if test="${adminUserDTO.viewStatus=='대기'}">
	                                            <select class="form-control border-input statusSelect" name="status">
	                                                <option value="0">대기</option>
	                                                <option value="1">인증</option>
	                                                <option value="2">탈퇴</option>
	                                            </select>
	                                            </c:if>
	                                            <c:if test="${adminUserDTO.viewStatus=='인증'}">
	                                            <select class="form-control border-input statusSelect" name="status">
	                                                <option value="1">인증</option>
	                                                <option value="2">탈퇴</option>
	                                            </select>
	                                            </c:if>
	                                            <c:if test="${adminUserDTO.viewStatus=='탈퇴'}">
	                                            <select class="form-control border-input statusSelect" name="status" disabled>
	                                                <option value="2">탈퇴</option>
	                                            </select>
	                                            </c:if>
                                            </div>
                                        </div>
                                    </div>
	                                <div class="row password">
	                                    <div class="col-md-5">
	                                        <div class="form-group">
	                                            <label>비밀번호 변경</label>
	                                            <input type="password" class="form-control border-input password" placeholder="Password">
	                                        </div>
	                                    </div>
	                                    <div class="col-md-7">
	                                        <p class="error password"></p>
	                                    </div>
	                                </div>
	                                <div class="row password">
	                                    <div class="col-md-5">
	                                        <div class="form-group">
	                                            <label>비밀번호 재확인</label>
	                                            <input type="password" class="form-control border-input password" name="password" placeholder="Password">
	                                        </div>
	                                    </div>
	                                    <div class="col-md-7">
	                                        <p class="error password"></p>
	                                    </div>
	                                </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>가입일</label>
                                                <input type="text" class="form-control border-input" disabled placeholder="Date" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${adminUserDTO.cdate}"/>">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>정보수정일</label>
                                                <input type="text" class="form-control border-input" disabled placeholder="Date" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${adminUserDTO.udate}"/>">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <label>탈퇴일</label>
                                                <input type="text" class="form-control border-input" disabled placeholder="Date" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${adminUserDTO.ddate}"/>">
                                            </div>
                                        </div>

                                    </div>
                                    <div class="text-center">
                                    	<p class="error submit"></p>
                                        <button type="submit" class="btn btn-info btn-fill btn-wd">수정</button>
		                                <button type="button" class="btn btn-info btn-fill btn-wd">취소</button>
                                    </div>
                                    <input type="hidden" name="page" value="${cri.page}">
                                	<input type="hidden" name="perPageNum" value="${cri.perPageNum}">
                                </form>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </div>

		<%@include file="adminFooter.jsp"%>
</body>
</html>