<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
#main {
	font-family: Dotum, sans-serif;
	font-size: 12px;
	position: relative;
	z-index: 20;
	max-width: 954px;
	height: 100%;
	margin: 0px auto;
}

#contain {
	position: relative;
	padding: 32px 51px 95px;
}

#content {
	height: 300px;
	line-height: 14px;
	width: 450px;
	margin: 100px auto;
	padding: 32px 29px 32px;
	border: 1px solid #dadada;
	background: #fff;
	border-radius: 5px;
}
 .h1{
      text-align: center;
      font-size: 20px;
      margin-bottom: 60px;
 
 }

 .btn{
    margin-top: 40px;
	width: 400px;
	border: none;
	outline: none;
	height: 40px;
	background: #FA5883;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	width: 100%;
	border-radius: 5px;
   
 
 }
 
 
 .confirm{
       width: 300px;
       height: 25px;
    
 
 
 }
 
 .send{
   
    margin-top: 10px;
	border: none;
	outline: none;
	background: #FA5883;
	color: #fff;
	font-size: 15px;
	cursor: pointer;
	width: 130px;
	border-radius: 5px;
	height: 40px;
 
 }

 .notes{
     margin-bottom: 15px;
     font-size: 16px;
     line-height: 25px;
 
 }
 
  .label{
    font-size: 15px;
    font-weight:bold;
  
  }

.point{
  color: red;
  font-weight: bold;
}
</style>
<body>
  <%@include file="header.jsp"%>
  <%@include file="mainMenu.jsp"%>
	<div class="content">
		<div id="main">
			<div id="contain">
				<div id="content">
				  <h1 class="h1">Google회원 탈퇴 페이지</h1>
				  <div class="notes">구글회원은 가입 탈퇴를 하기위해선 <span class="point">GOOGLE Email 인증</span>이 팔요합니다.</div>
					<form name="form" role="form" method="post">
						 <label class="label">인증 번호 입력</label><br>
						  <input type="text" name="confirm" class="confirm" placeholder="60분이내에 인증번호를 입력해주세요. " > 
						   <button value="인증번호" id="emailsend" class="send" >인증 번호 발송</button>
						 <input type="submit" class="btn" value="확인">
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script>
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
            	 alert("error");
             }	   
  		   
  	   }); //end ajax
     }); // end 이벤트
	
	
	</script>
</body>
</html>