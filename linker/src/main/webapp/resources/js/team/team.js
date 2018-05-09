/* ---------------------------------------------------------------------------------------함수 정리 ----------------------------------------------------------------------------*/

//모달창을 모두 닫는 함수
function hideModalDiv() {
	$('#team-modal-add-div').hide();
	$('#team-modal-modify-div').hide();
	$('#team-modal-delete-div').hide();
	$('#member-modal-modify-div').hide();
	$('#member-modal-transfer-div').hide();
	$('#member-modal-delete-div').hide();
	$('#add-member-modal').hide();
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
		str  =  "	<div class='list-btn'><input type='button' class='select-member-btn' name='selectMemberBtn' style='cursor:pointer;' value='멤버보기' /></div>"
			 +  "	<div class='list-btn'><input type='button' class='delete-team-btn' name='deleteTeamBtn' style='cursor:pointer;' value='삭제' /></div>"
			 +  "	<div class='list-btn'><input type='button' class='modify-team-btn' name='modifyTeamBtn' style='cursor:pointer;' value='수정' /></div>";
	}else{
		str  =  "	<div class='list-btn'><input type='button' class='select-member-btn' name='selectMemberBtn' style='cursor:pointer;' value='멤버보기' /></div>";
	}
	return str;
}

//권한에 따라 멤버 목록에 버튼을 출력하는 함수
function memberButton(data, myauth){
	var str = "";
	if(myauth== 0 && data == 0){
		str =  "<div class='list-btn'><input type='button' class='transfer-auth-btn' name='transferAuthBtn' style='cursor:pointer;' value='권한 양도' /></div>";
	}else if(myauth== 0 && data != 0){
		str = "	<div class='list-btn'><input type='button' class='modify-auth-btn' name='modifyAuthBtn' style='cursor:pointer;' value='권한수정' /></div>"
			+ "	<div class='list-btn'><input type='button' class='delete-member-btn' name='deleteMemberBtn' style='cursor:pointer;' value='탈퇴' /></div>";
	}else if(myauth== 1 && data != 0){
		str = "	<div class='list-btn'><input type='button' class='modify-auth-btn' name='modifyAuthBtn' style='cursor:pointer;' value='권한수정' /></div>"
			+ "	<div class='list-btn'><input type='button' class='delete-member-btn' name='deleteMemberBtn' style='cursor:pointer;' value='탈퇴' /></div>";
	}else if(myauth== 2 && data == 2){
		str = "	<div class='list-btn'><input type='button' class='delete-member-btn' name='deleteMemberBtn' style='cursor:pointer;' value='탈퇴' /></div>";
	}
	return str;
} 

//버튼 영역 동적 태그로 출력하는 함수
function memberAdd(){
	var memberStr = "";
	memberStr	+=	"<div class='side-menu'>"
				+	"	<h5 class='title'> Member Add </h5>"
				+	"	<input type='button' class='add-member-btn' id='add-member-btn' value='Add by Name or Email' style='cursor:pointer; width:200px;' />"
				+	"</div>";
	$('.member-list').children('.list-box-body').append(memberStr);
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
	str =   "<div id='team-list-table-body'>"
		+   "	<div class='one-list-row' data-id='" + data.t_id + "'>"
		+	"		<div class='t_id' style='display : none;'>" + data.t_id + "</div>"
		+	"		<div class='name'><i class='fas fa-users'></i>&nbsp&nbsp" + data.name + "</div>"
		+	"		<div class='cdate'>" + data.cdate + "</div>";
	str +=	"		<div class='auth'>" + auth(data.auth) +"</div>";
	str +=	teamButton(data.auth);//권한 따라서 버튼이 달라짐
	str +=  "	</div>"
		+	"	<div class='member-list' style='display : none;'>"	
		+   "		<h5 class='title'>Member List</h5>"
		+   "		<div class='list-box-body'>"
		+   "			<div class='category member-category'>"
		+   "				<div class='t_id' style='display : none;'>u_id</div>"
		+   "				<div class='email'>이메일</div>"
		+   "				<div class='nickname'>닉네임</div>"
		+   "				<div class='auth'>권한</div>"
		+   "			</div>"
		+   "			<div class='member-list-table-body' data-id='" + data.t_id + "'>"
		+   "			</div>"
		+   "		</div>"
		+   "	</div>"
		+	"</div>";

	$('#list-content').children('.list-box-body').append(str);
	allMemberList(data.t_id, data.auth);
}

