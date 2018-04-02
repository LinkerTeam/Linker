/**
 * 
 */
//프로젝트4 화면에서 볼 수 있는 카드리스트&카드 화면.
var p_id=4;
//u_id, cl_id는 임의의 값(4)을 사용.
var u_id=4;
var cl_id=4;

var modifyModal = document.getElementsByClassName('modifyModal')[0]; // 모달창 객체
var closeModal = document.getElementsByClassName("closeModal")[0]; // 닫힘버튼(X) 객체

var addList = document.getElementsByClassName("addList")[0]; //Add a List...버튼
var createList = document.getElementsByClassName("create")[0]; //list추가할 때 생기는 미니창
var createTextarea = document.getElementById("createTextarea"); //list 추가 textarea
var listAddBtn = document.getElementById("listAddBtn"); //list추가 save버튼
var cards = document.getElementsByClassName("cards"); //카드리스트
var scrollControll=false;
var cardlistIndex;



/* 전체 카드 출력 (여러 번 반복해서 사용되기 때문에 getAllList함수로 묶음.) */
function getAllList(){
	$.getJSON("/teams/"+p_id+"/cards", function(data){

		var str="";

		//Ajax로 호출된 목록에 대해 루프를 돌면서 <div>태그를 생성하도록 함.
		//<div>태그 안에 <div>태그와 <button>태그가 들어가는 형태.
		//<div><div></div><button></button></div>
		$(data).each(function(){
			str += "<div data-id='" + this.id + "' class='cardtitleLi'>"
			+ "<div id='cardLink' onclick='loadCardData(this)'>" + this.title + "</div>"
			+ "<button class=cardModifyBtn><i class='far fa-edit'></i></button></div>";
		});
		$(".cards").html(str); //내부의 요소를 싹 비우고 새로 추가

		//목록 마지막에 카드add창 추가
		var strstr= "<div class='addCard'><textarea name='title' id='createCardTextarea' rows='2' cols='20' style='resize:none'></textarea><br /><button type='button' id='addBtn'>add</button><button type='button' id='cancleBtn'>&times;</button></div>";
		$(".cards").append(strstr); //내부 요소의 제일 마지막에 추가

		if(scrollControll == true){
			cards[cardlistIndex].scrollTop=cards[cardlistIndex].scrollHeight;
		}
	});
};


//일단 전체 목록을 화면에 출력
getAllList();


/* Add a card... 누르면 카드추가창 생김. */
$("footer.createCardBox").click(function () {
	var index = $("footer.createCardBox").index(this); //전체 createCardBox 중에서 this의 인덱스값 얻기
	$(this).prev().children(".addCard").css("display", "block");

	$(this).css("display", "none"); //Add a card... 숨기기
	$(cards[index]).css("max-height", "calc(100% - 51px)"); //카드리스트 길이 조정
	$(cards[index]).css("border-bottom-left-radius", "5px"); 
	$(cards[index]).css("border-bottom-right-radius", "5px"); 
	$("#createCardTextarea").focus();

	cards[index].scrollTop = cards[index].scrollHeight; //추가창 보이도록 스크롤 아래로 이동
});


/* 카드추가창 이외의 영역 클릭하면 추가창 사라짐(-) */
/* $(document).click(function(e){
        	if(e.target !== $("footer.createCardBox")){
        		console.log("사라짐");	
        	}
	}) */


// x버튼 누르면 카드추가창 사라짐
$(".cards").on("click", ".addCard #cancleBtn", function(){
	$("footer.createCardBox").css("display", "block");
	$(this).parent(".addCard").css("display", "none");
	$(".cards").css("max-height", "calc(100% - 26px - 45px - 20px)"); //카드리스트 길이 조정
	$(".cards").css("border-bottom-left-radius", "5px"); 
	$(".cards").css("border-bottom-right-radius", "5px"); 
});



