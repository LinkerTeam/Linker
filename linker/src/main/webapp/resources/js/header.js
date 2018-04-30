

/**********************************************************************************
 * 파일명칭 : header.js
 * 기    능 : 헤더의 검색창 초기화, 개인 메뉴 관련된 기능을 구현하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/03
 **********************************************************************************/



/* 헤더 검색창 | blur될 경우 입력한 내용 초기화 */
$("#search").on("blur", function(){
	$(".header-search").children("form").children("button").css("left", "140px");
	$(this).val("");
});
$("#search").on("focus", function(){
	$(".header-search").children("form").children("button").css("transition", "0.5s");
	$(".header-search").children("form").children("button").css("left", "220px");
});	



/* 오른쪽 프로필 사진 클릭하면 menu 출력/숨기기 */
$(".rtMenu-button").click(function(){
	if($(".my-aside").hasClass("is-hidden"))
		$(".my-aside").removeClass("is-hidden");
	else
		$(".my-aside").addClass("is-hidden");
});

/* 오른쪽 메뉴 이외의 영역을 클릭하면 메뉴 닫기 */
$(document).click(function(e){
	if(!($(e.target).hasClass("header-profile")) && !($(e.target).hasClass("header-menu"))) 
		$(".my-aside").addClass("is-hidden");
});

