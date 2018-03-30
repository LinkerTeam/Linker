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
	3. 화면 클릭할 때마다 계속 data 로드하는 문제 (-)
	4. 프론트 (-)
	5. 달성, 가리기 (-)
	7. 코드정리 (-)
	8. 제목 20자 이하 입력하도록 처리 (-)
	9. 주석달기 (-)
	10. 변수이름 정리 (-)
	11. 창 줄였을 때 헤더 아이콘, 검색창 내려오는 문제(-)
	12. 창 줄였을 때 카드모달창 사이즈 조절 문제(-)
**************************************************************************************************************
	<해결한 것>
	1. 카드모달 닫을 때 새로고침 되지 않게 (+)
		2-2. 카드 제목을 수정하고 textarea focus를 둔 상태에서 모달 바깥을 눌러 창을 끄면 
			DB에는 바뀐 제목으로 저장이 되는데 목록에서는 예전제목으로 보임.(새로고침이 안됨.) (+)
	6. 스크롤 문제 (+)
**************************************************************************************************************/	    

//임의의 프로젝트 id값을 준다.(프로젝트4에 대한 화면 출력)
var p_id=4;

var cardModal = document.getElementById('popupBox'); //전체 모달창 객체
var titleDB; //DB의 카드 title값을 담을 변수
var titleTextarea = document.getElementsByClassName('title-modify')[0]; //제목입력 textarea
var textarea = document.getElementsByClassName('content-textarea')[0]; //내용입력 textarea
var cancelBtn = document.getElementsByClassName("cancelBtn")[0]; //내용 수정 취소버튼
var viewEdits = document.getElementsByClassName("viewEdits")[0]; //내용 저장하지 않았을 때 뜨는 view Edits
var discard = document.getElementsByClassName("discard")[0]; //내용 저장하지 않았을 때 뜨는 discard


/* 카드 내용 조회 */
function loadCardData(obj) {
	//클릭한 카드의 id값을 가져와서 var id에 담음.
   	var id=obj.parentNode.getAttribute("data-id");
	
	$.getJSON("/teams/"+p_id+"/cards/"+id, function(data){
		//클릭한 카드의 title값 가져오기
		titleDB=data.title;
		//DB에서 카드 id, 내용 가져오기(id는 화면에 표시하지 않는다.)
		$(".title-cardTitle p").html(data.id);
		$(".title-cardTitle textarea").val(titleDB);//카드제목 수정textarea에 'value'값으로 넣는다
			//.html로 담았다가 7시간 삽질함. ()
		textarea.value=data.content;
		
		//content의 text길이만큼 textarea의 height값 주기
	    textarea.style.height = "1px";
	    textarea.style.height = (textarea.scrollHeight)+"px";
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

// 닫기버튼 누르면 모달창 사라짐
$(".popupCardClose").click(function(){
	cardModal.style.display = "none";
});

console.log(textarea);
//textarea 글입력시 size조절
textarea.addEventListener('keydown', autosize);
function autosize() {
	var el = this;
    el.style.cssText = 'height:auto; padding:0';
    el.style.cssText = 'height:' + el.scrollHeight + 'px';
};

//textarea 클릭시 save, close버튼 보이기/감추기 이벤트
$("body").click(function (e) { 
    if (e.target == textarea || e.target== viewEdits) {
        $(".content-Btn").css("display", "block");
        //textarea활성화 시 text 전체선택
        textarea.select();
    } else{
        $(".content-Btn").css("display", "none");
    }
});


//카드 제목 수정폼 활성화시 text 전체선택
titleTextarea.addEventListener('click', function ( e ) {
	titleTextarea.select();
});


/* 카드 내용 등록/수정 */
function contentSave(){
	var id=$(".title-cardTitle p").html(); //div태그에 담긴 카드 id값 가져와서 var id에 담기
	var content=$(".content-textarea").val(); //수정textarea의 내용 담기
	
	$.ajax({
		type : 'put',
		url : "/teams/"+p_id+"/cards/" + id,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data : JSON.stringify({content : content}),
		dataType : 'text', 
		success : function(result) {
			console.log("result: " + result);
		},
		error : function(request, status, error ) {
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});//ajax
	$(".warning").css("display", "none");
};



/* 카드 내용 수정시 저장 여부 확인 */
$(cardModal).click(function(e) { 
	var id=$(".title-cardTitle p").html();//카드의 id값 담기
	var content=$(".content-textarea").val(); //수정textarea의 내용 담기
	
	//담긴 id값에 해당하는 카드의 data가져오기
    $.getJSON("/teams/"+p_id+"/cards/"+id, function(data){
    	//내용을 수정하고 저장하지 않은 채로 textarea를 비활성화하면 저장하지 않았다는 경고메시지 뜸.
    	//경고메시지 숨김 : textarea를 클릭했을 때, 저장취소/view Edits/discard 클릭했을 때, 
    		//textarea 밖을 클릭했는데 DB data가 null이고 textarea의 글자수가 0일 때.
    	if(e.target==textarea || e.target==cancelBtn ||e.target==viewEdits || 
    			e.target == discard || (e.target !== textarea && (data.content==null && content.length==0))){
    		$(".warning").css("display", "none");
    	}
    	//textarea 밖을 클릭했을 때 data와 수정내용이 같지 않으면 경고메시지
    	else if (e.target !== textarea && content !== data.content){
    		$(".warning").css("display", "block");
    	}
	});//JSON
});


/* 제목 수정 */
$(cardModal).click(function(e){
	var id=$(".title-cardTitle p").html();
	var titleModify=$(".title-modify").val(); //수정textarea의 value값 담기
	
	//아무 값도 입력하지 않을 경우
	if(titleModify==''){ return; }
	
	if(titleModify !== titleDB){
		$.ajax({
			type : 'put',
			url : "/teams/"+p_id+"/cards/" + id,
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify({title : titleModify}),
			dataType : 'text', 
			success : function(result) {
				getAllList(); //카드리스트 목록 갱신
			},
			error : function(request, status, error ) {
				alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});//ajax
	};
});



/* 카드 수정 취소 */
function modifyCancel() {
	var id=$(".title-cardTitle p").html();
	$.getJSON("/teams/"+p_id+"/cards/"+id, function(data){
		//DB에서 내용(content) 가져오기
		textarea.value=data.content;
		//content의 text길이만큼 textarea의 height값 주기
        textarea.style.height = "1px";
        textarea.style.height = (textarea.scrollHeight)+"px";
	});//JSON
	$(".warning").css("display", "none");
};

		