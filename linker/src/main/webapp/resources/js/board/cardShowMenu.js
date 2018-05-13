
/**********************************************************************************
 * 파일명칭 : cardShowMenu.js
 * 기    능 : 프로젝트 화면에서의 right side menu - 보관함 탭 휴지통 탭, 
 * 			  설정 탭의 프로젝트 닫기, 삭제하기와 관련된 기능을 구현하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
 **********************************************************************************/



var i = 0;
var j = 0;
var p_id = null; //해당 프로젝트의 id
var u_id = null; //회원 id(PK)

var theToggle = document.getElementById('toggle'); //오른쪽 메뉴 버튼 



/* 메뉴 button event */
// hasClass
 function hasClass(elem, className) {
 	return new RegExp(' ' + className + ' ').test(' ' + elem.className + ' ');
 };
 // addClass
 function addClass(elem, className) {
     if (!hasClass(elem, className)) {
     	elem.className += ' ' + className;
     };
 };
 // removeClass
 function removeClass(elem, className) {
 	var newClass = ' ' + elem.className.replace( /[\t\r\n]/g, ' ') + ' ';
 	if (hasClass(elem, className)) {
 		while (newClass.indexOf(' ' + className + ' ') >= 0 ) {
 			newClass = newClass.replace(' ' + className + ' ', ' ');
 		};
 		elem.className = newClass.replace(/^\s+|\s+$/g, '');
	};
};
// toggleClass
function toggleClass(elem, className) {
	var newClass = ' ' + elem.className.replace( /[\t\r\n]/g, " " ) + ' ';
    if (hasClass(elem, className)) {
        while (newClass.indexOf(" " + className + " ") >= 0 ) {
        	newClass = newClass.replace( " " + className + " " , " " );
        };
        elem.className = newClass.replace(/^\s+|\s+$/g, '');
	} else {
		elem.className += ' ' + className;
	};
};
theToggle.onclick = function() {
	toggleClass(this, 'on');
	openAside();
	return false;
};
	 
	 
	 
/* 메뉴 숨기기 & 펼치기 이벤트 */
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
        	readCardStatus(2);
        };
    } else { //클릭수가 짝수이면 숨기기
        boardAside.classList.remove('boardAside-open'); //클래스 이름 'boardAside-open' 제거
        boardAside.style.width = "0";
        content[0].style.marginRight = "0";
    };
};
	
