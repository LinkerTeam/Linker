<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트화면</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<!-- CSS -->
<link href="/resources/css/cards/cardTest.css?ver=22" type="text/css" rel="stylesheet" />
</head>


<body>
	<%@include file="../header.jsp"%>
	<%@include file="../mainMenu.jsp"%>
	
	<div class="content">
		<div class="projectTitle"><h2>프로젝트4</h2></div>
        <div class="cardlistContent">

			<!-- 카드리스트 전체 -->
            <div class="cardlists">
            	<!-- 각각의 카드리스트가 삽입될 곳 -->
           <!-- <div class="cardlist">
        			<header class="cardlistTitle">카드리스트 title</header>
                    <div class="cards">해당 카드리스트에 대한 카드목록이 추가되는 곳</div>
                    <footer class="createCardBox">Add a card...</footer>
                </div> -->
                
                <!-- 카드리스트 제일 끝의 Add a list...버튼 -->
           		<div class="cardlist addCardlist">
	                <div class="addList">Add a list...</div>
	                <div class="cardlistTitle create">
	                    <textarea name="title" id="createListTextarea" placeholder="Add a List..." onKeyUp='limitMemo(this, 20)'></textarea><br />
	                    <button type="button" id="listAddBtn">add</button>
	                    <button type="button" id="listCancleBtn">&times;</button>
	                </div>
                </div>
            </div>
            
		</div>
		<!-- 카드리스트 목록에서 카드 title 수정할 때의 모달 -->
		<div id="modifyModal" class="modifyModal">
			<div class="modifyModal-title"></div>
			<!-- 수정 모달 내용 -->
			<span class="closeModal">&times;</span>
			<div class="modifyModal-content" style="top: 0; left: 0;">
			    <textarea name="content" id="modifyTextarea" rows="2" style="resize:none" onKeyPress="javascript: if(event.keyCode == 13) return false;" onKeyUp="limitMemo(this, 20)"></textarea><br />
			    <button type="button" id="saveBtn" class="saveBtn">save</button>
			</div>
        </div>
        
	</div>
	
	<!-- 카드리스트 팝업 -->
	<!-- 열기 | .is-visible -->
	<div class="popupMenuWrap">
	    <!-- 제목 -->
	    <div class="popupMenuHeader">
	        <div class="title">List Actions</div>
	        <button class="popupMenuCloseBtn">
	            <i class="far fa-times-circle"></i>
	        </button>
	    </div>
	    <!-- 메뉴목록 -->
	    <div class="popupMenuContent">
	        <ul class="popupMenuList">
	            <li class="to-achieve"><a href="#">달성</a></li>
	            <li class="to-hide"><a href="#">가리기</a></li>
	        </ul>
	    </div>
	</div>
	
	<!-- 카드팝업 jsp -->
	<%@include file="cardModal.jsp"%>


	<script>

		var modifyModal = document.getElementsByClassName('modifyModal')[0]; // 카드title 수정하는 모달창
		var closeModal = document.getElementsByClassName("closeModal")[0]; // 카드 title 수정하는 모달창의 닫힘버튼(X)
	
		var addList = document.getElementsByClassName("addList")[0]; //카드리스트 제일 마지막의 Add a List...(카드 리스트 추가)
		var createList = document.getElementsByClassName("create")[0]; //카드리스트 추가할 때 생기는 미니창
		var createListTextarea = document.getElementById("createListTextarea"); //카드리스트 추가하는 textarea
		var listAddBtn = document.getElementById("listAddBtn"); //카드리스트 추가할 때의 save버튼
		
		var cards = document.getElementsByClassName("cards"); //카드리스트 각각의 div 중 실제 카드 목록이 들어가는 div
		var createCardBox = document.getElementsByClassName("createCardBox"); //카드리스트 각각의 div 중 footer-Add a card...부분
		var addCard = document.getElementsByClassName("addCard"); //카드리스트 각각의 div 중 카드추가창
		var createCardTextarea = document.getElementById("createCardTextarea"); //카드추가창의 textarea
		
		var cardlistIndex; //스크롤 조절에 쓸 카드리스트의 인덱스
		var modifyCardTitle; //수정할 카드의 title을 출력하는 div를 담을 변수
		
		//유저 id는 임의의 값을 사용
		var u_id = 4;
		//프로젝트 id는 임의의 값을 사용
		var p_id = 4;
		
		
		
		/* 매개변수 카드리스트id와 카드리스트title이 주어지면 그것을 이용해 카드리스트 태그를 문자열로 만드는 함수 */
		function newCardlistAdd(cardlistId, cardlistTitle){
			var listStr = "<div data-id='" + cardlistId + "' class='cardlist'>" + 
						  "	   <div class='cardlistTitleBox'>" +
						  "	   	   <button type='button' class='cardlistPopBtn'><img src='/resources/image/more.png' class='cardlistMore'/></button>" +
						  "	       <textarea class='cardlistTitle' onKeyUp='limitMemo(this, 20)'>" + cardlistTitle + "</textarea>" +
						  "	   </div>" +
						  "	   <div class='cards'>" +
						  "		   <div class='addCard'>" + 
						  "    		   <textarea name='title' id='createCardTextarea' class='createCardTextarea' style='resize:none' onKeyUp='limitMemo(this, 20)'></textarea><br />" + 
						  "    		   <button type='button' id='addBtn'>add</button>" + 
						  "    		   <button type='button' id='cancleBtn'>&times;</button>" + 
						  "		   </div>" +
						  "   	</div>" +
						  "   	<footer class='createCardBox'>Add a card...</footer>" + 
						  "</div>";
			$(".cardlists").children(".addCardlist").before(listStr);
			// 타이틀 길이만큼 필드의 높이를 조정
			var newTitle = $('[data-id='+cardlistId+']').find('textarea.cardlistTitle');
			newTitle.height(newTitle.prop('scrollHeight'));
		};
						
		
		/* 매개변수 카드id와 카드title이 주어지면 그것을 이용해 카드 태그를 문자열로 만드는 함수 */
		function newCardAdd(cardId, cardTitle){
			var newTitle = "<div data-id='" + cardId + "' class='cardtitleLi'>" + 
						   "    <div id='cardLink' onclick='loadCardData(this)'>" + cardTitle + "</div>" + 
						   "    <button class=cardModifyBtn><i class='far fa-edit'></i></button>" + 
						   "</div>";
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
		$.ajax({
			type : "GET",
			url : "/cards/" + p_id,
			success : function(data) {
				var allID = new Array(); //카드리스트 id를 담을 배열
				var allTitle = new Array(); //카드리스트 title을 담을 배열
				//DB에서 받아온 데이터를 이용하여 루프를 돌면서 카드리스트 id, title을 배열에 추가
				for(var i = 0; i < data.length; i++){
					allID.push(data[i].cl_id);
					allTitle.push(data[i].cl_title);
				}
				//중복되는 id값을 제거
				var uniqID = allID.reduce(function(a, b){
					if(a.indexOf(b) < 0) 
						a.push(b);
					return a;
				}, []);
				//중복되는 title 제거
				var uniqTitle = allTitle.reduce(function(a, b){
					if(a.indexOf(b) < 0) 
						a.push(b);
					return a;
				}, []);
				
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
			  			if(data[j].c_id !== 0 && data[j].cl_id === uniqID[i]){ //카드id가 0이 아니고 카드리스트id가 위에서 만든 카드리스트id 배열의 값과 같을 때
			  				var cardStr = newCardAdd(data[j].c_id, data[j].c_title); //문자열로 카드 태그를 만드는 함수 호출(data의 id와 title을 매개변수로 줌)
							$(".cards").eq(i).children(".addCard").before(cardStr); //해당 카드리스트에 카드 태그 삽입
			  			};
		  			};
				};
		  		
			},//success
			error : function() {
		   		alert("에러가 발생했습니다.");
		   	}
		});//ajax
			
		
		
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
		
		
		
		/* 카드 등록 | save버튼 눌렀을 때의 처리 */
		$(".cardlists").on("click", "#addBtn", function(){
			cardlistIndex = $(".addCard #addBtn").index(this); //전체 add버튼 중 this의 인덱스값 구하기
			
			var title = $(".createCardTextarea").eq(cardlistIndex).val(); //사용자가 입력한 내용은 변수로 처리
			var cl_id = $(".createCardTextarea").eq(cardlistIndex).parents(".cardlist").attr("data-id"); //해당 카드리스트의 id값
			
			//아무 값도 입력하지 않을 경우
			if(title == ''){ return; }
	
			$.ajax({
				type : 'post',
				url : "/cards/" + p_id + "/card",
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
						var cardStr = newCardAdd(cardId, title); //새로운 카드 태그 생성
						$(".addCard").eq(cardlistIndex).before(cardStr); //카드추가창 위에 새카드 태그 삽입
						$(".createCardTextarea").val(''); //textarea 초기화
						cards[cardlistIndex].scrollTop = cards[cardlistIndex].scrollHeight; //스크롤 조정
					};
				},
				error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
			});//Ajax
		});
	
	    
		
		/* 카드 제목 수정 |  카드 목록에서 수정 버튼 클릭할 경우 모달창 띄우기 */
		$(".cardlists").on("click", ".cardtitleLi button", function(e){
			modifyCardTitle = $(this).prev(); //수정할 카드의 title표시하는 div를 전역변수에 담아둠(수정 save버튼 처리에 이용할 예정)
			// 모달창을 클릭한 카드의 위치에서 뜨도록 함.
			// 1. 클릭한 수정버튼의 부모 찾아가서(cardtitleLi) 그 부모의 좌표값을 구하기
			var cardtitleLiX = $(this).parent("div").offset().left; //그 수정버튼의 부모 태그의 x좌표
			var cardtitleLiY = $(this).parent("div").offset().top; //그 수정버튼의 부모 태그의 y좌표
	
			// 2. 카드리스트의 전체높이 구하기
			var headerHeight = parseInt($(".cardlistTitle").css("height")); //카드리스트 헤더 높이
			var listHeight = parseInt($(".cards").css("height")); //카드리스트 중 카드부분 높이
			var footerHeight = parseInt($(".createCardBox").css("height")); //카드리스트 푸터 높이
			var x = headerHeight + listHeight + footerHeight; //카드리스트 전체높이
			
			var listScrollHeight = $(this).parent().parent().prop("scrollHeight"); //클릭한 수정버튼의 조상 .cards의 scrollHeight
			
			var cardId = $(this).parent().attr("data-id"); //카드의 id값을 담는다.
			var title = $(this).parent().children("a").text(); //카드의 자손 중 a태그의 내용을 담는다.
			
			if(cardtitleLiY > x){ // 3. 클릭한 카드의 y좌표가 전체높이보다 크면 수정창 위치 조정하여 띄움
				$(".modifyModal-content").css({
					"left" : cardtitleLiX,
					"top" : x + 15
				});
			} else { // 4. 클릭한 카드의 y좌표가 전체높이보다 작으면 그 위치에서 수정창 띄움
				$(".modifyModal-content").css({
					"left" : cardtitleLiX,
					"top" : cardtitleLiY
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
			closeModal.onclick = function(){
				modifyModal.style.display = "none";
			};
			// 모달창 범위 밖을 클릭하면 모달창 닫힘.
			window.onclick = function(event) {
				if (event.target == modifyModal)
					modifyModal.style.display = "none";
			}; 
			
			$(".modifyModal-title").html(cardId); //저장버튼 눌렀을 때의 처리를 위해 숨겨둔 div태그 안에 수정한 카드의 id값 담아두기
		});
	
	
	
		/* 카드 제목 수정 | save버튼 클릭할 경우 */
		$("#saveBtn").on("click", function(){
			var id = $(".modifyModal-title").html(); //div태그에 담긴 카드 id값 가져와서 var id에 담기
			var title = $("#modifyTextarea").val(); //수정textarea의 내용 담기
	
			//아무 값도 입력하지 않을 경우
			if(title == '') return;
	
			$.ajax({
				type : 'put',
				url : "/cards/" + p_id + "/card/" + id,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({title : title}),
				dataType : 'text', 
				success : function(result){
					if(result == 'SUCCESS'){
						$(".modifyModal").hide(); //모달창 감추기
						$(modifyCardTitle).text(title); //수정사항 적용
					}
				},
				error : function() {
	    			alert("에러가 발생했습니다.");
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
			$(".cardlistTitle.create").css("display", "block");
			$("#createListTextarea").focus(); //포커스 주기
			$(".addList").css("display", "none"); //Add a List...버튼은 숨긴다
		});
		
		
		
		/* 카드리스트 등록 | 카드리스트 추가창 바깥을 클릭하면 추가창 사라지게 */
		$(document).click(function(e){
			//클릭한 객체의 id와 class이름을 가져옴.
			var id = $(e.target).attr("id");
			var className = $(e.target).attr("class");
			
			//2. 클릭한 객체가 카드리스트 추가버튼이 아니면 and 카드리스트 추가창이 아니면 or X버튼이면
			if((className !== "addList" && className !== "cardlistTitle create" && id !== "createListTextarea") || id === "listCancleBtn"){ 
				$(".cardlistTitle.create").css("display", "none");
				$(".addList").css("display", "block");
			}
		});
		
		
		
		/* 카드리스트 등록 | save버튼 눌렀을 때의 처리 */
		$(".cardlists").on("click", "#listAddBtn", function(){
			var title = $("#createListTextarea").val(); //사용자가 입력한 내용은 변수로 처리
			
			//아무 값도 입력하지 않을 경우
			if(title == ''){ return; }
	
			$.ajax({
				type : 'post',
				url : "/cards/" + p_id,
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'POST'
				},
				dataType : 'text',
				data : JSON.stringify({
					p_id : p_id,
					u_id : u_id,
					title : title
				}),
				success : function(cardlistID) {
					console.log('cardlistID: ' + cardlistID);
					
					// 카드리스트가 성공적으로 등록 되면
					if (cardlistID !== null || cardlistID !== 0) {
						console.log('카드리스트가 성공적으로 등록 되었습니다.');
						
						newCardlistAdd(cardlistID, title); //주어진 매개변수로 카드리스트 태그 생성하여 삽입하는 함수
				  		$("#createListTextarea").val(''); //textarea 초기화
						
						// 카드리스트 컨테이너의 스크롤을 끝 지점으로 이동
						var container = $('.cardlists');
						var moveToPos = container.prop('scrollWidth') - container.innerWidth();
						container.scrollLeft(moveToPos);
					};
				},
				error : function() {
	    			alert("에러가 발생했습니다.");
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
				url : "/cards/" + p_id + "/" + cardlistID,
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'PUT'
				},
				data : JSON.stringify({title : titleTxt}),
				dataType : 'text',
				success : function(result) {
					console.log('result: ' + result);
					// 카드리스트 제목 변경이 성공적으로 데이터베이스에 반영되면
					if (result == 'SUCCESS') {
						console.log('카드리스트 아이디 : ' + cardlistID + ', 제목 "' + titleTxt + '"(으)로 수정 되었습니다.');
					}
				},
				error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
			});
		};
		
		
		
		/* 카드리스트 제목 수정 | 관련 이벤트 */
		$('.cardlists').on({			
			click: function(){
				// 카드리스트 제목 클릭하면 전체선택
				$(this).select();
			},
			focusin: function (event) {
				// 현재 입력된 카드리스트 제목 저장
				$(this).data('data-title', $(this).val());
			},
			focusout: function (event) {
				// 입력된 글자가 MAX-LANGTH 넘어 갈 경우 필드 높이 자동 조절
				$(this).trigger('input');
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
			}
		});
		
		
		/* 카드리스트 수정 | 상태변경 */
		$('.popupMenuList li').on('click', function() {
			var CARDLIST_STATE_ACHIEVEMENT = 2; // 카드리스트 상태 값 (달성)
			var CARDLIST_STATE_HIDING = 3;		// 카드리스트 상태 값 (가리기)
			var state = null;					// 선택한 상태 값을 저장
			
			var popup = $('.popupMenuWrap');
			var cardlistID = popup.data('data-cl-id');	// 상태 변경된 카드리스트 아이디
			
			if($(this).hasClass('to-achieve'))
				state = CARDLIST_STATE_ACHIEVEMENT;	// 달성 버튼
			else
				state = CARDLIST_STATE_HIDING;		// 가리기 버튼
		
			// 팝업 닫기
			closeCardlistPop();
		
			$.ajax({
				type : 'put',
				url : "/cards/" + p_id + "/" + cardlistID,
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'PUT'
				},
				data : JSON.stringify({ps_id : state}),
				dataType : 'text',
				success : function(result) {
					console.log('result: ' + result);
					// 카드리스트 상태 변경이 성공적으로 데이터베이스에 반영되면
					if (result == 'SUCCESS') {
						console.log('카드리스트 아이디 : ' + cardlistID + ', 상태 ' + state + '(으)로 수정 되었습니다.');
						// 상태 변경된 카드리스트의 임시 데이터를 삭제
						popup.removeData('data-cl-id');
						// 상태 변경된 카드리스트 요소를 삭제
						$('.cardlist[data-id="' + cardlistID + '"').remove();
					}
				},
				error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
			});
		
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
					&& className !== "popupMenuContent" && className !== "cardlistMore"){ 
				closeCardlistPop();
			};
		});

	</script>
</body>
</html>