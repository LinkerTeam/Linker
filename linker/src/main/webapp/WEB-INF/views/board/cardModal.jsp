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
<link href="/resources/css/cards/cardModal.css?ver=1" type="text/css" rel="stylesheet" />
</head>

<body>
	<div id="popupBox">
        <div class="popupCard">
        	<!-- 카드의 상태값이 보관/가리기일 때 상단bar-->
        	<div class="popCard-banner archive"><p><i class="fas fa-archive"></i> This card is archived. You can't edit this card anymore.</p></div>
        	<div class="popCard-banner hide"><p><i class="fas fa-archive"></i> This card is in the Trashbox.</p></div>
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
                            <textarea class="content-textarea description" placeholder="Add a more detailed description..."></textarea>
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
                <%@include file="cardAttach.jsp"%>
                <!-- 댓글작성 -->
                <article>
                    <div class="comment">
                        <div class="title-comment title">
                            <i class="far fa-comment"></i><strong>댓글작성</strong>
                        </div>
                        <div class="comment-content">
                            <textarea class="content-textarea reply create" placeholder="Write a comment..."></textarea>
	                        <div class="comment-Btn">
	                        	<button class="saveBtn reply create">Save</button>
	                        </div>
                        </div>
                    </div>
                </article>
                <!-- 댓글목록 & 이력 -->
                <article>
                    <div class="activity">
                        <div class="title-activity title">
                            <i class="fas fa-list-ul"></i><strong>댓글목록&이력</strong>
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
								<button class="closeBoardBtn reply" value="OK">Delete</button>
							</div>
						</div> 
					</div>
					<!-- /close board 모달창  -->
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
    <div id='#imgModal'>
    	<span class="closeModal imageModal">&times;</span>
    	<div class='imgModal'></div>
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
	    	24. 프로젝트 title 읽어오기, 수정 이벤트(-)
	    	25. 클릭한 왼쪽메인메뉴 활성화 표시(-)
	    	26. board를 close하면 설정탭에서 close-board 메뉴 사라져야 함(중복클릭 문제)
				-> 오른쪽 메인메뉴 분리할 예정이므로 메뉴 정리 되면 고치기(-)
			27. jpeg는 thumbnail 파일이 안 생김. (-)
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
		
		var deleteReplyId; //ajax처리를 위한 댓글의 id
	    
		
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
	       	popCardId = obj.parentNode.getAttribute("data-id"); //클릭한 카드의 id값을 가져와서 var id에 담음.
	       	
	       	modifyCardTitle = $(obj); //클릭한 카드의 title표시하는 div를 전역변수에 담아둠(제목 수정 처리에 이용할 예정)
	    	
	    	$.getJSON("/board/" + p_id + "/card/" + popCardId, function(data){
	    		popCardPsId = data.ps_id; //클릭한 카드의 ps_id값 전역변수에 담아두기 	
	    		popCardlistId = data.cl_id; //클릭한 카드의 카드리스트 id값 전역변수에 담아두기(send to board에 쓸 예정)
	    		
	    		//DB에서 카드 id, 내용 가져오기(id는 화면에 표시하지 않는다.)
	    		$(".card-id-Hidden").eq(0).html(data.id);
	    		$(".title-cardTitle input").val(data.title);//카드제목 수정input태그에 'value'값으로 넣는다
	    			//.html로 담았다가 7시간 삽질함.
	    		$(contentTextarea[0]).val(data.content);
	    		popCardContent = data.content; //전역변수에 클릭한 카드의 내용을 담아둠
	    		
	    		//content의 text길이만큼 textarea의 height값 주기
	    	    contentTextarea[0].style.height = "1px";
	    	    contentTextarea[0].style.height = (contentTextarea[0].scrollHeight) + "px";
	    	    
		    	cardStatus(data.ps_id); //카드 상태값에 따라 진행, 보관, 가리기 구별하여 각각 다른 형태의 카드모달창 출력
	    	});//JSON
	    	allReply(); //모든 댓글 getJSON으로 받아오는 함수
	    	allAttach(); //모든 첨부파일 getJSON으로 받아오는 함수
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
	    function autosize() {
	    	var el = this;
	        el.style.cssText = 'height:auto; padding:0';
	        el.style.cssText = 'height:' + el.scrollHeight + 'px';
	    };
	    contentTextarea[0].addEventListener('keydown', autosize); //내용 textarea
	    contentTextarea[1].addEventListener('keydown', autosize); //댓글 textarea
	
	    
	    
	    /* 내용 | textarea 클릭시 save, close버튼 보이기/감추기 이벤트 */
	    $("body").click(function (e) { 
	    	if(popCardPsId !== 1) return; //진행 상태인 카드가 아니면 그냥 return
	        if(e.target == contentTextarea[0] || e.target == viewEdits) { //target이 textarea이거나 view edits버튼이면
	            $(".content-Btn").css("display", "block"); //버튼 보이기
	            contentTextarea[0].select(); //textarea활성화 시 text 전체선택
	        } else { //target이 textarea, view edits버튼이 아니면
	            $(".content-Btn").css("display", "none"); //버튼 숨기기
	        };
	    });
	    
	    
	    
	    /* 내용 | 등록/수정 함수 */
	    function contentSave(){
	    	var content = $(".content-textarea.description").val(); //수정textarea의 내용 담기
	    	
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
	    	var content = contentTextarea[0].value; //수정textarea의 내용 담기
	    	//내용을 수정하고 저장하지 않은 채로 textarea를 비활성화하면 저장하지 않았다는 경고메시지 뜸.
        	//경고메시지 숨김 : textarea를 클릭했을 때, 저장취소/view Edits/discard 클릭했을 때, 
        	//		textarea 밖을 클릭했는데 DB data가 null이고 textarea의 글자수가 0일 때.
	    	if(e.target == contentTextarea[0] || e.target == cancelBtn || e.target == viewEdits || 
        			e.target == discard || (e.target !== contentTextarea[0] && (popCardContent == null && content.length == 0))){
        		$(".warning").css("display", "none");
        	} else if (e.target !== contentTextarea[0] && content !== popCardContent){//textarea 밖을 클릭했을 때 data와 수정내용이 같지 않으면 경고메시지
        		$(".warning").css("display", "block");
        	};
	    });
	
	
	
	    /* 내용 수정 취소 | X버튼, discard버튼 클릭할 경우 */
	    function modifyCancel() {
	    	$.getJSON("/board/" + p_id + "/card/" + popCardId, function(data){
	    		//DB에서 내용(content) 가져오기
	    		contentTextarea[0].value = data.content;
	    		//content의 text길이만큼 textarea의 height값 주기
	            contentTextarea[0].style.height = "1px";
	            contentTextarea[0].style.height = (contentTextarea[0].scrollHeight) + "px";
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
		    			edit = "<p class='edited'>(edited)</p>";
		    		};
	    			if(ps_id === 1 && this.u_id === u_id){ //카드의 상태값이 1일 때, 본인이 쓴 댓글에만 출력됨
	    				myReply = "<div class='replyBtn reply'>" +
							   	  "    <button class='replyModifyBtn reply'>수정</button>" +
							   	  "    <button class='replyDeleteBtn reply'>삭제</button>" +
							   	  "</div>";
					};
					
	    			str += "<div data-id='" + this.id + "' data-uid='" + this.u_id + "'class='replyArea'>" +
						   "	<img src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate" + this.profile + "' />" +
						   "	<div class='reply-commentArea'>" +
						   "		<div class='reply-info'>" +
						   "        	<p class='reply-nickname'>" + this.nickname + "</p>" +
						   "        	<p class='reply-cdate'>" + this.cdate + "</p>" + edit + myReply +
						   "		</div>" +
						   "		<pre class='reply-content'>" + this.content + "</pre>" +
						   "	</div>" +
						   "</div>";
	    		});
	    		$(".activity-content").html(str);
	    	});
	    };
	    
	    
	    
	    /* 댓글 등록 | textarea에 내용이 있으면 버튼 활성화 */
	    $(".content-textarea.reply.create").on("input", function(){ 
	    	var value = $(".content-textarea.reply.create").val();
	    	
	        if(value == "" || value == null) { //textarea의 value값이 없으면
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
	    	
	        if(value == "" || value == null) { //textarea의 value값이 없으면
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
	    				contentTextarea[1].value = "";
		    			$(".content-textarea.reply.modify").css("height", "50px"); //스크롤이벤트 때문에 늘어난 height 줄임
	    				$(".saveBtn.reply.create").css("backgroundColor", "#bdbdbd61"); //Save버튼 하얀색
	    	        	$(".saveBtn.reply.create").prop("disabled", true); //Save버튼 비활성화
	    			};
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});
	    });
	    
	    
	    
	    /* 댓글 수정 | 수정 버튼을 클릭할 경우 수정textarea 출력 */
	    $(".activity-content").on("click", ".replyModifyBtn", function(){
	    	var str = "<div class='replyModify-area'>" +
	    			  "	   <textarea class='content-textarea reply modify'></textarea>" +
					  "    <div class='comment-Btn'>" +
		        	  "        <button class='saveBtn reply modify'>Save</button>" +
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
	    
	    
	    
	    /* 댓글 수정 | 댓글 수정 후 Save버튼을 클릭할 경우 - ajax처리 */
	    $(".activity-content").on("click", ".saveBtn.reply.modify", function(){
			var modifyReplyContent = $(this).parent().prev(".content-textarea.reply.modify").val(); //수정textarea의 내용
			var replyId = $(this).parents(".replyArea").attr("data-id"); //해당 댓글의 data-id
	    	var replyModifyArea = $(this).parents(".replyModify-area"); //수정textarea + Save버튼
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
		    				$(replyCdate).after("<p class='edited'>(edited)</p>"); //edit 표시 띄우기
		    			$(replyModifyArea).remove(); //수정textarea와 Save버튼 숨기기
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
					  "    <div data-id='" + id + "' data-clId='"  + cl_id +  "' class='cardtitleLi tab-cards'>" +
					  "        <div id='cardLink' onclick='loadCardData(this)'>" + title + "</div>" +
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
	    function createTrashboxCard(id, cl_id, title){
	    	var str = "<div data-id='" + id + "' data-clId='"  + cl_id +  "' class='cardtitleLi tab-cards'>" +
					  "    <div id='cardLink' onclick='loadCardData(this)'>" + title + "</div>" +
					  "    <div class='cardStatus'><i class='fas fa-archive'></i> hidden</div>" +
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
					  "        <button class='archive-reopen switchBtn-archive return returnCardlist'>Send to board</button>" +
					  "		- " +
					  "        <button class='archive-hidden switchBtn-archive return returnCardlist'>Trashbox</button>" +
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
		*/
		
		
		/* 목록 조회 */
		function allAttach(){
			$.getJSON("/board/" + p_id + "/card/" + popCardId + "/allAttach", function(list){
		    	var str = "";
		    	$(list).each(function(){
					var attachInfoStr = "<div class='attachInfo'>" +
									    "	<p class='fileName'>" + originalFileName(this.file) + "</p>" + 
									    "	<p class='uploadDate'>" + this.cdate + "</p>" +
									    "	<p class='fileSize'>" + fileUnit(this.size) + "</p>";
					if(this.ps_id === 1){ //진행카드만 delete버튼 추가하고 div 닫음
						attachInfoStr += "<button class='attachDeleteBtn' data-src='" + this.file + "'>Delete</button></div>";						
					} else { //진행카드가 아니면 delete버튼 없이 div 닫음
						attachInfoStr += "</div>";	
					};
					
					if(checkImageType(this.file)){ //이미지 파일 일 때(썸네일 img 태그 포함)
						str += "<div class='attachLi'>" +
							   "    <div class='attachThumbnail'>" +
							   "        <a href='#'>" +
							   "            <img class='thumbnail' src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/uploadFile" + this.file + "'/>" +
							   "        </a>" + 
							   "    </div>" + attachInfoStr +
							   "</div>";
					} else { //일반 파일일 때
						str += "<div class='attachLi'>" +
				  			   "    <div class='attachThumbnail'>" +
							   "        <a href='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/uploadFile" + this.file + "'>" +
							   "            <p>" + checkFileType(this.file) + "</p>" +
							   "        </a>" + 
							   "    </div>" + attachInfoStr +
							   "</div>";
					};
		    	}); //each
		    	$(".uploadedList").html(str);
	    	}); //getJSON
		};
		
	
		/* 파일 확인 | 이미지 파일인지 확인 */
		function checkImageType(fileName){
			var pattern = /jpg$|gif$|png$|jpeg$/i; // i: 대소문자 구분 안 하도록
			return fileName.match(pattern);
		};
		
		
		/* 파일 확인 | 일반 파일의 확장자 추출 */
		function checkFileType(fileName) {
			var fileType = fileName.lastIndexOf(".") + 1; //뒤에서부터 . 문자를 찾아 index반환
			return fileName.substr(fileType).toUpperCase(); //.toUpperCase() : 대문자로 변환
		};
		
		
		/* 파일명 정리 | 원본 파일명 추출하기 */
		function originalFileName(fileName){
			var originalName = fileName.indexOf("_") + 1; //파일명 중 _ 의 index값 구함
			
			if(checkImageType(fileName)){ //이미지 파일일 경우 썸네일 파일명(s_) 때문에 _가 2번 들어가므로 
				fileName = fileName.substr(originalName); //전체 파일명 중에서 s_ 뒤의 문자열 구한 다음에
				originalName = fileName.indexOf("_") + 1; //한번 더 _ 의 index값 구함
			};
			
			return fileName.substr(originalName); //_ 뒤의 문자열 return
		};
		
		
		/* 파일 확인 | 파일 크기가 10MB 이상일 때 띄우는 경고창을 숨기는 함수 */
		function hideDiv (){ 
			document.getElementsByClassName("fileSizeWarning")[0].style.display="none"; 
		};
			
		
		/* 파일 확인 | 파일 크기 측정하여 적합할 경우 ajax 호출 */
		function fileCheck(file) {
			var maxSize = 10485760; // 10MB
			var fileSize = 0;
			
			fileSize = file.size; //첨부할 file의 size
			
			console.log("파일사이즈 : " + fileSize + ", 최대파일사이즈 : 10MB");
			
			if (fileSize > maxSize) { //파일 사이즈가 10MB가 넘을 경우
				var str = "<div class='fileSizeWarning'><span>10MB 이하의 파일만 등록 가능합니다.</span></div>";
				$("#popupBox").after(str); //경고메시지 띄움
				
				setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
				return; //ajax 호출 하지 않고 return
			};
			
			//FormData객체 : <form>태그로 만든 데이터 전송 방식과 동일하게 파일 데이터 전송
			var formData = new FormData();
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
			
			fileCheck(file); //파일크기 측정하여 ajax처리 하는 함수 호출			
		});
	
			
			
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
						deleteBtn.parent().parent().remove();
					};
				}
			});
		});
	
		
		
		/* 이미지파일 조회 | img파일 썸네일을 누를 경우 */
		$(".uploadedList").on("click", ".thumbnail", function() {
			var fileName = $(this).parent().parent().next().children(".fileName").text();
			var str = "<img class='originalImg' src='" + $(this).attr("src") + "' /><p>" + fileName + "</p>";
			
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
	    
	    
    </script>
    
</body>
</html>