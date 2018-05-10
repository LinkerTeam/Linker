<!-- 작성자 : 김소영 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Linker</title>
<link href="/resources/css/search/search.css?ver=222" type="text/css" rel="stylesheet" />
</head>
<body>
	<%@include file="../header.jsp"%>

	<!-- content 시작 -->

	<div class="content">
		<!-- wrap-content 시작 -->
		<div class="wrap-content">
			<!--  제목  -->
			<div class="title">
				<h3>Search List</h3>
			</div>

			<div id="filter">		
			<button class="filter" id="search-align-cdate" style='cursor:pointer;'>작성일자순</button>
			<button class="filter" id="search-align-title" style='cursor:pointer;'>제목순</button>
			<button class="filter" id="search-align-nickname" style='cursor:pointer;'>작성자순</button>
			</div>
			<!-- 목록 -->
			<div class="list-box-body">
				<div class="category search-category">
					<div class="card-title">카드 제목</div>
					<div class="card-content">카드 내용</div>
					<div class="card-writer">작성자</div>
					<div class="card-file-reply-num">첨부파일 / 댓글</div>
					<div class="card-cdate">생성 날짜</div>
					<div class="card-cardlist">카드 리스트 이름</div>
					<div class="card-project">프로젝트 이름</div>
					<div class="card-team">팀 이름</div>
				</div>
				<!-- 검색 내용 -->
				<c:forEach items="${cardResult}" var="cardResult">
					<div class="one-list-row" data-id="${cardResult.c_id}">
						<div class="card-title">${cardResult.c_title}</div>
						<c:choose>
						<c:when test="${cardResult.content.length() == 0 || cardResult.content == null}">
						<div class="content-null" maxlength="20">내용이 없습니다.</div>
						</c:when>
						<c:otherwise>
						<div class="card-content" maxlength="20">${cardResult.content}</div>
						</c:otherwise>
						</c:choose>
						<div class="card-writer">${cardResult.nickname}</div>
						<div class="card-file-reply-num"><i class="fas fa-paperclip"></i>&nbsp${cardResult.cnt_f_cid}&nbsp&nbsp&nbsp<i class="fas fa-comment"></i>&nbsp${cardResult.cnt_r_cid}</div>
						<div class="card-cdate"><fmt:formatDate pattern="yyyy-MM-dd" value="${cardResult.cdate}"></fmt:formatDate></div>						
						<div class="card-cardlist" maxlength="20">${cardResult.cl_title}</div>
						<div class="card-project">${cardResult.p_title}</div>
						<div class="card-team">${cardResult.t_name}</div>
						<input type="button" class="search-move-btn" style='cursor:pointer;' value="이동하기"
						 data-id="${cardResult.c_id}" data-clId= "${cardResult.cl_id}" data-pId="${cardResult.p_id}" data-tId="${cardResult.t_id}"/>
					</div>
				</c:forEach>
			</div>
			<!-- list-box-body 끝 -->
			<%@include file="../board/cardModal.jsp"%>
		</div>
		<!-- wrap-content 끝 -->
	</div>
	<!-- content 끝 -->
</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
<script type="text/javascript" src="/resources/js/search/search.js"></script>

</html>