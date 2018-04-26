<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="/resources/css/team/team.css?ver=1" type="text/css" rel="stylesheet" />
</head>
<body>
	<%@include file="../header.jsp"%>
	<%@include file="../mainMenu.jsp"%>
	<%@include file="../closeBoard.jsp"%>
	
	<!-- content 시작 -->	
	<div class="content">
	<!-- wrapContent 시작 -->
		<div class="wrapContent">
			<!-- 사이드 컨텐트 시작 -->
			<div class="smallContent" id="sideContent">
				<!-- 멤버 검색 -->
				<div class="sidemenu">
					<h3 class="title">Member Search</h3>
					<input type="text" name="memberSearch" id="memberSearch"
						placeholder=" Search Member..">
				</div>
				<!-- 팀 추가 -->
				<div class="sidemenu">
					<h3 class="title">Team Add</h3>
					<input type="button" class="addTeam" id="addTeamBtn"
						value="Add Team" />
				</div>
			</div>
			<!-- 사이드 컨텐트 끝 -->
			<!-- 팀 목록 컨텐트 시작 -->
			<div class="smallContent" id="listContent">
				<h3 class="title">Team List</h3>
				<!-- 팀 목록 작은 컨텐트 -->
				<div class="listBoxBody">
					<div class="category teamCategory">
						<div class="t_id" style="display: none;">t_id</div>
						<div class="name">이름</div>
						<div class="cdate">생성일자</div>
						<div class="auth">권한</div>
					</div>
					<!--  팀 목록 동적생성 -->
				</div>
			</div>
		</div>
		<!-- 한 팀의 정보 끝 -->

			<!-- 팀 추가 모달창 -->
			 <div class="modal" id="teamModalAddDiv">
			 	<div class="modalContent">
					<div>
						<label for="name">팀이름: </label> <input type="text" id="name"
							name="name" placeholder="write team name here." />
					</div>
					<div>
						<input type="button" id="teamModalAddBtn" value="확인" />
						<input type="button" class="modalCancleBtn" name="cancle" value="취소" />
					</div>
				</div>
			</div> 

			 <!-- 팀이름수정 모달 창 -->
			<div class="modal" id="teamModalModifyDiv">
				<div class="modalContent">
					<div>
						<p>수정할 팀 이름을 입력하세요.</p>
						<input type="text" id="modalTextTxt" name="modalTextTxt" maxlength="20"/>
					</div>
					<div>
						<input type="button" id="teamModalModifyBtn" value="수정" />
						<input type="button" class="modalCancleBtn" value="취소" />
					</div>
				</div>
			</div>

			<!--팀삭제 모달 창-->
			<div class="modal" id="teamModalDeleteDiv">
				<div class="modalContent">
					<p>정말로 삭제 하시겠습니까?</p>
					<div>
						<input type="button" id="teamModalDeleteBtn" value="삭제" />
						<input type="button" class="modalCancleBtn" value="취소" />
					</div>
				</div> 
			</div>
			
			<!-- 소유자권한양도 모달 창 -->
			<div class="modal" id="memberModalTransferDiv">
				<!-- jquery에서 생성 -->
			</div>
				
			<!-- 멤버권한수정 모달 창 -->
			<div class="modal" id="memberModalModifyDiv">
				<div  class="modalContent">
					<p>수정할 권한을 클릭하십시오.</p>
					<input type="button" id="memberAuthModify2Btn" value="팀원" />
					<input type="button" id="memberAuthModify1Btn" value="관리자" />
					<input type="button" class="modalCancleBtn" value="취소" />
				</div>
			</div>
				
			<!-- 멤버 삭제 모달 창 -->
			<div class="modal" id="memberModalDeleteDiv">
				<div  class="modalContent">
					<div>정말로 팀원을 삭제 하시겠습니까?</div>
						<h2>Remove from team</h2>
						<p>Remove all access to the team. The member will remain on all their
							boards in this team. They will receive a notification."
						</p>
					<div>
					<input type="button" id="memberModalDeleteBtn" value="삭제" />
					<input type="button" class="modalCancleBtn" value="취소" />
					</div>
				</div>
			</div>

			<!--  한 명의 멤버 추가버튼을 누를 때 모달창 -->
			<div class="modal"  id="addMemberModal">
				<div class="modalContent" >
					 Email:
					 <input type="text" id="memberTxt" name="memberTxt" placeholder="e.g. linker@gmail.com">
					 <p> Search for a person in Trello by name
						or email address, or enter an email address to invite someone new.
					 </p>
					 <input type="submit" id="memberModalAddBtn" value="Add To Team.." />
					 <input type="button" class="modalCancleBtn" name="cancle" value="취소" />
				</div>
			</div>

			<!--  여러 명 멤버 추가버튼을 누를 때 모달창 -->
			<div class="modal"  id="addMembersModal" >
				<div class="modalContent">
					<textarea name="membersTxt" id="membersTxt" cols="30" rows="10"
						placeholder="e.g. taco@gmail.com; choriize@gmail.com;pede@gmail.com;">
					</textarea>
					<input type="submit" id="membersModalAddBtn" value="Add To Team.." />
					<input type="button" class="modalCancleBtn" value="취소" />
				</div>
			</div>
			<!-- 모달창 끝 -->

	</div>
	<!-- content 끝 -->
