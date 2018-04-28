/* ---------------------------------------------------------------------------------------함수 정리 ----------------------------------------------------------------------------*/

//모달창을 모두 닫는 함수
function hideModalDiv() {
	$('#teamModalAddDiv').hide();
	$('#teamModalModifyDiv').hide();
	$('#teamModalDeleteDiv').hide();
	$('#memberModalModifyDiv').hide();
	$('#memberModalTransferDiv').hide();
	$('#memberModalDeleteDiv').hide();
	$('#addMemberModal').hide();
	$('#addMembersModal').hide();
}

//권한 값을 팀 목록, 멤버 목록에 출력하는 함수
function auth(auth){
	var str = "";
	switch (auth){
	case 0 : str = "Owner";
	break;
	case 1 : str = "Admin";
	break;
	case 2 : str = "Team Member";
	break;
	}
	return str;
}

//권한에 따라 팀 목록에 버튼을 출력하는  함수
function teamButton(auth){
	var str = "";
	if(auth == 0 ){
		str  =  "	<div class='listBtn'><input type='button' class='selectMemberBtn' name='selectMemberBtn' style='cursor:pointer;' value='멤버보기' /></div>"
			 +  "	<div class='listBtn'><input type='button' class='deleteTeamBtn' name='deleteTeamBtn' style='cursor:pointer;' value='팀 삭제' /></div>"
			 +  "	<div class='listBtn'><input type='button' class='modifyTeamBtn' name='modifyTeamBtn' style='cursor:pointer;' value='팀 이름 수정' /></div>";
	}else{
		str  =  "	<div class='listBtn'><input type='button' class='selectMemberBtn' name='selectMemberBtn' style='cursor:pointer;' value='멤버보기' /></div>";
	}
	return str;
}

//권한에 따라 멤버 목록에 버튼을 출력하는 함수
function memberButton(data, myauth){
	var str = "";
	if(myauth== 0 && data == 0){
		str =  "<div class='listBtn'><input type='button' class='transferAuthBtn' name='ransferAuthBtn' value='권한 양도' /></div>";
	}else if(myauth== 0 && data != 0){
		str = "	<div class='listBtn'><input type='button' class='modifyAuthBtn' name='modifyAuthBtn' value='권한수정' /></div>"
			+ "	<div class='listBtn'><input type='button' class='deleteMemberBtn' name='deleteMemberBtn' value='삭제' /></div>";
	}else if(myauth== 1 && data != 0){
		str = "	<div class='listBtn'><input type='button' class='modifyAuthBtn' name='modifyAuthBtn' value='권한수정' /></div>"
			+ "	<div class='listBtn'><input type='button' class='deleteMemberBtn' name='deleteMemberBtn' value='삭제' /></div>";
	}
	return str;
} 

//멤버 추가버튼 영역 동적 태그로 출력하는 함수
function memberAdd(){
	var memberStr = "";
	memberStr	+=	"<div class='sidemenu'>"
				+	"	<h5 class='title'> Member Add </h5>"
				+	"	<input type='button' class='addMemberBtn' id='addMemberBtn' value='Add by Name or Email' />"
				+	"</div>";
	$('.memberList').children('.listBoxBody').append(memberStr);
	return memberStr;
}

//모든 팀 데이터를 출력하는 함수. 화면이 뜨면 함수 실행
function allTeamList(){
	$.ajax({
		type : "GET",
		url : "/main/team/" + U_ID,
		success : function(data){
			for(var i=0; i< data.length; i++){
				allTeamStr(data[i]);//데이터 개수마다 동적 태그을 출력하는 함수. 매개변수가 1개임.
			}
			memberAdd();//멤버 추가하는 영역 출력하는 함수
		},
		error : function(){
			alert("에러가 발생했습니다.");
		}
	});	
}