/* 카드 등록 처리 - add버튼을 클릭할 경우 */
$(".cards").on("click", ".addCard #addBtn", function(){
	scrollControll=true;
	//사용자가 입력한 내용은 변수로 처리(textarea id="createTextarea")
	var title = $("#createCardTextarea").val();
	var createCardTextarea = document.getElementById("createCardTextarea");
	cardlistIndex = $(".addCard #addBtn").index(this);

	//아무 값도 입력하지 않을 경우
	if(title==''){ return; }

	$.ajax({
		type : 'post',
		url : "/teams/"+p_id+"/cards",
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
		success : function(result){
			if(result == 'SUCCESS'){

				getAllList(); //등록에 성공하면 전체 카드 목록 갱신
				$(".addCard").css("display", "none"); //카드추가창 사라짐
				$("footer.createCardBox").css("display", "block"); //Add a card... 생김
				$(".cards").css("max-height", "calc(100% - 26px - 45px - 20px)"); //카드리스트 길이 조정
				$(".cards").css("border-bottom-left-radius", "0px"); 
				$(".cards").css("border-bottom-right-radius", "0px");
				createCardTextarea.value=''; //textarea 초기화
			}
		},
		error : function(request, status, error ) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});//Ajax
});



/* 카드 title 수정 처리 - 수정 버튼 클릭할 경우 */
$(".cards").on("click", ".cardtitleLi button", function(e){
	// 모달창을 클릭한 카드의 위치에서 뜨도록 함.
	// 1. 클릭한 수정버튼의 부모 찾아가서(cardtitleLi) 그 부모의 좌표값을 구하기
	var cardtitleLiX = $(this).parent("div").offset().left; //그 수정버튼의 부모 태그의 x좌표
	var cardtitleLiY = $(this).parent("div").offset().top; //그 수정버튼의 부모 태그의 y좌표

	// 2. 카드리스트의 전체높이 구하기
	var listHeight=parseInt($(".cards").css("height")); //카드리스트 중 카드부분 높이
	var headerHeight=parseInt($(".cardlistTitle").css("height")); //카드리스트 헤더 높이
	var footerHeight=parseInt($(".createCardBox").css("height")); //카드리스트 푸터 높이
	var modifyHeight=parseInt($(".modifyModal-content").css("height")); //수정창 높이

	var x = headerHeight + listHeight + footerHeight; //카드리스트 전체높이

	if(cardtitleLiY > x){ // 3. 클릭한 카드의 y좌표가 전체높이보다 크면 수정창 위치 조정하여 띄움
		$(".modifyModal-content").css({
			"left": cardtitleLiX,
			"top": x + 15
		});
	}else{ // 4. 클릭한 카드의 y좌표가 전체높이보다 작으면 그 위치에서 수정창 띄움
		$(".modifyModal-content").css({
			"left": cardtitleLiX,
			"top": cardtitleLiY
		});
	}

	// 모달창을 띄운다.
	modifyModal.style.display = "block";

	// 닫힘버튼(X) 누르면 모달창 닫힘.
	closeModal.onclick=function(){
		modifyModal.style.display = "none";
	};
	// 모달창 범위 밖을 클릭하면 모달창 닫힘.
	window.onclick = function(event) {
		if (event.target == modifyModal) {
			modifyModal.style.display = "none";
		}
	};

	var card = $(this).parent(); //수정버튼의 조상-카드
	var id=card.attr("data-id"); //카드의 id값을 담는다.
	var title=card.children("a").text(); //카드의 자손 중 a태그의 내용을 담는다.

	$(".modifyModal-title").html(id); //div태그에 카드의 id값 주입(CSS를 hidden으로 줘서 화면 출력은 안되도록 함)
	$("#modifyTextarea").val(title); //카드의 원래 내용을 수정textarea에 담기
});



/* 카드 title 수정 처리 - 수정 내용 입력 후 save버튼 클릭할 경우 */
$("#saveBtn").on("click", function(){

	var id=$(".modifyModal-title").html(); //div태그에 담긴 카드 id값 가져와서 var id에 담기
	var title=$("#modifyTextarea").val(); //수정textarea의 내용 담기

	//아무 값도 입력하지 않을 경우
	if(title==''){ return; }

	$.ajax({
		type : 'put',
		url : "/teams/"+p_id+"/cards/" + id,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data : JSON.stringify({title : title}),
		dataType : 'text', 
		success : function(result){
			console.log("result: " + result);
			if(result == 'SUCCESS'){
				$(".modifyModal").hide(); //모달창 감추기
				getAllList(); //전체 목록 갱신
			}
		},
		error : function(request, status, error ) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});//ajax
});