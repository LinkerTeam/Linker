<<<<<<< Updated upstream

<%-----------------------------------------------------------------------------
 * 파일명칭 : cardShowMenu.jsp	
 * 설    명 : 프로젝트 화면에서의 right side menu
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
------------------------------------------------------------------------------%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- CSS -->
<link href="/resources/css/cards/cardShowMenu.css" type="text/css" rel="stylesheet" />
</head>

<body>
	<a href="#" id="toggle"><span></span></a>

	<!-- 오른쪽 메뉴 -->
	<!-- .boardAside-open | 열림 상태 -->
	<aside id="boardAside" class="boardAside">
		<div class="nav-tabs-wrap">
			<ul class="nav-tabs">
				<!-- .active | 탭 메뉴 활성화 상태 -->
				<!-- Tab1 | 이력목록 -->
				<%-- <li>
					<div class="nav-tab-btn">
						<a href="#" class="activity-tab">이력</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<ul class="pic-list">
								<li>
									<!-- 작성자 -->
									<div class="pic-list-writer">
										<div class="profile">
											<img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" 
												alt="프로필 사진" />
										</div>
									</div> <!-- 이력내용 -->
									<div class="pic-list-desc">
										<span class="name">왕링커</span>님이 '다이어리' 카드를 추가했습니다.
									</div> <!-- 시간/날짜 -->
									<p class="pic-list-datetime">2018.04.23 18:00</p>
								</li>
							</ul>
							<!-- 이력 더 보기 -->
							<a class="show-more" href="#">View all activity…</a>
						</div>
					</div>
				</li> --%>
				<!-- /이력목록 -->
			
				<!-- Tab2 | 보관목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#" class="archived-tab">보관함</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<div class="tab-content-box-controls">
								<div class="tab-archive-title">
									<span class="tab-archive-title-card">카드 보관함</span>
									<button class="switchBtn-archive swhitchCard">카드리스트 보관함으로</button><!-- 카드목록일 때 출력 -->
									<span class="tab-archive-title-cardlist">카드리스트 보관함</span>
									<button class="switchBtn-archive swhitchCardlist">카드 보관함으로</button><!-- 카드리스트일 때 출력 -->
								</div>
								<form class="tab-search-form">
							        <input type="search" value="" id="search-archive-txt" placeholder="Search" class="tab-search-input">
							        <button type="submit" class="tab-search-button"><i class="fas fa-search"></i></button>
							    </form>
							</div>
							<!-- 동적 카드 태그가 삽입되는 곳 -->
							<div class="nav-tab-content-Box-archive archiveCard">
							
							</div> 
							<!-- 동적 카드리스트 태그가 삽입되는 곳 -->
							<div class="nav-tab-content-Box-archive archiveCardlist">
							
							</div> 
						</div>
					</div>
				</li>
				<!-- /Tab2 | 보관목록 -->
			
				<!-- Tab3 | 가리기목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#"  class="trashbox-tab">휴지통</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<div class="tab-content-box-controls">
								<div class="tab-trashbox-title">
									<span class="tab-trashbox-title-card">카드 휴지통</span>
									<button class="switchBtn-hidden swhitchCard">카드리스트 휴지통으로</button><!-- 카드목록일 때 출력 -->
									<span class="tab-trashbox-title-cardlist">카드리스트 휴지통</span>
									<button class="switchBtn-hidden swhitchCardlist">카드 휴지통으로</button><!-- 카드리스트일 때 출력 -->
								</div>
								<form class="tab-search-form">
							        <input type="search" value="" id="search-hide-txt" placeholder="Search" class="tab-search-input">
							        <button type="submit" class="tab-search-button"><i class="fas fa-search"></i></button>
							    </form>
							</div>
							<div class="nav-tab-content-Box-hidden hiddenCard"></div><!-- 동적 카드 태그가 삽입되는 곳 -->
							<div class="nav-tab-content-Box-hidden hiddenCardlist"></div><!-- 동적 카드리스트 태그가 삽입되는 곳 -->
						</div>
					</div>
				</li>
				<!-- /Tab3 | 가리기목록 -->
				<!-- Tab4 | 보드설정 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#"  class="trashbox-tab">설정</a>
					</div>
					<div class="nav-tab-content">
						<ul>
							<li class="closeBoard">프로젝트 종료하기</li>
						</ul>
						<!-- close board 모달창 -->
						<div class='closeBoardModal'>
							<div class="closeBoardModal-content">
								<div class='closeBoardModal-title'>
									<span class="closeTitle">Close Project?</span>
									<span class="closeModal">&times;</span>
								</div>
								<div class='closeBoardModal-text'>
									<p class="closeBoardModal-text">
										프로젝트를 종료하면 모든 카드리스트와 카드를 조회할 수 없게 됩니다. <br>
										다시 오픈하시려면 상단바의 '종료된 프로젝트 관리' 메뉴를 이용하십시오.
									</p>
									<button class="closeBoardBtn" value="OK">프로젝트 종료하기</button>
								</div>
							</div> 
						</div>
						<!-- /close board 모달창  -->
					</div>
				</li>
				<!-- /Tab3 | 보드설정 -->
			</ul>
				
		</div>
	</aside>
</body>

<script src="../../../resources/js/jquery-3.3.1.min.js"></script>
<script src="../../../resources/js/board/cardShowMenu.js" type="text/javascript"></script>

</html>