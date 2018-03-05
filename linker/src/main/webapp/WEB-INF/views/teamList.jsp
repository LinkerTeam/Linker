<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<table class="table table-boared">
	<tr>
		<th style="width: 10px">id</th>
		<th>team name</th>
		<th>team leader</th>
		<th>team member</th>
		<th>date</th>
	</tr>
	
	<c:forEach items="${list}" var="teamVO">	
	<tr>
		<td>${teamVO.id}</td>
		<td>${teamVO.name}</td>
		<td>${teamVO.leader}</td>
		<td>${teamVO.member}</td>
		<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${teamVO.cdate}"/></td>
	</tr>
	</c:forEach>
</body>
</html>