<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <!-- css초기화 시트 -->
    <link href="/resources/css/common.css" type="text/css" rel="stylesheet" />
    <link href="/resources/css/login.css?ver=2" type="text/css" rel="stylesheet" />


</head>



<body>
    <div class="wap">
        <nav class="main-nav">
            <ul>
                <li>
                    <a class="login_btn" href="#0">로그인</a>
                </li>
                <li>
                    <a class="signup_btn" href="#0">회원가입</a>
                </li>
            </ul>
        </nav>
        
        <!-- 모달창 -->
        <div class="user-modal">
            <div class="user-modal-container">
               <div id="box">
                <ul class="switcher">
                    <li>
                        <a class="login_btn1" href="#0">로그인</a>
                    </li>
                    <li>
                        <a class="signup_btn1" href="#0">회원가입</a>
                    </li>
                </ul>

                <div id="login">
                    <form class="form" name="form1" action ="/user/loginPost" method="post" onsubmit="return login_check();" >
                        <p class="fieldset">
                            <i class="far fa-envelope"></i>
                            <label for="email"> Email </label>
                            <br>
                            <input type="text" class="email" placeholder="Email" name="email" id="email">
                          
                        </p>

                        <p class="fieldset">
                            <i class="fas fa-unlock-alt"></i>
                            <label for="email"> Password </label>
                            <Br>
                            <input type="password" class="password" placeholder="Password" name="password" id="password">
                            <a href="#0" class="hide-password"  id="password1">보이기</a>

                        
                        </p>

                        <p class="fieldset agree">
                           <input type="checkbox" class="checkbox"  name="useCookie">
                            <a>자동로그인</a>

                        </p>


                        <p class="fieldset">
                            <button type="submit" value="Login">Login</button>
                        </p>
                    </form>
                    
                  <!-- 소셜 로그인 -->
				  <div class="social-login">
  				  <a href="${google_url}" class="go-google" title="Connect with Google">
     	 		  <span>Google로 로그인</span>
                  </a>
				  </div>
				 
                  
                    <p class="form-bottom-message">
                        <a href="#0">Forgot your password?</a>
                    </p>
                </div>


                <div id="signup">

                    <form class="form" name="form2" action="/user/signup" method="post" onsubmit="return signup_check();">


                        <p class="fieldset">
                            <i class="far fa-envelope"></i>
                            <label for="email"> Email </label>
                            <input type="text" class="email" placeholder="Email" name="email" id="email2">
                          <a href="#0" value="중복확인" id="emailcheck" class="check" >중복확인</a><div id="EmailcheckMsg"></div>

                        </p>
                        <p class="fieldset">
                            <i class="far fa-user"></i>
                            <label for="nickname"> Nickname </label>
                            <input type="text" class="nickname" placeholder="Nickname" name="nickname" id="nickname">
                            <a href="#0" value="중복확인" id="checkbtn" class="check" >중복확인</a><div id="checkMsg"></div>
                       

                        </p>

                        <p class="fieldset" id="lastinput">
                            <i class="fas fa-unlock-alt"></i>
                            <label for="email"> Password </label>
                            <input type="password" class="password" placeholder="Password" name="password" id="pw">
                            <a href="#0" class="hide-password" id="password2" >보이기</a>
                       
                            
                            <p class="fieldset agree">
                          
                            <input type="checkbox" id="agree" >
                          
                            I agree to the Terms
                                </p>
                        </p>
                        <p class="fieldset">
                            <button type="submit" id="signupbtn">New account</button>
                        </p>

                    </form>
                </div>
             
            <div id="reset-password">
                    <p class="form-message">비밀번호를 잃어 버렸습니까? 이메일 주소를 넣어주세요.</br> 새로운 비밀번호를 지정해 주세요.</p>
    
                    <form class="form" name="form3" method="post" action="/user/forget" onsubmit="return forgetcheck();" >
                        <p class="fieldset">
                            <i class="far fa-envelope" id="mail"></i>
                            <label class="image-replace email" for="reset-email">E-mail</label>
                            <input class="full-width has-padding has-border" id="reset-email" type="email" name="email" placeholder="E-mail">
                            
                        </p>
    
                        <p class="fieldset">
                            <input type="submit" class="full-width has-padding input"  value="Reset password">
                        </p>
                    </form>
    
                    <p class="form-bottom-message" ><a href="#0" id="back">Back to log-in</a></p>
                </div>

           
          </div>
        </div>
      </div><!-- 모달창 END -->
    </div>

    <script>
    
       window.onload = function () {

            var button = document.getElementsByClassName('login_btn');
            var modal = document.getElementsByClassName('user-modal');
            var box = document.getElementsByClassName('user-modal-container');
            var id = document.getElementById('login');
            var signup = document.getElementById('signup');
            var signupbtn = document.getElementsByClassName('signup_btn')
            var btn = document.getElementsByClassName('login_btn1');
            var signupbtn2 = document.getElementsByClassName('signup_btn1')
            var reset=document.getElementById('reset-password');
            var forget=document.getElementsByClassName('form-bottom-message');
           
           
            button[0].onclick = function () {
           
               
                if (signup.style.display = "none") {
                    modal[0].style.display = "block";
                    id.style.display = "block";
                    id.style.background = "white";
                    btn[0].style.backgroundColor = "white";
                    reset.style.display="none";
                    if(signupbtn2[0].style.backgroundColor = "white"){
                    signupbtn2[0].style.backgroundColor = "lightgray";
                  }
                   }
               
            };


            signupbtn[0].onclick = function () {
              
                if (id.style.display = "none") {
                    modal[0].style.display = "block";
                    signup.style.display = "block";
                    signupbtn2[0].style.backgroundColor = "white";
                    reset.style.display="none";
                     if(btn[0].style.backgroundColor = "white"){
                     btn[0].style.backgroundColor = "lightgray";
                }
                 }
            }

            btn[0].onclick = function () {
                modal[0].style.display = "block";
                if (signup.style.display = "none") {
                    id.style.display = "block";
                    reset.style.display="none";
                }
                this.style.backgroundColor = "white";
                if (signupbtn2[0].style.backgroundColor = "white") {
                    signupbtn2[0].style.backgroundColor = "lightgray";
                    reset.style.display="none";
                }
            };


            signupbtn2[0].onclick = function () {
                if (id.style.display = "none") {
                    signup.style.display = "block";
                 
                    if (this.style.backgroundColor = "white")
                        this.style.backgroundColor = "white";
                        reset.style.display="none";
                 
                    if (btn[0].style.backgroundColor = "white") {
                        btn[0].style.backgroundColor = "lightgray"
                        reset.style.display="none";
                    }
                }
            }
            forget[0].onclick =function(){
                reset.style.display="block";
                
                id.style.display = "none";
            }
            forget[1].onclick=function(){
                reset.style.display="none";
                id.style.display = "block";

            }
            
            // 모달 close 이벤트 if문에 자기자신 클릭시에만 이벤트를 발생하게 한다. 모달창 닫기
            $('.user-modal').on('click', function(e){
            	//클릭했을때 user-modal클래스가 아니면 모달을 닫고 user-modal을 클릭했을때는 if문이 안돈다
            	//event.target은 마우스 클릭시 일어나는 위치찾기
                if ($(e.target).hasClass("user-modal")) { 
                    modal[0].style.display = "none";        
                }
            });

            //모달 close esc를 누르면 나오게된다. keycode에서 27은 esc이다.
            $(document).keyup(function(event){
                        if(event.which=='27'){
                            modal[0].style.display = "none";        
                        }
                      });
             
             var password = document.getElementsByClassName('password');
             var passwordhide = document.getElementsByClassName('hide-password');
         
           
           
           // SHow 버튼을 누르면 비밀번호가 text 타입이 돼었다가 password타입으로 변함
             passwordhide[0].addEventListener("click",function(){        
                     
                     if(password[0].getAttribute('type')=="password"){
                     password[0].setAttribute("type","text");
                     $('.hide-password').text('감추기');
                    
                    } else{
                        password[0].setAttribute("type","password");
                        $('.hide-password').text('보이기');
                    }
                    });
                    passwordhide[1].addEventListener("click",function(){        
                     
                     if(password[1].getAttribute('type')=="password"){
                     password[1].setAttribute("type","text");
                     $('.hide-password').text('감추기');
                    } else{
                        password[1].setAttribute("type","password");
                        $('.hide-password').text('보이기');
                    }
                    });
        }
        
        
       
        
       
       	 

	      //이메일 형식검사를위한 a@naver.com 형식을 나타낸것. 
	      var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	  
	        //로그인 유효성 검사
	        function login_check() {
	            var id = document.getElementById('email').value;
	            var pw = document.getElementById('password').value;
	            
	          
	            if(id == null  || id == "" ) {
	            	alert("아이디를 입력해주세요");
	            	document.getElementById('email').focus();
	                return false;
	            } 
	            	
	            if(pw ==null|| pw == ""){
	            	alert("비밀번호를 입력하세요");
	            	document.getElementById('password').focus();
	            	document.getElementById('password').value="";
	            	return false;
	            }
	            
	           
	             
                 //이메일 a@naver.com 형식  유효성 검사
				if(exptext.test(id)==false){

			//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			

			alert("이 메일형식이 올바르지 않습니다.");

			document.getElementById('email').focus();
			document.getElementById('email').value="";
			return false;

	    	 }   
                 
			
                 
                 
                 
	            
	      	return true;
	          
	            
	       }
            
	 
	     
               //회원가입 유효성검사
	     function signup_check() {
	        
	         var nickname= document.getElementById('nickname').value;
	         var email2 = document.getElementById('email2').value;
	         var password = document.getElementById('pw').value;
	         var check = document.getElementById('agree');
             var nickch =document.getElementById('checkMsg');
	         
	         if(nickname == null  || nickname == "" ) {
	            
	        	 alert("닉네임을입력해주세요");
	             document.getElementById('nickname').focus();
	             return false;
	
	         }
	         
	         if(!(nickname.length >2 && nickname.length <16)){
	        	 alert("닉네임을 2자 이상 입력해주세요");
	        	 document.getElementById('nickname').focus();
	        	 return false;
	         }
	         //아이디 대문 소문 숫자 검사  
	         for (i = 0; i < nickname.length; i++) {
	             ch = document.getElementById('nickname').value.charAt(i)
	             //아이디를 하나씩 하나씩 검사해서 숫자 소문자 대문자인지 체크해서 값을 비교함
	             if (!(ch >= '0' && ch <= '9') && !(ch >= 'a' && ch <= 'z')&&!(ch >= 'A' && ch <= 'Z')) {
	                  alert("아이디는 대소문자, 숫자만 입력가능합니다.")
	                  document.getElementById('nickname').focus();
	                
	                 return false;
	             }
	         }
	         
	        
	         if(email2 == null || email2 =="" )
	        	 {
	        	 alert("이메일을 입력해주세요");
	        	 document.getElementById('email2').focus();
	        	 return false;
	        	 
	        	 }
	         
	       
	         //이메일 형식 검사
	         if(exptext.test(email2)==false){
	        	 alert("이메일을 제대로 입력해주세요");
	        	 document.getElementById('email2').focus();
	        	 return false;
	         }
        
	         //비밀번호 자릿수 정하기 최소 8자리 이상 최대 16자리 이하
	            if(!(password.length >= 8 && password.length <= 16)){
	            	alert("비밀번호 8개이상 입력해주세요");
	            	document.getElementById('pw').focus();
	            	return false;
	            }
	             
	         
	         
	           //체크박스 체크했으면 true 안했으면 false값을 반환함
                  if(check.checked==false){
                	alert("가입에 동의해주세요");
                	document.getElementById('agree').focus();
                	return false;
                }
                  //닉네임 중복환인 안눌렀을떄
                  if(document.getElementById("checkMsg").innerHTML==""){
                	  alert("닉네임을 중복확인 해주세요");
                	  return false;
                  }
	         
                  //닉네임이 중복돼었을때 빨간색이면 중복이라고 나옴 
                  if(document.getElementById("nickcheck").style.color=='red'){
	        	 alert("닉네임이 중복되었습니다 다른 닉네임을 적어주세요");
	        	 return false;
	         }
                  
                  //이메일 중복확인 안눌렀을떄
                  if(document.getElementById("EmailcheckMsg").innerHTML==""){
                	  alert("이메일 중복확인 해주세요");
                	  return false;
                  }
	         
                  //이메일이 중복이 중복돼었을때 빨간색이면 중복이라고 나옴 
                  if(document.getElementById("echeck").style.color=='red'){
	        	 alert("이메일이 중복되었습니다 다른 이메일을 적어주세요");
	        	 return false;
	         }
        return true;
       }
               
               
           //비밀번호 찾기 이메일 검사 
          function forgetcheck(){
        	 var email3 = document.getElementById('reset-email').value;
        	  
        	 if(email3 == null || email3 ==''){
        	    alert("EMAIL을 입력해주세요");
        	    document.getElementById('reset-email').focus();
        		return false;
        	 }
        	 
        	 if(exptext.test(email3)==false){
        		 alert("EMAIL 형식을 제대로 지켜주세요.");
        		 document.getElementById('reset-email').focus();
        		 return false;
        		 
        	 }
        	  
        	 return true;
        	  
          }     
               
               
               
               
               
	     //닉네임 중복검사 하는 매소드 버튼을 눌러서 중복확인검사
  	   $('#checkbtn').on('click', function(){
           
  		   //POST 형식으로 FORM 보내기 작성 $.ajax형식으로 보내기
  		   $.ajax({
                 type: 'POST',    // POST 방식
                 url: '/user/checkSignup',  //보내는 form action을 지정해줌
                 data: {"nickname" : $('#nickname').val() // 데이터를 지정해줌 nickname의 값을 받아와서 nickname에 넣어줌 매개변수 request.getparameter("nickname")을 여기서 가져옴
                 },
                 headers: {
  	               //"Content-Type" : "application/json",
  	               "X-HTTP-Method-Override" : "POST"
  	            },
                 success: function(data){  //요청을 성공시에 함수를 실행함 data는 스프링에서 값을 받아옴
              	   // 0이면 닉네임중복아니고 0이외에 숫자는 모두 중복임 닉네임은 유니크값이라 1개라도 나오면 닉네임 존재한다는 얘기
                     if($.trim(data) == 0){
                         $('#checkMsg').html('<p style="color:blue" id="nickcheck">사용가능한 닉네임입니다.</p>');
                     }else{
                         $('#checkMsg').html('<p style="color:red" id="nickcheck">사용불가능한 닉네임입니다.</p>');
                     }
                 },error:function(){
                	 alert("error");
                 }
             });    //end ajax    
         });    //end on
         
               
      
         // 이메일 중복검사
       
    
         $('#emailcheck').on('click', function(){
    	   //POST 방식으로 FROM 보내기 작성 $.ajax형식으로 보내기
    	  
    	   $.ajax({
    		   type: 'POST',
    		   url : '/user/emailcheck',
    		   data : {"email" : $('#email2').val()},
    		   success:function(data){
    			   //$.trim()은  데이터의 문자의 앞뒤의 공백을 제거해주는 것 중간의 공백은 제거하지않는다.
    			   if($.trim(data)==0){
    				  
    				  $('#EmailcheckMsg').html('<p style="color:blue" id="echeck">사용가능한 이메일 입니다. </p>');
    			  }else{
    				 
    				  $('#EmailcheckMsg').html('<p style="color:red" id="echeck">이미 가입한 이메일입니다 다시 확인해주세요. </p>');
    			  }
    		   },error:function(){
              	 alert("error");
               }	   
    		   
    	   }); //end ajax
       }); // end 이벤트
        


    </script>
</body>

</html>