//데이터 개수마다 동적 태그을 출력하는 함수1. 매개변수가 data인 경우
function allTeamStr(data){
	var str = "";
	str =   "<div id='teamListTableBody'>"
		+   "	<div class='oneListRow' data-id='" + data.t_id + "'>"
		+	"		<div class='t_id' style='display : none;'>" + data.t_id + "</div>"
		+	"		<div class='name'>" + data.name + "</div>"
		+	"		<div class='cdate'>" + data.cdate + "</div>";
	str +=	"		<div class='auth'>" + auth(data.auth) +"</div>";
	str +=	teamButton(data.auth);//권한 따라서 버튼이 달라짐
	str +=  "	</div>"
		+	"	<div class='memberList' style='display : none;'>"	
		+   "		<h5 class='title'>Member List</h5>"
		+   "		<div class='listBoxBody'>"
		+   "			<div class='category memberCategory'>"
		+   "				<div class='t_id' style='display : none;'>u_id</div>"
		+   "				<div class='email'>이메일</div>"
		+   "				<div class='nickname'>닉네임</div>"
		+   "				<div class='auth'>권한</div>"
		+   "			</div>"
		+   "			<div class='memberListTableBody' data-id='" + data.t_id + "'>"
		+   "			</div>"
		+   "		</div>"
		+   "	</div>"
		+	"</div>";

	$('#listContent').children('.listBoxBody').append(str);
	allMemberList(data.t_id, data.auth);
}

//데이터 개수마다 동적 태그을 출력하는 함수2. 매개변수가 data, num인 경우
function allTeamStr(data, num){
	var str = "";
	str =   "<div id='teamListTableBody'>"
		+   "	<div class='oneListRow' data-id='" + data.t_id + "'>"
		+	"		<div class='t_id' style='display : none;'>" + data.t_id + "</div>"
		+	"		<div class='name'>" + data.name + "</div>"
		+	"		<div class='cdate'>" + data.cdate + "</div>";
	str +=	"		<div class='auth'>" + auth(data.auth) +"</div>";
	str +=			teamButton(data.auth);
	str +=  "	</div>"
		+	"	<div class='memberList' style='display : none;'>"	
		+  "		<h5 class='title'>Member List</h5>"
		+  "		<div class='listBoxBody'>"
		+  "			<div class='category memberCategory'>"
		+  "				<div class='t_id' style='display : none;'>u_id</div>"
		+  "				<div class='email'>이메일</div>"
		+  "				<div class='nickname'>닉네임</div>"
		+  "				<div class='auth'>권한</div>"
		+  "			</div>"
		+  "			<div class='memberListTableBody' data-id='" + data.t_id + "'>"
		+  "			</div>"
		+  "		</div>"
		+  "	</div>"
		+	"</div>";

	$('#listContent').children('.listBoxBody').append(str);
	allMemberList(data.t_id, data.auth);

}

//각 팀에 해당하는 멤버목록 출력하는 함수
function allMemberList(myT_id, myAuth){
	$.ajax({
		type : "GET",
		url : "/main/member/" + U_ID,
		data : {
			t_id : myT_id
		},
		success : function(data){
			var str="";
			for(var i=0; i<data.length; i++){
				allMemberStr(data[i], myAuth);//멤버 목록 동적 태그 생성하는 함수	
			}
		}, 
		error : function(){
			alert("에러가 발생했습니다.");
		}
	});
}

//멤버 목록 동적 태그 생성하는 함수	
function allMemberStr(data, myAuth){
	var str = "";
		str =  "<div class='oneListRow' data-id='" + data.u_id + "'>"
			+	"	<div class='u_id' style='display:none;'  data-id='" + data.u_id + "'>" + data.u_id + "</div>"
			+  "	<div class='email'>" + data.email + "</div>"
			+  "	<div class='nickname'>" + data.nickname + "</div>";
		str +=	"	<div class='auth'>" + auth(data.auth) +"</div>";
		str +=	memberButton(data.auth, myAuth);
		str	+=  "</div>";	

	$(".memberListTableBody[data-id='" + data.t_id + "']").append(str);	
}

/* ------------------------------------------------------------------------------함수 정리 끝 ---------------------------------------------------------------------------------------*/

//카드동적생성		
allTeamList();

//팀 목록에서 팀 추가 버튼을 눌렀을 때
$('#addTeamBtn').click(function() {
	$('#teamModalAddDiv').show();
});

//팀 목록에서 팀 추가 버튼을 눌렀을 때
$('#addTeamBtn').click(function() {
	$('#teamModalAddDiv').show();
});

/* 팀 추가(teamAdd) 유효성 검사
 * 1. 최대 글자 수 제한
 * 2. 입력 필수
 */
