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
		<!-- wrap-content 시작 -->
		<div class="wrap-content">
			<%-- <%@include file="teamShowMenu.jsp"%> --%>
			<div class="small-content" id="list-content">
				<!-- 팀 목록 컨텐트 시작 -->
				<div class="title-content">
					<!-- 팀 목록 제목  -->
					<div class="title">
						<h3>Team List</h3>
					</div>
					<!-- 팀 멤버 검색  -->
					<div class="title">
						<i class="fas fa-search"></i> <input type="text"
							name="memberSearch" id="member-search"
							placeholder=" Search Member.." />
					</div>
					<!-- 팀 추가 버튼  -->
					<div class="title">
						<input type="button" class="add-team" id="add-team-btn"
							value="Add Team" />
					</div>
				</div>
				<!-- 팀 목록 작은 컨텐트 -->
				<div class="category team-category">
					<div class="t_id" style="display: none;">t_id</div>
					<div class="name">이름</div>
					<div class="cdate">생성일자</div>
					<div class="auth">권한</div>
				</div>
				<div class="list-box-body">
					<!--  팀 목록 동적생성 -->
				</div>
			</div>
		</div>
		<!-- 한 팀의 정보 끝 -->

		<!-- 팀 추가 모달창 -->
		<div class="modal" id="team-modal-add-div">
			<div class="modal-content">
				<div>
					<label for="name">팀이름: </label> <input type="text" id="name"
						name="name" placeholder="write team name here." />
				</div>
				<div>
					<input type="button" id="team-modal-add-btn" value="확인" /> <input
						type="button" class="modal-cancle-btn" name="cancle" value="취소" />
				</div>
			</div>
		</div>

		<!-- 팀이름수정 모달 창 -->
		<div class="modal" id="team-modal-modify-div">
			<div class="modal-content">
				<div>
					<p>수정할 팀 이름을 입력하세요.</p>
					이름 : <input type="text" id="modal-text-txt" name="modalTextTxt" maxlength="20" />
				</div>
				<div>
					<input type="button" id="team-modal-modify-btn" value="수정" /> 
					<input type="button" class="modal-cancle-btn" value="취소" />
				</div>
			</div>
		</div>

		<!--팀삭제 모달 창-->
		<div class="modal" id="team-modal-delete-div">
			<div class="modal-content">
				<p>정말로 삭제 하시겠습니까?</p>
				<div>
					<input type="button" id="team-modal-delete-btn" value="삭제" /> 
					<input type="button" class="modal-cancle-btn" value="취소" />
				</div>
			</div>
		</div>

		<!-- 소유자권한양도 모달 창 -->
		<div class="modal" id="member-modal-transfer-div">
			<!-- jquery에서 생성 -->
		</div>

		<!-- 멤버권한수정 모달 창 -->
		<div class="modal" id="member-modal-modify-div">
			<div class="modal-content">
				<p>수정할 권한을 클릭하십시오.</p>
				<input type="button" id="member-auth-modify-2-btn" value="팀원" /> 
				<input type="button" id="member-auth-modify-1-btn" value="관리자" /> 
				<input type="button" class="modal-cancle-btn" value="취소" />
			</div>
		</div>

		<!-- 멤버 삭제 모달 창 -->
		<div class="modal" id="member-modal-delete-div">
			<div class="modal-content">
				<div>정말로 팀원을 탈퇴 하시겠습니까?</div>
				<div>
					<input type="button" id="member-modal-delete-btn" value="삭제" /> 
					<input type="button" class="modal-cancle-btn" value="취소" />
				</div>
			</div>
		</div>

		<!--  한 명의 멤버 추가버튼을 누를 때 모달창 -->
		<div class="modal" id="add-member-modal">
			<div class="modal-content">
				<p>새로운 사람을 초대 할 이메일 주소를 입력하십시오.</p>
				Email: <input type="text" id="member-txt" name="member-txt" placeholder="e.g. linker@gmail.com"><br>
				<input type="submit" id="member-modal-add-btn" value="Add To Team.." />
				<input type="button" class="modal-cancle-btn" name="cancle" value="취소" />
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