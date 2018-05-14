
/**********************************************************************************
 * 파일명칭 : cardModal.js
 * 기    능 : 카드 상세정보 조회, 제목/내용 수정, 보관함/휴지통<->프로젝트 이동,
 * 			  dropdown 메뉴 관련 기능을 구현하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
 **********************************************************************************/



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
var popCardFavorite; //즐겨찾기
var popCardUhcUID; //즐겨찾기 한 유저


/*
 * 전체 조회 
 */

/* 카드 상태값에 따라 카드모달창 출력이 달라짐 */
/*
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
    	$(".content-content > div").css("top", "375px"); //read more 위치 조정
    	$(".comment").show(); //댓글 작성 보이기
    	$(".popCardMenu").show(); //메뉴버튼 보이기
    	$(".cardTitle > span").addClass("star");
    	if(popCardFavorite === 1 && popCardUhcUID === u_id) //즐겨찾기된 경우
			$(".cardTitle > .star").html("<i class='fas fa-star'></i>"); //채워진 별 아이콘
		else  //즐겨찾기가 아닌 경우
			$(".cardTitle > .star").html("<i class='far fa-star'></i>"); //빈 별 아이콘
        break;
    case 2: //보관일 때
    	$(".changeStatus").removeClass("changeStatus"); //관련된 모든 클래스 이름에서 changeStatus 제거하여 CSS 속성 초기화
    	$(".popCard-banner.archive").addClass("changeStatus"); //1. 카드 상단에 상태바-보관 출력
    	$(".popupCard").addClass("changeStatus");//2. 카드모달창 padding 조절
    	$(".popupCard-aside-archive").addClass("changeStatus"); //3. 보관버튼 숨기기
    	$(".popupCard-aside-hide").removeClass("changeStatus"); //3. 휴지통버튼 출력
    	$(".popupCard-aside-sendToCardlist").addClass("changeStatus"); //4. '프로젝트로' 메뉴 출력
    	$(".content-content > div").css("top", "423px"); //read more 위치 조정
    	$(".comment").hide(); //댓글 작성 숨기기
    	$(".popCardMenu").show(); //메뉴버튼 보이기
    	$(".cardTitle > span").html("<i class='far fa-credit-card'></i>"); //별 아이콘 없앰
    	$(".star").removeClass("star");
    	
    	$(".title-modify").prop("disabled", true); //제목 수정 못하게
    	$(".content-textarea").prop("disabled", true); //내용 수정 못하게
    	$(".attach-content").hide(); //첨부파일 추가 영역 숨기기
    	break;
    case 3: //휴지통일 때
    	$(".changeStatus").removeClass("changeStatus"); //관련된 모든 클래스 이름에서 changeStatus 제거하여 CSS 속성 초기화
    	$(".popCard-banner.hide").addClass("changeStatus"); //1. 카드 상단에 상태바-휴지통 출력
    	$(".popupCard").addClass("changeStatus");//2. 카드모달창 padding 조절
    	$(".popupCard-aside-archive").addClass("changeStatus"); //3. 보관버튼 숨기기
    	$(".popupCard-aside-hide").addClass("changeStatus"); //3. 휴지통버튼 숨기기
    	$(".popupCard-aside-sendToCardlist").removeClass("changeStatus"); //4. '프로젝트로' 메뉴 숨기기
    	$(".content-content > div").css("top", "423px"); //read more 위치 조정
    	$(".comment").hide(); //댓글 작성 숨기기
    	$(".popCardMenu").hide();//메뉴 버튼 숨기기
    	$(".cardTitle > span").html("<i class='far fa-credit-card'></i>"); //별 아이콘 없앰
    	$(".star").removeClass("star");
    	
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
	
	$.getJSON("/board/" + p_id + "/card/" + popCardId, function(data) {
		popCardPsId = data.ps_id; //클릭한 카드의 ps_id값 전역변수에 담아두기 	
		popCardlistId = data.cl_id; //클릭한 카드의 카드리스트 id값 전역변수에 담아두기(send to board에 쓸 예정)
		popCardFavorite = data.status; //즐겨찾기 여부
		popCardUhcUID = data.uhc_u_id; //즐겨찾기 한 유저
		
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

/* 조회 닫기 | 카드 모달창의 닫기버튼 누르면 모달창 사라짐 */
$(".popupCardClose").click(function(){
	cardModal.style.display = "none";
});



