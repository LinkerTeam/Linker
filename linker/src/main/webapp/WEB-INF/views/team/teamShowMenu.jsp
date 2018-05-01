<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Linker</title>
<link href="/resources/css/team/teamShowMenu.css?ver=12" type="text/css" rel="stylesheet" />
</head>

<body>
	<!-- 이력 메뉴 버튼 -->
	<a href="#menu" id="toggle"><span></span></a>
	
	<!-- 이력 메뉴 -->
	<aside id="board-aside" class="board-aside">
		<div class="nav-tabs-wrap">
			<ul class="nav-tabs">
				<!-- .active | 탭 메뉴 활성화 상태 -->
				<!-- Tab1 | 이력목록 -->
				<li>
					<div class="nav-tab-btn">
						이력
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
						<!-- 이력메시지가 나오는 컨텐츠 -->
						<ul class="pic-list">
							<!-- jquery로 동적 생성 -->
						</ul>
						<!-- 이력 더 보기 -->
						<a class="show-more" href="#">View all activity…</a>
						</div>
					</div>
				</li>
				<!-- /이력목록 -->
			</ul>
		</div>
	</aside>
	
</body>

<script>
	var i = 0;
	var j = 0;
	var p_id = null;
	var u_id = null;
	
	  var theToggle = document.getElementById('toggle'); //오른쪽 메뉴 버튼 
	
	 /* 오른쪽 메뉴 button event */
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
	
	
	/* 오른쪽 메인메뉴 | 숨기기 & 펼치기 이벤트 */
	function openAside() {
		var boardAside = document.getElementById('board-aside'); //오른쪽 메뉴 전체
	    //var content = document.getElementsByClassName('cardlists'); //카드리스트가 출력되는 전체부분
	    var tabMenu = document.getElementsByClassName('nav-tabs'); //탭 메뉴
	    
	    j++; //오른쪽 메뉴버튼 클릭할 때마다 j의 값 1씩 증가하도록

	    if (j % 2 === 1) { //클릭수가 홀수이면 펼치기
	        boardAside.classList.add('board-aside-open'); //클래스 이름 'boardAside-open' 추가
	        boardAside.style.width = "330px";
	        //content[0].style.marginRight = "330px";
	        //활성화된 메뉴가 없다면 첫번째 탭 메뉴를 활성화
	        if (tabMenu[0].dataset.activenumber === undefined) {
	        	tabMenu[0].dataset.activenumber = 0;
	        	tabMenu[0].children[0].classList.add('active');
	        };
	    } else { //클릭수가 짝수이면 숨기기
	        boardAside.classList.remove('board-aside-open'); //클래스 이름 'boardAside-open' 제거
	        boardAside.style.width = "0";
	        //content[0].style.marginRight = "0";
	    };
	};

	/* 오른쪽 메인메뉴 | 탭버튼 제어 */
	var tabMenu = document.getElementsByClassName('nav-tabs'); //탭 메뉴
	for(var i = 0; i < tabMenu[0].childElementCount; i++){
		tabMenu[0].children[i].addEventListener("click", function(){
			
			var clickedTabIndex = getElementIndex(this); //클릭한 탭 번호
			var currentTabIndex = this.parentElement.dataset.activenumber; //현재 탭 변호
			
			//클릭한 탭이 현재 활성화 된 탭이 아닌 경우에만 탭의 내용 보여주기
			if(currentTabIndex !== clickedTabIndex){
		        tabMenu[0].children[currentTabIndex].classList.remove('active'); //현재 탭 비활성화
			    this.classList.add('active'); //클릭한 탭 활성화
			    this.parentElement.dataset.activenumber = clickedTabIndex; //클릭한 탭의 번호를 저장
			}
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
</script>
</html>