//데이터 개수마다 동적 태그을 출력하는 함수2. 매개변수가 data, num인 경우
function allTeamStr(data, num){
	var str = "";
	str =   "<div id='team-list-table-body'>"
		+   "	<div class='one-list-row' data-id='" + data.t_id + "'>"
		+	"		<div class='t_id' style='display : none;'>" + data.t_id + "</div>"
		+	"		<div class='name'><i class='fas fa-users'></i>&nbsp&nbsp" + data.name + "</div>"
		+	"		<div class='cdate'>" + data.cdate + "</div>";
	str +=	"		<div class='auth'>" + auth(data.auth) +"</div>";
	str +=			teamButton(data.auth);
	str +=  "	</div>"
		+	"	<div class='member-list' style='display : none;'>"	
		+  "		<h5 class='title'>Member List</h5>"
		+  "		<div class='list-box-body'>"
		+  "			<div class='category member-category'>"
		+  "				<div class='t_id' style='display : none;'>u_id</div>"
		+  "				<div class='email'>이메일</div>"
		+  "				<div class='nickname'>닉네임</div>"
		+  "				<div class='auth'>권한</div>"
		+  "			</div>"
		+  "			<div class='member-list-table-body' data-id='" + data.t_id + "'>"
		+  "			</div>"
		+  "		</div>"
		+  "	</div>"
		+	"</div>";

	$('#list-content').children('.list-box-body').append(str);
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
		str =  "<div class='one-list-row' data-id='" + data.u_id + "'>"
			+	"	<div class='u_id' style='display:none;'  data-id='" + data.u_id + "'>" + data.u_id + "</div>"
			+  "	<div class='email'><i class='fas fa-user'></i>&nbsp&nbsp" + data.email + "</div>"
			+  "	<div class='nickname'>" + data.nickname + "</div>";
		str +=	"	<div class='auth'>" + auth(data.auth) +"</div>";
		str +=	memberButton(data.auth, myAuth);
		str	+=  "</div>";	

	$(".member-list-table-body[data-id='" + data.t_id + "']").append(str);	
}

/* ------------------------------------------------------------------------------함수 정리 끝 ---------------------------------------------------------------------------------------*/

//카드동적생성		
allTeamList();

//팀 목록에서 팀 추가 버튼을 눌렀을 때
$('#add-team-btn').click(function() {
	$('#team-modal-add-div').show();
});

/* 팀 추가(teamAdd) 유효성 검사
 * 1. 최대 글자 수 제한
 * 2. 입력 필수
 */
