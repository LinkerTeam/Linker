<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- test -->
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- /test -->

<title>Cardlist</title>

<style>
	/* 
		Test
		html5doctor.com Reset Stylesheet
	*/
	html, body, div, span, object, iframe,
	h1, h2, h3, h4, h5, h6, p, blockquote, pre,
	abbr, address, cite, code,
	del, dfn, em, img, ins, kbd, q, samp,
	small, strong, sub, sup, var,
	b, i,
	dl, dt, dd, ol, ul, li,
	fieldset, form, label, legend,
	table, caption, tbody, tfoot, thead, tr, th, td,
	article, aside, canvas, details, figcaption, figure, 
	footer, header, hgroup, menu, nav, section, summary,
	time, mark, audio, video {margin:0; padding:0; border:0; outline:0; font-size:100%; vertical-align:baseline; background:transparent;}
	body {line-height:1;}
	article,aside,details,figcaption,figure,
	footer,header,hgroup,menu,nav,section {display:block;}
	nav ul {list-style:none;}
	blockquote, q {quotes:none;}
	blockquote:before, blockquote:after, q:before, q:after {content:''; content:none;}
	a {margin:0; padding:0; font-size:100%; vertical-align:baseline; background:transparent;}
	/* change colours to suit your needs */
	ins {background-color:#ff9; color:#000; text-decoration:none;}
	/* change colours to suit your needs */
	mark {background-color:#ff9; color:#000; font-style:italic; font-weight:bold;}
	del {text-decoration: line-through;}
	abbr[title], dfn[title] {border-bottom:1px dotted; cursor:help;}
	table {border-collapse:collapse; border-spacing:0;}
	/* change border colour to suit your needs */
	hr {display:block; height:1px; border:0; border-top:1px solid #cccccc; margin:1em 0; padding:0;}
	input, select {vertical-align:middle;}
	
	/*
	    카드리스트 스타일 시트
	*/
	
	/* 카드리스트 목록 컨테이너 */
	.cardlists-container {
	    position: absolute;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    left: 0;
	    white-space: nowrap;    /* 가로로 배치되는 카드리스트들이 개행되지 않게 */
	    overflow-x: auto;       /* 가로 스크롤바 표시 */
	    overflow-y: hidden;
	    padding: 20px 56px 10px 0;
	}
	
	/* 카드리스트들이 개행되지 않게 적용한 값이 상속되지 않게 초기화 */
	.cardlists-container * { 
	    white-space: normal;
	}
	
	/* 컨테이너 안에서 가로로 배치되는 요소들의 공통 속성 */
	.cardlist-regist-box, 
	.cardlist-box {
	    display: inline-block;
	    vertical-align: top;
	}
	
	/* 
	    카드리스트 등록 박스
	*/
	.cardlist-regist-box {
	    width: 246px;   
	    border-radius: 3px;
	    margin-left: 10px;
	    height: 34px;
	    overflow: hidden;
	}
	.cardlist-regist-box form {
	    background-color: #E2E4E6;
	    border-radius: 2px;
	    padding: 4px;
	}
	
	/* 카드리스트 추가 버튼 */
	.cardlist-add-btn {
	    width: 100%;
	    height: 34px;
	    line-height: 34px;
	    font-size: 16px;
	    color: #F5D3CE;
	    background-color: #963C2B;
	    box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    border-radius: 3px;
	    padding-left: 8px;
	}
	.cardlist-add-btn:hover {
	    cursor: pointer;
	    background-color: #63281d;
	}
	
	/* 카드리스트 등록 : 입력 대기상태 */
	.cardlist-regist-box.ready {
	    height: auto;
	    overflow: visible;
	}
	.cardlist-regist-box.ready .cardlist-add-btn {
	    display: none;
	}
	
	/* 카드리스트 등록 : 제목 입력필드 */
	.cardlist-input-title {
	    width: 100%;
	    height: 34px;
	    font-family: inherit;
	    font-size: 14px;
	    padding: 0 7px;
	    color: #575757;
	    background-color: #D7D9DB;
	    box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    border: 1px solid #aaa;
	    border-radius: 3px;
	    box-shadow: inset 0 0 10px rgba(0, 0, 0, .1);
	}
	.cardlist-input-title[type=text]:focus {
	    color: #575757;
	    background-color: #D7D9DB;
	    transition: none;
	}
	.cardlist-input-title::-webkit-input-placeholder {color: #797979;}
	.cardlist-input-title:-ms-input-placeholder {color: #797979;}
	
	/* 카드리스트 등록 : 버튼 공통속성 */
	.regist-btn {
	    width: 72px;
	    height: 30px;
	    font-size: 14px;
	    font-weight: bold;
	    background-color: #5EB54A;
	    border-style: none;
	    border-radius: 2px;
	    color: white;
	    cursor: pointer;
	    margin-top: 4px;
	}
	
	/* 카드리스트 등록 : 취소버튼 */
	.regist-btn.cardlist-cancle-btn {
	    background-color: #9c9c9c;
	}
	
	/* 
	    하나의 카드리스트 박스
	*/
	.cardlist-box {
	    background-color: #E2E4E6;
	    margin-left: 10px;
	    border-radius: 3px;
	}
	.cardlist-header {
	    position: relative;
	    width: 260px;
	    height: auto;
	    border-top-left-radius: 3px;
	    border-top-right-radius: 3px;
	    margin: 5px;
	    padding-right: 30px;
	}
	.cardlist-cards {
	    min-height: 0;
	    overflow-x: hidden;
	    overflow-y: auto;
	    padding: 0 4px;
	}
	
	/* 하나의 카드리스트 : 제목 수정 필드 */
	.cardlist-mod-title {
	    width: 100%;
	    min-height: 26px;
	    font-family: inherit;
	    font-size: 14px;
	    font-weight: bold;
	    padding: 4px 5px;
	    color: #333;
	    background-color: #E2E4E6;
	    resize: none;
	    box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    border-style :none;
	    border-radius: 3px;
	
	    height: 24px;
	    word-wrap: break-word;
	    overflow-y: hidden;
	}
	.cardlist-mod-title:focus {
	    box-sizing: border-box;
	    -moz-box-sizing: border-box;
	    -webkit-box-sizing: border-box;
	    border: 1px solid #0079bf;
	    box-shadow: 0 0 2px 0 #0284c6;
	    background-color: #fff;
	}
	
	/* 하나의 카드리스트 : 카드 추가버튼 */
	.card-add-btn {
	    display: block;
	    font-size: 16px;
	    color: #838C91;
	    border-bottom-left-radius: 3px;
	    border-bottom-right-radius: 3px;
	    padding: 10px;
	}
	.card-add-btn:hover {
	    color: #515252;
	    background-color: #CDD2D4;
	    text-decoration: underline;
	}
	
	/* 하나의 카드리스트 : 설정버튼 */
	.cardlist-pop-btn {
	    display: block;
	    position: absolute;
	    right: 0;
	    top: 0;
	}
	.fa-ellipsis-h {
	    font-size: 15px;
	    color: #838C91;
	    border-radius: 3px;
	    padding: 5px;
	}
	.cardlist-pop-btn:hover .fa-ellipsis-h {
	    color: #737475;
	    background: #CDD2D4;
	}
	
	/*
	    카드리스트 팝업
	*/
	.context-menu-wrap {
	    display: none;
	    position: absolute;
	    width: 200px;
	    z-index: 1100;
	}
	.context-menu-wrap.is-visible {
	    display: block;
	}
	
	/* 카드리스트 팝업 : 제목 */
	.context-menu-header {
	    position: relative;
	    height: 30px;
	    line-height: 30px;
	    border: 1px solid #838c91;
	    border-bottom: none;
	    background-color: #fff;
	}
	.context-menu-header .title {
	    font-size: 16px;
	    text-align: center;
	    margin: 0 10px;
	    border-bottom: 1px solid #d6dadc;
	}
	
	/* 카드리스트 팝업 : 닫기버튼 */
	.context-menu-close-btn {
	    position: absolute;
	    top: 0;
	    right: 0;
	    display: block;
	    height: 30px;
	    line-height: 30px;
	    padding: 0 10px;
	    border: none;
	    background: none;
	    cursor: pointer;
	}
	
	/* 카드리스트 팝업 메뉴 목록 */
	.context-menu-content {
	    overflow-x: hidden;
	    overflow-y: auto;
	    padding: 10px;
	    border: 1px solid #838c91;
	    border-top: none;
	    background-color: #fff;
	}
	.context-menu-list li {
	    list-style: none;
	}
	.context-menu-list li a {
	    display: block;
	    font-size: 16px;
	    line-height: 30px;
	    text-align: center;
	    text-decoration: none;
	    margin: 0 -10px;
	    color: #838c91;
	}
	.context-menu-list li a:hover {
	    background-color: #bacad3;
	    color: #111;
	}
	
	/* IR 기법 : 대체 텍스트를 위해 사용 */
	.replacement {
	    display: block;
	    position: absolute;
	    top: 0;
	    direction: ltr;
	    text-indent: -999em;    
	    overflow: hidden;
	}
	
	/* 테스트 코트 */
	.cardlists-container {background: #fff;}
</style>
</head>
<body>

	<!-- 카드리스트 -->
	<div id = "content" class="cardlists-container">

		<!-- 하나의 카드리스트 -->
		<c:forEach items="${cardlist}" var="item">
	        <div class="cardlist-box" data-id="${item.id}">
	            <!-- 제목 -->
	            <div class="cardlist-header">
	                <!-- 카드리스트 설정버튼 -->
	                <a href="#" class="cardlist-pop-btn"><i class="fas fa-ellipsis-h"></i><span class="replacement">상태변경</span></a>
	                <textarea class="cardlist-mod-title" maxlength="100">${item.title}</textarea>
	            </div>
	            <!-- 카드 모음 -->
	            <div class="cardlist-cards"></div>
	            <!-- 카드 추가버튼 -->
	            <a href="#" class="card-add-btn">카드를 추가 하시겠습니까?</a>
	        </div>
		</c:forEach>

	    <!-- 카드리스트 등록 박스 -->
	    <div class="cardlist-regist-box">
	        <!-- 카드리스트 추가 버튼 -->
	        <div class="cardlist-add-btn">Add a list...</div>
	        <form>
	            <label for="add-cardlist" class ="replacement">카드리스트 제목</label>
	            <input id="add-cardlist" class="cardlist-input-title" type="text" placeholder="Add a list…" maxlength="100" />
	            <button type="button" class="cardlist-save-btn regist-btn">저장</button>
	            <button type="button" class="cardlist-cancle-btn regist-btn">취소</button>
	        </form>
	    </div>
	
	</div>
	<!-- /카드리스트 -->
	
	<!-- 카드리스트 컨텍스트 메뉴 -->
	<!-- 열기 | .is-visible -->
	<div class="context-menu-wrap">
	    <!-- 제목 -->
	    <div class="context-menu-header">
	        <div class="title">List Actions</div>
	        <button class="context-menu-close-btn">
	            <a href="#"><i class="far fa-times-circle"></i><span class="replacement">닫기</span></a>
	        </button>
	    </div>
	    <!-- 메뉴목록 -->
	    <div class="context-menu-content">
	        <ul class="context-menu-list">
	            <li class="to-achieve"><a href="#">달성</a></li>
	            <li class="to-hide"><a href="#">가리기</a></li>
	        </ul>
	    </div>
	</div>
	
	
	<script>
	$(function() {
				
		// 카드리스트 컨텍스트 메뉴 닫기
		function closeCardlistPop(){
			var popup = $('.context-menu-wrap');
			if (popup.hasClass('is-visible'))
				popup.removeClass('is-visible');
		}
	
		// 카드리스트 등록 창 닫기
		function closeCardlistRegisterBox(){
			$('.cardlist-regist-box').removeClass('ready');
			// 카드리스트 제목 필드 초기화
			$('.cardlist-input-title').val('');
		}
				
		/*
			카드리스트 이벤트 처리
		*/
		// 카드리트트 추가 버튼 클릭
		$('.cardlist-add-btn').on('click', function(){
			// 카드리스트 등록 상태로 변경
			$(this).parent().addClass('ready');
			// 카드리스트 제목 필드로 포커스 이동
			$('.cardlist-input-title').focus();
		});
	
		// 카드리스트 등록 ㅡ 취소 버튼 클릭
		$('.cardlist-cancle-btn').on('click', function(){
			// 카드리스트 등록 창 닫기
			closeCardlistRegisterBox();
		});
	
		// 카드리스트 등록 ㅡ 저장 버튼 클릭
		$('.cardlist-save-btn').on('click', function(){
			var inputTitle = $('.cardlist-input-title');
			// 입력된 title 값의 양쪽 공백을 제거
			var title = $.trim(inputTitle.val());
			var projectID = '${projectID}';

			// 유효성 검사
			if (title == '') {
				// 입력된 값이 없다면 입력상태로 되돌리기
				inputTitle.focus();
				return false;
			}
			
			$.ajax({
				type : 'post',
				url : projectID,
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'POST'
				},
				dataType : 'text',
				data : JSON.stringify({
					title : title,
					p_id : projectID
				}),
				success : function(cardlistID) {
					console.log('cardlistID: ' + cardlistID);
					// 카드리스트가 성공적으로 등록 되면
					if (cardlistID != null || cardlistID != 0) {
						console.log('카드리스트가 성공적으로 등록 되었습니다.');
						// 카드리스트 등록 창 닫기
						closeCardlistRegisterBox();
						
						// 새로운 카드리스트 객체 생성
						var $newCardlist = null;
						$newCardlist =
							'<div class="cardlist-box" data-id="'+ cardlistID +'">'+
							    '<div class="cardlist-header">'+
									'<a href="#" class="cardlist-pop-btn"><i class="fas fa-ellipsis-h"></i><span class="replacement">상태변경</span></a>'+
									'<textarea class="cardlist-mod-title" maxlength="100">'+title+'</textarea>'+
							    '</div>'+
							    '<div class="cardlist-cards"></div>'+
							    '<a href="#" class="card-add-btn">카드를 추가 하시겠습니까?</a>'+
							'</div>';
							
						// 생성한 카드리스트 객체를 DOM에 추가
						$('.cardlist-regist-box').before($newCardlist);
						
						// 카드리스트 컨테이너의 스크롤을 끝 지점으로 이동
						var containerObj = $('.cardlists-container');
						var moveToPos = containerObj.prop('scrollWidth') - containerObj.innerWidth();
						containerObj.scrollLeft(moveToPos);
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
			
		});
	
		// 카드리스트 등록 ㅡ 엔터 키 입력
		$('.cardlist-input-title').keydown(function(key) {
			// Enter 키를 입력하면
			if (key.keyCode == 13) {
				// 기본 이벤트 제거
				event.preventDefault();
				// 카드리스트 등록이 구현된 로직으로 이동
				$('.cardlist-save-btn').trigger('click');
			}
		});
	
		// 카드리스트 제목 수정
		$('.cardlist-mod-title').focus(function(){
		// 포커스가 맞춰지면
			// 카드리스트 제목 저장
			$(this).data('data-title', $(this).val());
		})
		.blur(function() {
		// 포커스를 잃었을 때
			// 카드리스트 제목 변경여부에 따라 수정
			var CARDLIST_STATE_INPROGRESS = 1; // 카드리스트 상태 값 (진행)
			var title = $.trim($(this).val()); // 입력된 title 값의 양쪽 공백을 제거
			
			var cardlistObj = $(this).parents('.cardlist-box');
			var cardlistID = cardlistObj.data('id');
	
			// 유효성 검사
			if ($(this).data('data-title') == title) {
				// 공백만 추가된 경우라면 공백 삭제 (빈 문자열은 허용)
				$(this).val($.trim($(this).val()));
				// 유효성 검사를 위한 임시 데이터 삭제
				$(this).removeData('data-title');
				// 제목이 변경 되지 않으면 이벤트 처리를 하지 않는다
				return false;
			}
	
			$.ajax({
				type : 'put',
				url : '${projectID}' + '/' + cardlistID,
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'PUT'
				},
				dataType : 'text',
				data : JSON.stringify({
					title : title,
					ps_id : CARDLIST_STATE_INPROGRESS,
					id : cardlistID
				}),
				success : function(result) {
					console.log('result: ' + result);
					// 카드리스트 제목 변경이 성공적으로 데이터베이스에 반영되면
					if (result == 'SUCCESS') {
						console.log('카드리스트 아이디 : ' + cardlistID + ', 제목 "' + title + '"(으)로 수정 되었습니다.');
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});
		})
		.keydown(function(key) {
		// Enter 키를 입력하면
			if (key.keyCode == 13) {
				// 기본 이벤트 제거
				event.preventDefault();
				// 카드리스트 제목을 수정하는 로직으로 이동
				$(this).blur();
			}
		});
	
		// 카드리스트 제목 수정 | 입력된 글자의 길이만큼 필드의 높이가 자동으로 늘어난다.
        $('.cardlist-mod-title').each(function () {
            var field = $(this);
            //field.css('min-height', field.css('height'));
            var offset = field.innerHeight() - field.height();
            field.height(1);
            field.height(this.scrollHeight - offset);
        })
        .on('input paste', function () {
            var field = $(this);
            var offset = field.innerHeight() - field.height();

            if (field.innerHeight < this.scrollHeight) {
                field.height(this.scrollHeight - offset);
            } else {
                field.height(1);
                field.height(this.scrollHeight - offset);
            }
        });
		
		// 카드리스트 상태 수정
		$('.context-menu-list li').on('click', function() {
			
			var CARDLIST_STATE_ACHIEVEMENT = 2; // 카드리스트 상태 값 (달성)
			var CARDLIST_STATE_HIDING = 3;		// 카드리스트 상태 값 (가리기)
			var state = null;					// 선택한 상태 값을 저장
			
			var contextMenu = $('.context-menu-wrap');
			var data = contextMenu.data('data-temp');	// 상태 변경된 카드리스트의 임시 데이터를 담은 객체
			
			if($(this).hasClass('to-achieve'))
				state = CARDLIST_STATE_ACHIEVEMENT;	// 달성 버튼
			else
				state = CARDLIST_STATE_HIDING;		// 가리기 버튼
	
			// 컨텍스트 메뉴 창을 닫는다
			closeCardlistPop();
	
			$.ajax({
				type : 'put',
				url : '${projectID}' + '/' + data.cardlistID,
				headers : {
					'Content-Type' : 'application/json',
					'X-HTTP-Method-Override' : 'PUT'
				},
				dataType : 'text',
				data : JSON.stringify({
					title : data.title,
					ps_id : state,
					id : data.cardlistID
				}),
				success : function(result) {
					console.log('result: ' + result);
					// 카드리스트 상태 변경이 성공적으로 데이터베이스에 반영되면
					if (result == 'SUCCESS') {
						console.log('카드리스트 아이디 : ' + data.cardlistID + ', 상태 ' + state + '(으)로 수정 되었습니다.');
						// 상태 변경된 카드리스트의 임시 데이터를 삭제
						contextMenu.removeData('data-info');
						// 상태 변경된 카드리스트 요소를 삭제
						$('.cardlist-box[data-id="'+data.cardlistID+'"').remove();
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					console.log(jqXHR.responseText);
				}
			});

		});
	
		// 카드리스트 컨텍스트 메뉴 띄우기
		$('.cardlists-container').on('click','.cardlist-pop-btn', function() {
			// 버튼좌표
			var btnPosition = $(this).offset();
			var contextMenu = $('.context-menu-wrap');
			
			// 선택한 카드리스트 정보를 컨텍스트 메뉴 요소에 저장
			var temp = {};	// 데이터 저장할 임시객체
			var selectedCardlist = $(this).parents('.cardlist-box');
			temp.title = selectedCardlist.find('.cardlist-mod-title').val();
			temp.cardlistID = selectedCardlist.data('id');
			contextMenu.data('data-temp', temp);
						
			// 컨텍스트 메뉴가 화면에 없을 때 띄우기
			if (!contextMenu.hasClass('is-visible'))
				contextMenu.addClass('is-visible');
			
			// 컨텍스트 메뉴 좌표설정
			contextMenu.css('top', btnPosition.top+$(this).height()).css('left', btnPosition.left);
		});
	
		// 카드리스트 컨텍스트 메뉴 닫기버튼 클릭
		$('.context-menu-close-btn').on('click', function() {
			closeCardlistPop();
		});
		
	});
	</script>
</body>
</html>