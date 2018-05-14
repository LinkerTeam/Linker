
/**********************************************************************************
 * 파일명칭 : cardTest.js
 * 기    능 : 프로젝트 제목 수정, 
 * 			  카드리스트 생성, 수정, 보관함/휴지통<->프로젝트화면 이동,
 *            카드 생성, 수정, 보관함/휴지통<->프로젝트화면 이동 관련 기능 구현하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
 **********************************************************************************/



var modifyModal = document.getElementsByClassName('modifyModal')[0]; // 카드title 수정하는 모달창
var modifyTextarea = document.getElementById("modifyTextarea"); //카드 title 수정하는 textarea
var closeModal = document.getElementsByClassName("closeModal")[0]; // 카드 title 수정하는 모달창의 닫힘버튼(X)
	
var addList = document.getElementsByClassName("addList")[0]; //카드리스트 제일 마지막의 Add a List...(카드 리스트 추가)
var createList = document.getElementsByClassName("create")[0]; //카드리스트 추가할 때 생기는 미니창
var createListTextarea = document.getElementById("createListTextarea"); //카드리스트 추가하는 textarea
var listAddBtn = document.getElementById("listAddBtn"); //카드리스트 추가할 때의 저장버튼

var cards = document.getElementsByClassName("cards"); //카드리스트 각각의 div 중 실제 카드 목록이 들어가는 div
var createCardBox = document.getElementsByClassName("createCardBox"); //카드리스트 각각의 div 중 footer-Add a card...부분
var addCard = document.getElementsByClassName("addCard"); //카드리스트 각각의 div 중 카드추가창
var createCardTextarea = document.getElementById("createCardTextarea"); //카드추가창의 textarea

var cardlistIndex; //스크롤 조절에 쓸 카드리스트의 인덱스
var modifyCardTitle; //수정할 카드의 title을 출력하는 div를 담을 변수

var cardlistId; //카드리스트 ...(팝업메뉴) 클릭 시 카드리스트의 id를 담을 변수
var cardlistTitle = ""; //카드리스트 ...(팝업메뉴) 클릭 시 카드리스트의 제목을 담을 변수

var STATUS_ING = 1; //진행 (상태변경에 사용)
var STATUS_ARCHIVE = 2; //보관 (상태변경에 사용)
var STATUS_HIDDEN = 3; //가리기 (상태변경에 사용)

var p_title; //프로젝트 title



/* 프로젝트 title 수정 | 관련된 모든 이벤트 */
$("input[name=projectTitle]").on({	
	focusin: function (event) { 
		$(this).select(); //전체선택
		p_title = $(this).val(); // 기존의 프로젝트 제목을 저장
	},
	focusout: function (event) {
		//유효성 검사: 빈값을 입력할 경우 기본의 제목을 출력
		if($(this).val() === null || $.trim($(this).val()) === "") 
			$(this).val(p_title); 
		//기존의 제목과 입력한 값이 다를 경우에만 ajax호출
		if($(this).val() !== p_title)
			projectTitleModify($(this).val()); //ajax처리
	},
	keydown: function (key) { //Enter키 누르면
		if (key.keyCode === 13 || key.keyCode === 27) {
			event.preventDefault(); //기본 이벤트 제거
	       	$(this).blur(); //포커스 없앤다
		};
	},
});


