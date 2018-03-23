<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>Team List</div>

	<!-- 팀 목록 리스트 -->
	<table style="border: 1px solid black; width:1000px;" >
		<thead>
			<tr style="border: 1px solid black">
				<td style="border: 1px solid black; text-align: center">t_id</td>
				<td style="border: 1px solid black; text-align: center">name</td>
				<td style="border: 1px solid black; text-align: center">u_id</td>
				<td style="border: 1px solid black; text-align: center">cdate</td>
				<td style="border: 1px solid black; text-align: center">auth</td>
			</tr>
		</thead>
		<tbody id="teamListTableBody">
			<c:forEach items="${teamList}" var="teamList">
					<tr style="border: 1px solid black">
						<td class="t_id" style="border: 1px solid black">${teamList.t_id }</td>
						<td class="name" style="border: 1px solid black">${teamList.name}</td>
						<td class="u_id" style="border: 1px solid black">${teamList.u_id }</td>
					 	<td class="cdate" style="border: 1px solid black"><fmt:formatDate pattern="yyyy-MM-dd" value="${teamList.cdate}"></fmt:formatDate></td>
					 	<td class="auth" style="border: 1px solid black">${teamList.auth}</td>
						<c:choose>
							<c:when test="${teamList.auth==0}">
								<td><input type="button" class="modifyTeamBtn" name="modifyTeamBtn" value="수정" /></td>
								<td><input type="button" class="deleteTeamBtn" name="deleteTeamBtn" value="삭제" /></td>
								<td><input type="button" class="selectMemberBtn" name="selectMemberBtn" value="멤버보기" /></td>
							</c:when>
							<c:otherwise>
								<td><input type="button" class="selectMemberBtn" name="selectMemberBtn" value="멤버보기" /></td>
							</c:otherwise>
						</c:choose>
					</tr>

					<!-- member목록 리스트 -->
					<tbody class="memberListTable" style="display:none;">
						<tr style="border: 1px solid black" >
							<td style="border: 1px solid black; text-align: center">t_id</td>
							<td style="border: 1px solid black; text-align: center">u_id</td>
							<td style="border: 1px solid black; text-align: center">email</td>
							<td style="border: 1px solid black; text-align: center">nickname</td>
							<td style="border: 1px solid black; text-align: center">auth</td>
						</tr>
					 	<c:forEach items="${memberList}" var="memberList" varStatus="status">
					 		<c:if test="${ memberList.t_id == teamList.t_id}">
							<tr class="memberList" style="border: 1px solid black">
								<td class="t_id" style="border: 1px solid black">${memberList.t_id}</td>
								<td class="u_id" style="border: 1px solid black">${memberList.u_id}</td>
								<td class="email" style="border: 1px solid black">${memberList.email}</td>
								<td class="nickname" style="border: 1px solid black">${memberList.nickname}</td>
								<td class="auth" style="border: 1px solid black">${memberList.auth}</td>
								<c:choose>
									<c:when test="${teamList.auth==0 || teamList.auth==1 }">
										<td><input type="button" class="modifyAuthBtn" name="modifyAuthBtn" value="권한수정" /></td>
										<td><input type="button" class="deleteMemberBtn" name="deleteMemberBtn" value="삭제" /></td>
									</c:when>
								</c:choose>
							</tr>
							</c:if>
						</c:forEach> 
					</tbody>
			</c:forEach>
		</tbody>	
	</table>
	<!-- 팀이름수정 모달 창 -->
	<div id="teamModalModifyDiv" style="display: none">
		<div>
			수정할 팀 이름을 입력하세요. <input type="text" id="modalTextTxt"
				name="modalTextTxt" maxlength="20" />
		</div>
		<div>
			<button type="button" id="teamModalModifyBtn">수정</button>
			<button type="button" class="modalCancleBtn">취소</button>
		</div>
	</div>

	<!-- 팀삭제 모달 창 -->
	<div id="teamModalDeleteDiv" style="display: none">
		<div>정말로 삭제 하시겠습니까?</div>
		<div>
			<button type="button" id="teamModalDeleteBtn">삭제</button>
			<button type="button" class="modalCancleBtn">취소</button>
		</div>
	</div>
		<!-- 멤버수권한정 모달 창 -->
	<div id="memberModalModifyDiv" style="display: none">
		<div>
			수정할 권한을 클릭하십시오.
			<button type="button" id="memberAuthModify2Btn">팀원</button>
			<button type="button" id="memberAuthModify1Btn">관리자</button>
		</div>
		<div>
			<button type="button" class="modalCancleBtn">취소</button>
		</div>
	</div>

	<!-- 멤버 삭제 모달 창 -->
	<div id="memberModalDeleteDiv" style="display: none">
		<div>정말로 팀원을 삭제 하시겠습니까?</div>
		<div>
			<button type="button" id="memberModalDeleteBtn">삭제</button>
			<button type="button" class="modalCancleBtn">취소</button>
		</div>
	</div>
