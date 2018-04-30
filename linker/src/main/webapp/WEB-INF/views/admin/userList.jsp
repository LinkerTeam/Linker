<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>
</head>
 
<body>
	
	<div class="wrapper">
		<div class="sidebar" data-background-color="white" data-active-color="danger">
	        
	    	<%@include file="adminHeader.jsp"%>
	
	
	        <div class="content">
	            <div class="container-fluid">
	                <div class="row">
	                    
	                    <div class="col-md-12">
	                        <div class="card card-plain">
	                            <div class="header">
	                                <h4 class="title">회원 관리</h4>
	                                <p class="category">LINKER의 모든 회원 관리</p>
	                            </div>
	                            <div class="content table-responsive table-full-width">
	                                <table class="table table-hover">
	                                    <thead style="background-color:#fff;">
	                                        <th><input id="all-checked" class="form-check-input" type="checkbox"></th>
	                                        <th>이메일</th>
	                                        <th>닉네임</th>
	                                        <th>가입구분</th>
	                                        <th>상태</th>
	                                        <th>가입일</th>
	                                        <th>정보수정일</th>
	                                        <th>탈퇴일</th>
	                                    </thead>
	                                    <tbody>
	                                        <c:forEach items="${userList}" var="user">
												<tr onClick="location.href='/admin/readUser?id=${user.id}'" style="cursor:pointer;">
													<td onclick="event.cancelBubble = true;" style="cursor:default;"><input class="form-check-input" type="checkbox"></td>
													<td>${user.email}</td>
													<td>${user.nickname}</td>
													<td>${user.google}</td>
													<td>${user.viewStatus}</td>
													<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${user.cdate}"/></td>
													<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${user.udate}"/></td>
													<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${user.ddate}"/></td>
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
	
	    </div>
	</div>
	</body>
	
	<script src="../../resources/js/jquery-3.3.1.min.js"></script>
	<script src="../../resources/js/admin/bootstrap.min.js" type="text/javascript"></script>
	<script src="../../resources/js/admin/userList.js" type="text/javascript"></script>
</html>