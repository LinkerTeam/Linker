<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>LINKER FAVORITECARD</title>
<style type="text/css">
.content{
	background-color: #0067a3;
	overflow: hidden;
}
.content.board {
    width: 100%;
	background-color: #0079bf;
	overflow: hidden;
}

/* 헤더, 양쪽메뉴 제외한 본문영역 중 상단 프로젝트 타이틀 영역 */
.projectTitle > div {
    width: 400px;
    margin: 10px;
    padding: 5px;
    color: #fff;
    outline: none;
    border: none;
    border-radius: 3px;
    font-size: 20px;
    font-weight: bold;
    background-color: #0079bf;
}

/* 본문영역 중 프로젝트 타이틀을 제외한 영역 */
.cardlistContent {
    display: flex; 
    float: left;
    width: 100%;
    height: calc(100% - 60px); /* 상단 프로젝트 타이틀과 하단 스크롤 영역을 제외한 높이 */
    line-height: 1.3em; /* 가변단위. 1em은 현재 폰트크기임. */
}

/* 전체 카드리스트의 실질적 영역 */
.cardlists {
    display: flex;
    overflow-y: hidden; /* 가로스크롤만 생기도록 */
    transition: 0.2s;
}
.cardlists > * {
    flex: 0 0 auto;
}
/* 스크롤 디자인~ */
::-webkit-scrollbar {
    width: 10px;
    height: 12px;
}
::-webkit-scrollbar-track {
    background: rgba(0,0,0,.32);
    border-radius: 3px;
}
::-webkit-scrollbar-thumb {
    background: rgba(255, 255, 255, 0.55);
    border-radius: 10px;
}/* ~스크롤디자인 */

/* 동적으로 생성되는 각각의 카드리스트 */
.cardlist {
    width: 236px;
    height: 100%;
    position: relative;
    display: inline-block;
    margin-left: 10px;
    border-radius: 2px;
}
/* 카드리스트의 자식 전체에 공통으로 적용되는 속성들 */
.cardlist > * {
    background-color: #e2e4e6;
    color: #333;
    padding: 0 10px;
}

/* 카드리스트의 상단 | textarea + more버튼 */
.cardlistTitleBox {
	position: relative;
	width: 196px;
	padding: 10px 30px 5px 10px;
	border-top-left-radius: 5px;
	border-top-right-radius: 5px;
}
/* 카드리스트의 상단 | textarea */
textarea.cardlistTitle {
	resize: none; /* 사용자가 임의로 크기를 조절할 수 없게 함 */
	width: 100%;
	padding: 0 0 0 3px;
    border: none;
	border-radius: 0;
	background-color: #e2e4e6;
    color: #484848;
    font-size: 16px;
    font-weight: bold;
    line-height: 165%;
	box-sizing: border-box;
	overflow-y: hidden; /* 가끔 스크롤 짧게 잡혀서 추가 */
}

/* 카드리스트의 하단 | (Add a card...상자) */
.createCardBox {
	display: block;
    height: 40px;
    line-height: 40px;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    color: #656565;
    font-size: 16px;
    font-weight: 400;
    cursor: pointer;
}

.cardtitleLi:not(:last-child) {
    margin-bottom: 7px;
}
.cardtitleLi {
    display: block;
    position: relative;
    background-color: #fff;
    border-radius: 3px;
    color: #5e5e5e;
    font-size: 11pt;
    word-break: break-word;
    cursor: pointer;
    box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
}
.card-footer{
	display: block;
    height: 12px;
    line-height: 40px;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
    color: #656565;
    font-size: 16px;
    font-weight: 400;
}
.cardLink{   
	padding: 6px;
    font-size: 16px;
}
.cards {
    margin: 0;
    overflow-x: hidden;
    overflow-y: auto;
}
</style>
</head>
<body>
 <%@include file="../header.jsp"%>
 <%@include file="../closeBoard.jsp"%>
 	
 	<div class="content board">
		<!-- 이곳에 본문 입력 -->
 
 		<div class="projectTitle"><div>나의 즐겨 찾기 카드</div>
 		</div>
             <div class="cardlistContent">
				<!-- 카드리스트 전체 -->
	            <div class="cardlists">
	            	<!-- 각각의 카드리스트가 삽입될 곳 -->
	            </div>
			</div>
			<!-- 카드팝업 jsp -->
	<%@include file="../board/cardModal.jsp"%>