$('#teamModalAddBtn').click(function(e){
	var name = $("#name").val();
	var date = new Date('yyyy-MM-dd');

	if($('#name').val().length == 0){
		alert("팀 이름을 입력해주세요.");
		return;
	}else if($('#name').val().length > 20){
		alert("20자 이하로 입력해주세요.");
		return;
	}

    $.ajax({
	     type : 'post',
	     headers : {
	        "Content-Type" : "application/json",
	        "X-HTTP-Method-Override" : "POST"
	     },
	     contentType : 'text/javascript',
	     dataType : 'json',
	     data:JSON.stringify({
	         name : name
	     }),
	     success : function(result) {
	        console.log(result);
	        if(result != null){
	        hideModalDiv();
	    	var str = "";
	    	var str2;
	    	
			str =   "<div id='teamListTableBody'>"
				+   "	<div class='oneListRow' data-id='" + result.data_id + "'>"
				+	"		<div class='t_id' style='display : none;'>" + result.data_id + "</div>"
				+	"		<div class='name'>" + name + "</div>"
				+	"		<div class='cdate'>" + date + "</div>";
			str +=	"		<div class='auth'>" + auth(0) +"</div>";
			str +=	teamButton(0);
			str +=  "	</div>"
				+	"	<div class='memberList' style='display : none;'>"	
				+   "		<h5 class='title'>Member List</h5>"
		        +   "		<div class='listBoxBody'>"
		        +   "			<div class='category memberCategory'>"
		        +   "				<div class='t_id' style='display : none;'>u_id</div>"
		        +   "				<div class='email'>이메일</div>"
		        +   "				<div class='nickname'>닉네임</div>"
		        +   "				<div class='auth'>권한</div>"
		        +   "			</div>"
		        +   "			<div class='memberListTableBody' data-id='" + result + "'>"
		        +   "				<div class='oneListRow' data-id='" + U_ID + "'>"
		        +   "					<div class='u_id' style='display:none;'  data-id='" + U_ID + "'>" + U_ID + "</div>"
				+   "					<div class='email'>" + EMAIL + "</div>"
				+   "					<div class='nickname'>" + NICKNAME + "</div>";
			str +=  "					<div class='auth'>" + auth(0) +"</div>";
			str +=  memberButton(0, 0);
			str	+=  "				</div>"
		        +   "			</div>"
		        +   "		</div>"
		        +   "	</div>"
			 	+   "</div>";
			
			$('#listContent').children('.listBoxBody').append(str);
			memberAdd();
			
		    str2 = 	"<li data-id ='" + result.id + "'>"
		    	 + 	"	<div class='pic-list-writer'>"
		    	 + 	"		<div class='profile'>"
		    	 + 	"			<img src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate" + result.profile +"' alt='프로필 사진' />"
				 + 	"		</div>"
				 + 	"	</div>"
				 + 	"	<div class='pic-list-desc'>";
			str2 += "		<span class='name'>" + result.nickname + "</span> 님이 " + result.after + " 팀을 생성하였습니다."
				 + 	"	</div>"
				 + 	"	<p class='pic-list-datetime'>" + result.cdate + "</p>"
				 +	"</li>";
				
			$('.pic-list').append(str2);	
		
			$('.modalContent').find('#name').val('');
			      }
		},
		error : function() {
			alert("error");
		}
	});	                  
});
	    	                   
//멤버 한명 추가하기 버튼을 눌렀을 유효성검사 + 추가하기
$(document).on('click','#memberModalAddBtn',function() {
	var email = $('#memberTxt').val();
	var reg_email = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

	if(email.length == 0){                         
		alert("이메일을 입력해주세요.");
		return;
	}else if(email.length > 0 && email.length < 11){
		alert("글자 수가 적습니다 .이메일을 정확히 입력해주세요.");
		return;
	} 

	if(!reg_email.test(email) && email.length > 0){
		alert('이메일로 정확히 입력해주세요.');
		return;
	} 

	$.ajax({
	   url : '/team/'+ T_id,
	   type : 'post',
	   headers : {
	      "Content-Type" : "application/json",
	      "X-HTTP-Method-Override" : "POST"
	   },
	   data : JSON.stringify({
	      email : email,
	      T_id : T_id
	   }),
	   success : function(result) {
	       if(result == "1"){
	      	 hideModalDiv();
	         alert("해당 회원에 메일을 보냈습니다. 해당 회원이 수락하는 동시에 팀에 해당회원이 등록됩니다.");
	      }else if(result == "0"){
	         $('#memberTxt').val('');
	         alert(email+"은 이미 팀에 등록되어있습니다.");
	      }else{
	         $('#memberTxt').val('');
	         alert(email+"은 회원이 아닙니다.");
	      } 
	   },
	   error : function(xhr,status,error){
	      alert("error");
	   }
	}); 
});
	    	                   
