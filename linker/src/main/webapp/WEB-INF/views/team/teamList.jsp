<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Linker</title>
<link href="/resources/css/team/team.css?ver=222" type="text/css" rel="stylesheet" />
</head>
<body>
	<%@include file="../header.jsp"%>

	<!-- content 시작 -->
	<div class="content">
		<!-- wrapContent 시작 -->
		<div class="wrapContent">
			<%@include file="teamShowMenu.jsp"%>
			<div class="smallContent" id="listContent">
				<!-- 팀 목록 컨텐트 시작 -->
				<div class="titleContent">
					<!-- 팀 목록 제목  -->
					<div class="title">
						<h3>Team List</h3>
					</div>
					<!-- 팀 멤버 검색  -->
					<div class="title">
						<i class="fas fa-search"></i> <input type="text"
							name="memberSearch" id="memberSearch"
							placeholder=" Search Member.." />
					</div>
					<!-- 팀 추가 버튼  -->
					<div class="title">
						<input type="button" class="addTeam" id="addTeamBtn"
							value="Add Team" />
					</div>
				</div>
				<!-- 팀 목록 작은 컨텐트 -->
				<div class="category teamCategory">
					<div class="t_id" style="display: none;">t_id</div>
					<div class="name">이름</div>
					<div class="cdate">생성일자</div>
					<div class="auth">권한</div>
				</div>
				<div class="listBoxBody">
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
					<input type="button" id="teamModalAddBtn" value="확인" /> <input
						type="button" class="modalCancleBtn" name="cancle" value="취소" />
				</div>
			</div>
		</div>

		<!-- 팀이름수정 모달 창 -->
		<div class="modal" id="teamModalModifyDiv">
			<div class="modalContent">
				<div>
					<p>수정할 팀 이름을 입력하세요.</p>
					<input type="text" id="modalTextTxt" name="modalTextTxt" maxlength="20" />
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
			<div class="modalContent">
				<p>수정할 권한을 클릭하십시오.</p>
				<input type="button" id="memberAuthModify2Btn" value="팀원" /> 
				<input type="button" id="memberAuthModify1Btn" value="관리자" /> 
				<input type="button" class="modalCancleBtn" value="취소" />
			</div>
		</div>

		<!-- 멤버 삭제 모달 창 -->
		<div class="modal" id="memberModalDeleteDiv">
			<div class="modalContent">
				<div>정말로 팀원을 삭제 하시겠습니까?</div>
				<h2>Remove from team</h2>
				<p>Remove all access to the team. The member will remain on all
					their boards in this team. They will receive a notification."</p>
				<div>
					<input type="button" id="memberModalDeleteBtn" value="삭제" /> 
					<input type="button" class="modalCancleBtn" value="취소" />
				</div>
			</div>
		</div>

		<!--  한 명의 멤버 추가버튼을 누를 때 모달창 -->
		<div class="modal" id="addMemberModal">
			<div class="modalContent">
				Email: <input type="text" id="memberTxt" name="memberTxt" placeholder="e.g. linker@gmail.com">
				<p>Search for a person in Trello by name or email address, or
					enter an email address to invite someone new.</p>
				<input type="submit" id="memberModalAddBtn" value="Add To Team.." />
				<input type="button" class="modalCancleBtn" name="cancle" value="취소" />
			</div>
		</div>
		<!-- 모달창 끝 -->
	</div>
	<!-- content 끝 -->
</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
<script>
	var U_ID = ${u_id};//유저 id
	var EMAIL = '${email}';//유저 email
	var NICKNAME = '${nickname}';//유저 nickname
	var T_id = null; //t_id 변수
	var U_id = null; //u_id 변수
	var sT_id = null; //T_id의 선택자 변수
	var sU_id = null; //U_id의 선택자 변수
	var Cdate = null; //cdate 변수
	var selectedMemberName = null; //선택된 팀원 이름. option에서 소유자 권한 양도받을 팀원 이름. 
	var title = null; //팀 이름 변수(팀 이름 수정 버튼을 누를 경우, 텍스트 창에 팀 이름이 뜸)
</script>
<script type="text/javascript" src="/resources/js/team/team.js"></script>

</html>