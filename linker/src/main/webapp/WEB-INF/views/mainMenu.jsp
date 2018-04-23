<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- CSS -->
<link href="/resources/css/mainMenu.css?ver=11" type="text/css" rel="stylesheet" />
</head>

<body>
	<aside class="my-aside is-hidden">
		<div class="my-aside-close">&times;</div>
		<div class="my-aside-info">
		    <div class="my-aside-info-text" style="cursor:pointer">
				<p>${login.nickname}<br/>(${login.email})</p>
			</div>
			<div class="my-aside-info-img" style="cursor:pointer">
				<img src="https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate${login.profile}" alt="프로필 사진" />
			</div>
		</div>
		<!--메뉴-->
		<div class="my-aside-menu">
			<div class="setting-menu user-modify">
				<a href="http://localhost:9090/user/userModify">회원정보수정</a>
			</div>
			<div class="setting-menu team-modify">
				<a href="http://localhost:9090/main/team">팀 정보 수정</a>
			</div>
			<div class="setting-menu pwd-modify">
				<a href="http://localhost:9090/user/passwordchange">비밀번호변경</a>
			</div>
			<div class="setting-menu board-status-modify">
				<a href="#" class="closeBoard">종료 프로젝트</a>
			</div>
			<div class="setting-menu logout">
				<a href="http://localhost:9090/user/logout" class="logoutBtn">로그아웃</a>
			</div>
			
		</div>
	</aside>
	
	
	<script>
	    
		/* 오른쪽 프로필 메뉴의 닫기 버튼 */
		$(".my-aside-close").click(function(){
			$(".my-aside").addClass("is-hidden");
		});
	
	
		
		
		
		
		
	    /* 송성은님 코드 | close board list 모달창에 관한 이벤트 */
	    		
		//모달창 띄우기
		$(".project-list").on("click",function(){	
			$('.list-modal').addClass('is-visible');		
			
			$.ajax({
				type:"GET",
				url:"/main/projectlist",
				success : function(data){
					if(data != null){
					console.log(data);
					$('.content-list').html("");
					for(var i = 0; i < data.length ; i++){
					var str ="<div class='list-li'><a href='http://localhost:9090/board/"
					+data[i].t_id+
					"/"
					+data[i].id+"'>"
					+data[i].title+"</a>"
					+"<button class='preload' p='"+data[i].id+"' u='"+data[i].u_id+"' t='"+data[i].t_id+"'>re-load</button>"
					+"<button class='pdelete' p='"+data[i].id+"' u='"+data[i].u_id+"'>delete</button></div>"
					$('.content-list').append(str);
					}
				
					}
					
				},
				error : function(){
					alert("통신의 오류가 발생했습니다.");
				}
			});   
		})
		//모달창 닫기
		$(".list-modal").on("click",function(e){
			if($(e.target).hasClass("list-modal")){
				$(".list-modal").removeClass("is-visible");		
			}
		})
		

		 $(".content-list").on("click", ".preload", function(){
			u_id = $(this).attr("u");
			p_id = $(this).attr("p");
			var ps_id = 1;
			var parent = $(this).parent();

		    	$.ajax({
		    		type : "put",
		    		url : "/main/" + p_id + "/" + u_id,
		    		headers : {
		    			"Content-Type" : "application/json",
		    			"X-HTTP-Method-Override" : "PUT"
		    		},	
		    		data : JSON.stringify({ps_id : ps_id}),
		    		dataType : "text", 
		    		success : function(result) {
		    			if(result === "SUCCESS"){	
		    				if(ps_id == 1){
		    				
		    					parent.html("");
		    				}
		    			};//if
		    		},
		    		error : function() {
		    			alert("에러가 발생했습니다.");
		    		}
		    	});//ajax
		});
		
		$(".content-list").on("click", ".pdelete", function(){
			u_id = $(this).attr("u");
			p_id = $(this).attr("p");
			ps_id = 3;
			var parent = $(this).parent();
			
			if(confirm("모든 카드리스트와 카드가 함께 삭제됩니다. \n삭제된 보드는 복구가 불가능합니다. \n그래도 삭제하시겠습니까?") !== true){
				return; //취소를 누를 경우 ajax처리로 넘어가지 않고 return				
			}
			
			$.ajax({
	    		type : "put",
	    		url : "/main/" + p_id + "/" + u_id,
	    		headers : {
	    			"Content-Type" : "application/json",
	    			"X-HTTP-Method-Override" : "PUT"
	    		},	
	    		data : JSON.stringify({ps_id : ps_id}),
	    		dataType : "text", 
	    		success : function(result) {
	    			if(result === "SUCCESS"){	
	    				if(ps_id == 3){
	    					parent.html("");
	    				}
	    			};//if
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
		});
		
		
	</script>
</body>
</html>