
<%-----------------------------------------------------------------------------
 * 파일명칭 : adminBoard.jsp	
 * 설    명 : 개발일지 프로젝트 화면 HTML 페이지 별도로 생성하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/05/14
------------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER 개발일지</title>
<link href="/resources/css/cards/cardTest.css" type="text/css" rel="stylesheet" />
</head>

<body>
	<%@include file="../header.jsp"%>
	<%@include file="../closeBoard.jsp"%>
	
	<div class="content board">
		
		<div class="projectTitle"><input type="text" name="projectTitle" value="LINKER developers" disabled></div>
		<div class="cardlistContent">
			<!-- 카드리스트 전체 -->
			<div class="cardlists">
		 		<div data-id="1" class="cardlist">
		 			<div class="cardlistTitleBox"><textarea class="cardlistTitle" rows="1" style="height: 26px;" disabled>1주차 04.23 ~ 04.29</textarea></div>
		 			<div class="cards" style="max-height: calc(((100% - 26px) - 45px) - 20px);">	
		 				<div data-id="1" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">회의 내용, 일정</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div> 
						</div>
						<div data-id="2" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 오윤주</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div> 
						</div>
						<div data-id="3" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 김소영</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div>
						</div>
						<div data-id="4" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 송성은</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div>
						</div>
						<div data-id="11" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">다이어리</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i><i class="far fa-comment"></i><p>3</p></div>
						</div>
						<div data-id="24" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">2018.04.27(금) 회의내용</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div>
						</div>
						<div data-id="25" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">오류 및 수정사항 - 오윤주</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div>
						</div>
						<div data-id="26" data-clid="1" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">데이터 관련 - 오윤주</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div>
						</div> 			
					</div> 	
					<footer class="createCardBox row"></footer>
				</div>
				<div data-id="2" class="cardlist">
					<div class="cardlistTitleBox"><textarea class="cardlistTitle" rows="1" style="height: 26px;" disabled>2주차 04.30 ~ 05.06</textarea></div>
					<div class="cards" style="max-height: calc(((100% - 26px) - 45px) - 20px);">	
						<div data-id="5" data-clid="2" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">회의 내용, 일정</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="8" data-clid="2" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 오윤주</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div>
						</div>
						<div data-id="12" data-clid="2" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 김소영</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i><i class="far fa-comment"></i><p>1</p></div>
						</div>
						<div data-id="15" data-clid="2" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 송성은</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="18" data-clid="2" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">다이어리</div>
							<div class="cardIcon"><i class="far fa-comment"></i><p>1</p></div>
						</div>
					</div>
					<footer class="createCardBox row"></footer>
				</div>
				<div data-id="3" class="cardlist">
					<div class="cardlistTitleBox"><textarea class="cardlistTitle" rows="1" style="height: 26px;" disabled>3주차 05.07 ~ 05.13</textarea></div>
					<div class="cards" style="max-height: calc(((100% - 26px) - 45px) - 20px);">	
						<div data-id="6" data-clid="3" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">회의 내용, 일정</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="9" data-clid="3" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 오윤주</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i><i class="far fa-comment"></i><p>3</p></div>
						</div>
						<div data-id="13" data-clid="3" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 김소영</div>
							<div class="cardIcon"><i class="fas fa-align-left"></i></div>
						</div>
						<div data-id="16" data-clid="3" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 송성은</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="19" data-clid="3" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">다이어리</div>
							<div class="cardIcon"></div>
						</div>
					</div>	
					<footer class="createCardBox row"></footer>
				</div>
				<div data-id="4" class="cardlist">
					<div class="cardlistTitleBox"><textarea class="cardlistTitle" rows="1" style="height: 26px;" disabled>4주차 05.14 ~ 05.21</textarea></div>
					<div class="cards" style="max-height: calc(((100% - 26px) - 45px) - 20px);">	
						<div data-id="7" data-clid="4" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">회의 내용, 일정</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="10" data-clid="4" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 오윤주</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="14" data-clid="4" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 김소영</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="17" data-clid="4" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">작업일지 - 송성은</div>
							<div class="cardIcon"></div>
						</div>
						<div data-id="20" data-clid="4" class="cardtitleLi" onclick="loadCardData(this)">
							<div id="cardLink">다이어리</div>
							<div class="cardIcon"></div>
						</div>
					</div> 	
					<footer class="createCardBox row"></footer>
				</div>
				<div data-id="5" class="cardlist">
				<div class="cardlistTitleBox"><textarea class="cardlistTitle" rows="1" style="height: 26px;" disabled>오류</textarea></div>
					<div class="cards" style="max-height: calc(((100% - 26px) - 45px) - 20px);"></div>
					<footer class="createCardBox row"></footer>
				</div>
				<div data-id="6" class="cardlist">
					<div class="cardlistTitleBox"><textarea class="cardlistTitle" rows="1" style="height: 26px;" disabled>LINKER Developers</textarea></div>
						<div class="cards">	
							<div data-id="21" data-clid="6" class="cardtitleLi" onclick="loadCardData(this)"><div id="cardLink">오윤주</div><div class="cardIcon"></div></div>
							<div data-id="22" data-clid="6" class="cardtitleLi" onclick="loadCardData(this)"><div id="cardLink">김소영</div><div class="cardIcon"></div></div>
							<div data-id="23" data-clid="6" class="cardtitleLi" onclick="loadCardData(this)"><div id="cardLink">송성은</div><div class="cardIcon"></div></div>
						</div> 	
						<footer class="createCardBox row"></footer>
					</div> 	
				</div>
		</div>
	</div>
</body>
</html>