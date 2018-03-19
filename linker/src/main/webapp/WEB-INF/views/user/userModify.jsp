<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>회원정보 상세 페이지</title>
 <script>
    $(document).ready(function(){
    	//파일 업로드시 이미지 미리보기 
    	var upload = document.getElementsByClassName('uploadprofile')[0];
    	var holder = document.getElementById('holder');
    	var state = document.getElementById('status');

    	
    	  
    	upload.onchange = function (e) {
    	     
    		e.preventDefault(); //기존 이벤트를 제거한다
                //업로드된 이미지 가져와서 변수에 넣기
    	  var file = upload.files[0];
    	  var reader = new FileReader();
    	  reader.onload = function (event) {
    	    var img = new Image();
    	    img.src = event.target.result;
    	    // note: no onload required since we've got the dataurl...I think! :)
    	    console.log(img.width);
    	    console.log(img.height);
    	    //이미지 크기가 너무크면 그 이미지를 줄여서 보여주는 조건
    	    if (img.width > 56 && img.height >56) { // holder width
    	      img.width = 56;
    	      img.height = 56;
    	     }
    	    //holder값을 삭제후에 자식으로 이미지를 넣어준다.
    	    holder.innerHTML =""; 
    	    holder.appendChild(img);
    	  };
    	  reader.readAsDataURL(file);

    	  return false;
    	};
    
    
    	
    	//버튼을 눌렀을떄  document.폼이름.action="폼을 보낼 주소"설정하고 그리고 submit()매서드로 전송하기
    	 $("#btnUpdate").click(function(){
             document.form1.action = "/user/userModify"; 
             document.form1.submit();
        });
    	 
    	 
    	//이미지 타입체크
    	 function checkImageType(fileName){
    		 var pattern = /jpg$|gif$|png$|jpeg$/i;
    		 return fileName.match(pattern);
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
                           $('#checkMsg').html('<p style="color:blue">사용가능한 닉네임입니다.</p>');
                       }
                       else{
                           $('#checkMsg').html('<p style="color:red">사용불가능한 닉네임입니다.</p>');
                       }
                   }
               });    //end ajax    
           });    //end on
           
           
          /*  var str="";
           
          
        	   str = "<div><img src='displayFile?fileName="+${vo.profile}+"'/>"+${vo.profile}+"</div>";
                  alert(str);
           $(holder).append(str); */
    	     
           function checkImageType(fileName){
        	        // i는 대.소 문자의 구분없음
        	   var pattern = /jpg$|gif$|png$|jpeg$/i;
        	  
        	   return fileName.match(pattern);
           } 
    	      
    	 
    }); 
</script>
</head>
<body>
    <h2>회원정보 상세</h2>
   
   
     <!-- 데이터를 전송시에는  method="post" enctype="Multipart/form-data" 형식이여야함  사진, 동영상 등 글자가 아닌 파일은 모두 Multipart/form-data 형식의 데이터 데이터를 여러조각으로 나누어서 전송  --> 
    <form name="form1" method="post" enctype="multipart/form-data" onsubmit="return asd();" >
        <table border="1" width="400px">
            <tr>
                <td>이메일</td>
                 <!-- email는 수정이 불가능하도록 readonly속성 추가 -->
                <td><input name="email" value="${vo.email}" readonly="readonly"></td>
            </tr>
            <tr>
                <td>비밀번호</td>
                <td><input type="password" name="password"></td>
            </tr>
            <tr>
                <td>닉네임</td>
                <td><input id="nickname" name="nickname" value="${vo.nickname}"></td>
               <td><input type="button" value="중복확인" id="checkbtn" class="btn btn-default"/><div id="checkMsg"></div></td>
            </tr>
            <!-- 누락된 부분 -->
            <tr>
                <td>프로필사진</td>
                <td>
                  <p id="status"></p>
                  <div id='holder'></div>
                  
                  <!-- accept=".jpg,png "  특정파일만 올릴수있게 파일 업로드시 설정해줌 -->
               <p><input type="file" name="profileName" class='uploadprofile' accept=".jpg, .jpge, .png, .gif"></p>
                     <img src="displayFile?fileName=${vo.profile}"/>
                </td>
            </tr>
            
            <!-- 누락된 부분 -->
            <tr>
                <td>회원가입일자</td>
                <td>
                    <%-- <fmt:formatDate value="${vo.cdate}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
                    <input type="text" name="pppp" value="${vo.cdate}"  pattern="yyyy-MM-dd HH:mm:ss" readonly="readonly">
                </td>
            </tr>
            <tr>
                <td>회원정보 수정일자</td>
                <td>
                   <%--  <fmt:formatDate value="${vo.udate}" pattern="yyyy-MM-dd HH:mm:ss"/> --%>
                      <input type="text" name="pppp" value="${vo.udate}"  pattern="yyyy-MM-dd HH:mm:ss" readonly="readonly">
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <input type="submit" value="수정" id="btnUpdate">
                    <input type="button" value="삭제" id="btnDelete">
                </td>
            </tr>
        </table>
    </form>
  

    
</body>
</html>
