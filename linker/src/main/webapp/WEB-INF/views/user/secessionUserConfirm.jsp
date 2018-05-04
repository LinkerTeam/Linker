<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>

 #main{
    font-family: Dotum,sans-serif;
    font-size: 12px;
    position: relative;
    z-index: 20;
    max-width: 954px;
    height: 100%;
    margin: 0px auto;
}
 
 #contain{
    position: relative;
    padding: 32px 51px 95px;
    box-sizing: border-box;
}
  
  #content{    
    height : 400px;
    line-height: 14px;
    width: 450px;
    margin: 100px auto;
    padding: 32px 29px 32px;
    border: 1px solid #dadada;
    background: #fff;
    border-radius: 5px;
}

.btn {
	margin-top: 20px;
	width: 400px;
	border: none;
	outline: none;
	height: 40px;
	background: #0067a3;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	width: 100%;
	border-radius: 5px;
}
#agree{
	height: 30px;
	width: 100%;
	margin: 30px 0 20px 0;
}
 .head{
    font-size: 25px;
    font-weight:bold;
    margin-top: 10px;
    margin-bottom: 35px;
    text-align: center;
}
 .h1{
    font-size: 13px;
    margin-bottom: 10px;
}
 .notes{
	margin-bottom:  20px;
}
 .agreetext{
	color:red;
}

</style>

<body>
	<%@include file="../header.jsp"%>
	<%@include file="../closeBoard.jsp"%>
		<div class="content">
			 <div id="main">
				  <div id="contain">
					   <div id="content">
						   <div class="head">회원 탈퇴 안내</div>
							   <div class="notes">회원탈퇴를 신청하기 전에 안내 사항을 꼭 확인해주세요.</div>
							   <h1 class='h1'> 1.탈퇴 시 30일간 재가입이 불가능하며, 제재 중 탈퇴 시에는 이력에 따라 최대 5년간 재가입이 제한될 수 있습니다.</h1>
							   <h1 class='h1'> 2.팀을 소유하신 유저 분께서는 팀 소유를 다른분에게 넘겨 주시고 탈퇴를 해주세요.</h1>
							   <form action="/user/secessionUserConfirm" method="post" onsubmit='return check();'>
									<div class='h1'>위사항을 다 읽고 동의하시면 <a class="agreetext">'탈퇴에 동의합니다.'</a>라고 적어주세요</div>
										<input type="text" name="agree" id="agree">
										<input type="submit" class="btn">
									<button class="btn">취소</button>
								</form>
					   </div>
				  </div>
			 </div>
		</div>

      <script>
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
      
      
      </script>
</body>
</html>