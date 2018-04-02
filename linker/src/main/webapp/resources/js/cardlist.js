
//카드리스트 추가 버튼 클릭
$('.addList').on('click', function(){
	// 카드리스트 등록 상태로 변경
	$('.cardlist-regist-box').addClass('ready');
	// 카드리스트 제목 필드로 포커스 이동
	$('.cardlist-input-title').focus();
});



//카드리스트 등록 창 ㅡ 저장 버튼 클릭
$('.cardlist-save-btn').on('click', function(){
	// 카드리스트 등록이 구현된 로직 실행
	registCardlist();
});


/* 카드리스트 등록 | 카드리스트 추가버튼 눌렀을 때 */
$(".cardlists").on("click", ".addList", function(){
	alert('a');
});