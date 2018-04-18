<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- CSS -->

<link href="/resources/css/mainMenu.css?ver=111" type="text/css" rel="stylesheet" />
<style>
.list-modal{
	position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    /*width: 100%;
    height: 100%;*/
    background-color: rgb(0, 0, 0);
    /* 모달창 옆에 백그라운드 농도  */
    background-color: rgba(0, 0, 0, 0.8);
    /* Black w/ opacity */
    z-index: 3;
    /*overflow-y: auto;*/
  
    display: none;
    transition: opacity 0.3s 0, visibility 0 0.3s;
}
.list-modal.is-visible {
    display: block;
}
.list-content{
 	position: relative;
    height: auto;
    box-sizing: border-box;
    width: 400px;
    background: #fff;
    border-radius: 4px;
    padding: 20px 45px 20px 20px;
    margin: 250px auto 0 auto;

}
</style>
</head>

<body>
	<!--왼쪽 메뉴(확장메뉴, 축소메뉴)-->
	<!--확장 메뉴(글자)-->
	<nav class="mainNav"> <!--확장메뉴 | 상단 프로필영역-->
	<div class="profile-area">
		<a href="#" class="profile-img-area"> 
			<img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" class="profile-img" />
		</a>
		<div class="profile-nickname-area">
			<div class="profile-nickname">${login.nickname}</div>
		</div>
	</div>
	
	
	<!--확장메뉴 | 하단 메뉴영역-->
	<ul class="mainNav-menu">
		<li class="mainNav-menu-header">Main navigation</li>
		<li>
			<div class="list-modal">
				<div class="list-content">			 
					<div class="head-list">Hidden Project List</div>
					<div class="content-list"></div>
				</div>
			</div>
			<a href="#" class="project-list">Project</a>
		</li>
		<li><a href="#">ERD</a></li>
		<li><a href="#">CodeLauncher</a></li>
		<li><a href="#">Chat</a></li>
		<li><a href="#">Postman</a></li>
	</ul>
	</nav>


	<!--축소 메뉴(아이콘)-->
             <nav class="iconBar">
                 <a href="#"><img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" class="profile-img" /></a>
                 <!--마우스 오버시 아이콘 색변경 되도록-->
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/u765gerlj/icon_project_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/wbqihhlif/icon_project.png'"><img src="https://s5.postimg.org/wbqihhlif/icon_project.png" width="30" border="0" /><span class="icon-menuName">Project</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/beuacuicn/icon_erd_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/6sy64hp3r/icon_erd.png'"><img src="https://s5.postimg.org/6sy64hp3r/icon_erd.png" width="30" border="0" /><span class="icon-menuName">ERD</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/a12ngyix3/icon_code_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/8m12s8a47/icon_code.png'"><img src="https://s5.postimg.org/8m12s8a47/icon_code.png" width="30" border="0" /><span class="icon-menuName">CodeLauncher</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/aqlftbyw7/icon_chat_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/pmjz0x2l3/icon_chat.png'"><img src="https://s5.postimg.org/pmjz0x2l3/icon_chat.png" width="30" border="0" /><span class="icon-menuName">Chat</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/b3ctziwlj/icon_post_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/4pnqw9jzr/icon_post.png'"><img src="https://s5.postimg.org/4pnqw9jzr/icon_post.png" width="30" border="0" /><span class="icon-menuName">Postman</span></a>
             </nav>
            

	<!-- 오른쪽 메뉴 -->
	<!-- .mainAside-open | 열림 상태 -->
	<aside id="mainAside" class="mainAside">
		<div class="nav-tabs-wrap">
			<ul class="nav-tabs">
				<!-- .active | 탭 메뉴 활성화 상태 -->
				<!-- Tab1 | 이력목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#" class="activity-tab">Activity</a>
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
										<span class="name">백다방</span> added Checklist to git 수정된 문서
										확인
									</div> <!-- 시간/날짜 -->
									<p class="pic-list-datetime">2 hours ago</p>
								</li>
							</ul>
							<!-- 이력 더 보기 -->
							<a class="show-more" href="#">View all activity…</a>
						</div>
					</div>
				</li>
				<!-- /이력목록 -->
			
				<!-- Tab2 | 보관목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#" class="archived-tab">Archived</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<div class="tab-content-box-controls">
								<input type="search" placeholder="Search...">
								<button class="switchBtn-archive swhitchCard">Switch to lists</button><!-- 카드목록일 때 출력 -->
								<button class="switchBtn-archive swhitchCardlist">Switch to cards</button><!-- 카드리스트일 때 출력 -->
							</div>
							<div class="nav-tab-content-Box-archive archiveCard"></div> <!-- 동적 카드 태그가 삽입되는 곳 -->
							<div class="nav-tab-content-Box-archive archiveCardlist"></div> <!-- 동적 카드리스트 태그가 삽입되는 곳 -->
						</div>
					</div>
				</li>
				<!-- /Tab2 | 보관목록 -->
			
				<!-- Tab3 | 가리기목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#"  class="trashbox-tab">Trashbox</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<div class="tab-content-box-controls">
								<input type="search" placeholder="Search...">
								<button class="switchBtn-hidden swhitchCard">Switch to lists</button><!-- 카드목록일 때 출력 -->
								<button class="switchBtn-hidden swhitchCardlist">Switch to cards</button><!-- 카드리스트일 때 출력 -->
							</div>
							<div class="nav-tab-content-Box-hidden hiddenCard"></div><!-- 동적 카드 태그가 삽입되는 곳 -->
							<div class="nav-tab-content-Box-hidden hiddenCardlist"></div><!-- 동적 카드리스트 태그가 삽입되는 곳 -->
						</div>
					</div>
				</li>
				<!-- /Tab3 | 가리기목록 -->
			
				<!-- Tab4 | 설정 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#" class="settings-tab">settings</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<!--팀 멤버 프로필 사진-->
			                    <div class="all-members">
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                        <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
			                    </div>
							<!--초대 버튼-->
							<div class="invite">
								<a href="#" class="invite-button"> <span
									class="invite-icon"><i class="fas fa-user-plus"></i></span> <span>invite</span>
								</a>
							</div>
							<!--메뉴-->
							<div class="mainAside-tab4-menu">
								<div class="settingMenu user-modify">
									<a href="http://localhost:9090/user/userModify">회원정보수정</a>
								</div>
								<div class="settingMenu team-modify">
									<a href="http://localhost:9090/main/team">팀 정보 수정</a>
								</div>
								<div class="settingMenu pwd-modify">
									<a href="http://localhost:9090/user/passwordchange">비밀번호변경</a>
								</div>
								<div class="settingMenu boardStatus-modify">
									<a href="#" class="closeBoard">close-board</a>
								</div>
								<div class="settingMenu logout">
									<a href="http://localhost:9090/user/logout" class="logoutBtn">Logout</a>
								</div>
								
								<!-- close board 모달창 -->
								<div class='closeBoardModal'>
									<div class="closeBoardModal-content">
										<div class='closeBoardModal-title'>
											<span class="closeTitle">Close Board?</span>
											<span class="closeModal">&times;</span>
										</div>
										<div class='closeBoardModal-text'>
											<p class="closeBoardModal-text">
												상단바에서 "Boards"메뉴를 클릭하고 "Closed Boards보기"를 선택한 후,
												"Re-open"을 클릭하여 보드를 다시 열 수 있습니다.
											</p>
											<button class="closeBoardBtn" value="OK">close</button>
										</div>
									</div> 
								</div>
								<!-- /close board 모달창  -->
								
							</div>
							<!-- /메뉴 -->
						</div>
					</div>
				</li>
				<!-- /Tab4 | 설정 -->
			</ul>
		</div>
	</aside>
	
	<script>
		
		var i = 0;
		var j = 0;
		var p_id=null;
		var u_id=null;
	
		/* 왼쪽 메인메뉴 | 확장 & 축소 이벤트 */
		function openNav() {
		    var mainNav = document.getElementsByClassName("mainNav"); //확장메뉴
		    var content = document.getElementsByClassName("content"); //본문
		    var iconBar = document.getElementsByClassName("iconBar"); //축소메뉴
		    var logoBg = document.getElementsByClassName("logo-background"); //헤더 로고영역
		    var logoFull = document.getElementsByClassName("logo-full"); //확장로고
		    var logoMini = document.getElementsByClassName("logo-mini"); //축소로고
	
		    i++; //왼쪽 메뉴버튼 클릭할 때마다 i의 값 1씩 증가하도록
	
		    if (i % 2 === 1) { //클릭수가 홀수이면 축소메뉴 노출
		        content[0].style.marginLeft = "60px"; //본문 위치 메뉴너비에 맞춰 옮기기
		        iconBar[0].style.width = "60px"; //메뉴 영역 230px에서 60px로 줄이기
		        logoBg[0].style.width = "60px"; //로고 영역 230px에서 60px로 줄이기
		        mainNav[0].style.width = "0"; //확장메뉴 숨긴다
		        logoFull[0].style.width = "0"; //확장로고 숨긴다
		        logoMini[0].style.width = "60px"; //축소로고 너비 확보
		    }
		    else { //클릭수가 짝수이면 확장메뉴 노출
		        mainNav[0].style.width = "230px"; //확장메뉴 너비 확보
		        content[0].style.marginLeft = "230px"; //본문 위치 메뉴너비에 맞춰 옮기기
		        logoBg[0].style.width = "230px"; //확장시 로고영역 확보
		        logoFull[0].style.width = "230px"; //확장로고 너비 확보
		        logoMini[0].style.width = "0"; //축소로고 숨긴다
		    };
		};
	
	
		
		/* 오른쪽 메인메뉴 | 숨기기 & 펼치기 이벤트 */
		function openAside() {
			var mainAside = document.getElementById('mainAside'); //오른쪽 메뉴 전체
		    var content = document.getElementsByClassName('content'); //본문
		    var tabMenu = document.getElementsByClassName('nav-tabs'); //탭 메뉴
		    
		    j++ //오른쪽 메뉴버튼 클릭할 때마다 j의 값 1씩 증가하도록
	
		    if (j % 2 === 1) { //클릭수가 홀수이면 펼치기
		        mainAside.classList.add('mainAside-open'); //클래스 이름 'mainAside-open' 추가
		        mainAside.style.width = "330px";
		        content[0].style.marginRight = "330px";
		        //활성화된 메뉴가 없다면 첫번째 탭 메뉴를 활성화
		        if (tabMenu[0].dataset.activenumber === undefined) {
		        	tabMenu[0].dataset.activenumber = 0;
		        	tabMenu[0].children[0].classList.add('active');
		        };
		    } else { //클릭수가 짝수이면 숨기기
		        mainAside.classList.remove('mainAside-open'); //클래스 이름 'mainAside-open' 제거
		        mainAside.style.width = "0";
		        content[0].style.marginRight = "0";
		    };
		};

		/* 오른쪽 메인메뉴 | 탭버튼 제어 */
		var tabMenu = document.getElementsByClassName('nav-tabs'); //탭 메뉴
		for(var i = 0; i < tabMenu[0].childElementCount; i++){
			tabMenu[0].children[i].addEventListener("click", function(){
				
				var clickedTabIndex = getElementIndex(this); //클릭한 탭 번호
				var currentTabIndex = this.parentElement.dataset.activenumber; //현재 탭 변호
				
				//클릭한 탭이 현재 활성화 된 탭이 아닌 경우에만 탭의 내용 보여주기
				if(currentTabIndex !== clickedTabIndex){
			        tabMenu[0].children[currentTabIndex].classList.remove('active'); //현재 탭 비활성화
				    this.classList.add('active'); //클릭한 탭 활성화
				    this.parentElement.dataset.activenumber = clickedTabIndex; //클릭한 탭의 번호를 저장
				}
			});
		};
	
		/* 해당 노드의 인덱스 반환 */
		function getElementIndex(node) {
		    var index = 0;
		    while ((node = node.previousElementSibling)) {
		        index++;
		    }
		    return index;
		};
		
		
		
		
		/*
		* 보관/가리기 탭 관련
		*/
		
		
		/* 카드 보관/가리기 조회 | 오른쪽 탭(보관, 가리기)에서 카드 목록 조회 */
	    function readCardStatus(ps_id){
	    	$.ajax({
	    		type : "GET",
				url : "/board/" + p_id + "/cards/" + ps_id,
				success : function(data){
					var str = "";
					
			  		if(ps_id === 2){ //보관카드 조회
			  			for(var i = 0; i < data.length; i++){ //상태값이 2인 데이터들을 돌면서 동적 카드 태그 생성
							str += createArchivedCard(data[i].id, data[i].title);
						};
						$(".nav-tab-content-Box-archive.archiveCard").html(str); //보관탭에 동적 태그 삽입
			  		} else if(ps_id === 3) { //가리기카드 조회
			  			for(var i = 0; i < data.length; i++){ //상태값이 3인 데이터들을 돌면서 동적 카드 태그 생성
							str += createTrashboxCard(data[i].id, data[i].title);
						};
						$(".nav-tab-content-Box-hidden.hiddenCard").html(str); //가리기탭에 동적 태그 삽입
			  		};
				}, //success
				error : function() {
			   		alert("에러가 발생했습니다.");
			   	}
	    	}); //ajax
	    };
	    
	    /* 카드리스트 보관/가리기 조회 | 오른쪽 탭(보관, 가리기)에서 카드리스트 조회 */
		function readCardlistStatus(ps_id){
			$.ajax({
	    		type : "GET",
				url : "/board/" + p_id + "/cardlist/" + ps_id,
				success : function(data){
					var str = "";
					
			  		if(ps_id === 2){ //보관 카드리스트 조회
			  			for(var i = 0; i < data.length; i++){ //상태값이 2인 데이터들을 돌면서 동적 카드리스트 태그 생성
							str += createArchivedCardlist(data[i].id, data[i].title);
						};
						$(".nav-tab-content-Box-archive.archiveCardlist").html(str); //보관탭에 동적 태그 삽입
			  		} else if(ps_id === 3) { //가리기 카드리스트 조회
			  			for(var i = 0; i < data.length; i++){ //상태값이 3인 데이터들을 돌면서 동적 카드리스트 태그 생성
							str += createTrashboxCardlist(data[i].id, data[i].title);
						};
						$(".nav-tab-content-Box-hidden.hiddenCardlist").html(str); //가리기탭에 동적 태그 삽입
			  		};
				}, //success
				error : function() {
			   		alert("에러가 발생했습니다.");
			   	}
	    	}); //ajax
		};
	    
	    
	    /* 카드 보관 조회 | 보관탭을 누를 경우 */
	    $(".archived-tab").click(function(){
	    	readCardStatus(2); //상태값이 2인 카드 목록 조회
	    });
	    /* 카드 가리기 조회 | 가리기탭을 누를 경우 */
	    $(".trashbox-tab").click(function(){
	    	readCardStatus(3); //상태값이 3인 카드 목록 조회
	    });
	    
	    
	    
	    /* 카드리스트 보관 조회 | switch버튼 누를 경우 */
		$(".tab-content-box-controls > .switchBtn-archive").click(function(){
			$(".tab-content-box-controls > .switchBtn-archive").toggle();
			$(".nav-tab-content-Box-archive.archiveCard").toggle();
			
			readCardlistStatus(2); //상태값이 2인 카드리스트 조회
		});
		/* 카드리스트 가리기 조회 | switch버튼 누를 경우 */
		$(".tab-content-box-controls > .switchBtn-hidden").click(function(){
			$(".tab-content-box-controls > .switchBtn-hidden").toggle();
			$(".nav-tab-content-Box-hidden.hiddenCard").toggle();
			
			readCardlistStatus(3); //상태값이 3인 카드리스트 조회
		});
		
		
		
		/* 카드리스트/카드 보관/가리기 수정 | 탭에서 send to...버튼 or Trashbox버튼 누를 경우 */
		$(".tab-content-box").on("click", ".return", function(){
			var ps_id;
			var STATUS_ING = 1; //진행
	    	var STATUS_HIDDEN = 3; //가리기
	    	var className = $(this).attr("class"); //클릭한 요소의 class이름
	    	var id = $(this).parent().prev().attr("data-id");
	    	var title = $(this).parent().prev().children(":first").text();
	    	
	    	switch (className) {
	            case "archive-reopen switchBtn-archive return returnCard": //카드의 send to 
	            	ps_id = STATUS_ING; //ps_id = 1
	            	cardStatusChange(id, ps_id, title);
	                break;
	            case "archive-hidden switchBtn-archive return returnCard": //카드의 Trashbox
	            	if(confirm("Trashbox로 보내진 카드는 되돌릴 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
		    			ps_id = STATUS_HIDDEN; //ps_id = 3
	            	cardStatusChange(id, ps_id, title);
	            	break;
	            case "archive-reopen switchBtn-archive return returnCardlist": //카드리스트의 send to 
	            	ps_id = STATUS_ING; //ps_id = 1
		            cardlistStatusChange(id, ps_id, title);
	                break;
	            case "archive-hidden switchBtn-archive return returnCardlist": //카드리스트의 Trashbox
		            if(confirm("Trashbox로 보내진 카드리스트는 되돌릴 수 없습니다. \n소속된 카드도 함께 이동되며 더이상 조회할 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
		            	ps_id = STATUS_HIDDEN; //ps_id = 3
		            cardlistStatusChange(id, ps_id, title);
	            	break;
    		};
	    	cardStatusChange(id, ps_id, title); //상태변경에 대한 ajax처리 함수 호출
		});
		
		
		
		
		/*
		* board close 관련
		*/
		
		/***************************************************************************************
			< 수정사항 > 
			1. board를 close하면 설정탭에서 close-board 메뉴 사라져야 함(중복클릭 문제)
				-> 오른쪽 메인메뉴 분리할 예정이므로 메뉴 정리 되면 고치기(-)
		
		***************************************************************************************/
		
		
		/* board close | 모달창 열기 */
		$(".closeBoard").on("click",function(){
			//logout버튼의 왼쪽 상단에서 모달창 열기 위해 logout버튼의 좌표값 구함
			var boardModalX = $(".logoutBtn").position().left; //Logout버튼의 x좌표
			var boardModalY = $(".logoutBtn").position().top; //Logout버튼의 y좌표
			
			//모달창 위치 지정
			$(".closeBoardModal").css({
				"left" : boardModalX,
				"top" : boardModalY
			});
			$(".closeBoardModal").addClass("is-visible"); //모달창 열기
		});
				
		/* board close | 모달창 이외의 영역을 클릭하면 모달창 닫기 */
		$(document).on("click", function(e){
			var className = $(e.target).attr("class"); //클릭한 요소의 class이름
			
			//클릭한 요소가 모달창이 아니면 class이름 is-visible을 제거함으로써 모달창 숨기기
			if(className !== "closeBoardModal is-visible" && className !== "closeBoard" 
					&& className !== "closeTitle" && className !== "closeBoardModal-text")
				$(".closeBoardModal").removeClass("is-visible"); 
		});
		
		
		
		/* board close | 상태 2 - close화면에 대한 동적 태그 생성/삽입 */
		function closeBoardStr(){
			var closeBoardStr = "<div class='content'>" +
								"	<div class='closeBoardMessage'>" +
								"		<div class='closeBoardTitle'>${p_title} is closed.</div>" +
	  							"		<p class='boardReopen' onclick='closeBoard(1);'>Re-Open</p>" +
  		    					"		<p class='boardDelete' onclick='closeBoard(3);'>Permanently Delete Board…</p>" +
  		    					"	</div>" +
  		    					"</div>";
  		    //카드리스트 목록이 있는 content의 클래스이름을 hiddenContent로 바꿈으로써 화면에서 숨김(hiddenContent의 display속성: none)
  		    $(".content").removeClass("content").addClass("hiddenContent");
  		    $(".hiddenContent").before(closeBoardStr); //동적 태그 삽입
		};
		
		/* board close | 상태 3 - delete화면에 대한 동적 태그 생성/삽입 */
		function deleteBoardStr(){
			var deleteBoardStr = "<div class='deleteBoardMessage'>" +
								 "    <div class='deleteBoardTitle'>Board not found.</div>" +
								 "	  <p>This board may be private. If someone gave you this link, they may need to invite you to one of their boards or teams.</p>" +
								 "</div>";
			$(".content").html(deleteBoardStr); //.content를 비우고 Board not found 띄움
			$(".hiddenContent").remove(); //카드리스트 목록이 있는 hiddenContent는 완전 삭제
		};
		
		
		
		/* board close | ajax처리 */
	    function closeBoard(ps_id){
			//완전 숨기기는 복구 불가 경고창 띄움
			if(ps_id === 3){
				if(confirm("모든 카드리스트와 카드가 함께 삭제됩니다. \n삭제된 보드는 복구가 불가능합니다. \n그래도 삭제하시겠습니까?") !== true)
					return; //취소를 누를 경우 ajax처리로 넘어가지 않고 return
			};

	    	$.ajax({
	    		type : "put",
	    		url : "/main/" + p_id + "/" + u_id,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},	
	    		data : JSON.stringify({ps_id : ps_id}),
	    		dataType : "text", 
	    		success : function(result) {
	    			if(result === "SUCCESS"){	    				
	    				switch (ps_id) {
				            case 1: //상태값을 1(진행)로 변경했으면  카드리스트출력
				            	$(".content").remove(); //.content(board close화면의 클래스이름)를 삭제하고
		    					$(".hiddenContent").removeClass("hiddenContent").addClass("content"); //카드리스트가 있는 .hiddenContent의 클래스이름을 content로 바꾼 뒤
		    					$(".cardlist.addCardlist").prevAll().remove(); //Add a list...버튼 앞의 카드리스트를 모두 삭제(삭제 하지 않으면 중복 문제 발생)
		    					allCardlist(); //카드리스트&카드 목록 조회하는 함수 호출
				                break;
				            case 2: //상태값을 2(가리기)로 변경했으면 board close 화면 띄우는 함수 호출
				            	closeBoardStr();
				            	break;
				            case 3: //상태값을 3(완전 숨기기)로 변경했으면 
				            	deleteBoardStr();
				                break;
		    			};
	    			};//if
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
	    };
	    
	    
	    /* board close | 모달창에서 확인버튼을 누를 경우 */
	    $(".closeBoardBtn").click(function(){
	    	closeBoard(2); //프로젝트 상태변경 ajax 함수를 호출하여 프로젝트 상태값을 2로 변경하고 board close화면 출력
	    });
	    		
		//모달창 띄우기
		$(".project-list").on("click",function(){	
			$('.list-modal').addClass('is-visible');		
			
			$.ajax({
				type:"GET",
				url:"/main/projectlist",
				success : function(data){
					if(data != null){
					console.log(data);
					$('.content-list').html("");
					for(var i = 0; i < data.length ; i++){
					var str ="<div class='list-li'><a href='http://localhost:9090/board/"
					+data[i].t_id+
					"/"
					+data[i].id+"'>"
					+data[i].title+"</a>"
					+"<button class='preload' p='"+data[i].id+"' u='"+data[i].u_id+"' t='"+data[i].t_id+"'>re-load</button>"
					+"<button class='pdelete' p='"+data[i].id+"' u='"+data[i].u_id+"'>delete</button></div>"
					$('.content-list').append(str);
					}
				
					}
					
				},
				error : function(){
					alert("통신의 오류가 발생했습니다.");
				}
			});   
		})
		//모달창 닫기
		$(".list-modal").on("click",function(e){
			if($(e.target).hasClass("list-modal")){
				$(".list-modal").removeClass("is-visible");		
			}
		})
		
		 $('.content-list').on("click",".preload",function(){
			u_id = $(this).attr("u");
			p_id = $(this).attr("p");
			var ps_id = 1;
			var parent = $(this).parent();

		    	$.ajax({
		    		type : "put",
		    		url : "/main/" + p_id + "/" + u_id,
		    		headers : {
		    			"Content-Type" : "application/json",
		    			"X-HTTP-Method-Override" : "PUT"
		    		},	
		    		data : JSON.stringify({ps_id : ps_id}),
		    		dataType : "text", 
		    		success : function(result) {
		    			if(result === "SUCCESS"){	
		    				if(ps_id == 1){
		    				
		    					parent.html("");
		    				}
		    			};//if
		    		},
		    		error : function() {
		    			alert("에러가 발생했습니다.");
		    		}
		    	});//ajax
		});
		
		$('.content-list').on("click",".pdelete",function(){
			u_id = $(this).attr("u");
			p_id = $(this).attr("p");
			ps_id = 3;
			var parent = $(this).parent();
			
			if(confirm("모든 카드리스트와 카드가 함께 삭제됩니다. \n삭제된 보드는 복구가 불가능합니다. \n그래도 삭제하시겠습니까?") !== true){
				return; //취소를 누를 경우 ajax처리로 넘어가지 않고 return				
			}
			
			$.ajax({
	    		type : "put",
	    		url : "/main/" + p_id + "/" + u_id,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},	
	    		data : JSON.stringify({ps_id : ps_id}),
	    		dataType : "text", 
	    		success : function(result) {
	    			if(result === "SUCCESS"){	
	    				if(ps_id == 3){
	    					parent.html("");
	    				}
	    			};//if
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
		});
	</script>
</body>
</html>