$('#team-modal-add-btn').click(function(){
	var name = $("#name").val();
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth()+1
	var day = date.getDate();
	var today = year+"-"+month+"-"+day;
	var isRun = false;//버튼 다중클릭 방지 변수 초기화

	//버튼 다중클릭 방지 검사
	if(isRun == true){//버튼 클릭하지 않았을 경우
		return;
	}
	
	//팀이름 유효성 검사
	if($('#name').val().length == 0){
		alert("팀 이름을 입력해주세요.");
		return;
	}else if($('#name').val().length > 20){
		alert("20자 이하로 입력해주세요.");
		return;
	}
	
	//날짜 조건
	if(month < 10){
        month = "0"+month;
	}
    if(day < 10){
        day = "0"+day;
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
	        isRun=false;//버튼 클릭 했을 경우
	        if(result != null){
	        hideModalDiv();
	    	var str = "";
	    	var str2;
	    	
			str =   "<div id='team-list-table-body'>"
				+   "	<div class='one-list-row' data-id='" + result.data_id + "'>"
				+	"		<div class='t_id' style='display : none;'>" + result.data_id + "</div>"
				+	"		<div class='name'><i class='fas fa-users'></i>&nbsp&nbsp" + name + "</div>"
				+	"		<div class='cdate'>" + today + "</div>";
			str +=	"		<div class='auth'>" + auth(0) +"</div>";
			str +=	teamButton(0);
			str +=  "	</div>"
				+	"	<div class='member-list' style='display : none;'>"	
				+   "		<h5 class='title'>Member List</h5>"
		        +   "		<div class='list-box-body'>"
		        +   "			<div class='category member-category'>"
		        +   "				<div class='t_id' style='display : none;'>u_id</div>"
		        +   "				<div class='email'>이메일</div>"
		        +   "				<div class='nickname'>닉네임</div>"
		        +   "				<div class='auth'>권한</div>"
		        +   "			</div>"
		        +   "			<div class='member-list-table-body' data-id='" + result + "'>"
		        +   "				<div class='one-list-row' data-id='" + U_ID + "'>"
		        +   "					<div class='u_id' style='display:none;'  data-id='" + U_ID + "'>" + U_ID + "</div>"
				+   "					<div class='email'><i class='fas fa-user'></i>&nbsp&nbsp" + EMAIL + "</div>"
				+   "					<div class='nickname'>" + NICKNAME + "</div>";
			str +=  "					<div class='auth'>" + auth(0) +"</div>";
			str +=  memberButton(0, 0);
			str	+=  "				</div>"
		        +   "			</div>"
		        +   "		</div>"
		        +   "	</div>"
			 	+   "</div>";
			
			$('#list-content').children('.list-box-body').append(str);
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
		
			$('.modal-content').find('#name').val('');
			      }
		},
		error : function() {
			alert("error");
		}
	});	                  
});
	    	                   
//멤버 한명 추가하기 버튼을 눌렀을 유효성검사 + 추가하기
$(document).on('click','#member-modal-add-btn',function() {
	var email = $('#member-txt').val();
	var reg_email = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	var isRun = false;// 버튼 다중 클릭 방지 버튼

	if(isRun == true){//버튼 클릭 안했을 때
		return;
	}
	
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
		   isRun=false;//버튼 클릭했을 때
	       if(result == "1"){
	      	 hideModalDiv();
	         alert("해당 회원에 메일을 보냈습니다. 해당 회원이 수락하는 동시에 팀에 해당회원이 등록됩니다.");
	      }else if(result == "0"){
	         $('#member-txt').val('');
	         alert(email+"은 이미 팀에 등록되어있습니다.");
	      }else{
	         $('#member-txt').val('');
	         alert(email+"은 회원이 아닙니다.");
	      } 
	   },
	   error : function(xhr,status,error){
	      alert("error");
	   }
	}); 
});
	    	                   
//팀목록에서 수정버튼(.modify-team-btn)을 눌렀을 때
$(document).on('click','.modify-team-btn',function() {
	hideModalDiv();
	$('#team-modal-modify-div').show();
	T_id = $(this).parent().parent().children('.t_id').html();
	U_id = $(this).parent().parent().children('.u_id').html();
	title = $.trim($(this).parent().parent().children('.name').text());
	$('#modal-text-txt').val(title);
});

//팀 목록에서 삭제버튼(.delete-team-btn)을 눌렀을 때
$(document).on('click','.delete-team-btn',function() {
	hideModalDiv();
	$('#team-modal-delete-div').show();
	T_id = $(this).parent().parent().children('.t_id').html();
	console.log(T_id);
	teamName = $.trim($(this).parent().parent().children('.name').text());
	console.log(teamName);
});

//modal창에서 취소버튼(.modal-cancle-btn)을 눌렀을 때
$(document).on('click', '.modal-cancle-btn', function() {
	hideModalDiv();
});

