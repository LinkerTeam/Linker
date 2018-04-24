<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LINKER</title>
<!-- CSS -->
<link href="/resources/css/common.css" type="text/css" rel="stylesheet" />
<link href="/resources/css/header.css?ver=111" type="text/css" rel="stylesheet" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<!-- fontawesome -->
<script defer src="https://use.fontawesome.com/releases/v5.0.8/js/all.js"></script>
</head>
 
	<body>
		<!--header-->
		<header id="header">
		    <!--로고부분-->
		    <div class="header-background">
		    	<a href="http://localhost:9090/main" class="logo-link">
		        	<span class="logo-full"><img src="/resources/image/logo.png" width="100" /></span>
		        </a>
		        
			    <!--오른쪽메뉴 설정단추-->
			    <span class="rtMenu-button" style="cursor:pointer">
			        <img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" class="header-profile" alt="프로필 사진" />
			    </span>
		    </div>
		    
		    <!--헤더 검색창-->
		    <div class="header-search">
		        <form>
		            <input type="text" id="search" />
		            <button type="submit"><span><i class="fas fa-search"></i></span></button>
		        </form>
		    </div>
		</header>
	</body>
	
	<script>
	
		/* 헤더 검색창 | blur될 경우 입력한 내용 초기화 */
		$("#search").on("blur", function(){
			$(".header-search").children("form").children("button").css("left", "140px");
			$(this).val("");
		});
		$("#search").on("focus", function(){
			$(".header-search").children("form").children("button").css("transition", "0.5s");
			$(".header-search").children("form").children("button").css("left", "220px");
		});	
		
		
		
		/* 오른쪽 프로필 사진 클릭하면 menu 출력/숨기기 */
		$(".rtMenu-button").click(function(){
			if($(".my-aside").hasClass("is-hidden"))
				$(".my-aside").removeClass("is-hidden");
			else
				$(".my-aside").addClass("is-hidden");
		});
		
		/* 오른쪽 메뉴 이외의 영역을 클릭하면 메뉴 닫기 */
		$(document).click(function(e){
			if(!($(e.target).hasClass("header-profile")) && !($(e.target).hasClass("header-menu"))) 
				$(".my-aside").addClass("is-hidden");
		});
		
	</script>

</html>