/* 프로젝트 title 수정 | ajax 처리 */
function projectTitleModify(p_title){
	$.ajax({
		type : 'put',
		url : "/main/" + p_id + "/" + u_id,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data : JSON.stringify({title : p_title}),
		dataType : 'text', 
		success : function(result) {
			if(result === "SUCCESS"){
				$("input[name=projectTitle]").val(p_title); //수정사항 input tag에 적용
			};
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	});//ajax
};



/* 매개변수 카드리스트id와 카드리스트title이 주어지면 그것을 이용해 카드리스트 태그를 문자열로 만드는 함수 */
function newCardlistAdd(cardlistId, cardlistTitle){
	var listStr = "<div data-id='" + cardlistId + "' class='cardlist'>"
				+ "	   <div class='cardlistTitleBox'>"
				+ "	   	   <button type='button' class='cardlistPopBtn'><img src='/resources/image/more.png' class='cardlistMore'/></button>"
				+ "	       <textarea class='cardlistTitle' rows='1' onKeyUp='limitMemo(this, 20)'>" + cardlistTitle + "</textarea>"
				+ "	   </div>"
				+ "	   <div class='cards'>"
				+ "		   <div class='addCard'>"
				+ "    		   <textarea name='title' id='createCardTextarea' class='createCardTextarea' style='resize:none' onKeyUp='limitMemo(this, 20)'></textarea><br />"
				+ "    		   <button type='button' id='addBtn'>추가</button>"
				+ "    		   <button type='button' id='cancleBtn'>&times;</button>"
				+ "		   </div>"
				+ "   	</div>"
				+ "   	<footer class='createCardBox'>카드 추가</footer>"
				+ "</div>";
	$(".cardlists").children(".addCardlist").before(listStr);
	// 타이틀 길이만큼 필드의 높이를 조정
	var newTitle = $('[data-id='+cardlistId+']').find('textarea.cardlistTitle');
	newTitle.height(newTitle.prop('scrollHeight'));
};
				

/* 매개변수 카드id와 카드title이 주어지면 그것을 이용해 카드 태그를 문자열로 만드는 함수 */
function newCardAdd(cardId, cardlistId, cardTitle, status, uhc_u_id, content, file, reply) {
	if(status === undefined) status = 0;
	if(uhc_u_id === undefined) status = null;
	if(content === undefined) content = 0;
	if(file === undefined) file = 0;
	if(reply === undefined) reply = 0;
	
	var cardClass = "cardtitleLi";
	if(status === 1 && uhc_u_id === u_id)
		cardClass = "cardtitleLi favo";
	var newTitle =  "<div data-id='" + cardId + "' data-clId='" + cardlistId + "' class='" + cardClass + "' onclick='loadCardData(this)'>"
				 +  "    <div id='cardLink'>" + cardTitle + "</div><div class='cardIcon'>";
	if(content === 1)
		newTitle += "<i class='fas fa-align-left'></i>";	
	if(reply !== 0)
		newTitle += "<i class='far fa-comment'></i><p>" + reply + "</p>";
	if(file !== 0)
		newTitle += "<i class='fas fa-paperclip'></i><p>" + file + "</p>";
		newTitle += " 	 </div>"
				 +  "    <button class='cardModifyBtn' onclick='cardTitleModifyModal(this)'><i class='far fa-edit'></i></button>"
				 +  "</div>";
	return newTitle;
};


/* 글자수 제한 */
function limitMemo(obj, cnt) {
	if (obj.value.length > cnt){
		alert(cnt + "자 이내로 입력하세요.");
		obj.value = obj.value.substring(0, cnt);
	};
};


/* 카드리스트 제목영역 높이에 따라 카드리스트 전체 높이 조정 */
function cardsHeightControl(index){ //높이 조절할 카드리스트의 인덱스값을 매개변수로 넘겨줌
	var cardHeaderHeight = $(".cardlistTitle").eq(index).height(); //index번째 카드리스트 제목영역의 높이
	if(cardHeaderHeight > 40){ 
		$(".cards").eq(index).css("max-height", "calc(100% - 26px - 45px - 20px - 20px)");
	} else {
		$(".cards").eq(index).css("max-height", "calc(100% - 26px - 45px - 20px)");
	};
};



/* 카드 조회 | 한 프로젝트에 대한 전체 카드리스트 목록 출력 */
function allCardlist(){
	$.ajax({
		type : "GET",
		url : "/board/" + p_id,
		success : function(data) {
			var allID = new Array(); //카드리스트 id를 담을 배열
			var idIndex = new Array(); //data배열의 id에서 uniqID들의 index값
			
			var uniqID = new Array(); //중복되지 않은 id 배열
			var uniqTitle = new Array(); //uniqID들의 title 배열
			
			//DB에서 받아온 데이터를 이용하여 루프를 돌면서 카드리스트 id를 배열에 추가
			for(var i = 0; i < data.length; i++){
				allID.push(data[i].cl_id);
			};
			//중복되는 id값을 제거
			uniqID = allID.reduce(function(a, b){
						 if(a.indexOf(b) < 0) 
						 	a.push(b);
						 return a;
					 }, []);
			//data 배열에서 id: uniqID[i]의 index를 구함
			for (var i = 0; i < uniqID.length; i++) {
			    var index = data.map(function (item) {
			                    return item.cl_id;
			                }).indexOf(uniqID[i]); 
			    idIndex.push(index);

			    uniqTitle.push(data[idIndex[i]].cl_title); //구한 index값을 이용하여 해당 title을 뽑아내 uniqTitle에 담음
			};
			//카드리스트 출력하기
			var listStr = ""; //동적으로 생성할 태그를 문자열로 담을 변수
			for(var i = 0; i < uniqID.length; i++){ //for문을 돌면서 각각의 카드리스트에 대한 태그를 문자열로 만든다.
				newCardlistAdd(uniqID[i], uniqTitle[i]);
			
				cardsHeightControl(i); //카드리스트 제목영역 높이에 따라 카드리스트 전체 높이 조정
			};
	  		//카드 출력하기
	  		//for문을 돌면서 각각의 카드에 대한 태그를 문자열로 만든다.
	  		for(var i = 0; i < uniqID.length; i++){ 
	  			for(var j = 0; j < data.length; j++){
	  				//카드리스트id가 위에서 만든 카드리스트id 배열의 값과 같고 ps_id가 1(진행)일 때
		  			if(data[j].cl_id === uniqID[i] && data[j].c_ps_id === 1){ 
		  				var cardStr = newCardAdd(data[j].c_id, data[j].cl_id, data[j].c_title, 
		  						data[j].status, data[j].uhc_u_id, data[j].content, data[j].file, data[j].reply); //문자열로 카드 태그를 만드는 함수 호출
		  				$(".cardlist[data-id=" + uniqID[i] + "]").children(".cards").children(".addCard").before(cardStr);
		  			};
	  			};
			};
	  		
		},//success
		error : function() {
			alert("통신 에러가 발생했습니다."); 
	   	}
	});//ajax
	allFavorite(); //즐겨찾기 전체 목록 조회
};



/* 프로젝트 상태값에 따라 화면 다르게 출력 */
switch (p_ps_id) {
    case 1 : //프로젝트 상태값이 1(진행)이면 모든 카드리스트&카드 조회하는 함수 호출
    	allCardlist();
        break;
    case 2 : //프로젝트 상태값이 2(가리기)이면 board close화면 띄우는 함수 호출
    	closeBoardStr();
    	break;
    case 3 : //프로젝트 상태값이 3(완전 숨기기)이면 board not found 화면 띄우는 함수 호출
    	deleteBoardStr();
        break;
};



/* 카드 조회 | 특정 카드리스트에 대한 카드 조회 */
function listCards(cl_id){
	var addCard = $(".cardlist[data-id=" + cl_id + "]").children(".cards").children(".addCard").clone(); //복사
	var str = "";
	//새로운 데이터 받아옴
	$.getJSON("/board/" + p_id + "/cardlist/" + cl_id + "/cards", function(data) {
  		for(var i = 0; i < data.length; i++) { 
			str += newCardAdd(data[i].c_id, data[i].cl_id, data[i].c_title, data[i].status, 
					data[i].uhc_u_id, data[i].content, data[i].file, data[i].reply); //문자열로 카드 태그를 만드는 함수 호출
		};
		$(".cardlist[data-id=" + cl_id + "]").children(".cards").html(str); //동적 카드 태그 삽입
		$(".cardlist[data-id=" + cl_id + "]").children(".cards").append(addCard); //마지막에 카드 등록 textarea태그 추가
	});
};


/* 카드 등록 | Add a card... 눌렀을 때 카드추가창 보이기 */
$(".cardlists").on("click", ".createCardBox", function(){
	var index = $("footer.createCardBox").index(this);//카드리스트의 전체 footer 중 클릭한 footer의 인덱스값 얻기
	var cardlistHeader = $(this).parent().children(":first").height(); //카드리스트 제목영역 높이		
	
	$(".hidden").removeClass("hidden"); //다른 요소들의 클래스이름 hidden을 제거함으로써 나타내기
	$(this).addClass("hidden"); //Add a card...에 클래스이름 hidden을 부여함으로써 숨기기
	
	$(".show").removeClass("show"); //다른 요소들의 클래스이름 show를 제거함으로써 숨기기
	$(".showLong").removeClass("showLong"); //다른 요소들의 클래스이름 showLong을 제거함으로써 카드리스트 높이 초기화
	$(this).prev().children(".addCard").addClass("show"); //카드추가창에 클래스이름 show를 부여함으로써 나타내기
	
	//카드리스트 높이 조절
	if(cardlistHeader < 40)
		$(".show").parent().addClass("showLong");  //.cards에 클래스이름 show부여(heigth 조절, 끝부분 radius주기 위해) : 헤더가 한 줄일 경우
	else 
		$(".show").parent().addClass("show"); //.cards에 클래스이름 show부여(heigth 조절, 끝부분 radius주기 위해) : 헤더가 두 줄일 경우

	$(".addCard.show").children().first().focus(); //커서 포커스 줌. 
	
	cards[index].scrollTop = cards[index].scrollHeight; //추가창 보이도록 스크롤 아래로 이동
});
		


/* 카드 등록 | 카드추가창 바깥을 클릭하면 카드추가창 사라지게 */
$(document).click(function(e){
	//클릭한 객체의 id와 class이름을 가져옴.
	var id = $(e.target).attr("id");
	var className = $(e.target).attr("class");
	
	//2. 클릭한 객체가 Add a card... & 카드추가창이 아니면 or X버튼이면
	if((className !== "addCard show" && className !== "createCardBox hidden" && id !== "createCardTextarea") || id === "cancleBtn"){ 
		$(".hidden").removeClass("hidden"); //클래스이름 hidden을 제거함으로써 나타내기
		$(".show").removeClass("show"); //클래스이름 show를 제거함으로써 숨기기
		$(".showLong").removeClass("showLong"); //클래스이름 showLong를 제거함으로써 숨기기
	};
});



/* 카드 등록 | 저장버튼 눌렀을 때의 처리 */
$(".cardlists").on("click", "#addBtn", function(){
	cardlistIndex = $(".addCard #addBtn").index(this); //전체 add버튼 중 this의 인덱스값 구하기
	
	var title = $(".createCardTextarea").eq(cardlistIndex).val(); //사용자가 입력한 내용은 변수로 처리
	var cl_id = $(".createCardTextarea").eq(cardlistIndex).parents(".cardlist").attr("data-id"); //해당 카드리스트의 id값
	
	//아무 값도 입력하지 않을 경우
	if(title === ''){ return; }
	
	$.ajax({
		type : "post",
		url : "/board/" + p_id + "/card",
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : 'text',
		data : JSON.stringify({
			u_id : u_id,
			title : title,
			cl_id : cl_id
		}),
		success : function(cardId){
			if (cardId !== null || cardId !== 0) {
				var cardStr = newCardAdd(cardId, cl_id, title); //새로운 카드 태그 생성
				$(".addCard").eq(cardlistIndex).before(cardStr); //카드추가창 위에 새카드 태그 삽입
				$(".createCardTextarea").val(''); //textarea 초기화
				cards[cardlistIndex + 1].scrollTop = cards[cardlistIndex + 1].scrollHeight; //스크롤 조정(즐겨찾기 리스트 때문에 +1)
			};
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	});//Ajax
});
	


/* 카드 제목 수정 |  카드 목록에서 수정 버튼 클릭할 경우 모달창 띄우기 */
function cardTitleModifyModal(obj){
	event.stopPropagation(); //이벤트 전파 방지. 부모의 이벤트인 카드모달창 띄우는 이벤트가 발생하지 않도록 한다.

	modifyCardTitle = $(obj).prev().prev(); //수정할 카드의 title표시하는 div를 전역변수에 담아둠(수정 저장버튼 처리에 이용할 예정)
	// 모달창을 클릭한 카드의 위치에서 뜨도록 함.
	// 1. 클릭한 수정버튼의 부모 찾아가서(cardtitleLi) 그 부모의 좌표값을 구하기
	var cardtitleLiX = $(obj).parent("div").offset().left; //그 수정버튼의 부모 태그의 x좌표
	var cardtitleLiY = $(obj).parent("div").offset().top - 60; //그 수정버튼의 부모 태그의 y좌표에서 즐겨찾기 버튼의 height만큼을 뺀 좌표
	
	// 2. 카드리스트의 전체높이 구하기
	var headerHeight = parseInt($(obj).parent().parent().prev().css("height")); //카드리스트 헤더 높이
	var listHeight = parseInt($(obj).parent().parent().css("height")); //카드리스트 중 카드부분 높이
	var footerHeight = parseInt($(".createCardBox").css("height")); //카드리스트 푸터 높이
	var x = headerHeight + listHeight + footerHeight; //카드리스트 전체높이
				
	var listScrollHeight = $(obj).parent().parent().prop("scrollHeight"); //클릭한 수정버튼의 조상 .cards의 scrollHeight
	
	var cardId = $(obj).parent().attr("data-id"); //카드의 id값을 담는다.
	var title = $(obj).parent().children("a").text(); //카드의 자손 중 a태그의 내용을 담는다.
	
	
	//즐겨찾기가 아닌 카드-수정버튼일 경우
	if($(".favorite > .cards > .cardtitleLi[data-id='" + cardId + "']").length === 0) {
		$(".favorite-btn").html("<i class='far fa-star'></i> 즐겨찾기 추가");
		$(".favorite-btn").removeClass("delete").addClass("add"); //즐겨찾기 버튼의 클래스 이름 delete -> add로 변경
	} else { //즐겨찾기된 카드-수정버튼일 경우
		$(".favorite-btn").html("<i class='fas fa-star'></i> 즐겨찾기 해제");
		$(".favorite-btn").removeClass("add").addClass("delete"); //즐겨찾기 버튼의 클래스 이름 add -> delete로 변경
	};
	
	if(cardtitleLiY > x){ // 3. 클릭한 카드의 y좌표가 전체높이보다 크면 수정창 위치 조정하여 띄움
		$(".modifyModal-content").css({
			"left" : cardtitleLiX,
			"top" : x + 30
		});
	} else { // 4. 클릭한 카드의 y좌표가 전체높이보다 작으면 그 위치에서 수정창 띄움
		$(".modifyModal-content").css({
			"left" : cardtitleLiX,
			"top" : cardtitleLiY + 30
		});
	};
	
	// 5. 카드 수정창의 너비 조절
	if(listScrollHeight > listHeight) { //스크롤이 생기면
		$("#modifyTextarea").css("width", "202px"); 
	} else { //스크롤이 없으면
		$("#modifyTextarea").css("width", "211px");
	};
	
	// 모달창을 띄운다.
	$("#modifyTextarea").val($(modifyCardTitle).text());
	modifyModal.style.display = "block";
	// 커서 포커스 주기
	$("#modifyTextarea").select();
	
	// 닫힘버튼(X) 누르면 모달창 닫힘.
	$(".closeModal.modifyCardTitle").click(function(){
		modifyModal.style.display = "none";
	});
	// 모달창 범위 밖을 클릭하면 모달창 닫힘.
	window.onclick = function(event) {
		if (event.target !== modifyTextarea)
			modifyModal.style.display = "none";
	}; 
	
	$(".modifyModal-title").html(cardId); //저장버튼 눌렀을 때의 처리를 위해 숨겨둔 div태그 안에 수정한 카드의 id값 담아두기
};
	
	
	
/* 카드 제목 수정 | 저장버튼 클릭할 경우 */
$("#saveBtn").on("click", function(){
	var id = $(".modifyModal-title").html(); //div태그에 담긴 카드 id값 가져와서 var id에 담기
	var title = $("#modifyTextarea").val(); //수정textarea의 내용 담기
	
	//아무 값도 입력하지 않을 경우
	if(title == '') return;
	
	$.ajax({
		type : "put",
		url : "/board/" + p_id + "/card/" + id,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data : JSON.stringify({title : title}),
		dataType : 'text', 
		success : function(result){
			if(result == 'SUCCESS'){
				$(".modifyModal").hide(); //모달창 감추기
				$(".cardtitleLi[data-id='" + id + "'] > #cardLink").text(title); //수정사항 적용
			};
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	});//ajax
});

		



/*
 *카드리스트 관련
 */
 
 
/* 카드리스트 모달창 닫기 */
function closeCardlistPop(){
	var popup = $('.popupMenuWrap');
	if (popup.hasClass('is-visible'))
		popup.removeClass('is-visible');
};
 

 
 
/* 카드리스트 등록 | 카드리스트 추가버튼 눌렀을 때 추가창 나타내기 */
$(".cardlists").on("click", ".addList", function(){
	$(".cardlistCreateBox").css("display", "block");
	$("#createListTextarea").focus(); //포커스 주기
	$(".addList").css("display", "none"); //Add a List...버튼은 숨긴다
});



/* 카드리스트 등록 | 카드리스트 추가창 바깥을 클릭하면 추가창 사라지게 */
$(document).click(function(e){
	//클릭한 객체의 id와 class이름을 가져옴.
	var id = $(e.target).attr("id");
	var className = $(e.target).attr("class");

	//2. 클릭한 객체가 카드리스트 추가버튼이 아니면 and 카드리스트 추가창이 아니면 or X버튼이면
	if((className !== "addList" && className !== "cardlistCreateBox" && id !== "createListTextarea") || id === "listCancleBtn"){ 
		$(".cardlistCreateBox").css("display", "none");
		$(".addList").css("display", "block");
	}
});



/* 카드리스트 등록 | 저장버튼 눌렀을 때의 처리 */
$(".cardlists").on("click", "#listAddBtn", function(){
	var title = $("#createListTextarea").val(); //사용자가 입력한 내용은 변수로 처리
	
	//아무 값도 입력하지 않을 경우
	if(title == ''){ return; }
	
	$.ajax({
		type : "post",
		url : "/board/" + p_id,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"
		},
		dataType : "text",
		data : JSON.stringify({
			p_id : p_id,
			u_id : u_id,
			title : title
		}),
		success : function(cardlistID) {
			// 카드리스트가 성공적으로 등록 되면
			if (cardlistID !== null || cardlistID !== 0) {
				newCardlistAdd(cardlistID, title); //주어진 매개변수로 카드리스트 태그 생성하여 삽입하는 함수
		  		$("#createListTextarea").val(''); //textarea 초기화
				
				// 카드리스트 컨테이너의 스크롤을 끝 지점으로 이동
				var container = $('.cardlists');
				var moveToPos = container.prop('scrollWidth') - container.innerWidth();
				container.scrollLeft(moveToPos);
			};
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	});//ajax
});
		


/* 카드리스트 제목 수정 | 서버에 요청 */
function modifyCardlistTitle(titleElement) {
	
	var title = titleElement; //수정textarea의 내용 담기
	var cardlist = title.parents('.cardlist');
	var cardlistID = cardlist.attr("data-id");
	var titleTxt = $.trim(title.val());	// 입력된 제목 텍스트의 양쪽 공백을 제거

	// 유효성 검사
	// 기존 저장된 제목과 현재 입력된 제목을 비교
	if (title.data('data-title') == titleTxt) {
		// 공백만 추가된 경우라면 공백 삭제 (빈 문자열은 허용)
		title.val($.trim(title.val()));
		// 유효성 검사를 위한 임시 데이터 삭제
		title.removeData('data-title');
		return false;
	};
	
	//아무 값도 입력하지 않을 경우
	if(title == '') return;
	$.ajax({
		type : 'put',
		url : "/board/" + p_id + "/cardlist/" + cardlistID,
		headers : {
			'Content-Type' : 'application/json',
			'X-HTTP-Method-Override' : 'PUT'
		},
		data : JSON.stringify({cl_title : titleTxt}),
		dataType : 'text',
		success : function(result) {
			// 카드리스트 제목 변경이 성공적으로 데이터베이스에 반영되면
			if (result == 'SUCCESS') {
				console.log('카드리스트 아이디 : ' + cardlistID + ', 제목 "' + titleTxt + '"(으)로 수정 되었습니다.');
			};
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	});
};
	
	
	
/* 카드리스트 제목 수정 | 관련 이벤트 */
$(".cardlists").on({
	focusin: function (event) {
		$(this).select(); // 카드리스트 제목 클릭하면 전체선택
		$(this).data("data-title", $(this).val()); // 현재 입력된 카드리스트 제목 저장
	},
	focusout: function (event) {
		// 입력된 글자가 MAX-LANGTH 넘어 갈 경우 필드 높이 자동 조절
		$(this).trigger("input");
		// 카드리스트 제목을 수정하는 로직 실행
		modifyCardlistTitle($(this));
	},
	keydown: function (key) {
		// Enter 키를 입력하면
		if (key.keyCode == 13) {
			// 기본 이벤트 제거
			event.preventDefault();
			// 포커스를 없애고 카드리스트 제목을 수정하는 로직 실행
	       	$(this).blur();
		}
	},
	input: function (event) {
		// 입력된 글자의 길이만큼 필드의 높이가 자동으로 조절된다.
	    var title = $(this);
		
	    if (title.innerHeight() < title.prop('scrollHeight')){
	    	title.height(title.prop('scrollHeight'));
	    } else {
	    	title.height(1).height(title.prop('scrollHeight'));
	    };
	    
	    var index = $(".cardlistTitle").index($(this));
	    cardsHeightControl(index); //카드리스트 전체 높이 조절하는 함수호출
	},
}, 'textarea.cardlistTitle');
	
	
	
/* 카드리스트 모달 컨트롤 | 카드리스트 상태변경 팝업창 띄우기 */
$('.cardlists').on('click', '.cardlistPopBtn', function() {
	var btnPosition = $(this).offset();	// 버튼좌표
	var popup = $('.popupMenuWrap');	// 팝업
	
	cardlistId = $(this).parent().parent().attr("data-id"); //해당 카드리스트의 id를 전역변수에 담아둠
	cardlistTitle = $(this).next().val(); //해당 카드리스트의 제목을 전역변수에 담아둠
	
	// 선택한 카드리스트 아이디 정보를 팝업에 저장
	var selectedCardlist = $(this).parents('.cardlist');
	popup.data('data-cl-id', selectedCardlist.data('id'));
				
	// 팝업이 화면에 없다면 띄우기
	if (!popup.hasClass('is-visible'))
		popup.addClass('is-visible');
	
	// 팝업 좌표설정
	popup.css('top', btnPosition.top + $(this).height());
	if((btnPosition.left + popup.width()) > $(window).width()){
		var MARGIN_RIGHT = 10;
		var overWidth = (btnPosition.left + popup.width()) - $(window).width() + MARGIN_RIGHT;
		popup.css('left', btnPosition.left - overWidth);
	} else {
		popup.css('left', btnPosition.left);
	};
});
	
	
	
/* 카드리스트 팝업 닫기 버튼 */
$('.popupMenuCloseBtn').on('click', function() {
	closeCardlistPop();
});


		
/* 카드리스트 모달 이외의 영역을 클릭하면 모달창 닫힘 */
$(document).click(function(e){
	//클릭한 객체의 id와 class이름을 가져옴.
	var className = $(e.target).attr("class");
	
	if(className !== "cardlistPopBtn" && className !== "title" && className !== "popupMenuHeader" 
			&& className !== "popupMenuContent" && className !== "cardlistMore") { 
		closeCardlistPop();
	};
});


/* 카드리스트 보관/가리기 수정 | 해당 카드리스트의 카드 중 즐겨찾기에 있는 카드 삭제 */
function deleteFavoriteCard(id) {
	var array = $(".favorite").children(".cards").children(".cardtitleLi[data-clid=" + id + "]");
	for(var i = 0; i < array.length; i++) {
		var cardID = $(array).eq(i).attr("data-id");
		deleteFavorite(cardID);
	};
};


/* 카드리스트 보관/가리기 수정 | ajax처리 */
function cardlistStatusChange(id, ps_id, title){
	$.ajax({
		type : 'put',
		url : "/board/" + p_id + "/cardlist/" + id,
		headers : {
			'Content-Type' : 'application/json',
			'X-HTTP-Method-Override' : 'PUT'
		},
		data : JSON.stringify({cl_ps_id : ps_id}),
		dataType : 'text',
		success : function(result) {
			// 카드리스트 상태 변경이 성공적으로 데이터베이스에 반영되면
			if (result == 'SUCCESS') {
				$(".cardlist[data-id=" + id + "]").parent(".nav-tab-content-Box-archive.archive-cards").remove(); //프로젝트 버튼, 휴지통 버튼까지 함께 삭제
				$('.cardlist[data-id="' + id + '"').remove(); // 상태 변경된 카드리스트 요소를 삭제
				
				switch (ps_id) {
		            case 1: //보드에 카드리스트 태그 삽입
		            	newCardlistAdd(id, title); //동적 카드리스트 태그 생성하여 삽입
		            	listCards(id); //해당 리스트 갱신
		                break;
		            case 2: //보관탭에 동적 카드리스트 태그 삽입
		            	$(".nav-tab-content-Box-archive.archiveCardlist").prepend( createArchivedCardlist(id, title) );
		            	deleteFavoriteCard(id); //즐겨찾기에 있는 해당 리스트의 카드 삭제
		            	break;
		            case 3: //가리기탭에 동적 카드리스트 태그 삽입
		            	$(".nav-tab-content-Box-hidden.hiddenCardlist").prepend( createTrashboxCardlist(id, title) );
		            	deleteFavoriteCard(id); //즐겨찾기에 있는 해당 리스트의 카드 삭제 
		                break;
    			};
			}//if
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	});//ajax
};



/* 카드리스트 보관/가리기 수정 | 팝업창에서 보관 or 가리기 버튼 누를 경우 */
$('.popupMenuList li').on('click', function() {
	var state = null;					// 선택한 상태 값을 저장
	
	if($(this).hasClass('to-archive')) { // 보관 버튼
		state = STATUS_ARCHIVE;	
	} else { // 가리기 버튼
		if(confirm("휴지통으로 보내진 카드리스트는 되돌릴 수 없습니다. \n소속된 카드도 함께 이동되며 더이상 조회할 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
			state = STATUS_HIDDEN; 	
    	else return; //취소를 누르면 더이상 작업 수행하지 않고 return
	};
	
	closeCardlistPop(); // 팝업 닫기

	cardlistStatusChange(cardlistId, state, cardlistTitle); //상태변경 ajax 처리 함수 호출
});