//팀목록에서 수정버튼(.modifyTeamBtn)을 눌렀을 때
$(document).on('click','.modifyTeamBtn',function() {
	hideModalDiv();
	$('#teamModalModifyDiv').show();
	T_id = $(this).parents('div').children('.t_id').html();
	U_id = $(this).parents('div').children('.u_id').html();
	title = $(this).parents('div').children('.name').html();
	$('#modalTextTxt').val(title);
});

//팀 목록에서 삭제버튼(.deleteTeamBtn)을 눌렀을 때
$(document).on('click','.deleteTeamBtn',function() {
	hideModalDiv();
	$('#teamModalDeleteDiv').show();
	T_id = $(this).parents('div').children('.t_id').html();
	teamName = $(this).parents('div').children('.name').html();
});

//modal창에서 취소버튼(.modalCancleBtn)을 눌렀을 때
$(document).on('click', '.modalCancleBtn', function() {
	hideModalDiv();
});

//팀 삭제 delete modal창에서 삭제버튼(#modalDeleteBtn)을 눌렀을 때
$('#teamModalDeleteBtn').click(function() {
   $.ajax({
      type : 'delete',
      headers : {
         "Content-Type" : "application/json",
         "X-HTTP-Method-Override" : "DELETE"
      },
      dataType : 'json',
      contentType : 'text/javascript',
      data : JSON.stringify({
         t_id : T_id,
         u_id : U_ID,
         name : teamName
      }),
      success : function(result) {
         var str2;
         $('.memberList').hide();
         hideModalDiv();
         
        str =	"<div class='oneListRow' data-id='" + T_id + "'>"
        	+  "	</div>";
		
        $('.oneListRow[data-id=' + T_id + ']').remove();	
		
		str2 =  "<li data-id ='" + result.id + "'>"
	     	 +  "	<div class='pic-list-writer'>"
	     	 +  "		<div class='profile'>"
	     	 +  "			<img src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate" + result.profile +"' alt='프로필 사진' />"
			 +  "		</div>"
			 +  "	</div>"
			 +  "	<div class='pic-list-desc'>";
		str2 += "		<span class='name'>" + result.nickname + "</span> 님이 " + result.after + " 팀을 삭제하였습니다."
			 +  "	</div>"
			 +  "	<p class='pic-list-datetime'>" + result.cdate + "</p>"
			 +  "</li>";
			
		$('.pic-list').append(str2);
      },
      error : function() {
    	  alert("error");
      }
   });
});

//팀 목록 modify modal창에서 수정버튼(#modalModifyBtn)을 눌렀을 때
$('#teamModalModifyBtn').click(function() {
   var teamName = $('#modalTextTxt').val();
   $.ajax({
      type : 'put',
      headers : {
         "Content-Type" : "application/json",
         "X-HTTP-Method-Override" : "PUT"
      },
      dataType : 'json',
      data : JSON.stringify({
            t_id : T_id,
            name : teamName,
            u_id : U_ID,
		    before : title
       }),
      success : function(result) {
     	 var str2;
     	 hideModalDiv();
		 str =	"<div class='oneListRow' data-id='" + T_id + "'>"
		      +	"	<div class='name'>" + name + "</div>"
			  + "</div>";
     		
		 $('.oneListRow[data-id=' + T_id + ']').children('.name').html(teamName);
		
		 str2 =  "<li data-id ='" + result.id + "'>"
     		  +  "	<div class='pic-list-writer'>"
     		  +  "		<div class='profile'>"
     		  +  "			<img src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate" + result.profile +"' alt='프로필 사진' />"
     		  +  "		</div>"
     		  +  "	</div>"
     		  +  "	<div class='pic-list-desc'>";
     	 str2 += "		<span class='name'>" + result.nickname + "</span> 님이 '" + result.before + "' 팀의 이름을 '" + result.after + "'로 수정하였습니다."
			  +  "	</div>"
			  +  "	<p class='pic-list-datetime'>" + result.cdate + "</p>"
			  +  "</li>";
		
		 $('.pic-list').append(str2);

      },
      error : function() {
    	  alert("error");
      }
   });
});