</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
<script> 	

	/* 변수 선언 */
	var U_ID = ${u_id};//유저 id
	var EMAIL = '${email}';//유저 email
	var NICKNAME = '${nickname}';//유저 nickname
	var T_id = null; //t_id 변수
	var U_id = null; //u_id 변수
	var sT_id = null; //T_id의 선택자 변수
	var sU_id = null; //U_id의 선택자 변수
	var Cdate = null; //cdate 변수
	var selectedMemberName = null; //선택된 팀원 이름. option에서 소유자 권한 양도받을 팀원 이름. 
 
/* 함수 정리 */
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


	function auth(auth){
		//console.log("auth function start");
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

	function teamButton(auth){
		//console.log("authButton function start");
		var str = "";
		if(auth == 0 ){
			str  =  "	<div class='listBtn'><input type='button' class='selectMemberBtn' name='selectMemberBtn' value='멤버보기' /></div>"
				 +  "	<div class='listBtn'><input type='button' class='deleteTeamBtn' name='deleteTeamBtn' value='팀 삭제' /></div>"
				 +  "	<div class='listBtn'><input type='button' class='modifyTeamBtn' name='modifyTeamBtn' value='팀 이름 수정' /></div>";
		}else{
			str  =  "	<div class='listBtn'><input type='button' class='selectMemberBtn' name='selectMemberBtn' value='멤버보기' /></div>";
		}
		return str;
	}

	function memberButton(data, myauth){
		//console.log("authButton function start");
		var str = "";
		if(myauth== 0 && data == 0){
			str =  "<div class='listBtn'><input type='button' class='transferAuthBtn' name='ransferAuthBtn' value='권한 양도' /></div>";

		}else if(myauth== 0 && data != 0){
			str = "	<div class='listBtn'><input type='button' class='modifyAuthBtn' name='modifyAuthBtn' value='권한수정' /></div>"
				 +  "	<div class='listBtn'><input type='button' class='deleteMemberBtn' name='deleteMemberBtn' value='삭제' /></div>";
		}else if(myauth== 1 && data != 0){
			str = "	<div class='listBtn'><input type='button' class='modifyAuthBtn' name='modifyAuthBtn' value='권한수정' /></div>"
				 +  "	<div class='listBtn'><input type='button' class='deleteMemberBtn' name='deleteMemberBtn' value='삭제' /></div>";
		}
		return str;
	  } 

	function memberAdd(){
		var memberStr = "";
		memberStr	+=	"<div class='sidemenu'>"
			+	"	<h3 class='title'> Member Add </h3>"
			+	"	<input type='button' class='addMemberBtn' id='addMemberBtn' value='Add by Name or Email' />"
			+	"</div>";
		$('.memberList').children('.listBoxBody').append(memberStr);
		return memberStr;
	}
	
	function allTeamList(){
		console.log("allTeamList 함수에 입장했습니다");
		$.ajax({
			type : "GET",
			url : "/main/team/" + U_ID,
			success : function(data){
				console.log("allTeamList" + data);
				for(var i=0; i< data.length; i++){
					allTeamStr(data[i]);
				}
				memberAdd();
			},
			error : function(){
				alert("에러가 발생했습니다.");
			}
		});	
	}

	function allTeamStr(data){
		console.log("allTeamStr data(팀 한개씩 출력) : " + data);
		
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
					+  "		<h3 class='title'>Member List</h3>"
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

	function allMemberList(myT_id, myAuth){
		console.log("allMemberList 함수에 입장했습니다");
		$.ajax({
			type : "GET",
			url : "/main/member/" + U_ID,
			data : {
				t_id : myT_id
			},
			success : function(data){
				console.log("allMemberList " + data);
				console.log("allMemberList user의 해당팀의  myT_id : " + myT_id);
				
				var str="";
				for(var i=0; i<data.length; i++){
					console.log( myT_id + "," + data[i].t_id);
					 allMemberStr(data[i], myAuth);		
				}
			}, 
			error : function(){
				alert("에러가 발생했습니다.");
			}
		});
	}

	function allMemberStr(data, myAuth){
		console.log("allMemberStr data(해당 팀의 멤버들 출력) : " + data);
		console.log("allMemberStr user의 myAuth : " + myAuth);
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
						
	 //팀 목록에서 팀 추가 버튼을 눌렀을 때
	 $('#addTeamBtn').click(function() {
		$('#teamModalAddDiv').show();
 	 });
						 
	 //카드동적생성		
	 allTeamList();
	 
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
	          //console.log($('#name').val());
	          alert("팀 이름을 입력해주세요.");
	          return;
	       }else if($('#name').val().length > 20){
	          //console.log($('#name').length);
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
	    				str =   "<div id='teamListTableBody'>"
	    					+   "	<div class='oneListRow' data-id='" + result + "'>"
	    					+	"		<div class='t_id' style='display : none;'>" + result + "</div>"
	    					+	"		<div class='name'>" + name + "</div>"
	    					+	"		<div class='cdate'>" + date + "</div>";
	    				str +=	"		<div class='auth'>" + auth(0) +"</div>";
	    				str +=			teamButton(0);
	    				str +=  "	</div>"
	    					+	"	<div class='memberList' style='display : none;'>"	
	    					+  "		<h3 class='title'>Member List</h3>"
	    		            +  "		<div class='listBoxBody'>"
	    		            +  "			<div class='category memberCategory'>"
	    		            +  "				<div class='t_id' style='display : none;'>u_id</div>"
	    		            +  "				<div class='email'>이메일</div>"
	    		            +  "				<div class='nickname'>닉네임</div>"
	    		            +  "				<div class='auth'>권한</div>"
	    		            +  "			</div>"
	    		            +  "			<div class='memberListTableBody' data-id='" + result + "'>"
	    		        str +=  "				<div class='oneListRow' data-id='" + U_ID + "'>"
	    	            	+	"					<div class='u_id' style='display:none;'  data-id='" + U_ID + "'>" + U_ID + "</div>"
	    					+  "					<div class='email'>" + EMAIL + "</div>"
	    					+  "					<div class='nickname'>" + NICKNAME + "</div>";
	    				str +=	"					<div class='auth'>" + auth(0) +"</div>";
	    				str +=						memberButton(0, 0);
	    				str	+=  "				</div>";
	    		            +  "			</div>"
	    		            +  "		</div>"
	    		            +  "	</div>"
	    				 	+	"</div>";
	    				
	    				 	
	    				$('#listContent').children('.listBoxBody').append(str);
	    					memberAdd();
	    				 $('#memberSearch').val('');
	    	            }
	    	         },
	    	         error : function() {
	    	            console.log("error");
	    	         }
	    	      });
	    	                      
	    	    });
	    	                   
	    	    //멤버 한명 추가하기 버튼을 눌렀을 유효성검사 + 추가하기
	    	    $(document).on('click','#memberModalAddBtn',function() {
	    	      //console.log($('#memberTxt').val().length);
	    	      var email = $('#memberTxt').val();
	    	      //console.log(email);
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
	    	            console.log(result);
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
	    	            console.log("xhr" + xhr);
	    	            console.log("status" + status);
	    	            console.log("error" + error);
	    	            console.log("error");
	    	         }
	    	      }); 
	    	    });
	    	                   
	    	   //팀목록에서 수정버튼(.modifyTeamBtn)을 눌렀을 때
	    	   $(document).on('click','.modifyTeamBtn',function() {
	    	      hideModalDiv();
	    	      //console.log("clicked.");
	    	      $('#teamModalModifyDiv').show();
	    	      T_id = $(this).parents('div').children('.t_id').html();
	    	     //console.log(T_id);
	    	      U_id = $(this).parents('div').children('.u_id').html();
	    	     //console.log(U_id);
	    	      var title = $(this).parents('div').children('.name').html();
	    	      $('#modalTextTxt').val(title);

				});

	//팀 목록에서 삭제버튼(.deleteTeamBtn)을 눌렀을 때
		$(document).on('click','.deleteTeamBtn',function() {
		hideModalDiv();
		//console.log("clicked.");
		$('#teamModalDeleteDiv').show();

		T_id = $(this).parents('div').children('.t_id').html();
		//console.log(T_id);
	});

	//modal창에서 취소버튼(.modalCancleBtn)을 눌렀을 때
	$(document).on('click', '.modalCancleBtn', function() {
		//console.log("clicked.");
		hideModalDiv();
	});

	   //팀 삭제 delete modal창에서 삭제버튼(#modalDeleteBtn)을 눌렀을 때
	   $('#teamModalDeleteBtn').click(function() {
	      //console.log("clicked1.");
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
	         }),
	         success : function(result) {
	            console.log(result);
	            if(result == true){
	            $('.memberList').hide();
	            hideModalDiv();
            	str =	"<div class='oneListRow' data-id='" + T_id + "'>"
				 +  "	</div>";
				$('.oneListRow[data-id=' + T_id + ']').remove();	
	            }else{
	            	console.log("error");
	            }
	         },
	         error : function() {
	         console.log("error");
	         }
	      });
	   });

	   //팀 목록 modify modal창에서 수정버튼(#modalModifyBtn)을 눌렀을 때
	   $('#teamModalModifyBtn').click(function() {
	      var teamName = $('#modalTextTxt').val();
	      console.log(teamName);
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
	            u_id : U_id
	         }),
	         success : function(result) {
	        	 if(result == true){
	        	  hideModalDiv();
	        		str =	"<div class='oneListRow' data-id='" + T_id + "'>"
            		+	"		<div class='name'>" + name + "</div>"
					 +  "	</div>";
				$('.oneListRow[data-id=' + T_id + ']').children('.name').html(teamName);	
		            }else{
		            	console.log("error");
		            }
	         },
	         error : function() {
	         console.log("error");
	         }
	      });
	   });
	   
	   //멤버보기 버튼을 누를 경우1(멤버리스트 동적 생성)
	    $(".listBoxBody").on('click','.selectMemberBtn',function() {  
	 	  $(this).parents(".oneListRow").next().toggle(); 
	 	  console.log($(this).parents(".oneListRow"));
	   });
	       

	//멤버보기 버튼을 누를 경우2(소유자 권한 양도 모달 창 select의 option 값 가져오기)
	$(".listBoxBody").on('click','.selectMemberBtn',function() {  
/* 	$(".selectMemberBtn").click(function() { */
	      var str = "";
	      var checkBtn = $(this);
	      
	       //내가 선택한 버튼의 memberList 중 컬럼과 데이터 모두선택 (배열)
	      var memberList = checkBtn.parent().parent().next();
	      console.log(memberList);
	      
	      //내가 선택한 버튼의 memberList 중 컬럼을 제외한 memberList 데이터만 선택 (배열)
	      var memberListTableBody = memberList.children().children(".memberListTableBody"); 
	      console.log(memberListTableBody);
	      
	      //내가 선택한 버튼의 memberList에서 권한을 선택 (배열)
	      var Member = memberListTableBody.children('.oneListRow'); 
	      console.log(Member.length); 
	       
	      //만약 member가 여러명이라면 
	      if (Member.length > 1) { 
	         str = "<div class='modalContent'><p>&lt;경고&gt;<br>소유자는 권한을 양도하면 다시 소유자 권한으로 바꿀 수 없습니다.<br> 또한 팀에서 자동으로 탈퇴됩니다.</p>"
	            + "<label for='authTransferSelect'>권한 양도할 팀원</label>"
	            + "   <select name='authTransferSelect' id='authTransferSelect'>";
	         for (var i = 1; i < Member.length; i++) {
	            var userNickname = memberListTableBody.children().eq(i).children().eq(2).text();
	            console.log(userNickname);
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
	      console.log(T_id);
	      U_id = $(this).parents('div').children('.u_id').html();
	      console.log(U_id);

		$( '#memberModalTransferDiv' ).show();
	});
						
		   //멤버리스트에서 권한수정 버튼을 눌렀을 경우
		   $(document).on('click','.modifyAuthBtn',function() {
			   T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
			   console.log(T_id);
			   U_id = $(this).parents('div').children('.u_id').html();
			   console.log(U_id);
		      hideModalDiv();
		      $('#memberModalModifyDiv').show();
		   });
		                  
		   //멤버리스트에서 삭제버튼을 눌렀을 경우
		    $(document).on('click','.deleteMemberBtn',function() {
		      T_id =$(this).parent().parent().parent().parent().parent().prev().children('.t_id').html();
		      console.log(T_id);
		      U_id = $(this).parents('div').children('.u_id').html();
		      console.log(U_id);
		      hideModalDiv();
		      //console.log("clicked.");
		      $('#memberModalDeleteDiv').show();
		      console.log("됬다");
		   });
	
		   //멤버리스트에서 멤버 한명 추가버튼을 눌렀을 경우
		   $(document).on('click','.addMemberBtn',function() {
		       T_id = $(this).parent().parent().parent().prev().children('.t_id').html();
		      console.log(T_id);
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
		        	 console.log(result);
			            if(result == true){
			            hideModalDiv();
		            	str =	"<div class='oneListRow' data-id='" + U_id + "'>"
						 +  "	</div>";
						$('.oneListRow[data-id=' + U_id + ']').remove();	
			            }else{
			            	console.log("error");
			            }
		         },
		         error : function() {
		            console.log("error");
		         }
		      });
		   });
		                     
		   //멤버 권한 수정 modify modal창에서 '팀원'을 눌렀을 때
		   $(document).on('click','#memberAuthModify2Btn',function() {
		      //console.log(U_id);
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
		        		 console.log("error");
		        	 }
		         },
		         error : function() {
		            //console.log("error");
		         }
		      });
		   });
		                     
		   //멤버 권한 수정 modify modal창에서 '관리자'을 눌렀을 때
		   $(document).on('click','#memberAuthModify1Btn',function() {
		      //console.log(u_id);
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
		        		 console.log("error");
		        	 }
		         },
		         error : function() {
		         //console.log("error");
		         }
		      });
		   });

		   //멤버 권한양도 transfer modal창에서 권한양도버튼(#modalTransferBtn)을 눌렀을 때
		    $(document).on('click','#authTransferBtn',function() { 
		      console.log("T_id : " + T_id);
		      selectedMemberName = $("#authTransferSelect option:selected").val();//양도할 사람
		      console.log("selectedMemberName : " + selectedMemberName);
		      
		      //소유자 권한을 양도받으려는 팀원들의 정보들(teamMember)
		      console.log("s_T_id : " + s_T_id);//팀목록에 있는  t_id
		      var memberList = s_T_id.parent().next();//해당 t_id의  memberList
		      console.log("memberList : " + memberList);
		      var oneListRow = memberList.children().children().eq(1).children();//memberList에 있는 .oneListRow.
		      console.log("oneListRow : " + oneListRow);
	
		      //selectedMemberName의 t_id, u_id가져오는 기능
		      for (var i = 1; i < oneListRow.length; i++) {//oneList의 개수만큼 for문 돌림(멤버 명수만큼)
		         var searchNickname = oneListRow.eq(i).find('.nickname').text();//1~n명까지의 멤버들의 nickName을 하나씩 추출
		         console.log("searchNickname : " + searchNickname);
		         var s_searchNickname = oneListRow.eq(i).find('.nickname');
		         console.log(s_searchNickname);
		         if (selectedMemberName == searchNickname) {//select에서 선택한 nickName과 같은 nickName을 발견했을 경우
		            console.log("searchNickname : " + searchNickname);
		            console.log("s_searchNickname : " + s_searchNickname);
		            break;
		         }
		      }
		      transferT_id = T_id;
		      console.log("trasferT_id : " + transferT_id);
		      transferU_id = s_searchNickname.parent().children('.u_id').text();
		      console.log("transferU_id : " + transferU_id);
		      
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
		            //console.log(result);
		            location.reload();
		            $('#memberModalTransferDiv').hide();
		            alert("권한이 정상적으로 양도되었습니다..");
		         },
		         error : function() {
		            console.log("error");
		         } 
		      });  
		   });
		   
		//팀리스트 검색에 keyword를 입력할경우
		$('#memberSearch').keyup(function(){
			var keyword = $(this).val();
			console.log(keyword);
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
					data : keyword,
					success : function(result) {
						console.log(result);
						//allTeamStr(result);
					},
					error : function(){
						console.log("error");
					}
				}); 
			}
		});

</script>

</html>