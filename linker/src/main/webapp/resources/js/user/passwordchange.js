﻿$('#btw').on('click', function(){

	event.preventDefault();
	var formObj = $("form[role='form']");
	var pw=$('#password0');
	var pwval=pw.val();

	$.ajax({
	      type: 'POST',    // POST 방식
	      url: '/user/passwordcheck',  //보내는 form action을 지정해줌
	      data: JSON.stringify({ "password": pwval
	      }),
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
		 

	 

	if(password0 == null || password0 ==''){
	 alert("비밀번호를 입력해주세요");
	 document.getElementById('password0').focus();
		 return false;
	}

	if(password1 == null || password1 == ""){
		 alert("비밀번호를 입력해주세요");
		 document.getElementById('password').focus();
		 return false;
	 }
 
	if(password2 == null || password2 == ""){
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