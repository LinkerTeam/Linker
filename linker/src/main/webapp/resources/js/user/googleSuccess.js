 
   //모든 HTML 페이지 로드후 에 자바스크립트 시작  jquery는 $(document).ready(function(){ 내용 }) === $(function(){ 내용 });
   window.onload = function () {

    var button = document.getElementsByClassName('login_btn');
    var modal = document.getElementsByClassName('user-modal');
    var box = document.getElementsByClassName('user-modal-container');
    var id = document.getElementById('login');
    var signup = document.getElementById('signup');
    var signupbtn = document.getElementsByClassName('signup_btn')
    var btn = document.getElementsByClassName('login_btn1');
    var signupbtn2 = document.getElementsByClassName('signup_btn1')
    var reset = document.getElementById('reset-password');
    var forget = document.getElementsByClassName('form-bottom-message');
   
       
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
     passwordhide[0].addEventListener("click", function(){        
             
             if(password[0].getAttribute('type')=="password"){
             password[0].setAttribute("type", "text");
             $('.hide-password').text('감추기');
            
            } else{
                password[0].setAttribute("type", "password");
                $('.hide-password').text('보이기');
            }
            });
            passwordhide[1].addEventListener("click", function(){        
             
             if(password[1].getAttribute('type')=="password"){
             password[1].setAttribute("type", "text");
             $('.hide-password').text('감추기');
            } else{
                password[1].setAttribute("type", "password");
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
        	alert("아이디를 입력해주세요.");
        	document.getElementById('email').focus();
            return false;
        } 
        	
        if(pw ==null|| pw == ""){
        	alert("비밀번호를 입력하세요.");
        	document.getElementById('password').focus();
        	document.getElementById('password').value="";
        	return false;
        }

         //이메일 a@naver.com 형식  유효성 검사
		if(exptext.test(id)==false){

	//이메일 형식이 알파벳+숫자@알파벳+숫자.알파벳+숫자 형식이 아닐경우			

	alert("이메일 형식이 올바르지 않습니다.");

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
		alert("닉네임을 입력해주세요.");
		document.getElementById('nickname').focus();
		return false;
	} 
	if(!(nickname.length >=2 && nickname.length <16)){
		alert("닉네임을 2자 이상 입력해주세요.");
		document.getElementById('nickname').focus();
		return false;
	}
	
	if(email2 == null || email2 =="" ){
		alert("이메일을 입력해주세요.");
		document.getElementById('email2').focus();
		return false;
	}

	//패스워드 특문 숫자 체크 정규식
	if(pwcheck(password) == false){
		alert("패스워드는 1개 이상의 숫자와 1개 이상의 특수문자가 필요합니다.");
		return false;
	}
	
	//비밀번호 자릿수 정하기 최소 8자리 이상 최대 16자리 이하
	if(!(password.length >= 8 && password.length <= 16)){
        	alert("8자 이상 입력해주세요.");
        	document.getElementById('pw').focus();
        	return false;
    } 

	//체크박스 체크했으면 true 안했으면 false값을 반환함
    if(check.checked==false){
        	alert("가입에 동의해주세요.");
        	document.getElementById('agree').focus();
        	return false;
    }
    //닉네임 중복환인 안눌렀을떄
    if(document.getElementById("checkMsg").innerHTML==""){
			alert("닉네임을 중복확인 해주세요.");
			return false;
    }
     
    //닉네임이 중복돼었을때 빨간색이면 중복이라고 나옴 
    if(document.getElementById("nickcheck").style.color=='red'){
			alert("닉네임이 중복되었습니다. 다른 닉네임을 적어주세요.");
			return false;
  	}
          
    //이메일 중복확인 안눌렀을떄
    if(document.getElementById("EmailcheckMsg").innerHTML==""){
			alert("이메일 중복확인 해주세요");
			return false;
    }
          //이메일이 중복이 중복돼었을때 빨간색이면 중복이라고 나옴 
    if(document.getElementById("echeck").style.color=='red'){
			alert("이메일이 틀렸습니다.이메일을 다시 확인해주세요.");
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
        	 alert("통신 에러가 발생했습니다."); 
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
		   if($.trim(data) == 0){
			  $('#EmailcheckMsg').html('<p style="color:blue" id="echeck">사용가능한 이메일 입니다. </p>');
		  }else if($.trim(data) == 2){
			  $('#EmailcheckMsg').html('<p style="color:red" id="echeck">이메일 형식이 틀렸습니다. 다시 확인해주세요. </p>');
		  }else{
			  $('#EmailcheckMsg').html('<p style="color:red" id="echeck">이미 가입한 이메일입니다 다시 확인해주세요. </p>');
		  }
	   },error:function(){
		   alert("통신 에러가 발생했습니다."); 
       }	   	   
   }); //end ajax
   }); // end 이벤트
   
 //패스워드에 숫자1개이상+특문 1개이상 체크
   function pwcheck(password){
	   return /[\@\#\$\%\^\&\*\(\)\_\+\!]/.test(password) && /[0-9]/.test(password);
   }