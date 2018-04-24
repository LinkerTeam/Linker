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
<link href="/resources/css/cards/cardShowMenu.css?ver=111" type="text/css" rel="stylesheet" />
</head>

<body>
	<span class="showMenu-button" style="cursor:pointer" onclick="openAside()">메뉴보기</span>
	<!-- 오른쪽 메뉴 -->
	<!-- .boardAside-open | 열림 상태 -->
	<aside id="boardAside" class="boardAside">
		<div class="nav-tabs-wrap">
			<ul class="nav-tabs">
				<!-- .active | 탭 메뉴 활성화 상태 -->
				<!-- Tab1 | 이력목록 -->
				<li>
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
							        <input type="search" value="" placeholder="Search" class="tab-search-input">
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
									<button class="switchBtn-hidden swhitchCard">카드리스트 보관함으로</button><!-- 카드목록일 때 출력 -->
									<span class="tab-trashbox-title-cardlist">카드리스트 휴지통</span>
									<button class="switchBtn-hidden swhitchCardlist">카드 보관함으로</button><!-- 카드리스트일 때 출력 -->
								</div>
								<form class="tab-search-form">
							        <input type="search" value="" placeholder="Search" class="tab-search-input">
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
	
	
	<script>

	
		var i = 0;
		var j = 0;
		var p_id = null;
		var u_id = null;
		
		
		/* 오른쪽 메인메뉴 | 숨기기 & 펼치기 이벤트 */
		function openAside() {
			var boardAside = document.getElementById('boardAside'); //오른쪽 메뉴 전체
		    var content = document.getElementsByClassName('cardlists'); //카드리스트가 출력되는 전체부분
		    var tabMenu = document.getElementsByClassName('nav-tabs'); //탭 메뉴
		    
		    j++ //오른쪽 메뉴버튼 클릭할 때마다 j의 값 1씩 증가하도록
	
		    if (j % 2 === 1) { //클릭수가 홀수이면 펼치기
		        boardAside.classList.add('boardAside-open'); //클래스 이름 'boardAside-open' 추가
		        boardAside.style.width = "330px";
		        content[0].style.marginRight = "330px";
		        //활성화된 메뉴가 없다면 첫번째 탭 메뉴를 활성화
		        if (tabMenu[0].dataset.activenumber === undefined) {
		        	tabMenu[0].dataset.activenumber = 0;
		        	tabMenu[0].children[0].classList.add('active');
		        };
		    } else { //클릭수가 짝수이면 숨기기
		        boardAside.classList.remove('boardAside-open'); //클래스 이름 'boardAside-open' 제거
		        boardAside.style.width = "0";
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
		
		
		
		/* 보관/trashbox탭 | 검색창 blur되면 value값 초기화 */
	    $(".tab-search-input").on("blur", function(){
	    	$(this).val("");
	    });
		
		
		
		/* 카드 보관/가리기 조회 | 오른쪽 탭(보관, 가리기)에서 카드 목록 조회 */
	    function readCardStatus(ps_id){
	    	$.ajax({
	    		type : "GET",
				url : "/board/" + p_id + "/cards/" + ps_id,
				success : function(data){
					var str = "";
					
			  		if(ps_id === 2){ //보관카드 조회
			  			for(var i = 0; i < data.length; i++){ //상태값이 2인 데이터들을 돌면서 동적 카드 태그 생성
							str += createArchivedCard(data[i].id, data[i].cl_id, data[i].title);
						};
						$(".nav-tab-content-Box-archive.archiveCard").html(str); //보관탭에 동적 태그 삽입
			  		} else if(ps_id === 3) { //가리기카드 조회
			  			for(var i = 0; i < data.length; i++){ //상태값이 3인 데이터들을 돌면서 동적 카드 태그 생성
							str += createTrashboxCard(data[i].id, data[i].cl_id, data[i].title);
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
		$(".tab-archive-title > .switchBtn-archive").click(function(){
			$(".tab-archive-title > .switchBtn-archive").toggle();
			$(".tab-archive-title-card").toggle();
			$(".tab-archive-title-cardlist").toggle();
			$(".nav-tab-content-Box-archive.archiveCard").toggle();
			$(".nav-tab-content-Box-archive.archiveCardlist").toggle();
			
			readCardlistStatus(2); //상태값이 2인 카드리스트 조회
		});
		/* 카드리스트 휴지통 조회 | switch버튼 누를 경우 */
		$(".tab-trashbox-title > .switchBtn-hidden").click(function(){
			$(".tab-trashbox-title > .switchBtn-hidden").toggle();
			$(".tab-trashbox-title-card").toggle();
			$(".tab-trashbox-title-cardlist").toggle();
			$(".nav-tab-content-Box-hidden.hiddenCard").toggle();
			$(".nav-tab-content-Box-hidden.hiddenCardlist").toggle();
			
			readCardlistStatus(3); //상태값이 3인 카드리스트 조회
		});
		
		
		
		/* 카드리스트/카드 보관/가리기 수정 | 탭에서 send to...버튼 or Trashbox버튼 누를 경우 */
		$(".tab-content-box").on("click", ".return", function(){
			var ps_id;
			var STATUS_ING = 1; //진행
	    	var STATUS_HIDDEN = 3; //가리기
	    	var className = $(this).attr("class"); //클릭한 요소의 class이름
	    	var id = $(this).parent().prev().attr("data-id"); //카드 아이디
	    	var title = $(this).parent().prev().children(":first").text();
	    	var cl_id = $(this).parent().prev().attr("data-clId"); //선택한 카드의 카드리스트 id
	    	console.log(cl_id);
	    	
	    	switch (className) {
	            case "archive-reopen switchBtn-archive return returnCard": //카드의 send to 
	            	ps_id = STATUS_ING; //ps_id = 1
	            	cardStatusChange(id, ps_id, cl_id, title);
	                break;
	            case "archive-hidden switchBtn-archive return returnCard": //카드의 Trashbox
	            	if(confirm("휴지통으로 보내진 카드는 되돌릴 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
		    			ps_id = STATUS_HIDDEN; //ps_id = 3
	            	cardStatusChange(id, ps_id, cl_id, title);
	            	break;
	            case "archive-reopen switchBtn-archive return returnCardlist": //카드리스트의 send to 
	            	ps_id = STATUS_ING; //ps_id = 1
		            cardlistStatusChange(id, ps_id, title);
	                break;
	            case "archive-hidden switchBtn-archive return returnCardlist": //카드리스트의 Trashbox
		            if(confirm("휴지통으로 보내진 카드리스트는 되돌릴 수 없습니다. \n소속된 카드도 함께 이동되며 더이상 조회할 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
		            	ps_id = STATUS_HIDDEN; //ps_id = 3
		            cardlistStatusChange(id, ps_id, title);
	            	break;
			};
	    	cardStatusChange(id, ps_id, cl_id, title); //상태변경에 대한 ajax처리 함수 호출
		});
		
		
		
		
		/*
		* board close 관련
		*/
		
		
		
		/* board close | 모달창 열기 */
		$(".closeBoard").on("click",function(){
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
								"		<div class='closeBoardTitle'>이 프로젝트는 종료되었습니다.</div>" +
	  							"		<p class='boardReopen' onclick='closeBoard(1);'>다시 열기</p><br/>" +
			    				"		<p class='boardDelete' onclick='closeBoard(3);'>삭제하기</p>" +
								"	</div>" +
								"</div>";
			//카드리스트 목록이 있는 content의 클래스이름을 hiddenContent로 바꿈으로써 화면에서 숨김(hiddenContent의 display속성: none)
			$(".content").removeClass("content").addClass("hiddenContent");
			$(".hiddenContent").before(closeBoardStr); //동적 태그 삽입
		};
		
		/* board close | 상태 3 - delete화면에 대한 동적 태그 생성/삽입 */
		function deleteBoardStr(){
			var deleteBoardStr = "<div class='deleteBoardMessage'>" +
								 "    <div class='deleteBoardTitle'>프로젝트가 영구적으로 삭제되었습니다.</div>" +
								 "	  <p>이 프로젝트는 다시 열 수 없고 종료된 프로젝트 목록에서도 삭제됩니다.</p>" +
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
	    
	    
	</script>
	
</body>

</html>