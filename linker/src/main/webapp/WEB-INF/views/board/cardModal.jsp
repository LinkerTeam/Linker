<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- CSS -->
<link href="/resources/css/cards/cardModal.css?ver=1111" type="text/css" rel="stylesheet" />
</head>

<body>
	<div id="popupBox">
        <div class="popupCard">
        	<!-- 카드의 상태값이 보관/가리기일 때 상단bar-->
        	<div class="popCard-banner archive"><p><i class="fas fa-archive"></i> 이 카드는 보관함에 있습니다. 수정이 불가능합니다.</p></div>
        	<div class="popCard-banner hide"><p><i class="fas fa-archive"></i> 이 카드는 휴지통에 있습니다. 조회만 가능합니다.</p></div>
            <!-- 헤더 | 카드 제목 -->
            <header class="cardTitle">
                <span><i class="far fa-credit-card"></i></span>          
                <div class="title-cardTitle">
                	<!--카드 제목 DB에서 가져옴-->
                	<input type="text" class="title-modify" maxlength="20"  onkeydown="enterPress(event); limitMemo(this, 20);"/>
                	<!-- 카드모달 닫기 버튼 -->
            		<div class="popupCardClose">&times;</div>
                	<!-- id값(hidden) -->
                	<p class="card-id-Hidden"></p>
                </div>
                <div class="popupCardUserInfo">
                	<div class="popupCardProfile"></div>
                	<p class="popupCardUserNickname"></p>
                	<p class="popupCardCdate"></p>
                </div>
                <!-- 카드모달 드롭다운 메뉴 -->
                <div class="popCardMenu">
                	<img class="popCardMenuIcon" src="https://s5.postimg.cc/qx0hjoxmv/588a64e7d06f6719692a2d11.png">
                </div>
            </header>

            <!-- 왼쪽 | 카드 실제 내용 부분-->
            <section>
                <!-- 내용 -->
                <article>
                    <div class="cardContent">
                        <div class="title-content title">
                            <i class="fas fa-align-left"></i><strong>본문</strong>
                        </div>
                        <div class="content-content">
                            <textarea class="content-textarea description" placeholder="본문 추가하기"></textarea>
                            <div class="readMore-box"><button class="readMore">read more</button></div>
                        </div>
                        <div class="content-Btn">
                            <button class="saveBtn description">저장</button>
                            <button class="cancelBtn" onclick="modifyDescriptionCancel()">&times;</button>
                        	<span class="countByte">0</span><p>/10,000byte<p>
                        </div>
                         <div class="warning">
                            <ul class="warningUL">
 	                            <li>저장하지 않은 내용입니다.</li>
                                <li class="viewEdits">편집</li>
                                <li class="saveBtn description">저장</li>
                                <li class="discard" onclick="modifyDescriptionCancel()">삭제</li>
                            </ul>
                        </div>
                        <div class="countByte-warning"><p>제한된 글자수를 넘어 저장할 수 없습니다.</p></div>
                    </div>
                </article>

                <!-- 첨부파일 -->
                <%@include file="cardAttach.jsp"%>
                <!-- 댓글작성 -->
                <article>
                    <div class="comment">
                        <div class="title-comment title">
                            <i class="far fa-comment"></i><strong>댓글작성</strong>
                        </div>
                        <div class="comment-content">
                            <textarea class="content-textarea reply create" placeholder="댓글 작성하기"></textarea>
	                        <div class="comment-Btn">
	                        	<button class="saveBtn reply create">저장</button>
	                        	<button class="cancelBtn" onclick="modifyReplyCancel()">&times;</button>
	                        </div>
                        </div>
                    </div>
                </article>
                <!-- 댓글목록 & 이력 -->
                <article>
                    <div class="activity">
                        <div class="title-activity title">
                            <i class="fas fa-list-ul"></i><strong>댓글목록</strong>
                        </div>
                        <div class="activity-content"></div>
                    </div>
                    <!-- 댓글 삭제 모달창 -->
					<div class="closeBoardModal reply">
						<div class="closeBoardModal-content reply">
							<div class="closeBoardModal-title reply">
								<span class="closeTitle reply">Delete comment?</span>
								<span class="closeModal reply">&times;</span>
							</div>
							<div class="closeBoardModal-text reply">
								<p class="closeBoardModal-text reply">
									삭제한 댓글은 되돌릴 수 없습니다. 정말 삭제하시겠습니까?
								</p>
								<button class="closeBoardBtn reply" value="OK">삭제</button>
							</div>
						</div> 
					</div>
					<!-- /close board 모달창  -->
                </article>
            </section>


            <!-- 오른쪽 | 사이드메뉴 -->
            <aside class="popupCard-aside">
                <div><strong>Menu</strong></div>
                <span class="closeModal dropdown">&times;</span>
                <ul>
                    <li><div class="popupCard-aside-archive"><i class="fas fa-archive"></i><p>보관함으로</p></div></li>
                    <li><div class="popupCard-aside-hide"><i class="fas fa-trash-alt"></i><p>휴지통으로</p></div></li>
                    <li><div class="popupCard-aside-sendToCardlist"><i class="fas fa-undo-alt"></i><p>보드로</p></div></li>
                </ul>
            </aside>
        </div>
    </div>
    <div id="#imgModal">
    	<div class="imgModal"></div>
	    <span class="closeModal imageModal">&times;</span>
    </div>
    
    <script>
	    /**
	     * 
	     */
	
	    /**************************************************************************************************************
	    	<해결할 것>
	    	2. 모달 밖 클릭했을 때 모달 닫기 (-)
	    		2-1. 카드내용에 수정사항이 있고, 저장하지 않았을 경우에 
	    			다시 카드를 띄우면 수정사항이 출력되고 저장하지 않았다는 경고메시지 출력
	    			(지금은 껐다 키면 DB내용이 들어가있고 수정사항은 사라짐.) (-)
	    			+) close버튼에도 적용할 것. (-)
	    	7. 코드정리 (-)
	    	9. 주석달기 (-)
	    	10. 변수이름 정리 (-)
	    	12. 창 줄였을 때 카드모달창 사이즈 조절 문제(-)
	    	13. enter키 눌렀을 때 저장되기 - 카드리스트제목(+)카드제목(+)카드제목수정모달(-)카드모달내용(-)
	    	17. jQuery, javascript 뒤섞인 것 최대한 정리(-)
	    	19. 리스트에서 화면 마우스로 클릭하고 움직이면 스크롤 따라오게 (-)
	    	20. 카드리스트 보관/숨기기 모달창 띄우고 스크롤할 때 모달창만 둥둥 뜨는 문제(-)
	    	23. 보관카드 - 내용 없으면 placeholder 뜬 채로 수정 불가인데 placeholder없애? (-)
				< 4월 19일 목요일 테스트 후 발견된 오류 29-37 >
			34. textarea drag & drop 해서 20글자 넘은상태에서 경고창을 안 띄움. 20자 count도 다시 손봐야 한다(byte계산)(-)
				< 강사님 피드백 38-45 >
			50. 댓글 textarea 스크롤 문제(-)
			52. 첨부파일 경고창 소스 중복 정리(-) (관리자 페이지부터 하고 나중에 고칠 것)
			53. 
	    **************************************************************************************************************
	    	<해결한 것>
	    	1. 카드모달 닫을 때 새로고침 되지 않게 (+)
	    		2-2. 카드 제목을 수정하고 textarea focus를 둔 상태에서 모달 바깥을 눌러 창을 끄면 
	    			DB에는 바뀐 제목으로 저장이 되는데 목록에서는 예전제목으로 보임.(새로고침이 안됨.) (+)
	    	3. 화면 클릭할 때마다 계속 data 로드하는 문제 (+)
	    	4. 프론트 (+)
	    	5. 보관, 가리기 (+)
	    	6. 스크롤 문제 (+)
	    	8. 제목 20자 이하 입력하도록 처리 (+)
	    	11. 창 줄였을 때 헤더 아이콘, 검색창 내려오는 문제(+)
	    	14. 조회 ajax for문 수정(+)
	    	15. ajax error처리(+)
	    	16. 연산자 띄어쓰기 정리(+)
	    	18. 카드리스트와 통합하여 기능확인, 정리하기(+)
	    	20. 카드리스트 height조절(+)
	    	21. 가리기 경고창(+)
	    	22. 카드리스트 추가시 가끔 스크롤이 끝으로 이동 안 하고 맨앞으로 튕김(+) -> ?
	    	24. 프로젝트 title 읽어오기, 수정 이벤트(+)
	    	25. 클릭한 왼쪽메인메뉴 활성화 표시(+) -> 기능상 필요 없어서 왼쪽 메뉴 없앰
	    	26. board를 close하면 설정탭에서 close-board 메뉴 사라져야 함(중복클릭 문제)
				-> 오른쪽 메인메뉴 분리할 예정이므로 메뉴 정리 되면 고치기(+) -> 메뉴 분리해서 저절로 해결됨
			27. jpeg는 thumbnail 파일이 안 생김. (+) -> S3 하면서 해결됨
			28. 작은 로고 정리(+)
			29. 카드 모달창에 cdate가 년월일까지만 표시되는 문제(+)
			30. title 수정 선택했을 때 바탕 흰색으로, 수정 창이라는 것을 표시해주기(+)
			31. 카드 안의 text나 img를 끌어다 drop했을 때 파일 첨부하는 함수 호출됨, 종종 경고창 안 사라짐(+)
			32. 프로젝트 title 유효성검사(+)
			33. 댓글 빈값 못들어가게(+) -> $.trim() 활용
			35. 내용textarea 스크롤문제(+) -> 스크롤이벤트를 keydown에서 input으로 바꿈
			36. 첨부파일에 대한 유효성 검사(+)
			37. 버튼 중복클릭 문제? (-) -> 중복클릭되는 버튼이 없음
			38. img첨부파일 원본 파일 확인 모달창에 X버튼 없애기 or 버튼을 파일명 아래로 내리기 - 모든 모달창 확인(-)
				-> 이미지가 작으면 이렇게 하는 게 나을지 몰라도 이미지가 클 경우 더 불편해짐. 수정 안 하기로.
			39. 글씨 크기 키우기(+)
			40. 카드 X 크게(+)
			41. 한 카드에 대한 첨부파일 크기 제한(+) -> 50MB
			42. 카드 모달창 멤버 메뉴 정리(+) -> 필요 없어서 없애버림. 필요하면 추후 보드 메뉴-설정에서 팀 목록 띄우든지 할 것임.
			43. 오른쪽 보관/trashbox탭 title 정리(-) -> 검색창? (+)
			44. board 화면 가로 스크롤 말고 페이징으로 처리? -> 페이징 처리보다 스크롤 방식이 효율적일 것으로 생각, 수정X
			45. 첨부파일 레이아웃 변경(+) -> 한줄에 2개씩 6개까지만 출력되도록 함. 더보기/접기 버튼 추가함
			46. 전체 테마 색 변경(+)
			47. 오른쪽 side Medu 정리(+)
			48. 카드모달 메뉴 dropdown으로 변경(+) 
				-> 이거 수정하다가 4월 23일 새벽 5시 카드/카드리스트 상태변경에 대한 중대한 오류 발견해서 수정함(블로그에 포스팅함)
			49. 영어를 한글로(+)
			51. 카드모달 내용 textarea 유효성 검사(+) 글자수, 빈값
	    **************************************************************************************************************/	    

	    var ATTACHLISTNUM = 6; //기본 첨부파일 리스트 개수
		var ONECARDATTACHLISTBYTE = 52428800; //한 카드에 첨부할 수 있는 총 용량 : 50MB
		var DESCRIPTIONBYTE = 10000; //내용 byte 제한
	
	    var cardModal = document.getElementById("popupBox"); //전체 모달창 객체
	    var popCardTitle = document.getElementsByClassName("title-modify")[0]; //제목input태그
	    var cancelBtn = document.getElementsByClassName("cancelBtn")[0]; //내용 수정 취소버튼
	    var viewEdits = document.getElementsByClassName("viewEdits")[0]; //내용 저장하지 않았을 때 뜨는 view Edits
	    var discard = document.getElementsByClassName("discard")[0]; //내용 저장하지 않았을 때 뜨는 discard
	    var contentTextarea = document.getElementsByClassName("content-textarea"); //내용[0]/댓글[1] textarea
	    
		var popCardId; //카드 상세내용 조회할 때 클릭한 카드id값을 담을 변수
		var popCardlistId; //카드 상세내용 조회할 때 클릭한 카드의 카드리스트 id값을 담을 변수
		var popCardPsId; //카드 상세내용 조회할 때 클릭한 카드의 ps_id값을 담을 변수
		var popCardContent; //카드 상세내용 조회할 때 클릭한 카드 내용을 담을 변수
		var popCardAttachAllByte = 0; //한 카드에 대한 모든 첨부파일 용량(byte)
			
		var deleteReplyId; //ajax처리를 위한 댓글의 id

		var attachCount = ATTACHLISTNUM; //불러올 첨부파일 개수
		
		

		
		
		/* 카드 상태값에 따라 카드모달창 출력이 달라짐 */
		/*
			1(진행) : 
				1. 카드 상단에 상태바 가리기
				2. 카드모달창 padding 초기화
				3. 보관버튼, 가리기버튼 출력
				4. send to cardlist메뉴 가리기
			2(보관) :  
				1. 카드 상단에 상태바 archive 출력
				2. 카드모달창 padding 조절
				3. 보관버튼 숨기기, 가리기버튼 출력
				4. send to cardlist 출력
			3(가리기) :
				1. 카드 상단에 상태바 hidding 출력
				2. 카드모달창 padding 조절
				3. 보관버튼, 가리기버튼 숨기기
				4. send to cardlist 숨기기
			
			script :
				1이 아니면 클래스 이름 changeStatus 부여하여 속성 제어
				
			CSS :
				.changeStatus{ display: block; }
				.popupCard-aside-archive.changeStatus,
				.popupCard-aside-hide.changeStatus{ display: none; }
		*/
		/* 카드 상태값에 따라 다른 형태의 카드모달창 출력 */
		function cardStatus(ps_id){
			switch (ps_id) {
            case 1: //진행일 때 
            	$(".changeStatus").removeClass("changeStatus"); //관련된 모든 클래스 이름에서 changeStatus 제거하여 CSS 속성 초기화
            	
            	$(".title-modify").prop("disabled", false); //제목 수정 할 수 있게
            	$(".content-textarea").prop("disabled", false); //내용 수정 할 수 있게
            	$(".attach-content").show(); //첨부파일 추가 영역 출력
                break;
            case 2: //보관일 때
            	$(".changeStatus").removeClass("changeStatus"); //관련된 모든 클래스 이름에서 changeStatus 제거하여 CSS 속성 초기화
            	$(".popCard-banner.archive").addClass("changeStatus"); //1. 카드 상단에 상태바 archive 출력
            	$(".popupCard").addClass("changeStatus");//2. 카드모달창 padding 조절
            	$(".popupCard-aside-archive").addClass("changeStatus"); //3. 보관버튼 숨기기
            	$(".popupCard-aside-hide").removeClass("changeStatus"); //3. 가리기버튼 출력
            	$(".popupCard-aside-sendToCardlist").addClass("changeStatus"); //4. send to cardlist메뉴 출력
            	
            	$(".title-modify").prop("disabled", true); //제목 수정 못하게
            	$(".content-textarea").prop("disabled", true); //내용 수정 못하게
            	$(".attach-content").hide(); //첨부파일 추가 영역 숨기기
            	break;
            case 3: //가리기일 때
            	$(".changeStatus").removeClass("changeStatus"); //관련된 모든 클래스 이름에서 changeStatus 제거하여 CSS 속성 초기화
            	$(".popCard-banner.hide").addClass("changeStatus"); //1. 카드 상단에 상태바 hide 출력
            	$(".popupCard").addClass("changeStatus");//2. 카드모달창 padding 조절
            	$(".popupCard-aside-archive").addClass("changeStatus"); //3. 보관버튼 숨기기
            	$(".popupCard-aside-hide").addClass("changeStatus"); //3. 가리기버튼 숨기기
            	$(".popupCard-aside-sendToCardlist").removeClass("changeStatus"); //4. send to cardlist메뉴 숨기기
            	
            	$(".title-modify").prop("disabled", true); //제목 수정 못하게
            	$(".content-textarea").prop("disabled", true); //내용 수정 못하게
            	$(".attach-content").hide(); //첨부파일 추가 영역 숨기기
                break;
    		};
		};
		
		
		
		/* 카드 상세내용 조회 */
	    function loadCardData(obj) {
	       	popCardId = obj.getAttribute("data-id"); //클릭한 카드의 id값을 가져와서 var id에 담음.
	       	
	       	modifyCardTitle = $(obj).children().eq(0); //클릭한 카드의 title표시하는 div를 전역변수에 담아둠(제목 수정 처리에 이용할 예정)
	    	
	    	$.getJSON("/board/" + p_id + "/card/" + popCardId, function(data){
	    		popCardPsId = data.ps_id; //클릭한 카드의 ps_id값 전역변수에 담아두기 	
	    		popCardlistId = data.cl_id; //클릭한 카드의 카드리스트 id값 전역변수에 담아두기(send to board에 쓸 예정)
	    		
	    		//DB에서 카드 id, 내용 가져오기(id는 화면에 표시하지 않는다.)
	    		$(".card-id-Hidden").eq(0).html(data.id);
	    		$(".title-cardTitle input").val(data.title);//카드제목 수정input태그에 'value'값으로 넣는다
	    			//.html로 담았다가 7시간 삽질함.
	    		$(".popupCardProfile").html("<img src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate" + data.profile + "'/>"); //작성자의 프로필
	    		$(".popupCardUserNickname").text(data.nickname); //작성자의 닉네임
	    		
	    		var checkCdate = data.cdate.lastIndexOf(":"); //시, 분, 초 중 초를 자르기 위해 뒤에서부터 :를 찾아 인덱스 반환
	    		var cdate = data.cdate.substring(0, checkCdate); //문자열의 시작부터 index번째의 문자만 자름
	    		$(".popupCardCdate").text(cdate); //카드 생성 날짜
	    		
	    		$(contentTextarea[0]).val($.trim(data.content)); //내용 textarea에 공백을 없애고 DB내용 담기
	    		//내용textarea 높이 조절
	    		contentTextarea[0].style.height = "1px";
	    	    contentTextarea[0].style.height = (contentTextarea[0].scrollHeight) + "px";
	    	    if(contentTextarea[0].scrollHeight > 280) { //스크롤 높이가 280 초과면
	    	    	$(contentTextarea[0]).css("height", "280px"); //280px로 고정
	    	    	$(".readMore-box").show(); //read more버튼 출력
	    	    } else {
	    	    	$(".readMore-box").hide(); //read more버튼 숨기기
	    	    };
	    		popCardContent = data.content; //전역변수에 클릭한 카드의 내용을 담아둠
	    		$(".warning").hide();
	    	    
		    	cardStatus(data.ps_id); //카드 상태값에 따라 진행, 보관, 휴지통 구별하여 각각 다른 형태의 카드모달창 출력
	    	});//JSON
	    	
	    	allReply(); //모든 댓글 getJSON으로 받아오는 함수
	    	attachCount = ATTACHLISTNUM; //기본 첨부파일 로드 개수 6개
	    	allAttach(); //모든 첨부파일 getJSON으로 받아오는 함수
	    	cardModal.style.display = "block"; //모달창 띄우기
	    };
	    
	    
	    /* 내용 조회 | read more버튼을 클릭했을 경우 */
	    $(".readMore").click(function() {
	    	//content의 text길이만큼 textarea의 height값 주기
    	    contentTextarea[0].style.height = "1px";
    	    contentTextarea[0].style.height = (contentTextarea[0].scrollHeight) + "px";
    	    
    	    $(".readMore-box").hide(); 
	    });
	    
	    
	
	    /* //모달창 밖 클릭하면 모달창 사라짐
	    window.onclick = function (event) {
	    	var warning=$(".warning").css("display");
	    	
	    	console.log("warning: " + warning);
	    	if(warning == 'block'){
	    		alert('a');
	    	}
	        if (event.target == cardModal && document.activeElement !== textarea) {
	        	cardModal.style.display = "none";
	        }
	    } */
	
	    
	    
	    /* 조회 닫기 | 카드 모달창의 닫기버튼 누르면 모달창 사라짐 */
	    $(".popupCardClose").click(function(){
	    	cardModal.style.display = "none";
	    });
	
	    
	    
	    /* 제목 | 폼 활성화시 text 전체선택 */
	    $(popCardTitle).on("focus", function(){
	    	if(popCardPsId === 1) //진행 상태인 카드일 때만
	    		$(popCardTitle).select();
	    });
	    
	    
	    
	    /* 제목 수정 | 반복되어 쓰이기 때문에 함수로 묶음 */
	    function popCardTitleModify(){
			var titleModify = $(".title-modify").val(); //수정input태그의 value값 담기
				    	
			//아무 값도 입력하지 않을 경우
			if(titleModify == ''){ return; }
			
			if(titleModify !== popCardTitle){
				$.ajax({
					type : 'put',
					url : "/board/" + p_id + "/card/" + popCardId,
					headers : {
						"Content-Type" : "application/json",
						"X-HTTP-Method-Override" : "PUT"
					},
					data : JSON.stringify({title : titleModify}),
					dataType : 'text', 
					success : function(result) {
						if(result === "SUCCESS")
							$(modifyCardTitle).text(titleModify); //수정사항 카드리스트에 적용
					},
					error : function() {
						alert("에러가 발생했습니다.");
					}
				});//ajax
			};//if
	    };
	    
	    /* 제목 수정 | 카드 모달창(전체)을 클릭할 경우 */
	    $(cardModal).click(function(){
	    	if(popCardPsId === 1) //진행 상태인 카드일 때만
	    		popCardTitleModify(); //ajax처리하는 함수 호출
	    });
	    
	    /* 제목 수정 | 엔터키를 누를 경우 */
	    function enterPress(key){
			if (key.keyCode == 13) {
				event.preventDefault(); //기본 이벤트 제거
				popCardTitleModify();
				
				var obj = key.srcElement? key.srcElement : key.target; //이벤트를 발생시킨 객체를 찾아서
				obj.blur(); //포커스 해제
			};
		};
		
		
		
		/* 내용 제한 : 10,000byte - 한글 5,000자, 영문 10,000자 */
		
		/* 내용 | textarea 밑에 byte 표시하기 */
		$(function(){
			$(contentTextarea[0]).keyup(function(){
				bytesHandler(this);
			});
		});
		function bytesHandler(obj){
			var text = $(obj).val();
			$(".countByte").text(getTextLength(text));
			
			if(getTextLength(text) > DESCRIPTIONBYTE) {
				$(".countByte").css("color", "red");
				$(".countByte-warning").show();
			} else {
				$(".countByte").css("color", "black");
				$(".countByte-warning").hide();
			};
		};
		function getTextLength(text) {
			var textLength = 0;
			
			for (var i = 0; i < text.length; i++) {
				if (escape(text.charAt(i)).length == 6) {
					textLength++;
				};
				textLength++;
			};
			return textLength;
		};
			
	    
	    /* 내용 | 내용이 textarea의 height보다 길어지면 size조절 */
	    function autosize() {
	    	var el = this;
	        el.style.cssText = "height:auto; padding:0";
	        el.style.cssText = "height:" + el.scrollHeight + "px";
	    };
	    contentTextarea[0].addEventListener("input", autosize); //내용 textarea
	    contentTextarea[1].addEventListener("input", autosize); //댓글 textarea
	
	    
	    /* 내용 | textarea 클릭시 저장/close버튼 보이기/감추기 이벤트 */
	    $("body").click(function (e) { 
	    	if(popCardPsId !== 1) return; //진행 상태인 카드가 아니면 그냥 return
	        if(e.target == contentTextarea[0] || e.target == viewEdits) { //target이 textarea이거나 view edits버튼이면
	            $(".content-Btn").css("display", "block"); //버튼 보이기
	        } else { //target이 textarea, view edits버튼이 아니면
	            $(".content-Btn").css("display", "none"); //버튼 숨기기
	        };
	    });
	    
	    
	    /* 내용 | textarea 포커스 얻었을 때 글자 전체선택 */
	    $(contentTextarea[0]).on("focus", function(){
	    	$(contentTextarea[0]).select();
	    	//content의 text길이만큼 textarea의 height값 주기
    	    contentTextarea[0].style.height = "1px";
    	    contentTextarea[0].style.height = (contentTextarea[0].scrollHeight) + "px";
    	    
    	    $(".readMore-box").hide();
	    	bytesHandler(this); //내용의 byte계산하여 출력하는 함수
	    });
	    
	    
	    /* 내용 | 저장버튼을 눌렀을 경우 */
	    $(".saveBtn.description").click(function(){
	    	if($(".content-Btn").children(".countByte").html() > DESCRIPTIONBYTE) { //입력된 byte값이 제한byte값보다 크면
				return;	
	    	} else { 
	    		contentSave(); //ajax처리하는 함수 호출
	    	};
	    });
	    
	    
	    /* 내용 | 등록/수정 함수 */
	    function contentSave(){
	    	var content = $.trim($(".content-textarea.description").val()); //수정textarea의 내용 담기
	    	
	    	$.ajax({
	    		type : 'put',
	    		url : "/board/" + p_id + "/card/" + popCardId,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},
	    		data : JSON.stringify({content : content}),
	    		dataType : 'text', 
	    		success : function(result) {
	    			if(result === "SUCCESS") {
		    			if(content === "" || content === null) { //textarea의 value가 빈값이면
		    				$(".content-textarea.description").val("");
		    	    	} else {
		    	    		$(".content-textarea.description").val(content); //내용 textarea에 빈값을 없앤 값을 넣어준다
		    	    	};
		    	    	
		    			$(".warning").css("display", "none"); //경고메시지 숨기기
		    			popCardContent = content; //전역변수에 담긴 content값 바꿔주기
	    			};
	    			
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
	    };
	
	
	    
	    /* 내용 수정 | 카드 모달창(전체)을 클릭했을 때 content가 DB데이터와 다를 경우 저장 여부 확인 */
	    $(cardModal).click(function(e) { 
	    	var readMore = document.getElementsByClassName("readMore")[0]; //readMore버튼
	    	var content = contentTextarea[0].value; //수정textarea의 내용 담기
	    	
	    	if($.trim(content) === "" || content === null) { //textarea의 value가 빈값이면
	    		contentTextarea[0].value = $.trim(popCardContent); //공백을 제외한 원래의 내용 출력하고 
	    		return; //경고메시지 출력하지 않고 return
	    	};
		    	
	    	//내용을 수정하고 저장하지 않은 채로 textarea를 비활성화하면 저장하지 않았다는 경고메시지 뜸.
        	//경고메시지 숨김 : textarea를 클릭했을 때, 저장취소/view Edits/discard 클릭했을 때, read more버튼 클릭했을 때
        	//		textarea 밖을 클릭했는데 DB data가 null이고 textarea의 글자수가 0일 때.
	    	if(e.target == contentTextarea[0] || e.target == cancelBtn || e.target == viewEdits || e.target == readMore ||
        			e.target == discard || (e.target !== contentTextarea[0] && ($.trim(popCardContent) == null && content.length == 0))){
        		$(".warning").css("display", "none");
        	} else if (e.target !== contentTextarea[0] && content !== $.trim(popCardContent)){//textarea 밖을 클릭했을 때 data와 수정내용이 같지 않으면 경고메시지
        		$(".warning").css("display", "block");
        	};
	    });
	    
	    
	    /* 내용 수정 | 편집버튼 누르면 내용textarea에 focus */
	    $(viewEdits).click(function(){
	    	contentTextarea[0].focus();
	    });
	
	
	
	    /* 내용 수정 취소 | X버튼, discard버튼 클릭할 경우 */
	    function modifyDescriptionCancel() {
	    	$.getJSON("/board/" + p_id + "/card/" + popCardId, function(data){
	    		//DB에서 내용(content) 가져오기
	    		contentTextarea[0].value = data.content;
	    		//content의 text길이만큼 textarea의 height값 주기
	            contentTextarea[0].style.height = "1px";
	            contentTextarea[0].style.height = (contentTextarea[0].scrollHeight) + "px";
	    		bytesHandler(contentTextarea[0]);
	    	});
	    	$(".warning").css("display", "none");
	    };
	    
	    
	    
	    
	    /*
	    * 댓글
	    */
	    
	    
	    /* 댓글 조회 | getJSON으로 데이터 받아와서 동적 태그 생성하여 삽입 */
	    function allReply(){
	    	$.getJSON("/board/reply/all/" + popCardId, function(data){
	    		var str = "";
	    		
	    		$(data).each(function(){
	    			var edit = ""; 
		    		var myReply = "";
		    		var ps_id = this.ps_id;
		    		
	    			if(this.cdate !== this.udate){ //수정된 댓글에만 출력됨
		    			edit = "<p class='edited'>(수정됨)</p>";
		    		};
	    			if(ps_id === 1 && this.u_id === u_id){ //카드의 상태값이 1일 때, 본인이 쓴 댓글에만 출력됨
	    				myReply = "<div class='replyBtn reply'>" +
							   	  "    <button class='replyModifyBtn reply'>수정</button>" +
							   	  "    <button class='replyDeleteBtn reply'>삭제</button>" +
							   	  "</div>";
					};
					
					var content = this.content.replace(/(\n|\r\n)/g, '<br>');
					
	    			str += "<div data-id='" + this.id + "' data-uid='" + this.u_id + "'class='replyArea'>" +
						   "	<img src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate" + this.profile + "' />" +
						   "	<div class='reply-commentArea'>" +
						   "		<div class='reply-info'>" +
						   "        	<p class='reply-nickname'>" + this.nickname + "</p>" +
						   "        	<p class='reply-cdate'>" + this.cdate + "</p>" + edit + myReply +
						   "		</div>" +
						   "		<p class='reply-content'>" + content + "</p>" +
						   "	</div>" +
						   "</div>";
	    		});
	    		$(".activity-content").html(str);
	    	});
	    };
	    
	    
	    
	    /* 댓글 등록 | textarea에 내용이 있으면 버튼 활성화 */
	    $(".content-textarea.reply.create").on("input", function(){ 
	    	var value = $(".content-textarea.reply.create").val();
	    	
	        if($.trim(value) == "" || value == null) { //textarea의 value값이 없으면
	        	$(".saveBtn.reply.create").css("backgroundColor", "#bdbdbd61"); //하얀색
	        	$(".saveBtn.reply.create").prop("disabled", true); //비활성화
	        } else { //textarea에 값을 입력하면
	        	$(".saveBtn.reply.create").css("backgroundColor", "#5aac44"); //초록색
	        	$(".saveBtn.reply.create").prop("disabled", false); //활성화
	        }
	    });
	    
	    /* 댓글 수정 | textarea에 내용이 없으면 버튼 비활성화 */
	    $(".activity-content").on("input", ".content-textarea.reply.modify", function(){
			var value = $(".content-textarea.reply.modify").val();
	    	
	        if($.trim(value) == "" || value == null) { //textarea의 value값이 없으면
	        	$(".saveBtn.reply.modify").css("backgroundColor", "#bdbdbd61"); //하얀색
	        	$(".saveBtn.reply.modify").prop("disabled", true); //비활성화
	        } else { //textarea에 값을 입력하면
	        	$(".saveBtn.reply.modify").css("backgroundColor", "#5aac44"); //초록색
	        	$(".saveBtn.reply.modify").prop("disabled", false); //활성화
	        }
	    });
	    
	    
	    
	    /* 댓글 등록 | 저장 버튼을 클릭할 경우 */
	    $(".saveBtn.reply.create").click(function(){	    	
			var content = contentTextarea[1].value; //수정textarea의 내용 담기
			
	    	$.ajax({
	    		type : "POST",
	    		url : "/board/reply",
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "POST"
	    		},
	    		data : JSON.stringify({
	    			c_id : popCardId,
	    			content : content,
	    			u_id : u_id
	    		}),
	    		dataType : 'text', 
	    		success : function(result) {
	    			if(result === "SUCCESS") {
		    			allReply(); //댓글 목록 갱신
		    			modifyReplyCancel();
	    			};
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});
	    });
	    
	    /* 댓글 등록 | textarea value 초기화 */
	    function modifyReplyCancel() {
	    	$(".content-textarea.reply.create").val(""); //value 초기화
	    	$(".content-textarea.reply.create").css("height", "50px"); //스크롤이벤트 때문에 늘어난 height 줄임
	    	$(".saveBtn.reply.create").css("backgroundColor", "#bdbdbd61"); //저장버튼 하얀색
        	$(".saveBtn.reply.create").prop("disabled", true); //저장버튼 비활성화
	    };
	    	
	    
	    /* 댓글 수정 | 수정 버튼을 클릭할 경우 수정textarea 출력 */
	    $(".activity-content").on("click", ".replyModifyBtn", function() {
	    	var str = "<div class='replyModify-area'>" +
	    			  "	   <textarea class='content-textarea reply modify'></textarea>" +
					  "    <div class='comment-Btn'>" +
		        	  "        <button class='saveBtn reply modify'>저장</button>" +
		        	  "        <button class='cancelBtn reply'>&times;</button>" +
                      "    </div>" +
                      "</div>";
	    	$(this).parent().parent().parent().append(str); //동적 태그 생성하여 해당 댓글 div에 추가
	    	
	    	var modifyBeforContent = $(this).parents(".reply-info").next().html(); //원래 댓글 내용 꺼내서
	    	var modifyTextarea = $(this).parents(".reply-info").nextAll(".replyModify-area").children(".content-textarea.reply.modify"); //수정textarea

	    	$(modifyTextarea).html(modifyBeforContent); //수정textarea에 담기
	    	$(modifyTextarea).focus(); //focus주기
	    	$(".replyModify-area").prevAll().hide(); //댓글 작성자, 수정/삭제 버튼은 숨기기
	    });
	    
	    
	    /* 댓글 수정 | 수정 X버튼 누를 경우 textarea사라짐 */
	    $(".activity-content").on("click", ".cancelBtn.reply", function(){
	    	$(this).parent().parent().prevAll().toggle();
	    	$(this).parent().parent(".replyModify-area").remove();
	    });
	    
	    
	    
	    /* 댓글 수정 | 댓글 수정 후 저장버튼을 클릭할 경우 - ajax처리 */
	    $(".activity-content").on("click", ".saveBtn.reply.modify", function(){
			var modifyReplyContent = $(this).parent().prev(".content-textarea.reply.modify").val(); //수정textarea의 내용
			var replyId = $(this).parents(".replyArea").attr("data-id"); //해당 댓글의 data-id
	    	var replyModifyArea = $(this).parents(".replyModify-area"); //수정textarea + 저장버튼
	    	var replyInfo = $(replyModifyArea).prevAll(".reply-info"); //댓글 작성자, 날짜표시되는 div
	    	var replyContent = $(replyModifyArea).prevAll(".reply-content"); //댓글 내용 표시되는 div
	    	var replyCdate = $(this).parent().parent().prev().prev().children(".reply-cdate"); //cdate 표시되는 div
	    	
	    	$.ajax({
	    		type : 'put',
	    		url : "/board/reply/" + replyId,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},
	    		data : JSON.stringify({content : modifyReplyContent}),
	    		dataType : 'text', 
	    		success : function(result) {
	    			if(result === "SUCCESS"){
	    				$(replyInfo).css("display", "block"); //댓글 작성자 보이기
		    			$(replyContent).css("display", "block"); //댓글 수정, 삭제 버튼 보이기
	    				if($(replyCdate).next().attr("class") !== "edited") //날짜 옆에 edit표시가 없다면
		    				$(replyCdate).after("<p class='edited'>(수정됨)</p>"); //edit 표시 띄우기
		    			$(replyModifyArea).remove(); //수정textarea와 저장버튼 숨기기
		    			$(replyContent).html(modifyReplyContent); //바뀐 댓글내용 동적으로 적용
	    			};
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
	    });
	    
	    
	    
	    /* 댓글 삭제 | 삭제 버튼 누를 경우 모달창 띄움 */
		$(".activity-content").on("click", ".replyDeleteBtn.reply", function(){
			deleteReplyId = $(this).parents(".replyArea").attr("data-id"); //ajax처리를 위한 댓글의 id
			var replyDeleteModalY = $(this).offset().top; //삭제 버튼의 y좌표
			var scrollTop = $("#popupBox").scrollTop(); 
			
			//모달창 위치 지정
			$(".closeBoardModal.reply").css({
				//삭제버튼의 y좌표에 화면의 scrollTop만큼 더해줘서 
				//	스크롤을 아래로 내렸을 때도 삭제모달창이 위치를 제대로 잡도록 함
				"top" : replyDeleteModalY + scrollTop - 25
			});
			$(".closeBoardModal.reply").show(); //모달창 열기
		});
	    
		/* 댓글 삭제 | 모달창 이외의 영역을 클릭하면 모달창 닫기 */
		$(document).on("click", function(e){
			var className = $(e.target).attr("class"); //클릭한 요소의 class이름
			
			if(className !== "closeBoardModal reply" && className !== "replyDeleteBtn reply" 
					&& className !== "closeTitle reply" && className !== "closeBoardModal-text reply")
				$(".closeBoardModal.reply").hide();
		});
	    
		
		
	    /* 댓글 삭제 | ajax처리 */
	    $(".closeBoardBtn.reply").click(function(){
 	    	$.ajax({
	    		type : "delete",
	    		url : "/board/reply/" + deleteReplyId,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "DELETE"
	    		},
	    		dataType : "text",
	    		success : function(result){
	    			if(result === "SUCCESS"){
	    				$(".replyArea[data-id=" + deleteReplyId + "]").remove(); //해당 댓글 삭제
	    			};
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});
	    });
	    
	    
	    
	    
	    /*
	     * 카드 보관/가리기 관련
	     */
	    
	    
	    /* 카드 보관/가리기 | 보관탭에 삽입될 카드 태그 생성 */
	    function createArchivedCard(id, cl_id, title){
	    	var str = "<div class='nav-tab-content-Box-archive archive-cards'>" +
					  "    <div data-id='" + id + "' data-clId='"  + cl_id + "' class='cardtitleLi tab-cards' onclick='loadCardData(this)'>" +
					  "        <div id='cardLink'>" + title + "</div>" +
					  "        <div class='cardStatus'><i class='fas fa-archive'></i> 보관함</div>" +
					  "    </div>" +
					  "    <p class='quiet'>" +
					  "        <button class='archive-reopen switchBtn-archive return returnCard'>보드로</button>" +
					  "     - " +
					  "        <button class='archive-hidden switchBtn-archive return returnCard'>휴지통으로</button>" +
					  "    </p>" +
					  "</div>";
			return str;
	    };
	    
	    /* 카드 보관/가리기 | 가리기탭에 삽입될 카드 태그 생성 */
	    function createTrashboxCard(id, cl_id, title){
	    	var str = "<div data-id='" + id + "' data-clId='"  + cl_id + "' class='cardtitleLi tab-cards' onclick='loadCardData(this)'>" +
					  "    <div id='cardLink'>" + title + "</div>" +
					  "    <div class='cardStatus'><i class='fas fa-trash-alt'></i> 휴지통</div>" +
					  "</div>";
			return str;
	    };
	    
	    
	    /* 카드리스트 보관/가리기 | 보관탭에 삽입될 카드리스트 태그 생성 */
	    function createArchivedCardlist(id, title){
	    	var str = "<div class='nav-tab-content-Box-archive archive-cards'>" +
	    			  "    <div data-id='" + id + "' class='cardlist tab-cardlist'>" +
					  "        <div class='cardlistTitleBox tab-cardlist'>"+ title +"</div>" +
					  "    </div>" +
					  "    <p class='quiet'>" +
					  "        <button class='archive-reopen switchBtn-archive return returnCardlist'>보드로</button>" +
					  "		- " +
					  "        <button class='archive-hidden switchBtn-archive return returnCardlist'>휴지통으로</button>" +
					  "    </p>" +
					  "</div>";
			return str;
	    };
	    
	    /* 카드리스트 보관/가리기 | 가리기탭에 삽입될 카드리스트 태그 생성 */
	    function createTrashboxCardlist(id, title){
	    	var str = "<div data-id='" + id + "' class='cardlist tab-cardlist'>" +
					  "    <div class='cardlistTitleBox tab-cardlist'>" + title + "</div>" +
					  "</div>";
			return str;
	    };
	    
	    
	    
	    /* 카드 보관/가리기 수정 | ajax처리 */
	    function cardStatusChange(id, ps_id, cl_id, title){
	    	$.ajax({
	    		type : 'put',
	    		url : "/board/" + p_id + "/cardstatus/" + id,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},	
	    		data : JSON.stringify({ps_id : ps_id}),
	    		dataType : 'text', 
	    		success : function(data) {	
					$(".cardtitleLi[data-id=" + id + "]").parent(".nav-tab-content-Box-archive.archive-cards").remove(); //가리기탭에서 카드 밑의 send to cardlist, Trashbox 버튼까지 함께 삭제
					$(".cardtitleLi[data-id=" + id + "]").remove(); //카드리스트에서 카드 삭제
				   
					switch (ps_id) {
				    	case 1: //카드리스트에 카드 태그 삽입
				    		$(".cardlist[data-id='" + cl_id + "']").children(".cards").append( newCardAdd(id, cl_id, title) );
				    		break;
				    	case 2: //보관탭에 카드 태그 삽입
				    		$(".nav-tab-content-Box-archive.archiveCard").prepend( createArchivedCard(id, cl_id, title) ); //보관탭에 동적 카드태그 삽입
				    		break;
				    	case 3: //가리기탭에 카드 태그 삽입
				    		$(".nav-tab-content-Box-hidden.hiddenCard").prepend( createTrashboxCard(id, cl_id, title) ); //가리기탭에 동적 카드태그 삽입
				    		break;
			    	};
					cardStatus(ps_id); //상태값에 맞게 카드모달창 형태 변경 
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
	    };
	    
	    
	    
	    /* 카드 보관/가리기 수정 | 카드모달창에서 보관버튼 or 가리기버튼 클릭할 경우 */
	    $(".popupCard-aside ul li div").click(function(){
	    	var className = $(this).attr("class"); //클릭한 요소의 class이름
	    	var title = $(".title-cardTitle input").val(); //클릭한 카드의 title
	    	
	    	
	    	if(className === "popupCard-aside-sendToCardlist changeStatus"){ //send to cardlist 버튼이면
	    		popCardPsId = STATUS_ING; //ps_id = 1
	    	} else if(className === "popupCard-aside-archive"){ //보관 버튼이면
	    		popCardPsId = STATUS_ARCHIVE; //ps_id = 2
	    	} else if(className === "popupCard-aside-hide"){ //가리기 버튼이면
	    		if(confirm("Trashbox로 보내진 카드는 되돌릴 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
		    		popCardPsId = STATUS_HIDDEN; //ps_id = 3
		    	else return; //취소를 누르면 더이상 작업 수행하지 않고 return
	    	} else { 
	    		return; 
	    	};
	    	
	    	cardStatusChange(popCardId, popCardPsId, popCardlistId, title); //상태변경에 대한 ajax처리 함수 호출
	    });
	    
	    
	    
	    
	    /*
		* 첨부파일
		*	- 확장자 제한 : 이미지 - jpg, gif, png, jpeg
		*					기타 - jsp, html, java, class, js, css, zip, ppt, pptx, doc, docx, xlsx, pdf, hwp, rtf, txt
		*	- 각 파일의 크기 제한 : 10MB
		*	- 한 카드 전체 파일의 크기 제한 : 50MB
		*	- 파일명 제한 : 공백과 확장자명 포함 75byte (확장자 제외 70byte, 목록에서의 표시는 45byte까지만) 
	    *					한글은 1글자로 계산, 영어는 0.5글자로 계산하면
	    *					75byte = 확장자 최대 5자 빼고 한글 35자, 영문 70자
		*/
		/****************************************************************************
		첨부파일 부분은 유효성 검사할 것도 많고 전체적으로 복잡해서 쉽게 읽기 어려움.
		최대한 중복 제거하고 각각의 함수, 이벤트 구분 잘 해서 정리해야 할 듯.
		*****************************************************************************/
		
		
		
		
		/* 글자수 계산 */
		/* function checkByte(text) {
            var checkByte = 0;
            
            for (var i = 0; i < text.length; i++) {
                var textChar = escape(text.charAt(i)); //각 글자를 하나씩 떼어서 '%16진수코드값' 형태로 변환
                //escape() : 영어, 숫자, 일부 특수문자는 제외하고 한글과 한자, 일부 특수문자만 16진수코드값으로 바꿔준다.

                if (textChar.length === 1) { //영문, 숫자, 16진수코드값으로 변환되지 않는 일부특수문자는 1byte
                    checkByte++;
                } else if (textChar.indexOf("%u") !== -1) { //한글이나 한자는 2byte
                    checkByte += 2;
                } else if (textChar.indexOf("%") !== -1) { //16진수코드값으로 변환된 일부 특수문자는 1byte
                    checkByte++;
                };
            };
            return checkByte;
        }; */
        
		/* 파일명 정리 | 글자수가 지정한 글자수 이상이면 ...으로 생략 표시 */
		/* function textLengthCut(text, limitByte) {
            if (text == null || text == "") return; //매개변수에 대한 유효성 검사

            if (limitByte == "" || limitByte == null) limitByte = 40; //textByte를 따로 지정해주지 않았을 경우. 기본값
			
            var textByte = checkByte(text); //text의 byte 계산
            
            if (textByte > limitByte) {
            	
                text = text.substr(0, length) + "...";
            };
            return text;
        }; */
        
        
        /* 파일명 정리 | text의 byte 계산, 계산한 byte가 지정한 byte 이상이면 ...으로 생략 표시 */
        function checkByte(text, limitByte) {
            var textByte = 0;
            var index = 0;

            if (text == null || text == "") return; //매개변수에 대한 유효성 검사
            if (limitByte == "" || limitByte == null) limitByte = 40; //textByte를 따로 지정해주지 않았을 경우. 기본값
            
            for (var i = 0; i < text.length; i++) {
                var textChar = escape(text.charAt(i)); //각 글자를 하나씩 떼어서 '%16진수코드값' 형태로 변환
                //escape() : 영어, 숫자, 일부 특수문자는 제외하고 한글과 한자, 일부 특수문자만 16진수코드값으로 바꿔준다.
                
                if (textChar.indexOf("%u") !== -1) { //한글은 2byte
                	textByte += 2;
                } else { //영문, 숫자, 16진수코드값 %u로 변환되지 않는 일부특수문자는 1byte
                	textByte++;
                };
                
                if(textByte === limitByte)
                	index = i;
            };
            
			if (textByte > limitByte)
				text = text.substr(0, index) + "...";
            
            return [textByte, text]; //text의 byte와 생략된 text를 반환
        };
        
		
		
		/* 목록 조회 */
		function allAttach(){
			$.getJSON("/board/" + p_id + "/card/" + popCardId + "/allAttach", function(lists){
		    	var str = "";
		    	//최대 6개까지만 목록 출력하기 위해 length 결정함
		    	if(lists.length <= attachCount) {
		    		var listLength = lists.length; //6개보다 작으면 동적 태그 생성하는 for문 length만큼 돌기
		    		$(".uploadedList-btn.more").hide(); //더보기 버튼 숨기기
		    	} else {
		    		var listLength = attachCount; //6개보다 크면 for문은 6번만 돈다
		    		$(".uploadedList-btn.more").show(); //더보기 버튼 출력
		    	};
		    	
		    	if(attachCount > ATTACHLISTNUM) { //현재 출력되어있는 파일 개수가 6개보다 많으면
		    		$(".uploadedList-btn.short").show(); //접기 버튼 출력
		    	} else {
		    		$(".uploadedList-btn.short").hide();
		    	};
		    	
		    	//결정된 length만큼 for문을 돌며 동적 목록 태그 생성
		    	for(var i = 0; i < listLength; i++) {
		    		var list = lists[i];
		    	
					var fullFileName = originalFileName(list.file); //원본 파일명
					var miniFileName = checkByte(fullFileName)[1]; //42byte가 넘어서는 글자는 생략된 파일명
					
					var attachInfoStr = "<div class='attachInfo'>" +
									    "	<p class='fullFileName'>" + fullFileName + "</p>" + 
									    "	<p class='miniFileName'>" + miniFileName + "</p>" + 
									    "	<p class='uploadDate'>" + list.cdate + "</p>" +
									    "	<p class='fileSize'>" + fileUnit(list.size) + "</p>";
					if(list.ps_id === 1){ //진행카드만 delete버튼 추가하고 div 닫음
						attachInfoStr += "<button class='attachDeleteBtn' data-src='" + list.file + "'>Delete</button></div>";						
					} else { //진행카드가 아니면 delete버튼 없이 div 닫음
						attachInfoStr += "</div>";	
					};
					
					if(checkFileType(fullFileName) === "image"){ //이미지 파일 일 때(썸네일 img 태그 포함)
						str += "<div class='attachLi'>" +
							   "    <div class='attachThumbnail'>" +
							   "        <a href='#'>" +
							   "            <img class='thumbnail' src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/uploadFile" + list.file + "'/>" +
							   "        </a>" + 
							   "    </div>" + attachInfoStr +
							   "</div>";
					} else { //일반 파일일 때
						str += "<div class='attachLi'>" +
				  			   "    <div class='attachThumbnail'>" +
							   "        <a href='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/uploadFile" + list.file + "'>" +
							   "            <p>" + checkFileType(fullFileName) + "</p>" +
							   "        </a>" + 
							   "    </div>" + attachInfoStr +
							   "</div>";
					};
		    	}; //for	
		    	$(".uploadedList").html(str);
		    	//해당 카드에 대한 모든 첨부파일의 총 용량 구함
		    	popCardAttachAllByte = 0;
		    	$(lists).each(function() {
		    		popCardAttachAllByte += this.size;
		    	});
 	    	}); //getJSON
		};
		
		/* 목록 조회 | 더보기 버튼을 눌렀을 경우 */
		$(".uploadedList-btn.more").click(function(){
			attachCount += ATTACHLISTNUM;
			allAttach();
		});
		/* 목록 조회 | 접기 버튼을 눌렀을 경우 */
		$(".uploadedList-btn.short").click(function(){
			attachCount = ATTACHLISTNUM;
			allAttach();
		});
		
		/* 파일명 정리 | 원본 파일명 추출하기 */
		function originalFileName(fileName){
			var originalName = fileName.indexOf("_") + 1; //파일명 중 _ 의 index값 구함
			return fileName.substr(originalName); //_ 뒤의 문자열 return
		};
		
		
		
		/* 파일 확인 | 확장자 확인 */
		function checkFileType(fileName) {
			var index = fileName.lastIndexOf(".") + 1; //뒤에서부터 . 문자를 찾아 index반환
			var fileType = fileName.substr(index); //index를 이용하여 확장자만 추출
			
			var imgPattern = /jpg$|gif$|png$|jpeg$/i; // 첨부 가능한 이미지파일 확장자(i: 대소문자 구분 안 하도록)
			var basicFilePattern = /jsp$|html$|java$|class$|js$|css$|zip$|ppt$|pptx$|doc$|docx$|xlsx$|pdf$|hwp$|rtf$|txt$/i; //첨부 가능한 기타파일 확장자
			var returnValue;
			
			if(fileType.match(basicFilePattern) !== null){ //기타 파일일 경우
				return fileType.toUpperCase();// 확장자 반환(.toUpperCase() : 대문자로 변환)
			} else if(fileType.match(imgPattern) !== null) { //이미지 파일일 경우
				return "image"; //image 문자열 반환
			} else { //첨부 가능한 확장자가 아니면 경고창 띄우고 return
				hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
				var str = "<div class='fileSizeWarning'><span>" + fileType + " 의 확장자는 첨부가 불가능합니다.</span></div>";
				$("#popupBox").after(str); //경고메시지 띄움
				
				setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
				return false; //ajax 호출 하지 않고 return
			};
		};
		

		
		/* 파일 확인 | 파일 첨부가 불가능할 때 띄우는 경고창을 숨기는 함수 */
		function hideDiv (){ 
			$(".fileSizeWarning").css("display", "none");
		};
			
		
		/* 파일 확인 | 파일 크기에 따라 출력 단위 결정 */
		function fileUnit(fileSize){
			var str;
			if (fileSize / 1024 > 1) { //1KB 초과일 때 
				if (((fileSize / 1024) / 1024) > 1) { // 1MB 이상
					fileSize = (Math.round(((fileSize / 1024) / 1024) * 100) / 100);
					str = fileSize + "MB";
				} else { // KB
					fileSize = (Math.round((fileSize / 1024) * 100) / 100);
					str = fileSize + "KB";
				};
			} else { //1KB 이하일 때 
				fileSize = (Math.round(fileSize * 100) / 100);
				str = fileSize + "Byte";
			};  
			return str;
		};
		
		
		
		/* 일반 파일첨부 방식 | 파일 첨부창 띄우기 */
		$(".chooseFile").click(function(){
			$(".upfileInput").click();
		});
		
		/* 일반 파일첨부 방식 | 파일 첨부창에서 업로드할 파일을 선택 후 */
		function upfileInput(obj) {
			var file = obj.files[0];
			fileCheck(file); //첨부한 파일크기 측정하여 ajax처리 하는 함수 호출		
		};
		
		
		
		/* Drag & drop 방식 | 브라우저에 파일을 끌어다 놓았을 때 파일 보여주는 창 띄우는 것을 막음 */
		$(".popupCard").on("dragenter dragover", function(event){
			event.preventDefault(); //이벤트 제한
		});
				
			
		/* Drag & drop 방식 | 브라우저의 지정 위치에 파일을 drop했을 때 */
		$(".popupCard").on("drop", function(event){
			event.preventDefault(); //기본 이벤트 제한
			
			var files = event.originalEvent.dataTransfer.files; //전달된 파일 데이터를 가져옴
			var file = files[0];
			
			if(file === undefined) return; //알 수 없는 객체를 drop할 경우

			if(popCardPsId === 2 || popCardPsId === 3){ //보관함이나 휴지통에 있는 카드에 drop했을 때
				hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
				var str = "<div class='fileSizeWarning'><span>이 카드는 보관상태로, 파일을 첨부할 수 없습니다.</span></div>";
				$("#popupBox").after(str); //경고메시지 띄움
				
				setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
				return;
			};
			
			fileCheck(file); //파일크기 측정하여 ajax처리 하는 함수 호출			
		});
		
		/* 파일 확인 | 파일 크기, 파일명 길이, 확장자 확인하여 적합할 경우 ajax 호출 */
		function fileCheck(file) {
			var maxSize = 10485760; // = 10MB
			var fileSize = 0;
			var formData = new FormData(); //FormData객체 : <form>태그로 만든 데이터 전송 방식과 동일하게 파일 데이터 전송
			
			var remain = fileUnit(ONECARDATTACHLISTBYTE - popCardAttachAllByte);
			
			fileSize = file.size; //첨부할 file의 size
			console.log("파일사이즈 : " + fileSize + "byte, 최대파일사이즈 : 10485760byte");

			//해당 카드의 전체 첨부파일 용량(50MB) 확인
			if(popCardAttachAllByte + fileSize > ONECARDATTACHLISTBYTE) {
				hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
				if(parseInt(remain) > 0) { //용량이 남았을 때
					var str = "<div class='fileSizeWarning'><span>이 카드는 총 첨부 용량을 초과했습니다. 기존의 파일을 삭제하거나 " 
													+ remain + " 이하의 파일만 첨부가 가능합니다.</span></div>";
				} else { //용량이 남지 않았을 때
					var str = "<div class='fileSizeWarning'><span>이 카드는 총 첨부 용량을 초과했습니다. 더이상 첨부가 불가능합니다. 다른 파일을 삭제해 주세요.</span></div>";
				};
				$("#popupBox").after(str); //경고메시지 띄움
				
				setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
				return; //ajax 호출 하지 않고 return
			};
			//확장자 유효성 검사
			if(checkFileType(file.name) == false) return; //checkFileType함수 안에 경고창 출력 포함되어 있음
			//파일 크기 유효성 검사
			if (fileSize > maxSize) { //파일 사이즈가 10MB가 넘을 경우
				hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
				var str = "<div class='fileSizeWarning'><span>10MB 이하의 파일만 등록 가능합니다.</span></div>";
				$("#popupBox").after(str); //경고메시지 띄움
				
				setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
				return; //ajax 호출 하지 않고 return
			};
			//파일명 길이 유효성 검사
			if(checkByte(file.name)[0] > 75) { //파일명이 75byte를 초과할 경우
				var str = "<div class='fileSizeWarning'><span>파일명은 한글 35자, 영어 70자까지 가능합니다.</span></div>";
			
				$("#popupBox").after(str); //경고메시지 띄움
				
				setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
				return; //ajax 호출 하지 않고 return
			};
			
			
			formData.append("file", file); //FormData객체에 파일 데이터 객체를 추가함
			
			$.ajax({
				url : "/board/" + p_id + "/card/" + popCardId + "/addAttach",
				data : formData,
				dataType : "text",
				processData : false, //데이터를 일반적 query string으로 변환할 것인지에 대한 설정. 기본값 true로 설정할 경우 'application/x-www-form-urlencoded' 타입으로 전송하게 된다.
				contentType : false, //기본값인 application/x-www-form-urlencoded 말고 multipart/form-data방식으로 파일전송 하기 위해 false
				type : "POST",
				success : function(data) {
					if (data !== null)
						allAttach(); //첨부파일 목록 갱신
				},
				error : function() {
					alert("에러가 발생했습니다.");
				}
			}); //ajax
		};
			
		
			
		/* 삭제 | delete 버튼을 눌렀을 경우 confirm 후 ajax처리 */
		$(".uploadedList").on("click", ".attachDeleteBtn", function(e) {
			if(!(confirm("삭제한 첨부파일은 되돌릴 수 없습니다. 정말 삭제하시겠습니까?"))) return;
			
			var deleteBtn = $(this);
	
			$.ajax({
				url : "/board/deleteAttach",
				type : "POST",
				data : {
					fileName : $(this).attr("data-src")
				},
				dataType : "text",
				success : function(result) {
					if (result === "DELETED") {
						//deleteBtn.parent().parent().remove();
						allAttach();
					};
				}
			}); //ajax
		});
	
		
		
		/* 이미지파일 조회 | img파일 썸네일을 누를 경우 */
		$(".uploadedList").on("click", ".thumbnail", function() {
			var fullFileName = $(this).parent().parent().next().children(".fullFileName").text();
			var str = "<img class='originalImg' src='" + $(this).attr("src") + "' /><p>" + fullFileName + "</p>";
			
			$(".imgModal").html(str); //이미지 보여주는 동적 태그 생성하여 삽입
			$(".imgModal").show(); //모달창 출력
			$(".closeModal.imageModal").show(); //X버튼 출력
		});
	    

		
	    /* 첨부파일 | img 모달창에서 X버튼 누르면 모달창 닫기 */
	    $(document).on("click", function(e){
			var className = $(e.target).attr("class"); //클릭한 요소의 class이름
			
			//클릭한 요소가 이미지모달창이 아니면 모달창 닫기
			if(className !== "thumbnail" && className !== "originalImg"){
				$(".imgModal").hide();
				$(".closeModal.imageModal").hide(); //X버튼 숨기기				
			};
		});
	    
	    
	    
	    /* 카드모달창 dropdown | 열고 닫기 */
	    $(".popCardMenu").click(function(){
	    	$(".popupCard-aside").toggle();
	    });
	    /* 카드모달창 dropdown | 다른 영역 누르면 닫기 */
		$(document).on("click", function(e){
			var className = $(e.target).attr("class");
			if(className !== "popCardMenu" && className !== "popCardMenuIcon") { 
				$(".popupCard-aside").hide();
			};
		});
    </script>
    
</body>
</html>