/* 탭버튼 제어 */
var tabMenu = document.getElementsByClassName("nav-tabs"); //탭 메뉴
for(var i = 0; i < tabMenu[0].childElementCount; i++) {
	tabMenu[0].children[i].addEventListener("click", function(){
		
		var clickedTabIndex = getElementIndex(this); //클릭한 탭 번호
		var currentTabIndex = this.parentElement.dataset.activenumber; //현재 탭 변호
		
		//클릭한 탭이 현재 활성화 된 탭이 아니면 클릭한 탭의 내용 보여주기
		if(currentTabIndex !== clickedTabIndex){
	        tabMenu[0].children[currentTabIndex].classList.remove("active"); //현재 탭 비활성화
		    this.classList.add("active"); //클릭한 탭 활성화
		    this.parentElement.dataset.activenumber = clickedTabIndex; //클릭한 탭의 번호를 저장
		};
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
* 보관/휴지통 탭 관련
*/
	
	
	
/* 보관/휴지통탭 | 검색창 blur되면 value값 초기화 */
$(".tab-search-input").on("blur", function(){
	$(this).val("");
});
	
	
/* 카드 보관/휴지통 조회 | 오른쪽 탭(보관, 휴지통)에서 카드 목록 조회 */
function readCardStatus(ps_id){
	$.ajax({
		type : "GET",
		url : "/board/" + p_id + "/cards/" + ps_id,
		success : function(data){
			var str = "";
			
	  		if(ps_id === 2){ //보관카드 조회
	  			for(var i = 0; i < data.length; i++){ //상태값이 2인 데이터들을 돌면서 동적 카드 태그 생성
					str += createArchivedCard(data[i].c_id, data[i].cl_id, data[i].c_title, data[i].content, data[i].reply, data[i].file);
				};
				$(".nav-tab-content-Box-archive.archiveCard").html(str); //보관탭에 동적 태그 삽입
	  		} else if(ps_id === 3) { //휴지통 카드 조회
	  			for(var i = 0; i < data.length; i++){ //상태값이 3인 데이터들을 돌면서 동적 카드 태그 생성
					str += createTrashboxCard(data[i].c_id, data[i].cl_id, data[i].c_title, data[i].content, data[i].reply, data[i].file);
				};
				$(".nav-tab-content-Box-hidden.hiddenCard").html(str); //휴지통탭에 동적 태그 삽입
	  		};
		}, //success
		error : function() {
	   		alert("에러가 발생했습니다.");
	   	}
	}); //ajax
};

/* 카드리스트 보관/휴지통 조회 | 오른쪽 탭(보관, 휴지통)에서 카드리스트 조회 */
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
	  		} else if(ps_id === 3) { //휴지통 카드리스트 조회
	  			for(var i = 0; i < data.length; i++){ //상태값이 3인 데이터들을 돌면서 동적 카드리스트 태그 생성
					str += createTrashboxCardlist(data[i].id, data[i].title);
				};
				$(".nav-tab-content-Box-hidden.hiddenCardlist").html(str); //휴지통탭에 동적 태그 삽입
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
/* 카드 휴지통 조회 | 휴지통탭을 누를 경우 */
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
	
	
	
/* 카드리스트/카드 보관/휴지통 수정 | 탭에서 '프로젝트로' 버튼 or '휴지통으로' 버튼 누를 경우 */
$(".tab-content-box").on("click", ".return", function(){
	var ps_id;
	var STATUS_ING = 1; //진행
	var STATUS_HIDDEN = 3; //휴지통
	var className = $(this).attr("class"); //클릭한 요소의 class이름
	var id = $(this).parent().prev().attr("data-id"); //카드 아이디
	var title = $(this).parent().prev().children(":first").text();
	var cl_id = $(this).parent().prev().attr("data-clId"); //선택한 카드의 카드리스트 id
	
	switch (className) {
        case "archive-reopen switchBtn-archive return returnCard": //카드의 '프로젝트로' 버튼
        	ps_id = STATUS_ING; //ps_id = 1
        	cardStatusChange(id, ps_id, cl_id, title);
            break;
        case "archive-hidden switchBtn-archive return returnCard": //카드의 '휴지통으로' 버튼
        	if(confirm("휴지통으로 보내진 카드는 되돌릴 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
    			ps_id = STATUS_HIDDEN; //ps_id = 3
        	cardStatusChange(id, ps_id, cl_id, title);
        	break;
        case "archive-reopen switchBtn-archive return returnCardlist": //카드리스트의 '프로젝트로' 버튼
        	ps_id = STATUS_ING; //ps_id = 1
            cardlistStatusChange(id, ps_id, title);
            break;
        case "archive-hidden switchBtn-archive return returnCardlist": //카드리스트의 '휴지통으로' 버튼
            if(confirm("휴지통으로 보내진 카드리스트는 되돌릴 수 없습니다. \n소속된 카드도 함께 이동되며 더이상 조회할 수 없습니다. \n정말 보내시겠습니까?") === true) //확인을 눌렀을 때 로직 실행
            	ps_id = STATUS_HIDDEN; //ps_id = 3
            cardlistStatusChange(id, ps_id, title);
        	break;
	};
	//cardStatusChange(id, ps_id, cl_id, title); //상태변경에 대한 ajax처리 함수 호출
});
	

/* 달성탭에서 카드 검색한 경우 */
$('#search-archive-txt').keyup(function(){
	var ps_id = 2;
	var keyword = $(this).val();
	var searchArchiveBtn = $('.nav-tab-content-Box-archive.archiveCardlist').css("display");
	if(keyword != ''){//입력한 글자가 null이 아닌경우
		if(searchArchiveBtn == "none"){ //카드 검색한 경우
			$.ajax({
				type : "get",
				url : "/board/" + p_id + "/searchCard/" + keyword,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "GET"
				},
				dataType : 'json',
				contentType : 'text/javascript',
				data :{
					ps_id : ps_id
				},
				success : function(data){
				 	var str = "";
				  		if(ps_id == 2){ //보관 카드리스트 조회
							$(".nav-tab-content-Box-archive.archiveCard").html('');
				  			for(var i = 0; i < data.length; i++){ //상태값이 2인 데이터들을 돌면서 동적 카드리스트 태그 생성
								str += createArchivedCard(data[i].id, data[i].cl_id, data[i].title);
							}
							$(".nav-tab-content-Box-archive.archiveCard").html(str); //보관탭에 동적 태그 삽입
				  		}
				}, //success
				error : function() {
			   		alert("에러가 발생했습니다.");
			   	}
			});
		}else{//카드리스트 검색한 경우
			$.ajax({
    			type : "GET",
    			headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "GET"
				},
				url : "/board/" + p_id + "/searchCardlist/" + keyword,
				contentType : 'text/javascript',
				data :{
					ps_id : ps_id
				},
				success : function(data){
			 		var str = "";
		  			if(ps_id == 2){ //달성 카드 조회
		  				$(".nav-tab-content-Box-archive.archiveCardlist").html('');
		  				for(var i = 0; i < data.length; i++){ //상태값이 2인 데이터들을 돌면서 카드 생성
							str += createArchivedCardlist(data[i].id, data[i].title);
						}
						$(".nav-tab-content-Box-archive.archiveCardlist").html(str); //보관탭에 카드 삽입
		  			}
				}, //success
				error : function() {
			   		alert("에러가 발생했습니다.");
			   	}
			});
		}
	}else{//입력한 글자가 null인 경우
		if(searchArchiveBtn == "none"){ //카드 검색한 경우 
			readCardStatus(2);
		}else{//카드리스트 검색한 경우
			readCardlistStatus(2);
		}
	}
}); 

/* 가리기탭에서 카드 검색한 경우  */
$('#search-hide-txt').keyup(function(){
	var ps_id = 3;
	var keyword = $(this).val();
	var searchHideBtn = $('.nav-tab-content-Box-hidden.hiddenCardlist').css("display");
	if(keyword != ''){
		if(searchHideBtn == "none"){ //카드 검색한 경우 
			$.ajax({
				type : "get",
				url : "/board/" + p_id + "/searchCard/" + keyword,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "GET"
				},
				dataType : 'json',
				contentType : 'text/javascript',
				data :{
					ps_id : ps_id
				},
				success : function(data){
				 	var str = "";
				  			$(".nav-tab-content-Box-hidden.hiddenCard").html('');
				  			for(var i = 0; i < data.length; i++){ //상태값이 3인 데이터들을 돌면서 동적 카드리스트 태그 생성
				  				str += createTrashboxCard(data[i].id, data[i].cl_id, data[i].title);
							}
							$(".nav-tab-content-Box-hidden.hiddenCard").html(str); //가리기탭에 동적 태그 삽입
				  		}, //success
				error : function() {
			   		alert("에러가 발생했습니다.");
			   	}
	    	}); //ajax
		}else{//카드리스트 검색한 경우
			$.ajax({
	    		type : "GET",
	    		headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "GET"
				},
				url : "/board/" + p_id + "/searchCardlist/" + keyword,
				contentType : 'text/javascript',
				data :{
					ps_id : ps_id
				},
				success : function(data){
				 	var str = "";
			  			$(".nav-tab-content-Box-hidden.hiddenCardlist").html('');
			  			for(var i = 0; i < data.length; i++){ //상태값이 3인 데이터들을 돌면서 동적 카드 생성
							str += createTrashboxCardlist(data[i].id, data[i].title);
						}
						$(".nav-tab-content-Box-hidden.hiddenCardlist").html(str); //가리기탭에 카드 삽입
			  		}, //success
				error : function() {
			   		alert("에러가 발생했습니다.");
			   	}
	    	}); //ajax
		}
	}else{
		if(searchHideBtn == "none"){ //카드 검색한 경우 
			readCardStatus(3);
		}else{//카드리스트 검색한 경우
			readCardlistStatus(3);
		}
	}
});	
	
/*
* 프로젝트 닫기 관련
*/
	
	
	
/* 프로젝트 닫기 | 모달창 열기 */
$(".closeBoard").on("click",function(){
	$(".closeBoardModal").addClass("is-visible"); //모달창 열기
});
		
/* 프로젝트 닫기 | 모달창 이외의 영역을 클릭하면 모달창 닫기 */
$(document).on("click", function(e){
	var className = $(e.target).attr("class"); //클릭한 요소의 class이름
	
	//클릭한 요소가 모달창이 아니면 class이름 is-visible을 제거함으로써 모달창 숨기기
	if(className !== "closeBoardModal is-visible" && className !== "closeBoard" 
			&& className !== "closeTitle" && className !== "closeBoardModal-text")
		$(".closeBoardModal").removeClass("is-visible"); 
});
	
	
/* 프로젝트 닫기 | 상태 2 - close화면에 대한 동적 태그 생성/삽입 */
function closeBoardStr(){
	var closeBoardStr = "<div class='content'>"
					  + "	<div class='closeBoardMessage'>"
					  + "		<div class='closeBoardTitle'>이 프로젝트는 종료되었습니다.</div>"
					  + "		<p class='boardReopen' onclick='closeBoard(1);'>다시 열기</p><br/>"
		    		  + "		<p class='boardDelete' onclick='closeBoard(3);'>삭제하기</p>"
					  + "	</div>"
					  + "</div>";
	//카드리스트 목록이 있는 content의 클래스이름을 hiddenContent로 바꿈으로써 화면에서 숨김(hiddenContent의 display속성: none)
	$(".content").removeClass("content").addClass("hiddenContent");
	$(".hiddenContent").before(closeBoardStr); //동적 태그 삽입
};
	
/* 프로젝트 닫기 | 상태 3 - delete화면에 대한 동적 태그 생성/삽입 */
function deleteBoardStr(){
	var deleteBoardStr = "<div class='deleteBoardMessage'>"
					   + "    <div class='deleteBoardTitle'>프로젝트가 영구적으로 삭제되었습니다.</div>"
					   + "	  <p>이 프로젝트는 다시 열 수 없고 종료된 프로젝트 목록에서도 삭제됩니다.</p>"
					   + "</div>";
	$(".content").html(deleteBoardStr); //.content를 비우고 Board not found 띄움
	$(".hiddenContent").remove(); //카드리스트 목록이 있는 hiddenContent는 완전 삭제
};
	
	
/* 프로젝트 닫기 | ajax처리 */
function closeBoard(ps_id){
	//완전 숨기기는 복구 불가 경고창 띄움
	if(ps_id === 3){
		if(confirm("모든 카드리스트와 카드가 함께 삭제됩니다. \n삭제된 프로젝트는 복구가 불가능합니다. \n그래도 삭제하시겠습니까?") !== true)
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
		            case 1: //상태값을 1(진행)로 변경했으면
		            	$(".content").remove(); //.content(프로젝트 닫기화면의 클래스이름)를 삭제하고
    					$(".hiddenContent").removeClass("hiddenContent").addClass("content"); //카드리스트가 있는 .hiddenContent의 클래스이름을 content로 바꾼 뒤
    					$(".cardlist.addCardlist").prevAll().remove(); //Add a list...버튼 앞의 카드리스트를 모두 삭제(삭제 하지 않으면 중복 문제 발생)
    					allCardlist(); //카드리스트&카드 목록 조회하는 함수 호출
		                break;
		            case 2: //상태값을 2(가리기)로 변경했으면 프로젝트 닫기 화면 띄우는 함수 호출
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


/* 프로젝트 닫기 | 모달창에서 확인버튼을 누를 경우 */
$(".closeBoardBtn").click(function(){
	closeBoard(2); //프로젝트 상태변경 ajax 함수를 호출하여 프로젝트 상태값을 2로 변경하고 프로젝트 닫기화면 출력
});
