<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- CSS -->
<link href="/resources/css/cards/cardAttach.css?ver=1" type="text/css" rel="stylesheet" />
</head>
 
<body>
	<article>
	<div class="attach">
		<div class="title-attach title">
			<i class="fas fa-paperclip"></i><strong>첨부파일</strong>
		</div>
		<!-- Drag & drop하여 파일 추가하는 box -->
		<div class="attach-content">
			<p>카드 위로 파일을 끌어다놓거나</p>
			<div class="chooseFile">여기를 눌러 파일을 선택하세요</div>
			<input class="upfileInput" type="file" value="upload" onchange="upfileInput(this)"/>
		</div>
		<!-- 첨부파일 목록이 출력되는 곳 -->
		<div class="uploadedList"></div>
		<div class="uploadedList-btn more">더 보기...</div>
		<div class="uploadedList-btn short">접기...</div>
	</div>
	</article>
	
	<script>
	
	
	</script>
</body>
</html>