</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<script>
$(document).ready(function() {
	var modalState = 0; //모달창이 열려있는지 닫혀있는지 판단하는 변수
	var memberlistState = 0;
	var T_id = null; 
	var U_id = null;
	var Cdate = null;
	
	//모달창을 모두 닫는 함수
	 function hideModalDiv(){
		$('#teamModalModifyDiv').hide();
		$('#teamModalDeleteDiv').hide();
		$('#memberModalModifyDiv').hide();
		$('#memberModalDeleteDiv').hide();
		modalStatue=0;
	}
	 
	//팀목록에서 수정버튼(.modifyTeamBtn)을 눌렀을 때
	$(document).on('click','.modifyTeamBtn', function() {
		if (modalState == 1) {
			hideModalDiv();
		}
		
		//console.log("clicked.");
		
		$('#teamModalModifyDiv').show();
		modalState = 1;

		var title = $(this).parents('tr').children('.name').html();
		$('#modalTextTxt').val(title);

		T_id = $(this).parents('tr').children('.t_id').html();
		//console.log(T_id);
		U_id = $(this).parents('tr').children('.u_id').html();
		//console.log(U_id);
		Cdate = $(this).parents('tr').children('.cdate').html();
		//console.log(Cdate);
	});

	//팀 목록에서 삭제버튼(.deleteTeamBtn)을 눌렀을 때
	$(document).on('click','.deleteTeamBtn',function() {
		if (modalState == 1) {
			hideModalDiv();
		}
		
		//console.log("clicked.");
		
		$('#teamModalDeleteDiv').show();
		modalState = 1;

		T_id = $(this).parents('tr').children('.t_id').html();
		//console.log(T_id);
		U_id = $(this).parents('tr').children('.u_id').html();
		//console.log(U_id);
	});

	//modal창에서 취소버튼(.modalCancleBtn)을 눌렀을 때
	$(document).on('click', '.modalCancleBtn', function() {
		//console.log("clicked.");

		if (modalState == 1) {
			hideModalDiv();
		}
	});

	//팀 삭제 delete modal창에서 삭제버튼(#modalDeleteBtn)을 눌렀을 때
	$(document).on('click','#teamModalDeleteBtn',function() {
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
				u_id : U_id
			}),
			success : function(result) {
				console.log(result);
				location.reload();
				
				$('#teamModalDeleteDiv').hide();
				alert("삭제되었습니다.");

				//console.log("str success");
				//console.log("str list success");
				//console.log("checked 2");

			},
			error : function() {
				console.log("error");
			}
		});
	});

	//팀 목록 modify modal창에서 수정버튼(#modalModifyBtn)을 눌렀을 때
	$(document).on('click','#teamModalModifyBtn',function() {
		var teamName = $('#modalTextTxt').val();
		//console.log(teamName);
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
				location.reload();//새로고침
				$('#teamModalModifyDiv').hide();alert("수정되었습니다.");
			},
			error : function() {
				console.log("error");
			}
		});
	});
	
	//멤버보기 버튼을 누를 경우
	$(document).on('click','.selectMemberBtn',function(){
		//console.log(memberlistState);
		
		var memberlist = $(this).parents('tbody').next();
		//console.log("memberlist");
		//console.log(memberlist);
		
		if(memberlistState == 0){
			/* $('.memberListTable').show(); */
			$(memberlist).show();
			memberlistState=1;
			//console.log(memberlistState);
		}else if(memberlistState == 1){
			/* $('.memberListTable').hide(); */
			$(memberlist).hide();
			memberlistState=0;
			//console.log(memberlistState);
		}
	});
	
	//멤버리스트에서 권한수정 버튼을 눌렀을 경우
	$(document).on('click','.modifyAuthBtn',function(){
		T_id = $(this).parents('tr').children('.t_id').html();
		//console.log(T_id);
		U_id = $(this).parents('tr').children('.u_id').html();
		//console.log(U_id);
		
		if (modalState == 1) {
			hideModalDiv();
		}
		
		//console.log("clicked.");
		
		$('#memberModalModifyDiv').show();
		modalState = 1;

	});
	
	//멤버리스트에서 삭제버튼을 눌렀을 경우
	$(document).on('click','.deleteMemberBtn',function(){
		T_id = $(this).parents('tr').children('.t_id').html();
		console.log(T_id);
		U_id = $(this).parents('tr').children('.u_id').html();
		console.log(U_id);
		
		if (modalState == 1) {
			hideModalDiv();
		}
		
		//console.log("clicked.");
		
		$('#memberModalDeleteDiv').show();
		modalState = 1;

	});
	
	//멤버 삭제 delete modal창에서 삭제버튼(#modalDeleteBtn)을 눌렀을 때
	$(document).on('click','#memberModalDeleteBtn',function() {
		console.log('/teamList/' + T_id);
		$.ajax({
			url:'teamList/' + T_id,
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
				//console.log(result);
				location.reload();
				
				$('#memberModalDeleteBtn').hide();
				alert("삭제되었습니다.");
			},
			error : function() {
				console.log("error");
			}
		});
	});
	
	//멤버 권한 수정 modify modal창에서 '팀원'을 눌렀을 때
	$(document).on('click','#memberAuthModify2Btn',function() {
		//console.log(u_id);
		$.ajax({
			url:'teamList/'+T_id,
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
				location.reload();//새로고침
				$('#teamModalModifyDiv').hide();
				alert("수정되었습니다.");
			},
			error : function() {
				console.log("error");
			}
		});
	});
	
	//멤버 권한 수정 modify modal창에서 '관리자'을 눌렀을 때
	$(document).on('click','#memberAuthModify1Btn',function() {
		//console.log(u_id);
		$.ajax({
			url:'teamList/'+T_id,
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
				location.reload();//새로고침
				$('#teamModalModifyDiv').hide();
				alert("수정되었습니다.");
			},
			error : function() {
				console.log("error");
			}
		});
	});
});
</script>
</html>