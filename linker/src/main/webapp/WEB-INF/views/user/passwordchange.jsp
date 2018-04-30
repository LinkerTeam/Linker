<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
<title>Insert title here</title>
<style type="text/css">

  *,
*:after,
*:before {
    /* -webkit-,-moz-등의 접두사는 특정브라우저를 따로 안정성을위해서 적어둔다.  */
    box-sizing: border-box;
}
  
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
}
#content{
    height : 500px;
    line-height: 14px;
    width: 450px;
    margin: 100px auto;
    padding: 32px 29px 32px;
    border: 1px solid #dadada;
    background: #fff;
    border-radius: 5px;
    }

.pwWaring{
    font-style: normal;
    color: red;
}
  
.password{
    height: 40px;
    width:  100%;
    border : 3px soild;
    padding-left: 20px;
 }
  .password:focus{
  	outline: none;
 }
  .text{
    text-align: center;
    margin-bottom: 50px;
 }
  .btn{
	margin-top: 20px;
	width:400px;
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
input[type="password"]{
	margin-bottom:  10px;
}
input[type="password"] {
	margin-top: 20px;
} 
.title{
	font-size: 20px;
	margin-bottom: 40px;
}
</style>
</head>
<body>
   <%@include file="../header.jsp"%>
   <%@include file="../closeBoard.jsp"%>
	
		<div class="content">
			<div id="main">
				<div id="contain">
					<div id="content">
						<h1 class="title">비밀번호 변경</h1>
						<span>안전한 비밀번호로 내정보를 보호하세요</span>
						<p>
							<em class="pwWaring">다른 아이디/사이트에서 사용한 적 없는 비밀번호 </em>
						</p>
						<p>
							<em class="pwWaring">이전에 사용한 적 없는 비밀번호</em>가 안전합니다.
						</p>
						<form role='form' method="post">
							<p>
								<input type="password" class="password" name="password0"
									id="password0" placeholder="현재 비밀번호">
							</p>
	
							<p>
								<input type="password" class="password" name="password"
									id="password" placeholder="새 비밀번호">
							</p>
	
							<p>
								<input type="password" class="password" name="password2"
									id="password2" placeholder="새 비밀번호확인">
							</p>
	
							<button type="button" id="btw" class="btn" value="전송">확인</button>
							<br>
							<button type="reset" class="btn" vlaue="취소">취소</button>
	
						</form>
					</div>
				</div>
			</div>
		</div>
	<script>
      
    /*ajax와 form 전송을 한버튼으로 처리하기!!! ajax성공후에 값이 올바르면  if(유효성검사 함수를넣음)넣어서  맞으면 form을 전송  */
      $('#btw').on('click', function(){

            event.preventDefault();
        	var formObj = $("form[role='form']");
        	var pw=$('#password0');
        	var pwval=pw.val();

        	  $.ajax({
                  type: 'POST',    // POST 방식
                  url: '/user/passwordcheck',  //보내는 form action을 지정해줌
               /*    dataType: 'text', */
                  data: { "password": pwval
                  },
                  async:false, //동기식으로 만듬
                  headers: {
   	               'Content-Type' : 'application/json', 
   	               'X-HTTP-Method-Override' : 'POST'
   	            },
                  success: function(data){  //요청을 성공시에 함수를 실행함 data는 스프링에서 값을 받아옴
               	   
                      if(data==true){
   	  
                    	  if(passwordcheck()){
                    	    alert("비밀번호가 변경되었습니다.");
                    	    formObj.submit();}
                    	  
                         /*  $('#checkMsg').html('<p style="color:blue" id="nickcheck">사용가능한 닉네임입니다.</p>'); */
                      }else{
                    	  console.log(data);
                    	  alert("현재 비밀번호가 틀렸습니다 다시 입력해주세요");
                         /*  $('#checkMsg').html('<p style="color:red" id="nickcheck">사용불가능한 닉네임입니다.</p>'); */
                      }
                  },error:function(){
                 	 alert("데이터오류");
                  }
              });    //end ajax   
 
   		   });
 		
		 //현재 비밀번호 체크함    
         function passwordcheck(){
			 //현재 비밀번호
        	 var password0 =document.getElementById('password0').value;
        	 //새비밀번호
			 var password1 =document.getElementById('password').value;
			 //새비밀번호 체크
        	 var password2 =document.getElementById('password2').value;
			 
        	 var pwcheck = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,20}$/;
        	 
        	 console.log(!(pwcheck.test(password1)));
        	 if(password0 == null || password0 ==''){
        		 alert("비밀번호를 입력해주세요");
        		 document.getElementById('password0').focus();
        		 return false;
        	 }
        	 
        	 if (password1 == null || password1 == ""){
        		 alert("비밀번호를 입력해주세요");
        		 document.getElementById('password').focus();
        		 return false;
        	 }
        	 
        	 if (password2 == null || password2 == ""){
        		 alert("비밀번호를 입력해주세요");
        		 document.getElementById('password2').focus();
        		 return false;
        	 }
        	 
        	 if(pwcheck(password1) == false){
        		 alert('비밀번호를 다시 입력해주세요. 8자리이상 영문자 대소문자 와 최소 1개의 숫자 혹은 특수 문자를 포함해주셔야합니다. ');
        		 
        		 return false;
        	 }
        	 
        	 if(!(password1.length>=8)){
        		 alert("비밀번호를 최소 8자리 이상 입력해주세요");
        		 return false;
        	 }
        	 
        	 if(!( password1.length<=20)){
        		 alert("비밀번호를 최대 20자리까지 가능합니다.");
        		 return false;
        	 }
        	 
             if(password1 !== password2 ){
            	 alert("비밀번호가 서로 다릅니다 다시 확인해주세요");
            	 return false;   	 
             }
             if(password0 == password1){
            	 alert("현재 비밀번호 와 새로운 비밀번호가 같습니다.")
            	 return false;
             }
        	 
        	 return true;
         }
		 
		 //패스워드에 숫자1개이상+특문 1개이상 체크
         function pwcheck(password){
      	   return /[\@\#\$\%\^\&\*\(\)\_\+\!]/.test(password) && /[0-9]/.test(password);
         }
     
     </script>
</body>
</html>