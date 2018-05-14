<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="/resources/css/user/userModify.css" type="text/css" rel="stylesheet" /> 
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>회원정보 상세 페이지</title>
</head>
<body>

	<%@include file="../header.jsp"%>
	<%@include file="../closeBoard.jsp"%>

	<div class="content">

		<div id="main">
			<div id="contain">
				<div id="content">
					<h2 class="head">회원정보 수정</h2>

					<!-- 데이터를 전송시에는  method="post" enctype="Multipart/form-data" 형식이여야함  사진, 동영상 등 글자가 아닌 파일은 모두 Multipart/form-data 형식의 데이터 데이터를 여러조각으로 나누어서 전송  -->
					<form name="form1" method="post" enctype="multipart/form-data"
						action="/user/userModify" onsubmit='return subcheck();'>
						<table id="table" border="1" width="410px" height="400px">
							<!-- 테이블에서 tr은 줄 td는 각 행 -->

							<tr>
								<td id="path"><p class="inputtext">Email</p></td>
								<td><p class="inputtext">${vo.email}</p></td>
							</tr>

							<tr>
								<td><p class="inputtext">닉네임
									<p></td>
								<td><p>
										<input id="nickname" name="nickname" value="${vo.nickname}">
										<span><input type="button" value="중복확인" id="checkbtn"
											class="btn-default" /></span>
									</p>
									<div id="checkMsg"></div></td>
							</tr>
							<!-- 누락된 부분 -->
							<tr class="lasttr">
								<td><p class="inputtext">프로필사진</p></td>
								<td>
									<div class="file_input">
										<p>
											<label>사진 올리기 <input type="file" name="profileName" class='uploadprofile' id='file' accept=".jpg, .jpge, .png, .gif">
											</label>
										<p id="status"></p>
										<div id='holder'>
										 <img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" class="profile" alt="프로필 사진" width="200" height="170" />
										<button class="delete-profile">기본이미지로 변경</button>
										</div>
										<!-- accept=".jpg, .png "  특정파일만 올릴수있게 파일 업로드시 사용자설정해줌 -->
										<div><span class="war-message">프로필 사진을 올릴 시 이미지 파일만 업로드 가능하며  용량은 최대 1MB까지 가능합니다.</span></div>
								</div>
								</td>
										</p>
							</tr>
							<%-- 이미지 불러오기!!  --%>
						</table>
						<p>
							<input type="submit" value="수정" class="btn">
						</p>
						<p>
							<input type="button" value="취소" id="btnDelete" class="btn">
						</p>

					</form>
					<div class="secessionSpan">
						Linker를 더 이상 이용하지 않는다면 <a
							href="http://localhost:9090/user/secessionUser" class="secession">회원탈퇴
							바로가기▶</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script src="/resources/js/user/userModify.js"></script>
</html>
