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
<link href="/resources/css/cards/cardModal.css?ver=2" type="text/css" rel="stylesheet" />
</head>

<body>
	<div id="popupBox" class="overlay">
        <div class="popupCard">
        	<!-- 카드의 상태값이 보관/가리기일 때 상단bar-->
        	<div class="popCard-banner archive"><p><i class="fas fa-archive"></i> This card is archived. You can't edit this card anymore.</p></div>
        	<div class="popCard-banner hide"><p><i class="fas fa-archive"></i> This card is hidden. You can't edit this card anymore.</p></div>
            <!-- 헤더 | 카드 제목 -->
            <header class="cardTitle">
                <i class="far fa-credit-card"></i>                
                <div class="title-cardTitle">
                	<input type="text" class="title-modify" maxlength="20"  onkeydown="enterPress(event); limitMemo(this, 20);"/><!--카드 제목 DB에서 가져옴-->
                	<p class="card-id-Hidden"></p><!-- id값(hidden) -->
                </div>
            </header>
            <!-- 닫기 버튼 -->
            <div class="popupCardClose">&times;</div>

            <!-- 왼쪽 | 카드 실제 내용 부분-->
            <section>
                <!-- 내용 -->
                <article>
                    <div class="cardContent">
                        <div class="title-content title">
                            <i class="fas fa-align-left"></i><strong>Description</strong>
                        </div>
                        <div class="content-content">
                            <textarea class="content-textarea" placeholder="Add a more detailed description..."></textarea>
                        </div>
                        <div class="content-Btn">
                            <button class="saveBtn" onclick="contentSave()">save</button>
                            <button class="cancelBtn" onclick="modifyCancel()">&times;</button>
                        </div>
                         <div class="warning">
                            <ul class="warningUL">
 	                            <li>저장하지 않은 내용입니다.</li>
                                <li class="viewEdits">View edits</li>
                                <li class="save" onclick="contentSave()">Save</li>
                                <li class="discard" onclick="modifyCancel()">Discard</li>
                            </ul>
                        </div>
                    </div>
                </article>

                <!-- 첨부파일 -->
                <article>
                    <div class="attach">
                        <div class="title-attach title">
                            <i class="fas fa-paperclip"></i><strong>첨부파일</strong>
                        </div>
                        <div class="attach-content v"></div>
                    </div>
                </article>
                <!-- 댓글작성 -->
                <article>
                    <div class="comment">
                        <div class="title-comment title">
                            <i class="far fa-comment"></i><strong>댓글작성</strong>
                        </div>
                        <div class="comment-content v"></div>
                    </div>
                </article>
                <!-- 댓글목록 & 이력 -->
                <article>
                    <div class="activity">
                        <div class="title-activity title">
                            <i class="fas fa-list-ul"></i><strong>댓글목록&이력</strong>
                        </div>
                        <div class="activity-content v"></div>
                    </div>
                </article>
            </section>


            <!-- 오른쪽 | 사이드메뉴 -->
            <aside class="popupCard-aside">
                <div><strong>Menu</strong></div>
                <ul>
                    <li><div class="popupCard-aside-members"><i class="fas fa-users"></i><p>Members</p></div></li>
                    <li><div class="popupCard-aside-archive"><i class="fas fa-archive"></i><p>Archive</p></div></li>
                    <li><div class="popupCard-aside-hide"><i class="far fa-eye-slash"></i><p>Trashbox</p></div></li>
                    <li><div class="popupCard-aside-sendToCardlist"><i class="fas fa-undo-alt"></i><p>send to cardlist</p></div></li>
                </ul>
            </aside>

        </div>
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
	    	5. 보관, 가리기 (-)
	    	7. 코드정리 (-)
	    	9. 주석달기 (-)
	    	10. 변수이름 정리 (-)
	    	12. 창 줄였을 때 카드모달창 사이즈 조절 문제(-)
	    	13. enter키 눌렀을 때 저장되기 - 카드리스트제목(+)카드제목(+)카드제목수정모달(-)카드모달내용(-)
	    	17. jQuery, javascript 짬뽕 정리(-)
	    	18. 카드리스트와 통합하여 기능확인, 정리하기(-)
	    	19. 리스트에서 화면 마우스로 클릭하고 움직이면 스크롤 따라오게 (-)
	    	20. 카드리스트 보관/숨기기 모달창 띄우고 스크롤할 때 모달창만 둥둥 뜨는 문제(-)
	    	22. 카드리스트 추가시 가끔 스크롤이 끝으로 이동 안 하고 맨앞으로 튕김(-)
	    	23. 보관카드 - 내용 없으면 placeholder 뜬 채로 수정 불가인데 placeholder없애? (-)
	    	24. 
	    **************************************************************************************************************
	    	<해결한 것>
	    	1. 카드모달 닫을 때 새로고침 되지 않게 (+)
	    		2-2. 카드 제목을 수정하고 textarea focus를 둔 상태에서 모달 바깥을 눌러 창을 끄면 
	    			DB에는 바뀐 제목으로 저장이 되는데 목록에서는 예전제목으로 보임.(새로고침이 안됨.) (+)
	    	3. 화면 클릭할 때마다 계속 data 로드하는 문제 (+)
	    	4. 프론트 (+)
	    	6. 스크롤 문제 (+)
	    	8. 제목 20자 이하 입력하도록 처리 (+)
	    	11. 창 줄였을 때 헤더 아이콘, 검색창 내려오는 문제(+)
	    	14. 조회 ajax for문 수정(+)
	    	15. ajax error처리(+)
	    	16. 연산자 띄어쓰기 정리(+)
	    	20. 카드리스트 height조절(+)
	    	21. 가리기 경고창(+)
	    **************************************************************************************************************/	    
	
	    //임의의 프로젝트 id값을 준다.(프로젝트4에 대한 화면 출력)
	    var p_id = 4;
	
	    var cardModal = document.getElementById("popupBox"); //전체 모달창 객체
	    var popCardTitle = document.getElementsByClassName("title-modify")[0]; //제목input태그
	    var contentTextarea = document.getElementsByClassName("content-textarea")[0]; //내용입력 textarea
	    var cancelBtn = document.getElementsByClassName("cancelBtn")[0]; //내용 수정 취소버튼
	    var viewEdits = document.getElementsByClassName("viewEdits")[0]; //내용 저장하지 않았을 때 뜨는 view Edits
	    var discard = document.getElementsByClassName("discard")[0]; //내용 저장하지 않았을 때 뜨는 discard
		var popCardId; //카드 상세내용 조회할 때 클릭한 카드id값을 담을 변수
		var popCardPsId; //카드 상세내용 조회할 때 클릭한 카드의 ps_id값을 담을 변수
		var popCardContent; //카드 상세내용 조회할 때 클릭한 카드 내용을 담을 변수
	    
	
		
		
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
                break;
            case 2: //보관일 때
            	$(".changeStatus").removeClass("changeStatus"); //관련된 모든 클래스 이름에서 changeStatus 제거하여 CSS 속성 초기화
            	$(".popCard-banner.archive").addClass("changeStatus"); //1. 카드 상단에 상태바 archive 출력
            	$(".popupCard").addClass("changeStatus");//2. 카드모달창 padding 조절
            	$(".popupCard-aside-archive").addClass("changeStatus"); //3. 보관버튼 숨기기
            	$(".popupCard-aside-hide").removeClass("changeStatus"); //3. 가리기버튼 출력
            	$(".popupCard-aside-sendToCardlist").addClass("changeStatus"); //4. send to cardlist메뉴 출력.
            	
            	$(".title-modify").prop("disabled", true); //제목 수정 못하게
            	$(".content-textarea").prop("disabled", true); //내용 수정 못하게
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
                break;
    		};
		};
		
		
		
		/* 카드 상세내용 조회 */
	    function loadCardData(obj) {
	       	popCardId = obj.parentNode.getAttribute("data-id"); //클릭한 카드의 id값을 가져와서 var id에 담음.
	       	modifyCardTitle = $(obj); //클릭한 카드의 title표시하는 div를 전역변수에 담아둠(제목 수정 처리에 이용할 예정)
	    	
	    	$.getJSON("/board/" + p_id + "/card/" + popCardId, function(data){
	    		popCardPsId = data.ps_id; //클릭한 카드의 ps_id값 전역변수에 담아두기 		
	    		
	    		//DB에서 카드 id, 내용 가져오기(id는 화면에 표시하지 않는다.)
	    		$(".card-id-Hidden").eq(0).html(data.id);
	    		$(".title-cardTitle input").val(data.title);//카드제목 수정input태그에 'value'값으로 넣는다
	    			//.html로 담았다가 7시간 삽질함.
	    		$(contentTextarea).val(data.content);
	    		popCardContent = data.content; //전역변수에 클릭한 카드의 내용을 담아둠
	    		
	    		//content의 text길이만큼 textarea의 height값 주기
	    	    contentTextarea.style.height = "1px";
	    	    contentTextarea.style.height = (contentTextarea.scrollHeight) + "px";
	    	    
		    	cardStatus(data.ps_id); //카드 상태값에 따라 진행, 보관, 가리기 구별하여 각각 다른 형태의 카드모달창 출력
	    	});//JSON
	    	cardModal.style.display = "block"; //모달창 띄우기
	    };
	    
	    
	
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
	    popCardTitle.addEventListener('click', function (e) {
	    	if(popCardPsId === 1) //진행 상태인 카드일 때만
		    	popCardTitle.select();
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
	    		popCardTitleModify();
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
		
	    
	    
	    /* 내용 | 내용이 textarea의 height보다 길어지면 size조절 */
	    contentTextarea.addEventListener('keydown', autosize);
	    function autosize() {
	    	var el = this;
	        el.style.cssText = 'height:auto; padding:0';
	        el.style.cssText = 'height:' + el.scrollHeight + 'px';
	    };
	
	    
	    
	    /* 내용 | textarea 클릭시 save, close버튼 보이기/감추기 이벤트 */
	    $("body").click(function (e) { 
	    	if(popCardPsId !== 1) return; //진행 상태인 카드가 아니면 그냥 return
	        if(e.target == contentTextarea || e.target == viewEdits) { //target이 textarea이거나 view edits버튼이면
	            $(".content-Btn").css("display", "block"); //버튼 보이기
	            contentTextarea.select(); //textarea활성화 시 text 전체선택
	        } else { //target이 textarea, view edits버튼이 아니면
	            $(".content-Btn").css("display", "none"); //버튼 숨기기
	        };
	    });
	    
	    
	    
	    /* 내용 | 등록/수정 함수 */
	    function contentSave(){
	    	var content = $(".content-textarea").val(); //수정textarea의 내용 담기
	    	
	    	$.ajax({
	    		type : 'put',
	    		url : "/board/"+p_id+"/card/" + popCardId,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},
	    		data : JSON.stringify({content : content}),
	    		dataType : 'text', 
	    		success : function(result) {
	    			console.log("result: " + result);
	    			$(".warning").css("display", "none"); //경고메시지 숨기기
	    			popCardContent = content; //전역변수에 담긴 content값 바꿔주기
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
	    };
	
	
	    
	    /* 내용 수정 | 카드 모달창(전체)을 클릭했을 때 content가 DB데이터와 다를 경우 저장 여부 확인 */
	    $(cardModal).click(function(e) { 
	    	var content = $(".content-textarea").val(); //수정textarea의 내용 담기
	    	//내용을 수정하고 저장하지 않은 채로 textarea를 비활성화하면 저장하지 않았다는 경고메시지 뜸.
        	//경고메시지 숨김 : textarea를 클릭했을 때, 저장취소/view Edits/discard 클릭했을 때, 
        	//		textarea 밖을 클릭했는데 DB data가 null이고 textarea의 글자수가 0일 때.
	    	if(e.target == contentTextarea || e.target == cancelBtn || e.target == viewEdits || 
        			e.target == discard || (e.target !== contentTextarea && (popCardContent == null && content.length == 0))){
        		$(".warning").css("display", "none");
        	} else if (e.target !== contentTextarea && content !== popCardContent){//textarea 밖을 클릭했을 때 data와 수정내용이 같지 않으면 경고메시지
        		$(".warning").css("display", "block");
        	};
	    });
	
	
	
	    /* 내용, 제목 수정 취소 | X버튼, discard버튼 클릭할 경우 */
	    function modifyCancel() {
	    	$.getJSON("/board/" + p_id + "/card/" + popCardId, function(data){
	    		//DB에서 내용(content) 가져오기
	    		contentTextarea.value = data.content;
	    		//content의 text길이만큼 textarea의 height값 주기
	            contentTextarea.style.height = "1px";
	            contentTextarea.style.height = (contentTextarea.scrollHeight) + "px";
	    	});
	    	$(".warning").css("display", "none");
	    };
	    
	    
	    
	    
	    
	    /*
	     * 카드 보관/가리기 관련
	     */
	    
	    
	    /* 카드 보관/가리기 | 보관탭에 삽입될 카드 태그 생성 */
	    function createArchivedCard(id, title){
	    	var str = "<div class='nav-tab-content-Box-archive archive-cards'>" +
					  "    <div data-id='"+ id +"' class='cardtitleLi tab-cards'>" +
					  "        <div id='cardLink' onclick='loadCardData(this)'>"+ title +"</div>" +
					  "        <div class='cardStatus'><i class='fas fa-archive'></i> archived</div>" +
					  "    </div>" +
					  "    <p class='quiet'>" +
					  "        <button class='archive-reopen switchBtn-archive return returnCard'>Send to Cardlist</button>" +
					  "     - " +
					  "        <button class='archive-hidden switchBtn-archive return returnCard'>Trashbox</button>" +
					  "    </p>" +
					  "</div>";
			return str;
	    };
	    
	    /* 카드 보관/가리기 | 가리기탭에 삽입될 카드 태그 생성 */
	    function createTrashboxCard(id, title){
	    	var str = "<div data-id='"+ id +"' class='cardtitleLi tab-cards'>" +
					  "    <div id='cardLink' onclick='loadCardData(this)'>"+ title +"</div>" +
					  "    <div class='cardStatus'><i class='fas fa-archive'></i> hidden</div>" +
					  "</div>";
			return str;
	    };
	    
	    
	    /* 카드리스트 보관/가리기 | 보관탭에 삽입될 카드리스트 태그 생성 */
	    function createArchivedCardlist(id, title){
	    	var str = "<div class='nav-tab-content-Box-archive archive-cards'>" +
	    			  "    <div data-id='"+ id +"' class='cardlist tab-cardlist'>" +
					  "        <div class='cardlistTitleBox tab-cardlist'>"+ title +"</div>" +
					  "    </div>" +
					  "    <p class='quiet'>" +
					  "        <button class='archive-reopen switchBtn-archive return returnCardlist'>Send to board</button>" +
					  "		- " +
					  "        <button class='archive-hidden switchBtn-archive return returnCardlist'>Trashbox</button>" +
					  "    </p>" +
					  "</div>";
			return str;
	    };
	    
	    /* 카드리스트 보관/가리기 | 가리기탭에 삽입될 카드리스트 태그 생성 */
	    function createTrashboxCardlist(id, title){
	    	var str = "<div data-id='"+ id +"' class='cardlist tab-cardlist'>" +
					  "    <div class='cardlistTitleBox tab-cardlist'>"+ title +"</div>" +
					  "</div>";
			return str;
	    };
	    
	    
	    
	    /* 카드 보관/가리기 수정 | ajax처리 */
	    function cardStatusChange(id, ps_id, title){
	    	$.ajax({
	    		type : 'put',
	    		url : "/board/" + p_id + "/cardStatus/" + id,
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
			            	
			                break;
			            case 2: //보관탭에 카드 태그 삽입
			            	$(".nav-tab-content-Box-archive.archiveCard").prepend( createArchivedCard(id, title) ); //보관탭에 동적 카드태그 삽입
			            	break;
			            case 3: //가리기탭에 카드 태그 삽입
			            	$(".nav-tab-content-Box-hidden.hiddenCard").prepend( createTrashboxCard(id, title) ); //가리기탭에 동적 카드태그 삽입
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
	    	
	    	cardStatusChange(popCardId, popCardPsId, title); //상태변경에 대한 ajax처리 함수 호출
	    });
	    
	    
	    
    </script>
    
</body>
</html>