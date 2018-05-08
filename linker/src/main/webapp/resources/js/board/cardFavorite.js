
/**********************************************************************************
 * 파일명칭 : cardFavorite.js
 * 기    능 : 프로젝트 화면 안에서 카드 즐겨찾기 조회/추가/삭제하는 기능을 구현하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/05/06
 * 
 * 비    고 : 한 프로젝트 안에서의 즐겨찾기 카드 개수는 많지 않을 것 같아 추가/삭제 
 *            처리 후 목록을 갱신하도록 함. 만약 이게 비효율적이고 부담이 많다면 
 *            목록을 갱신하지 말고 직접 카드 태그를 삽입/삭제 하도록 변경.
**********************************************************************************/




/* 즐겨찾기 조회 */
function allFavorite(){
	$.getJSON("/board/favoritelist/" + p_id, function(data) {
		if(data.length < 1) {
			$(".favorite").children(".cards").empty(); 
			$(".favorite").hide(); //즐겨찾기 카드가 없으면 리스트 숨기기
			return;
		};
		
		var str = "";
		for(var i = 0; i < data.length;i++) //동적 카드 태그 생성
			str += newCardAdd(data[i].c_id, data[i].cl_id, data[i].c_title, 0, data[i].uhc_u_id, data[i].content, data[i].file, data[i].reply);
			//status에 대한 매개변수로 0을 준 이유 : 즐겨찾기 리스트에 있는 카드는 왼쪽에 초록색 border속성 주지 않기 위해
		$(".favorite > .cards").html(str); //생성한 카드 태그를 즐겨찾기 리스트 내부에 추가
		$(".favorite").show(); //즐겨찾기 리스트 출력
	});
};

/* 즐겨찾기 추가 | ajax처리 */
function addFavorite(cardID) {
	var link = document.location.href.split("/"); //t_id를 얻기 위해 url에서 정보를 가져와서 /단위로 끊음
	var teamID = link[4]; 
	var listID = $(".cardtitleLi[data-id='" + cardID + "']").attr("data-clid"); //카드리스트 id
	var title = $(".cardtitleLi[data-id='" + cardID + "']").children("#cardLink").text(); //카드 제목
	
	$.ajax({
		type : "post",
		url : "/board/favorite",
		headers :{     
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "POST"							
		},
		data : JSON.stringify({ 
			t_id : teamID, 
			p_id : p_id,
			cl_id : listID,
			c_id : cardID 
		}),
		dataType : "text",
		success : function(result){
			if(result === "SUCCESS") {
				$(".cardlist[data-id='" + listID + "'] > .cards > .cardtitleLi[data-id='" + cardID + "']").addClass("favo");
				allFavorite(); //목록 갱신
			};
		}, 
		error : function() {
			alert("에러가 발생했습니다.");
		}
	}); //ajax
};

/* 즐겨찾기 삭제 | ajax처리 */
function deleteFavorite(cardID) {
	$.ajax({
		type : "DELETE",
		url : "/board/favoriteDelete/" + cardID,
		success : function(result){
			if(result === "SUCCESS") {
				allFavorite(); //목록 갱신
				$(".favo[data-id=" + cardID + "]").removeClass("favo");
			};			
		}, 
		error : function() {
			alert("에러가 발생했습니다.");
		}
	});
};

/* 즐겨찾기 버튼을 눌렀을 경우 | 버튼의 클래스이름에 따라 추가ajax 또는 삭제ajax 함수 호출 */
$(".favorite-btn").on("click", function(){
	var cardID = $(".modifyModal-title").text();
	if($(this).attr("class") === "favorite-btn add") //추가 버튼이면
		addFavorite(cardID);
	else //삭제 버튼이면
		deleteFavorite(cardID);
});
