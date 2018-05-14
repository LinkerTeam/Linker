/**
 * 작성자 : 김소영
 */
$(document).ready(function(){
	
	//'이동하기' 버튼 클릭할 경우
	$(".search-move-btn").click(function(){
		var c_id = $(this).attr("data-id");
		var cl_id = $(this).attr("data-clId");
		var p_id = $(this).attr("data-pId");
		var t_id = $(this).attr("data-tId");
		
		location.href="/board/" + t_id + "/" + p_id;
	});
	
	//'작성일자 순' 버튼을 클릭한 경우
	$("#search-align-cdate").click(function(){
		self.location = "/main/search/" + keyword + "&d";
	});
	
	//'제목순'버튼을 클릭한 경우
	$("#search-align-title").click(function(){
		self.location = "/main/search/" + keyword + "&t";
	});
	
	//'작성자순' 버튼을 클릭한 경우
	$("#search-align-nickname").click(function(){
		self.location = "/main/search/" + keyword + "&n";
	});
});