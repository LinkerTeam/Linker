<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<title>회원정보 상세 페이지</title>
<style type="text/css">
*, *:after, *:before {
	/* -webkit-,-moz-등의 접두사는 특정브라우저를 따로 안정성을위해서 적어둔다.  */
	box-sizing: border-box;
}
#main {
	font-family: Dotum, sans-serif;
	font-size: 12px;
	position: relative;
	z-index: 20;
	max-width: 954px;
	height: 100%;
	margin: 0px auto;
}
#contain {
	position: relative;
	padding: 32px 51px 95px;
}
#content {
	height: 730px;
	line-height: 14px;
	width: 550px;
	margin: 30px auto;
	padding: 32px 29px 32px;
	border: 1px solid #dadada;
	background: #fff;
	border-radius: 5px;
}
.btn {
	margin-top: 20px;
	width: 400px;
	border: none;
	outline: none;
	height: 40px;
	background: #FA5883;
	color: #fff;
	font-size: 18px;
	cursor: pointer;
	width: 100%;
	border-radius: 5px;
}
.head {
	font-size: 20px;
	margin-bottom: 70px;
	text-align: center;
}
.inputtext {
	font-size: 20px;
	margin-bottom: 30px;
}
#holder {
	height: 200px;
}
.content input[type="submit"] {
	margin-top: 50px;
}
#checkMsg {
	height: 25px;
}
#table {
	height: 400px;
	border-top: 1px solid #444444;
	border-collapse: collapse;
}
#table td {
	border-bottom: 1px solid #444444;
	text-align: left;
	padding-top: 20px;
	padding-left: 5px;
	margin-right: 50px;
}
#holder {
	margin-top: 20px;
}
#path {
	width: 150px;
}
#checkbtn{
	width: 70px;
	border: none;
	outline: none;
	height: 40px;
	background: #FA5883;
	color: #fff;
	font-size: 13px;
	cursor: pointer;	
	border-radius: 5px;
}
 #nickname{
    height: 30px;
 }
.file_input label {
    position:relative;
    cursor:pointer;
    display:inline-block;
    vertical-align:middle;
    overflow:hidden;
    width:250px;
    height:30px;
    background:#FA5883;
    color:#fff;
    text-align:center;
    line-height:30px;
    border-radius: 5px;
}
.file_input label input {
    position:absolute;
    width:0;
    height:0;
    overflow:hidden;
}
.secessionSpan{
	padding-top: 15px;
	text-align: center;
}
</style>
</head>
<body>

	<%@include file="../header.jsp"%>
	<%@include file="../mainMenu.jsp"%>

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

							<tr>
								<td><p class="inputtext">프로필사진</p></td>
								<td>
									<div class="file_input">
										<p>
											<label> 프로필 사진올리기 <input type="file"
												name="profileName" class='uploadprofile' id='file'
												accept=".jpg, .jpge, .png, .gif">

											</label>
										<p id="status"></p>
										<div id='holder'></div>
										<!-- accept=".jpg,png "  특정파일만 올릴수있게 파일 업로드시 설정해줌 -->
								</td>

								</p>
								</div>
							</tr>

							<%-- 이미지 불러오기!!  --%>

						</table>
						<p>
							<input type="submit" value="수정" class="btn">
						</p>
						<p>
							<input type="reset" value="삭제" id="btnDelete" class="btn">
						</p>



					</form>
					<div class="secessionSpan">Linker를 더 이상 이용하지 않는다면 
					<a href="http://localhost:9090/user/secessionUser" class="secession">회원탈퇴 바로가기▶</a>
				    </div>
				</div>
			</div>
		</div>
	</div>
	<script>
		var file = document.getElementById('file').value;
		console.log("${vo.nickname}");
		console.log(file);

		function subcheck() {

			var nickname = document.getElementById('nickname').value;

			if (nickname == null || nickname == '') {
				alert('닉네임을 비울수 없습니다.');
				document.getElementById('nickname').focus();
				return false;
			}
			if (!(nickname.length > 2 && nickname.length < 15)) {
				alert('닉네임은 2자이상 16자이내에서 작성해주세요');
				document.getElementById('nickname').focus();
				return false;
			}

			//기존 닉네임을 바꾸지 않았을떄 체크해줌. 
			if ("${vo.nickname}" != nickname) {
				//닉네임 중복환인 안눌렀을떄
				if (document.getElementById("checkMsg").innerHTML == "") {
					alert("닉네임을 중복확인 해주세요");
					return false;
				}

				//닉네임이 중복돼었을때 빨간색이면 중복이라고 나옴 
				if (document.getElementById("nickcheck").style.color == 'red') {
					alert("닉네임이 중복되었습니다 다른 닉네임을 적어주세요");
					return false;
				}
			}
			return true;
		}

		window.onload = function() {
			//파일 업로드시 이미지 미리보기 
			var upload = document.getElementsByClassName('uploadprofile')[0];
			var holder = document.getElementById('holder');
			var state = document.getElementById('status');

			upload.onchange = function(e) {

				e.preventDefault(); //기존 이벤트를 제거한다
				//업로드된 이미지 가져와서 변수에 넣기
				var file = upload.files[0];
				var reader = new FileReader();
				reader.onload = function(event) {
					var img = new Image();
					img.src = event.target.result;
					// note: no onload required since we've got the dataurl...I think! :)
					console.log(img.width);
					console.log(img.height);
					//이미지 크기가 너무크면 그 이미지를 줄여서 보여주는 조건
					if (img.width > 56 && img.height > 56 || img.width == 0
							&& img.height == 0) { // holder width
						img.width = 200;
						img.height = 150;
					}
					//holder값을 삭제후에 자식으로 이미지를 넣어준다.
					holder.innerHTML = "";
					holder.appendChild(img);
				};
				reader.readAsDataURL(file);

				return false;
			};

			//이미지 타입체크
			function checkImageType(fileName) {
				var pattern = /jpg$|gif$|png$|jpeg$/i;
				return fileName.match(pattern);
			}

			//닉네임 중복검사 하는 매소드 버튼을 눌러서 중복확인검사
			$('#checkbtn')
					.on(
							'click',
							function() {
								//POST 형식으로 FORM 보내기 작성 $.ajax형식으로 보내기
								$
										.ajax({
											type : 'POST', // POST 방식
											url : '/user/checkSignup', //보내는 form action을 지정해줌
											data : {
												"nickname" : $('#nickname')
														.val()
											// 데이터를 지정해줌 nickname의 값을 받아와서 nickname에 넣어줌 매개변수 request.getparameter("nickname")을 여기서 가져옴
											},
											headers : {
												//"Content-Type" : "application/json",
												"X-HTTP-Method-Override" : "POST"
											},
											success : function(data) { //요청을 성공시에 함수를 실행함 data는 스프링에서 값을 받아옴
												// 0이면 닉네임중복아니고 0이외에 숫자는 모두 중복임 닉네임은 유니크값이라 1개라도 나오면 닉네임 존재한다는 얘기
												if ($.trim(data) == 0) {
													$('#checkMsg')
															.html(
																	'<p id="check" style="color:blue">사용가능한 닉네임입니다.</p>');
												} else {
													$('#checkMsg')
															.html(
																	'<p id="check" style="color:red">사용불가능한 닉네임입니다.</p>');
												}
											}
										}); //end ajax    
							}); //end on

			function checkImageType(fileName) {
				// i는 대.소 문자의 구분없음
				var pattern = /jpg$|gif$|png$|jpeg$/i;
				return fileName.match(pattern);
			}
		}
	</script>
</body>
</html>