//멤버보기 버튼을 누를 경우1(멤버리스트 동적 생성)
 $(".listBoxBody").on('click','.selectMemberBtn',function() {  
	  $(this).parents(".oneListRow").next().toggle(); 
});
  
//멤버보기 버튼을 누를 경우2(소유자 권한 양도 모달 창 select의 option 값 가져오기)
$(".listBoxBody").on('click','.selectMemberBtn',function() {  
      var str = "";
      var checkBtn = $(this);
      
      //내가 선택한 버튼의 memberList 중 컬럼과 데이터 모두선택 (배열)
      var memberList = checkBtn.parent().parent().next();
      
      //내가 선택한 버튼의 memberList 중 컬럼을 제외한 memberList 데이터만 선택 (배열)
      var memberListTableBody = memberList.children().children(".memberListTableBody"); 
      
      //내가 선택한 버튼의 memberList에서 권한을 선택 (배열)
      var Member = memberListTableBody.children('.oneListRow'); 
       
      //만약 member가 여러명이라면 
      if (Member.length > 1) { 
    	  
         str = "<div class='modalContent'><p>&lt;경고&gt;<br>소유자는 권한을 양도하면 다시 소유자 권한으로 바꿀 수 없습니다.<br> 또한 팀에서 자동으로 탈퇴됩니다.</p>"
             + "<label for='authTransferSelect'>권한 양도할 팀원</label>"
             + "   <select name='authTransferSelect' id='authTransferSelect'>";
         
         for (var i = 1; i < Member.length; i++) {
            var userNickname = memberListTableBody.children().eq(i).children().eq(2).text();
				str += "<option>"
				+ userNickname
				+ "</option>";
		 }
		
         str += "   </select>"
	         + "<input type='button' id='authTransferBtn' value='권한 양도'/>"
	         + "<input type='button' class='modalCancleBtn' value='취소'/></div>";

	     //소유자 권한 양도 모달 창         
	     $("#memberModalTransferDiv").html(str);
	     str = "";
	     
	  }else{ //만약 member가 소유자만 있다면
	     str += "<div class='modalContent'><h3 class='title'>팀원이 소유자만 있는 경우에는 권한 양도가 불가합니다. 팀을 삭제해주세요.</h3>"
	         + "<input type='button' class='modalCancleBtn' value='취소'/></div>";

	     $("#memberModalTransferDiv").html(str);
	     str = "";
	  }  
});
			
//멤버리스트에서 권한 양도 버튼을 눌렀을 경우
$(document).on('click','.transferAuthBtn',function() {
	//권한을 양도하고 삭제되려는 소유자의 t_id, u_id 
	T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
	s_T_id = $(this).parent().parent().parent().parent().parent().prev().children('.t_id'); //select option의 값을 가진 data를 추출하기 위해 만든 변수 .children('.t_id')
	U_id = $(this).parents('div').children('.u_id').html();

	$( '#memberModalTransferDiv' ).show();
});
					
//멤버리스트에서 권한수정 버튼을 눌렀을 경우
$(document).on('click','.modifyAuthBtn',function() {
	T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
	U_id = $(this).parents('div').children('.u_id').html();
	hideModalDiv();
	$('#memberModalModifyDiv').show();
});

//멤버리스트에서 삭제버튼을 눌렀을 경우
$(document).on('click','.deleteMemberBtn',function() {
	T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
	U_id = $(this).parents('div').children('.u_id').html();
	hideModalDiv();
	$('#memberModalDeleteDiv').show();
});

//멤버리스트에서 멤버 한명 추가버튼을 눌렀을 경우
$(document).on('click','.addMemberBtn',function() {
	T_id = $(this).parent().parent().parent().prev().children('.t_id').html();
	$('#addMemberModal').show();
});

//멤버 삭제 delete modal창에서 삭제버튼(#modalDeleteBtn)을 눌렀을 때
$(document).on('click','#memberModalDeleteBtn',function() {
	$.ajax({
		url : 'team/'+ T_id,
		type : 'delete',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "DELETE"
		},
		dataType : 'json',
		contentType : 'text/javascript',
		data : JSON.stringify({
			t_id : T_id,
			u_id : U_id
		}),
		success : function(result) {
			if(result == true){
				hideModalDiv();
				str =  "<div class='oneListRow' data-id='" + U_id + "'>"
					+  "</div>";
				$('.oneListRow[data-id=' + U_id + ']').remove();	
			}else{
				alert("error");
			}
		},
		error : function() {
			alert("error");
		}
	});
});