//팀 삭제 delete modal창에서 삭제버튼(#modalDeleteBtn)을 눌렀을 때
$('#team-modal-delete-btn').click(function() {
	console.log(T_id);
   $.ajax({
      type : 'put',
      headers : {
         "Content-Type" : "application/json",
         "X-HTTP-Method-Override" : "PUT"
      },
      url : 'team/delete/' + T_id,
      dataType : 'json',
      contentType : 'text/javascript',
      data : JSON.stringify({
         u_id : U_ID,
         name : teamName
      }),
      success : function(result) {
         var str2;
         $('.member-list').hide();
         hideModalDiv();

        $('.one-list-row[data-id=' + T_id + ']').remove();	
		
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
$('#team-modal-modify-btn').click(function() {
	console.log(T_id);
   var teamName = $('#modal-text-txt').val();
   $.ajax({
      type : 'put',
      url : 'team/update/' + T_id,
      headers : {
         "Content-Type" : "application/json",
         "X-HTTP-Method-Override" : "PUT"
      },
      dataType : 'json',
      data : JSON.stringify({
            name : teamName,
            u_id : U_ID,
		    before : title
       }),
      success : function(result) {
     	 var str2;
     	 hideModalDiv();
		 str =	"<div class='one-list-row' data-id='" + T_id + "'>"
		      +	"	<div class='name'>" + name + "</div>"
			  + "</div>";
     		
		 $('.one-list-row[data-id=' + T_id + ']').children('.name').html(teamName);
		
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
 $(".list-box-body").on('click','.select-member-btn',function() {  
	  $(this).parents(".one-list-row").next().toggle(); 
});
			
//멤버리스트에서 권한 양도 버튼을 눌렀을 경우
$(document).on('click','.transfer-auth-btn',function() {
	//권한을 양도하고 탈퇴되려는 소유자의 t_id, u_id 
	T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
	s_T_id = $(this).parent().parent().parent().parent().parent().prev().children('.t_id'); //select option의 값을 가진 data를 추출하기 위해 만든 변수 .children('.t_id')
	U_id = $(this).parents('div').children('.u_id').html();

	 var str = "";
     var checkBtn = $(this);
     /* 내가 선택한 버튼의 memberList 중 컬럼을 제외한 memberList 데이터만 선택 (배열)*/
     var memberListTableBody = checkBtn.parent().parent().parent();

     //내가 선택한 버튼의 memberList에서 권한을 선택 (배열)
     var Member = memberListTableBody.children('.one-list-row'); 
      
     //만약 member가 여러명이라면 
     if (Member.length > 1) { 
   	  
        str = "<div class='modal-content'>권한양도<hr/><p>&lt;경고&gt;<br>소유자는 권한을 양도하면 다시 소유자 권한으로 바꿀 수 없습니다.<br> 또한 팀에서 자동으로 탈퇴됩니다.</p><br><br>"
            + "<label for='auth-transfer-select'>권한 양도할 팀원</label>"
            + "   <select name='auth-transfer-select' id='auth-transfer-select'>";
        
        for (var i = 1; i < Member.length; i++) {
           var userNickname = memberListTableBody.children().eq(i).children().eq(2).text();
				str += "<option>"
				+ userNickname
				+ "</option>";
		 }
		
        str += "   </select><br><br>"
	         + "<input type='button' id='auth-transfer-btn' style='cursor:pointer;' value='권한 양도'/>"
	         + "<input type='button' class='modal-cancle-btn' style='cursor:pointer;' value='취소'/></div>";

	     //소유자 권한 양도 모달 창         
	     $("#member-modal-transfer-div").html(str);
	     str = "";
	     
	  }else{ //만약 member가 소유자만 있다면
	     str += "<div class='modal-content'>권한양도<hr/><p>팀원이 소유자만 있는 경우에는 권한 양도가 불가합니다. 팀을 삭제해주세요.</p><br><br>"
	         + "<input type='button' class='modal-cancle-btn' style='cursor:pointer;' value='취소'/></div>";

	     $("#member-modal-transfer-div").html(str);
	     str = "";
	  }
     
	$( '#member-modal-transfer-div' ).show();
});
					
//멤버리스트에서 권한수정 버튼을 눌렀을 경우
$(document).on('click','.modify-auth-btn',function() {
	T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
	U_id = $(this).parents('div').children('.u_id').html();
	hideModalDiv();
	$('#member-modal-modify-div').show();
});

//멤버리스트에서 탈퇴버튼을 눌렀을 경우
$(document).on('click','.delete-member-btn',function() {
	T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
	U_id = $(this).parents('div').children('.u_id').html();
	hideModalDiv();
	$('#member-modal-delete-div').show();
});

//멤버리스트에서 멤버 한명 추가버튼을 눌렀을 경우
$(document).on('click','.add-member-btn',function() {
	T_id = $(this).parent().parent().parent().prev().children('.t_id').html();
	$('#add-member-modal').show();
});

//멤버 탈퇴 delete modal창에서 탈퇴버튼(#modalDeleteBtn)을 눌렀을 때
$(document).on('click','#member-modal-delete-btn',function() {
	if(U_id == U_ID){//소유자가 아닌 사용자가 해당 팀에서 자진으로 탈퇴할 경우
		$.ajax({
			url : 'team/delete/volunteer/'+ T_id + "/" + U_id,
			type : 'delete',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'json',
			data : JSON.stringify({
				t_id : T_id,
				u_id : U_id
			}),
			contentType : 'text/javascript',
			success : function(result) {
				if(result == true){
					hideModalDiv();

					$('.one-list-row[data-id=' + T_id + ']').parent().remove();	
				}else{
					alert("error");
				}
			},
			error : function() {
				alert("error");
			}
		});
	}else{//소유자가 아닌 사용자가 해당 팀에서 타의로 탈퇴당한 경우
		$.ajax({
			url : 'team/delete/forced/'+ T_id + "/" + U_id,
			type : 'delete',
			headers : {
				"Content-Type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dataType : 'json',
			data : JSON.stringify({
				t_id : T_id,
				u_id : U_id
			}),
			contentType : 'text/javascript',
			success : function(result) {
				if(result == true){
					hideModalDiv();

					$('.one-list-row[data-id=' + U_id + ']').remove();	
				}else{
					alert("error");
				}
			},
			error : function() {
				alert("error");
			}
		});
	}
});

//멤버 권한 수정 modify modal창에서 '팀원'을 눌렀을 때
$(document).on('click','#member-auth-modify-2-btn',function() {
	$.ajax({
		url : 'team/update/'+ T_id + "/" + U_id,
		type : 'put',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		dataType : 'json',
		data : JSON.stringify({
			auth : 2
		}),
		success : function(result) {
			if(result == true){
				hideModalDiv();
				str = auth(2);
				$(".one-list-row[data-id='" + U_id + "']").children('.auth').html(str);
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
$(document).on('click','#member-auth-modify-1-btn',function() {
	$.ajax({
		url : 'team/update/'+ T_id + "/" + U_id,
		type : 'put',
		headers : {
			"Content-Type" : "application/json",
			"X-HTTP-Method-Override" : "PUT"
		},
		dataType : 'json',
		data : JSON.stringify({
			auth : 1
		}),
		success : function(result) {
			if(result == true){
				hideModalDiv();
				str =  auth(1);
				$(".one-list-row[data-id='" + U_id + "']").children('.auth').html(str);
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
 $(document).on('click','#auth-transfer-btn',function() { 
   selectedMemberName = $("#auth-transfer-select option:selected").val();//양도할 사람
   
   //소유자 권한을 양도받으려는 팀원들의 정보들(teamMember)
   var memberList = s_T_id.parent().next();//해당 t_id의  memberList
   var oneListRow = memberList.children().children().eq(1).children();//memberList에 있는 .one-list-row.
	
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
         $('#member-modal-transfer-div').hide();
         alert("권한이 정상적으로 양도되었습니다..");
      },
      error : function() {
         alert("error");
      } 
   });  
});

//팀리스트 검색에 keyword를 입력할경우
$('#member-search').keyup(function(){
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
				console.log(data);
				$('#list-content').children('.list-box-body').html('');
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
		$('#list-content').children('.list-box-body').html('');
		allTeamList();
	}
}); 