/**
 * 작성자 : 김소영
 */
$(".search-move-btn").click(function(){
	console.log(this);
	var c_id = $(this).attr("data-id");
	console.log(c_id);
	var cl_id = $(this).attr("data-clId");
	console.log(cl_id);
	var p_id = $(this).attr("data-pId");
	console.log(p_id);
	var t_id = $(this).attr("data-tId");
	console.log(t_id);
	
	location.href="/board/" + t_id + "/" + p_id;
});