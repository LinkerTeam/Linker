
/**********************************************************************************
 * 파일명칭 : cardModalReply.js
 * 기    능 : 카드 상세 내용 조회 모달에서의 댓글 기능을 구현하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/04
 **********************************************************************************/



var deleteReplyId; //ajax처리를 위한 댓글의 id
	    

	    
/* 조회 | getJSON으로 데이터 받아와서 동적 태그 생성하여 삽입 */
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

	    
/* 등록 | textarea에 내용이 있으면 버튼 활성화 */
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

/* 수정 | textarea에 내용이 없으면 버튼 비활성화 */
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

/* 등록 | 저장 버튼을 클릭할 경우 */
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
				var count = $(".replyArea").length; //댓글 개수
				//댓글 아이콘이 없는 상태에서 새로 등록할 경우 아이콘과 1추가
				if(count === 0)
					$(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").append("<i class='far fa-comment'></i><p>1</p>");
				else //댓글 아이콘이 있는 상태에서 새로 등록할 경우 count +1
					$(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").children(".svg-inline--fa.fa-comment.fa-w-18").next("p").html(count + 1);
    			allReply(); //댓글 목록 갱신
    			modifyReplyCancel(); //textarea value 초기화
			};
		},
		error : function() {
			alert("에러가 발생했습니다.");
		}
	});
});

/* 등록 | textarea value 초기화 */
function modifyReplyCancel() {
	$(".content-textarea.reply.create").val(""); //value 초기화
	$(".content-textarea.reply.create").css("height", "50px"); //스크롤이벤트 때문에 늘어난 height 줄임
	$(".saveBtn.reply.create").css("backgroundColor", "#bdbdbd61"); //저장버튼 하얀색
	$(".saveBtn.reply.create").prop("disabled", true); //저장버튼 비활성화
};
	
	    
/* 수정 | 수정 버튼을 클릭할 경우 수정textarea 출력 */
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

/* 수정 | 수정 X버튼 누를 경우 textarea사라짐 */
$(".activity-content").on("click", ".cancelBtn.reply", function(){
	$(this).parent().parent().prevAll().toggle();
	$(this).parent().parent(".replyModify-area").remove();
});

/* 수정 | 댓글 수정 후 저장버튼을 클릭할 경우 - ajax처리 */
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



/* 삭제 | 삭제 버튼 누를 경우 모달창 띄움 */
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

/* 삭제 | 모달창 이외의 영역을 클릭하면 모달창 닫기 */
$(document).on("click", function(e){
	var className = $(e.target).attr("class"); //클릭한 요소의 class이름
	
	if(className !== "closeBoardModal reply" && className !== "replyDeleteBtn reply" 
			&& className !== "closeTitle reply" && className !== "closeBoardModal-text reply")
		$(".closeBoardModal.reply").hide();
});

/* 삭제 | ajax처리 */
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
				var count = $(".replyArea").length; //댓글 개수
				var replyIcon = $(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").children(".svg-inline--fa.fa-comment.fa-w-18");
				if(count === 1) { //댓글이 1개인 상태에서 삭제했을 경우 아이콘, 개수 p태그 삭제
					$(replyIcon).next("p").remove();
					$(replyIcon).remove();
				} else { //삭제 후에도 댓글이 0개가 아니면 count -1
					$(replyIcon).next("p").html(count - 1);
				};
    			
				$(".replyArea[data-id=" + deleteReplyId + "]").remove(); //해당 댓글 삭제
			};
		},
		error : function() {
			alert("에러가 발생했습니다.");
		}
	});
});

