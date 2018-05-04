
<%-----------------------------------------------------------------------------
 * 파일명칭 : cardTest.jsp	
 * 설    명 : 카드리스트와 카드가 출력되는 하나의 프로젝트 화면
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
------------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트화면</title>
<!-- CSS -->
<link href="/resources/css/cards/cardTest.css?ver=11" type="text/css" rel="stylesheet" />
</head>


<body>
	<%@include file="../header.jsp"%>
	<%@include file="../closeBoard.jsp"%>
	
	<div class="content board">
		<%@include file="cardShowMenu.jsp"%>
		
		<div class="projectTitle"><input type="text" name="projectTitle" value="${project.title}" onKeyUp='limitMemo(this, 20)'></div>
        <div class="cardlistContent">

			 
			<!-- 카드리스트 전체 -->
            <div class="cardlists">
			<div class="cardlist favorite"></div>
            	<!-- 각각의 카드리스트가 삽입될 곳 -->
                <!-- 카드리스트 제일 끝의 Add a list...버튼 -->
           		<div class="cardlist addCardlist">
	                <div class="addList">카드리스트 추가</div>
	                <div class="cardlistCreateBox">
	                    <textarea name="title" id="createListTextarea" placeholder="카드리스트 추가" onKeyUp='limitMemo(this, 20)'></textarea><br />
	                    <button type="button" id="listAddBtn">추가</button>
	                    <button type="button" id="listCancleBtn">&times;</button>
	                </div>
                </div>
            </div>
            
		</div>
		<!-- 카드리스트 목록에서 카드 title 수정할 때의 모달 -->
		<div id="modifyModal" class="modifyModal">
			<div class="modifyModal-title"></div>
			<!-- 수정 모달 내용 -->
			<div class="modifyModal-content" style="top: 0; left: 0;">
			    <textarea name="content" id="modifyTextarea" rows="2" style="resize:none" onKeyPress="javascript: if(event.keyCode == 13) return false;" onKeyUp="limitMemo(this, 20)"></textarea><br />
			    <button type="button" id="saveBtn" class="saveBtn">저장</button>
			    <span class="closeModal modifyCardTitle">&times;</span>
			</div>
        </div>
        
	</div>
	
	<!-- 카드리스트 팝업 -->
	<!-- 열기 | .is-visible -->
	<div class="popupMenuWrap">
	    <!-- 제목 -->
	    <div class="popupMenuHeader">
	        <div class="title">리스트</div>
	        <button class="popupMenuCloseBtn">
	            <i class="far fa-times-circle"></i>
	        </button>
	    </div>
	    <!-- 메뉴목록 -->
	    <div class="popupMenuContent">
	        <ul class="popupMenuList">
	            <li class="to-archive"><a href="#">보관함으로</a></li>
	            <li class="to-hide"><a href="#">휴지통으로</a></li>
	        </ul>
	    </div>
	</div>
	
	<!-- 카드팝업 jsp -->
	<%@include file="cardModal.jsp"%>

</body>

<script>
	var u_id = ${project.u_id}; //유저 id
	var p_id = ${project.id}; //프로젝트 id
	var p_ps_id = ${project.ps_id}; //프로젝트 상태값
</script>
<script src="../../../resources/js/jquery-3.3.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<script src="../../../resources/js/board/cardTest.js" type="text/javascript"></script>

</html>