//멤버 권한 수정 modify modal창에서 '팀원'을 눌렀을 때
$(document).on('click','#memberAuthModify2Btn',function() {
	$.ajax({
		url : 'team/'+ T_id,
		type : 'put',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		dataType : 'json',
		data : JSON.stringify({
			t_id : T_id,
			u_id : U_id,
			auth : 2
		}),
		success : function(result) {
			if(result == true){
				hideModalDiv();
				str =	"	<div class='auth'>" + auth(2) +"</div>";
				$(".oneListRow[data-id='" + U_id + "']").children('.auth').html(str);
			}else{
				alert("error");
			}
		},
		error : function() {
			alert("error");
		}
	});
});

//멤버 권한 수정 modify modal창에서 '관리자'을 눌렀을 때
$(document).on('click','#memberAuthModify1Btn',function() {
	$.ajax({
		url : 'team/'+ T_id,
		type : 'put',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		dataType : 'json',
		data : JSON.stringify({
			t_id : T_id,
			u_id : U_id,
			auth : 1
		}),
		success : function(result) {
			if(result == true){
				hideModalDiv();
				str =	"	<div class='auth'>" + auth(1) +"</div>";
				$(".oneListRow[data-id='" + U_id + "']").children('.auth').html(str);
			}else{
				alert("error");
			}
		},
		error : function() {
			alert("error");
		}
	});
});

//멤버 권한양도 transfer modal창에서 권한양도버튼(#modalTransferBtn)을 눌렀을 때
 $(document).on('click','#authTransferBtn',function() { 
   selectedMemberName = $("#authTransferSelect option:selected").val();//양도할 사람
   
   //소유자 권한을 양도받으려는 팀원들의 정보들(teamMember)
   var memberList = s_T_id.parent().next();//해당 t_id의  memberList
   var oneListRow = memberList.children().children().eq(1).children();//memberList에 있는 .oneListRow.
	
   //selectedMemberName의 t_id, u_id가져오는 기능
   for (var i = 1; i < oneListRow.length; i++) {//oneList의 개수만큼 for문 돌림(멤버 명수만큼)
      var searchNickname = oneListRow.eq(i).find('.nickname').text();//1~n명까지의 멤버들의 nickName을 하나씩 추출
      var s_searchNickname = oneListRow.eq(i).find('.nickname');
      if (selectedMemberName == searchNickname) {//select에서 선택한 nickName과 같은 nickName을 발견했을 경우
         break;
      }
   }
   transferT_id = T_id;
   transferU_id = s_searchNickname.parent().children('.u_id').text();
   
    $.ajax({
      url : 'team/'+ T_id + "/"+ U_id,
      type : 'put',
      headers : {
         "Content-Type" : "application/json",
         "X-HTTP-Method-Override" : "PUT"
      },
      dataType : 'json',
      contentType : 'text/javascript',
      data : JSON.stringify({
         deleteT_id : T_id,
         deleteU_id : U_id,
         transferT_id : transferT_id,
         transferU_id : transferU_id
      }),
      success : function(result) {
         location.reload();
         $('#memberModalTransferDiv').hide();
         alert("권한이 정상적으로 양도되었습니다..");
      },
      error : function() {
         alert("error");
      } 
   });  
});

//팀리스트 검색에 keyword를 입력할경우
$('#memberSearch').keyup(function(){
	var keyword = $(this).val();
	if(keyword != ''){
	//검색어에 값이 있다면 결과를 보여주기
	 	$.ajax({
			url : 'team/search/' + keyword,
			type : 'get',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "GET"
			},
			dataType : 'json',
			contentType : 'text/javascript',
			data : {u_id : U_ID},
			success : function(data) {
				$('#listContent').children('.listBoxBody').html('');
				for(var i=0; i< data.length; i++){
					allTeamStr(data[i],1);
				}
				memberAdd();
			},
			error : function(){
				alert("error");
			}
		}); 
	}else{
		$('#listContent').children('.listBoxBody').html('');
		allTeamList();
	}
}); 