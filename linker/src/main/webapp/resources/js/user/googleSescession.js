$('#emailsend').on('click', function(event){
   //POST 방식으로 FROM 보내기 작성 $.ajax형식으로 보내기
   event.preventDefault();

   $.ajax({
	   type: 'POST',
	   url : '/user/googlekey',
	   data : {"email" : "1"},
	   success:function(data){
		   //$.trim()은  데이터의 문자의 앞뒤의 공백을 제거해주는 것 중간의 공백은 제거하지않는다.
		  if($.trim(data)=="true"){
			alert("EMAIL 전송 완료");
		  }else{
			alert("EMAIL 전송 실패");
		  }
	   },error:function(){
		   	alert("통신 에러가 발생했습니다.");
       }	   
   }); //end ajax
}); // end 이벤트