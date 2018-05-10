 function check(){

    	 var agree = document.getElementById('agree').value;
    	    
    	       if(agree==null || agree == ""){
    	    	   alert("탈퇴 동의 텍스트를 '탈퇴에 동의합니다.'를 입력해주세요");
    	    
    	    	   return false;
    	       }
    	       
    	       if(agree !== "탈퇴에 동의합니다."){
    	    	   alert("탈퇴 방지 문구가 틀렸습니다. 다시 입력해주세요.");
    	    	   return false;
    	       }
    	     
    	       if(confirm("정말로 탈퇴하시겠습니까?")==false){
    	    	   return false;
    	       }
    	  return true;
      }
      
$('.btn').on("click",function(e){
	e.preventDefault();
	history.back();
	alert(1);
});
      