</body>
<script type="text/javascript">
/* 즐겨찾기 카드 조회 | 접속 유저에 대한 전체 카드리스트 목록 출력 */
favoriteTeam();

var p_id = 0;
var u_id = ${login.id};

function favoriteTeam(){
	$.ajax({
		type : 'GET',
		url : "/board/favoteam",
		success : function(data){
			console.log(data);
			var allID = new Array(); //카드리스트 id를 담을 배열
			var idIndex = new Array(); //data배열의 id에서 uniqID들의 index값
			
			var uniqID = new Array(); //중복되지 않은 id 배열
			var uniqTitle = new Array(); //uniqID들의 title 배열
			
			//DB에서 받아온 데이터를 이용하여 루프를 돌면서 카드리스트 id를 배열에 추가
			for(var i = 0; i < data.length; i++){
				allID.push(data[i].t_id);
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
			                    return item.t_id;
			                }).indexOf(uniqID[i]); 
			    idIndex.push(index);

			    uniqTitle.push(data[idIndex[i]].t_name); //구한 index값을 이용하여 해당 title을 뽑아내 uniqTitle에 담음
			};
			
			//카드리스트 출력하기
			var listStr = ""; //동적으로 생성할 태그를 문자열로 담을 변수
			for (var i =0; i< uniqID.length; i++){
				newCardlistAdd(uniqID[i], uniqTitle[i]);
				cardsHeightControl(i); //카드리스트 제목영역 높이에 따라 카드리스트 전체 높이 조정
			}
			
			//카드 출력하기
	  		//for문을 돌면서 각각의 카드에 대한 태그를 문자열로 만든다.
	  		for(var i = 0; i < uniqID.length; i++){ 
	  			for(var j = 0; j < data.length; j++){
	  				//카드리스트id가 위에서 만든 카드리스트id 배열의 값과 같고 ps_id가 1(진행)일 때
		  			if(data[j].t_id === uniqID[i] && data[j].c_ps_id === 1){ 
		  				var cardStr = newCardAdd(data[j].c_id, data[j].t_id, data[j].c_title); //문자열로 카드 태그를 만드는 함수 호출
		  				$(".cards").eq(i).append(cardStr); //해당 카드리스트에 카드 태그 삽입
		  			};
	  			};
			};
			
		}, error : function(){
			alert("통신오류입니다.")
		}
	})
	
}


/* 매개변수 카드리스트id와 카드리스트title이 주어지면 그것을 이용해 카드리스트 태그를 문자열로 만드는 함수 */
function newCardlistAdd(cardlistId, cardlistTitle){
	var listStr = "<div data-id='" + cardlistId + "' class='cardlist'>" + 
				  "	   <div class='cardlistTitleBox'>" +
				  "	       <div class='cardlistTitle' rows='1' >" + cardlistTitle + "</div>" +
				  "	   </div>" +
				  "	   <div class='cards'>" +
				  "   	</div>" +
				  "<footer class='card-footer'></footer>"+
				  "</div>"
	$('.cardlists').append(listStr);
	// 타이틀 길이만큼 필드의 높이를 조정
	var newTitle = $('[data-id='+cardlistId+']').find('textarea.cardlistTitle');
	newTitle.height(newTitle.prop('scrollHeight'));
};
				

/* 매개변수 카드id와 카드title이 주어지면 그것을 이용해 카드 태그를 문자열로 만드는 함수 */
function newCardAdd(cardId, cardlistId, cardTitle){
	var newTitle = "<div data-id='" + cardId + "' data-clId='" + cardlistId + "' class='cardtitleLi' onclick='loadCardData(this)'> " + 
				   "    <div class='cardLink'>" + cardTitle + "</div>" +
				   "	<i class='fas fa-star delete-favo' id='"+cardId+"' data-c_id='" + cardId + "' data-t_id='" + cardlistId + "' onclick='favoriteDelete(this)'>" +
			   	   "</div>";
	return newTitle;
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

</script>
</html>