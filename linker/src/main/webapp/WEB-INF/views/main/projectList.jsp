<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="/resources/css/project/projectList.css" type="text/css" rel="stylesheet" />
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title></title>

</head>
<body>
	<%@include file="../header.jsp"%>
	<%@include file="../closeBoard.jsp"%>

	<div class="content">
		<div class="wrapper">
			<a href="http://localhost:9090/board/mycard" class="my-favo">즐겨찾기</a>
			<!-- 즐겨찾기 목록  -->
			<div class="main-favorite"></div>
			<!-- Projects In a Team -->
			<!-- 팀 정보 -->
			<c:forEach items="${team}" var="teamList">
				<div class="projectBox">
					<div class="teamInfo">
						<i class="fas fa-users"></i> <span class="title">${teamList.name}</span>
						<a class="tid">${teamList.t_id}</a> <a class="uid">${teamList.u_id}</a>
						<a class="memberbtn">팀멤버</a>
					</div>
 
					<!-- 진행 프로젝트 목록 -->
					<c:forEach items="${result}" var="projectList">
						<!-- 팀의 id와 프로젝트의 t_id가 같은경우에만 출력  -->
						<c:if test="${ teamList.t_id == projectList.t_id}">
							<!-- 상태코드를 확인해서 1인경우 진행중인 상태만 나오기 위해서 -->
							<c:if test="${projectList.ps_id ==1}">
								<ul class="projects">
									<li><a
										href="http://localhost:9090/board/${teamList.t_id}/${projectList.id}"
										class="pj-url""> <span class="name">${projectList.title}</span>
											<!-- 즐겨찾기 상태 확인  1인경우 즐겨찾기 --> <c:choose>
												<c:when test="${projectList.favorite == 0}">
													<span><i class="far fa-star add-favo"
														id='${projectList.id}' data-p_id="${projectList.id}"
														data-t_id="t${projectList.t_id}"></i></span>
												</c:when>
												<c:otherwise>
													<span><i class="fas fa-star delete-favo"
														id='${projectList.id}' data-p_id="${projectList.id}"
														data-t_id="t${projectList.t_id}"></i></span>
												</c:otherwise>
											</c:choose>
									</a></li>
								</ul>
							</c:if>
						</c:if>
					</c:forEach>

					<!-- 프로젝트 추가 버튼 -->
					<span class="addProject"><button class="createProjectBtn"
							type="button">프로젝트 추가하기</button></span>
				</div>
			</c:forEach>

			<!-- 팀추가  -->
			<div class="teaminsert">
				<a class="teaminsert-a" href="#"> <span>새로운 팀 추가하기</span>
				</a>
			</div>

			<!--  팀생성 모달창   -->
			<div class="create-modal">
				<div class="modal-contents">
					<div class="headtitle">
						<span class="pop-over-header-title">팀 추가</span> <a href="#"
							class="connectmodal"></a>
					</div>
					<div class="content-text">
						<form name="form1" action="main/teamcreate" method="post"
							class="teamform">
							<input type="input" name="name" class="team-title" value=""
								placeholder="팀 이름을 입력하세요" maxlength="20">
							<button class="teambtn disabled" disabled="disabled">추가</button>
						</form>
						<span class="tclosebtn"><i class="fas fa-times"></i></span>
					</div>
				</div>
			</div>

			<!-- 팀 멤버 모달창 -->
			<div class="member-modal">
				<div class="member-content">
					<div class="popupCardClose">×</div>
					<h1 class="member-head"></h1>
					<div class="member-list"></div>
				</div>
			</div>
		</div>
		<%@include file="footer.jsp"%>
	</div>

	<!-- /프로젝트 본문 -->

    <!-- 프로젝트 생성 모달창 -->
    <!-- 띄우기 | is-visible -->
    <div class="project-modal">
        <div class="createProjectBox">
            <form class="createProjectForm">
                <label for="add-prj" class="hidden-txt">프로젝트 이름을 입력하세요</label>
                <input id="add-prj" class="projectNameInput" placeholder="프로젝트 이름을 입력하세요" maxlength="20" onkeydown="enterPress(event);" value="">
                <button class="registProjectBtn disabled" disabled type="button">추가</button>
            </form>
            <span class="closeBtn"><i class="fas fa-times"></i></span>
        </div>
    </div>
    <!-- /프로젝트 생성 모달창 -->

</body>
<script>

</script>
<script src="/resources/js/main/project.js"></script>
</body>
</html>