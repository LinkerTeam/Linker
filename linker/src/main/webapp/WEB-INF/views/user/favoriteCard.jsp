<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link href="/resources/css/user/favoriteCard.css" type="text/css" rel="stylesheet" />
<title>LINKER</title>
</head>
<script type="text/javascript">
var p_id = 0;
var u_id = ${login.id};
</script>
<body>
 <%@include file="../header.jsp"%>
 <%@include file="../closeBoard.jsp"%>
 	
 	<div class="content board">
		<!-- 이곳에 본문 입력 -->
 
 		<div class="projectTitle"><div>즐겨찾기</div>
 		</div>
             <div class="cardlistContent">
				<!-- 카드리스트 전체 -->
	            <div class="cardlists">
	            	<!-- 각각의 카드리스트가 삽입될 곳 -->
	            </div>
			</div>
				
		<!-- 카드리스트 목록에서 카드 title 수정할 때의 모달 -->
		<div id="modifyModal" class="modifyModal">
			<div class="modifyModal-title"></div>
			<!-- 수정 모달 내용 -->
			<div class="modifyModal-content" style="top: 0; left: 0;">
				<div class="favorite-btn add"></div>
			    <textarea name="content" id="modifyTextarea" rows="2" style="resize:none" onKeyPress="javascript: if(event.keyCode == 13) return false;" onKeyUp="limitMemo(this, 20)"></textarea><br />
			    <button type="button" id="saveBtn" class="saveBtn">저장</button>
			    <span class="closeModal modifyCardTitle">&times;</span>
			</div>
        </div>
			<!-- 카드팝업 jsp -->
			
		<%@include file="../board/cardModal.jsp"%>
	</div>
</body>

<script src="../../../resources/js/user/favoriteCard.js" type="text/javascript"></script>

</html>