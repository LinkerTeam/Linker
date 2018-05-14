/* 즐겨찾기 카드 조회 | 접속 유저에 대한 전체 카드리스트 목록 출력 */
favoriteTeam();

function favoriteTeam(){
	$.ajax({
		type : 'GET',
		url : "/board/favoteam",
		success : function(data){
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
		  				var cardStr = newCardAdd(data[j].c_id, data[j].cl_id, data[j].c_title, 
		  						data[j].status, data[j].content, data[j].file, data[j].reply); //문자열로 카드 태그를 만드는 함수 호출
		  				$(".cards").eq(i).append(cardStr); //해당 카드리스트에 카드 태그 삽입
		  			};
	  			};
			};
			
		}, error : function(){
			alert("통신 에러가 발생했습니다."); 
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
function newCardAdd(cardId, cardlistId, cardTitle,status, content, file, reply){
	//매개변수값이 undefined 정해지지않은경우에는 0으로 넣는다.
	if(status === undefined) status = 0;
	if(content === undefined) content = 0;
	if(file === undefined) file = 0;
	if(reply === undefined) reply = 0;
	
	var cardClass = "cardtitleLi";
	
	if(status === 1)
		cardClass = "cardtitleLi favo";
	var newTitle =  "<div data-id='" + cardId + "' data-clId='" + cardlistId + "' class='" + cardClass + "' onclick='loadCardData(this)'>"
				 +  "    <div id='cardLink'>" + cardTitle + "</div><div class='cardIcon'>";
   	
 	if(content === 1)
		newTitle += "<i class='fas fa-align-left'></i>";	
	if(reply !== 0)
		newTitle += "<i class='far fa-comment'></i><p>" + reply + "</p>";
	if(file !== 0)
		newTitle += "<i class='fas fa-paperclip'></i><p>" + file + "</p>";
		newTitle += " 	 </div>"
				 +  "    <button class='cardModifyBtn' onclick='cardTitleModifyModal(this)'><i class='far fa-edit'></i></button>"
				 +  "</div>";		   	   
			   	   
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

var datanum = 0;
/* 카드 제목 수정 |  카드 목록에서 수정 버튼 클릭할 경우 모달창 띄우기 */
function cardTitleModifyModal(obj){
	event.stopPropagation(); //이벤트 전파 방지. 부모의 이벤트인 카드모달창 띄우는 이벤트가 발생하지 않도록 한다.
	
	modifyCardTitle = $(obj).prev().prev(); //수정할 카드의 title표시하는 div를 전역변수에 담아둠(수정 저장버튼 처리에 이용할 예정)
	// 모달창을 클릭한 카드의 위치에서 뜨도록 함.
	// 1. 클릭한 수정버튼의 부모 찾아가서(cardtitleLi) 그 부모의 좌표값을 구하기
	var cardtitleLiX = $(obj).parent("div").offset().left; //그 수정버튼의 부모 태그의 x좌표
	var cardtitleLiY = $(obj).parent("div").offset().top - 60; //그 수정버튼의 부모 태그의 y좌표에서 즐겨찾기 버튼의 height만큼을 뺀 좌표
	
	// 2. 카드리스트의 전체높이 구하기
	var headerHeight = parseInt($(obj).parent().parent().prev().css("height")); //카드리스트 헤더 높이
	var listHeight = parseInt($(obj).parent().parent().css("height")); //카드리스트 중 카드부분 높이
	var footerHeight = parseInt($(".createCardBox").css("height")); //카드리스트 푸터 높이
	var x = headerHeight + listHeight + footerHeight; //카드리스트 전체높이
				
	var listScrollHeight = $(obj).parent().parent().prop("scrollHeight"); //클릭한 수정버튼의 조상 .cards의 scrollHeight
	
	var cardId = $(obj).parent().attr("data-id"); //카드의 id값을 담는다.
	var title = $(obj).parent().children("a").text(); //카드의 자손 중 a태그의 내용을 담는다.
	
	

	$(".favorite-btn").html("<i class='fas fa-star'></i> 즐겨찾기 해제");
	$(".favorite-btn").removeClass("add").addClass("delete"); //즐겨찾기 버튼의 클래스 이름 add -> delete로 변경
	
	
	if(cardtitleLiY > x){ // 3. 클릭한 카드의 y좌표가 전체높이보다 크면 수정창 위치 조정하여 띄움
		$(".modifyModal-content").css({
			"left" : cardtitleLiX,
			"top" : x + 30
		});
	} else { // 4. 클릭한 카드의 y좌표가 전체높이보다 작으면 그 위치에서 수정창 띄움
		$(".modifyModal-content").css({
			"left" : cardtitleLiX,
			"top" : cardtitleLiY + 30
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
	$(".closeModal.modifyCardTitle").click(function(){
		modifyModal.style.display = "none";
	});
	// 모달창 범위 밖을 클릭하면 모달창 닫힘.
	window.onclick = function(event) {
		if (event.target !== modifyTextarea)
			modifyModal.style.display = "none";
	}; 
	
	$(".modifyModal-title").html(cardId); //저장버튼 눌렀을 때의 처리를 위해 숨겨둔 div태그 안에 수정한 카드의 id값 담아두기
};


/* 즐겨찾기 삭제 | ajax처리 */
function deleteFavorite(cardID) {
	$.ajax({
		type : "DELETE",
		url : "/board/favoriteDelete/" + cardID,
		success : function(result){
			if(result === "SUCCESS") {
				$('.cardlists').html("");
				favoriteTeam();
				$(".popupCardClose").click();
			};			
		}, 
		error : function() {
			alert("통신 에러가 발생했습니다.");
		}
	});
};

/* 삭제ajax 함수 호출  */
$(".favorite-btn").on("click", function(){
	var cardID = $(".modifyModal-title").text();
		deleteFavorite(cardID);

});


/* 카드 제목 수정 | 저장버튼 클릭할 경우 */
$("#saveBtn").on("click", function(){
	var id = $(".modifyModal-title").html(); //div태그에 담긴 카드 id값 가져와서 var id에 담기
	var title = $("#modifyTextarea").val(); //수정textarea의 내용 담기
	
	//아무 값도 입력하지 않을 경우
	if(title == '') return;
	
	$.ajax({
		type : "put",
		url : "/board/" + p_id + "/card/" + id,
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		data : JSON.stringify({title : title}),
		dataType : 'text', 
		success : function(result){
			if(result == 'SUCCESS'){
				$(".modifyModal").hide(); //모달창 감추기
				$(".cardtitleLi[data-id='" + id + "'] > #cardLink").text(title); //수정사항 적용
			};
		},
		error : function() {
			alert("통신 에러가 발생했습니다.");
		}
	});//ajax
});

