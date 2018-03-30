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
	<div id="popupBox" class="overlay">
        <div class="popupCard">
        	 <div class="archive-banner"><p><i class="fas fa-archive"></i> This card is archived.</p></div>
            <!-- 헤더 | 카드 제목 -->
            <header class="cardTitle">
                <i class="far fa-credit-card"></i>                
                <div class="title-cardTitle">
                	<input type="text" class="title-modify" maxlength="20"  onkeydown="enterPress(event); limitMemo(this, 20);"/><!--카드 제목 DB에서 가져옴-->
                	<p class="cardIdHidden"></p><!-- id값(hidden) -->
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
            <aside>
                <div><strong>Menu</strong></div>
                <ul>
                    <li><div class=aside-Members><i class="fas fa-users"></i><p>Members</p></div></li>
                    <li><div class=aside-Archive><i class="fas fa-archive"></i><p>Archive</p></div></li>
                    <li><div class=aside-Hide><i class="far fa-eye-slash"></i><p>Hide</p></div></li>
                    <li><div class=aside-sendToBoard><i class="fas fa-undo-alt"></i><p>Send to board</p></div></li>
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
	    	5. 달성, 가리기 (-)
	    	7. 코드정리 (-)
	    	9. 주석달기 (-)
	    	10. 변수이름 정리 (-)
	    	12. 창 줄였을 때 카드모달창 사이즈 조절 문제(-)
	    	13. enter키 눌렀을 때 저장되기 - 카드리스트제목(+)카드제목(+)카드제목수정모달(-)카드모달내용(-)
	    	17. jQuery, javascript 짬뽕 정리(-)
	    	18. 카드리스트와 통합하여 기능확인, 정리하기(-)
	    	19. 리스트에서 화면 마우스로 클릭하고 움직이면 스크롤 따라오게 (-)
	    	20. 카드리스트 달성/숨기기 모달창 띄우고 스크롤할 때 모달창만 둥둥 뜨는 문제(-)
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
	    var popCardTitle; //DB의 카드 title값을 담을 변수
		var popCardContent; ////카드 상세내용 조회할 때 클릭한 카드 내용을 담을 변수
		var cardtitleLi; //archive 누를 경우 리스트에서 삭제할 태그를 담아둘 변수
	    
	
		
		/* 카드 상세내용 조회 */
	    function loadCardData(obj) {
	       	popCardId = obj.parentNode.getAttribute("data-id"); //클릭한 카드의 id값을 가져와서 var id에 담음.
	       	modifyCardTitle = $(obj); //클릭한 카드의 title표시하는 div를 전역변수에 담아둠(제목 수정 처리에 이용할 예정)
	    	
	    	$.getJSON("/cards/" + p_id + "/card/" + popCardId, function(data){
	    		//클릭한 카드의 title값 가져오기
	    		titleDB = data.title;
	    		//DB에서 카드 id, 내용 가져오기(id는 화면에 표시하지 않는다.)
	    		$(".title-cardTitle p").html(data.id);
	    		$(".title-cardTitle input").val(titleDB);//카드제목 수정input태그에 'value'값으로 넣는다
	    			//.html로 담았다가 7시간 삽질함.
	    		$(contentTextarea).val(data.content);
	    		popCardContent = data.content; //전역변수에 클릭한 카드의 내용을 담아둠
	    		
	    		//content의 text길이만큼 textarea의 height값 주기
	    	    contentTextarea.style.height = "1px";
	    	    contentTextarea.style.height = (contentTextarea.scrollHeight) + "px";
	    	    
	    	    //달성카드인지 판단
	    	    /* if(data.ps_id === 2){
	    	    	$(".archive-banner").children("p").html("This card is archived."); //카드모달창 상단
	    	    	$(".aside-Archive").css("display", "none"); //달성버튼 가리기
	    	    	$(".aside-sendToBoard").css("display", "block"); //send to board버튼 보이기
	    			$(".archive-banner").addClass("archiveShow"); //class이름 archive 부여함으로써 화면에 출력
	    			$(".popupCard").addClass("archiveShow"); //카드모달창 padding 조절
	    	    } else {
	    			$(".archive-banner").removeClass("archiveShow"); 
	    			$(".popupCard").removeClass("archiveShow");
	    	    };
	    	    
	    	    //숨김카드인지 판단
	    	    if(data.ps_id === 3){  	
	    			$(".archive-banner").children("p").html("This card is hidden."); //카드모달창 상단
	    	    	$(".aside-Hide").css("display", "none"); //숨김버튼 가리기
	    	    	$(".aside-sendToBoard").css("display", "block"); //send to board버튼 보이기
	    			$(".archive-banner").addClass("hiddenShow"); //class이름 archive 부여함으로써 화면에 출력
	    			$(".popupCard").addClass("hiddenShow"); //카드모달창 padding 조절
	    	    } else {
	    			$(".archive-banner").removeClass("hiddenShow"); 
	    			$(".popupCard").removeClass("hiddenShow");
	    	    } */
	    	    switch (data.ps_id) {
	            case 1:
	                $(".archive-banner").removeClass("archiveShow");
	                $(".popupCard").removeClass("archiveShow");
	                $(".archive-banner").removeClass("hiddenShow");
	                $(".popupCard").removeClass("hiddenShow");
	                break;
	            case 2:
	                $(".archive-banner").children("p").html("This card is archived."); //카드모달창 상단
	                $(".aside-Archive").css("display", "none"); //달성버튼 가리기
	                $(".aside-sendToBoard").addClass("archiveShow"); //send to board버튼 보이기
	                $(".archive-banner").addClass("archiveShow"); //class이름 archive 부여함으로써 화면에 출력
	                $(".popupCard").addClass("archiveShow"); //카드모달창 padding 조절
	                break;
	            case 3:
	                $(".archive-banner").children("p").html("This card is hidden."); //카드모달창 상단
	                $(".aside-Hide").css("display", "none"); //숨김버튼 가리기
	                $(".aside-sendToBoard").addClass("hiddenShow"); //send to board버튼 보이기
	                $(".archive-banner").addClass("hiddenShow"); //class이름 archive 부여함으로써 화면에 출력
	                $(".popupCard").addClass("hiddenShow"); //카드모달창 padding 조절
	                break;
	        }
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
						url : "/cards/" + p_id + "/card/" + popCardId,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PUT"
						},
						data : JSON.stringify({title : titleModify}),
						dataType : 'text', 
						success : function(result) {
							if(result === "SUCCESS"){
								$(modifyCardTitle).text(titleModify); //수정사항 카드리스트에 적용
							}
						},
						error : function() {
							alert("에러가 발생했습니다.");
						}
					});//ajax
				};
	    };
	    
	    /* 제목 수정 | 카드 모달창(전체)을 클릭할 경우 */
	    $(cardModal).click(function(){
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
	        if (e.target == contentTextarea || e.target == viewEdits) { //target이 textarea이거나 view edits버튼이면
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
	    		url : "/cards/"+p_id+"/card/" + popCardId,
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
        		//textarea 밖을 클릭했는데 DB data가 null이고 textarea의 글자수가 0일 때.
	    	if(e.target == contentTextarea || e.target == cancelBtn || e.target == viewEdits || 
        			e.target == discard || (e.target !== contentTextarea && (popCardContent == null && content.length == 0))){
        		$(".warning").css("display", "none");
        	} else if (e.target !== contentTextarea && content !== popCardContent){//textarea 밖을 클릭했을 때 data와 수정내용이 같지 않으면 경고메시지
        		$(".warning").css("display", "block");
        	};
	    });
	
	
	
	    /* 내용, 제목 수정 취소 | X버튼, discard버튼 클릭할 경우 */
	    function modifyCancel() {
	    	$.getJSON("/cards/" + p_id + "/card/" + popCardId, function(data){
	    		//DB에서 내용(content) 가져오기
	    		contentTextarea.value = data.content;
	    		//content의 text길이만큼 textarea의 height값 주기
	            contentTextarea.style.height = "1px";
	            contentTextarea.style.height = (contentTextarea.scrollHeight) + "px";
	    	});
	    	$(".warning").css("display", "none");
	    };
	    
	    
	    
	    /* 달성 | 카드모달창에서 달성 메뉴 클릭할 경우 */
	    //$(".aside-Archive").click(function(){
	    $("aside ul li").click(function(){
	    	alert("ㄴ");
	    	var CARD_STATUS_ARCHIVE = 2;
	    	var CARD_STATUS_HIDDEN = 3;
	    	var ps_id;
	    	$.ajax({
	    		type : 'put',
	    		url : "/cards/"+p_id+"/card/" + popCardId,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},
	    		data : JSON.stringify({ps_id : ps_id}),
	    		dataType : 'text', 
	    		success : function(result) {
	    			if(result === "SUCCESS"){
		    			$(".archive-banner").addClass("archiveShow"); //카드모달창 상단 상태 표시
		    			$(".popupCard").addClass("archiveShow"); //카드모달창 padding 조절
		    				    			
		    			//카드리스트에서 숨기기, 달성탭에서 보이기
		    			cardtitleLi = $(modifyCardTitle).parent(); //달성탭으로 태그 보내기 위해 변수에 담아둠
		    			$(modifyCardTitle).parent().detach(); //리스트에서 카드 삭제(detach() : 하위태그 모두 삭제)
		    			$(cardtitleLi).addClass("archive"); //달성탭에서 보이는 카드의 CSS 속성 변경을 위해 클래스이름 archive추가
		    			$(".nav-tab-content-Box-card").prepend(cardtitleLi); //card태그 삽입
		    			$(cardtitleLi).children("button").css("display", "none"); //수정 버튼 가리기
		    			$(".aside-Archive").css("display", "none"); //달성버튼 가리기
		    			$(".aside-sendToBoard").css("display", "block"); //send to board버튼 보이기
		    			$(cardtitleLi).children("#cardLink").append("<div><i class='fas fa-archive'></i> archive</div>"); //달성탭에서 보이는 카드에 아이콘 삽입
		    			var str = "<p class='quiet'>" + 
		    					  "    <button class='archive-reopen archiveBtn'>Send to Cardlist</button>" +
		    					  " - " +
		    					  "    <button class='archive-hidden archiveBtn'>Hidden</button>" +
		    					  "</p>";
		    			$(".cardtitleLi.archive").eq(0).after(str); //Send to cardlist... & hidden버튼 추가하기
	    			};
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
	    });
	    
	    

    </script>
    
</body>
</html>