/*
 * 제목 
 */



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
					$(".cardtitleLi[data-id='" + popCardId + "'] > #cardLink").text(titleModify); //수정사항 카드리스트에 적용
			},
			error : function() {
				alert("통신 에러가 발생했습니다."); 
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
		


/*
 * 내용 
 *  - 유효성 검사 : 글자수 제한 10,000byte - 한글 5,000자, 영문 10,000자
 */



/* 내용 조회 | read more버튼을 클릭했을 경우 */
$(".readMore").click(function() {
	//content의 text길이만큼 textarea의 height값 주기
    contentTextarea[0].style.height = "1px";
    contentTextarea[0].style.height = (contentTextarea[0].scrollHeight) + "px";
    
    $(".readMore-box").hide(); 
});

/* 내용 | textarea 밑에 byte 표시하기 */
$(function(){
	$(contentTextarea[0]).keyup(function(){
		bytesHandler(this);
	});
});
function bytesHandler(obj){
	var text = $(obj).val();
	$(".countByte").text(getTextLength(text));
	
	//지정된 글자수 이상이면 경고창 출력
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
    	    	
    	    	//내용이 없다가 추가된 경우 리스트 목록에 아이콘 추가
    	    	if($.trim(popCardContent) === "" && content !== "") 
    	    		$(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").prepend("<i class='fas fa-align-left'></i>");
    	    	//내용이 있다가 없어진 경우 리스트 목록의 아이콘 삭제
    	    	else if((popCardContent !== "" || popCardContent !== null) && (content === "" || content === null))
    	    		$(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").children(".svg-inline--fa.fa-align-left.fa-w-14").remove();
    	    		
    	    	$(".warning").css("display", "none"); //경고메시지 숨기기
    			popCardContent = content; //전역변수에 담긴 content값 바꿔주기
			};
			
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
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
 * 카드 보관/휴지통 관련
 */



/* 카드 보관/휴지통 | 보관탭에 삽입될 카드 태그 생성 */
function createArchivedCard(id, cl_id, title, content, reply, file) {
	if(content === undefined) content = 0;
	if(reply === undefined) reply = 0;
	if(file === undefined) file = 0;
	
	var str =  "<div class='nav-tab-content-Box-archive archive-cards'>"
			+  "    <div data-id='" + id + "' data-clId='"  + cl_id + "' class='cardtitleLi tab-cards' onclick='loadCardData(this)'>"
			+  "        <div id='cardLink'>" + title + "</div><div class='cardStatus'>";
	if(content === 1)
		str += "<i class='fas fa-align-left'></i>";	
	if(reply !== 0)
		str += "<i class='far fa-comment'></i>" + reply;
	if(file !== 0)
		str += "<i class='fas fa-paperclip'></i>" + file;
		str	+= "        <i class='fas fa-archive'></i> 보관함</div>"
			+  "    </div>"
			+  "    <p class='quiet'>"
			+  "        <button class='archive-reopen switchBtn-archive return returnCard'>프로젝트로</button>"
			+  "     - "
			+  "        <button class='archive-hidden switchBtn-archive return returnCard'>휴지통으로</button>"
			+  "    </p>"
			+  "</div>";
	return str;
};

/* 카드 보관/휴지통 | 휴지통탭에 삽입될 카드 태그 생성 */
function createTrashboxCard(id, cl_id, title, content, reply, file) {
	if(content === undefined) content = 0;
	if(reply === undefined) reply = 0;
	if(file === undefined) file = 0;
	
	var str =  "<div data-id='" + id + "' data-clId='"  + cl_id + "' class='cardtitleLi tab-cards' onclick='loadCardData(this)'>"
			+  "    <div id='cardLink'>" + title + "</div><div class='cardStatus'>";
	if(content === 1)
		str += "<i class='fas fa-align-left'></i>";	
	if(reply !== 0)
		str += "<i class='far fa-comment'></i>" + reply;
	if(file !== 0)
		str += "<i class='fas fa-paperclip'></i>" + file;
		str	+= "    <i class='fas fa-trash-alt'></i> 휴지통</div>"
			+  "</div>";
	return str;
};
	    
	    
/* 카드리스트 보관/휴지통 | 보관탭에 삽입될 카드리스트 태그 생성 */
function createArchivedCardlist(id, title){
	var str = "<div class='nav-tab-content-Box-archive archive-cards'>"
			+ "    <div data-id='" + id + "' class='cardlist tab-cardlist'>"
			+ "        <div class='cardlistTitleBox tab-cardlist'>"+ title +"</div>"
			+ "    </div>"
			+ "    <p class='quiet'>"
			+ "        <button class='archive-reopen switchBtn-archive return returnCardlist'>프로젝트로</button>"
			+ "		- "
			+ "        <button class='archive-hidden switchBtn-archive return returnCardlist'>휴지통으로</button>"
			+ "    </p>"
			+ "</div>";
	return str;
};

/* 카드리스트 보관/휴지통 | 휴지통탭에 삽입될 카드리스트 태그 생성 */
function createTrashboxCardlist(id, title){
	var str = "<div data-id='" + id + "' class='cardlist tab-cardlist'>"
			+ "    <div class='cardlistTitleBox tab-cardlist'>" + title + "</div>"
			+ "</div>";
	return str;
};



/* 카드 보관/휴지통 수정 | ajax처리 */
function cardStatusChange(id, ps_id, cl_id){
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
			var data = JSON.parse(data);
			
			$(".cardtitleLi[data-id=" + id + "]").parent(".nav-tab-content-Box-archive.archive-cards").remove(); //휴지통탭에서 카드 밑의 send to cardlist, Trashbox 버튼까지 함께 삭제
			$(".cardtitleLi[data-id=" + id + "]").remove(); //카드리스트에서 카드 삭제
			deleteFavorite(id); //즐겨찾기 카드일 경우 status 초기화
			
			switch (ps_id) {
		    	case 1: //카드리스트에 카드 태그 삽입
		    		listCards(cl_id); //해당 카드리스트의 카드 목록 갱신
		    		break;
		    	case 2: //보관탭에 카드 태그 삽입
		    		$(".nav-tab-content-Box-archive.archiveCard").prepend( createArchivedCard(id, cl_id, data.title, data.checkContent, data.reply, data.file) ); //보관탭에 동적 카드태그 삽입
		    		break;
		    	case 3: //휴지통탭에 카드 태그 삽입
		    		$(".nav-tab-content-Box-hidden.hiddenCard").prepend( createTrashboxCard(id, cl_id, data.title, data.checkContent, data.reply, data.file) ); //휴지통탭에 동적 카드태그 삽입
		    		break;
	    	};
			cardStatus(ps_id); //상태값에 맞게 카드모달창 형태 변경 
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	});//ajax
};



/* 카드 보관/휴지통 수정 | 카드모달창에서 보관버튼 or 휴지통버튼 클릭할 경우 */
$(".popupCard-aside ul li div").click(function(){
	var className = $(this).attr("class"); //클릭한 요소의 class이름
	//var title = $(".title-cardTitle input").val(); //클릭한 카드의 title
	
	
	if(className === "popupCard-aside-sendToCardlist changeStatus"){ //send to cardlist 버튼이면
		popCardPsId = STATUS_ING; //ps_id = 1
	} else if(className === "popupCard-aside-archive"){ //보관 버튼이면
		popCardPsId = STATUS_ARCHIVE; //ps_id = 2
	} else if(className === "popupCard-aside-hide"){ //휴지통 버튼이면
		if(confirm("휴지통으로 보내진 카드는 되돌릴 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
    		popCardPsId = STATUS_HIDDEN; //ps_id = 3
    	else return; //취소를 누르면 더이상 작업 수행하지 않고 return
	} else { 
		return; 
	};
	
	cardStatusChange(popCardId, popCardPsId, popCardlistId); //상태변경에 대한 ajax처리 함수 호출
});



/* 카드모달창 dropdown 메뉴 | 열고 닫기 */
$(".popCardMenu").click(function(){
	$(".popupCard-aside").toggle();
});
/* 카드모달창 dropdown 메뉴 | 다른 영역 누르면 닫기 */
$(document).on("click", function(e){
	var className = $(e.target).attr("class");
	if(className !== "popCardMenu" && className !== "popCardMenuIcon") { 
		$(".popupCard-aside").hide();
	};
});


/* 즐겨찾기 | 별 아이콘을 눌렀을 경우 */
$(".cardTitle").on("click", ".star", function(){
	if(popCardFavorite === null) { //즐겨찾기가 아니면
		addFavorite(popCardId); //추가 ajax처리
		$(this).html("<i class='fas fa-star'></i>"); //채워진 별 아이콘
		popCardFavorite = 1; //전역변수 status값 변경
	} else { //즐겨찾기면
		deleteFavorite(popCardId); //삭제 ajax처리
		$(this).html("<i class='far fa-star'></i>"); //빈 별 아이콘		
		popCardFavorite = null; //전역변수 status값 변경
	};
});
	