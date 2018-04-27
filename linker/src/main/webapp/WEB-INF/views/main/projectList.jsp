<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">


    <link rel="stylesheet" href="/resources/css/project/projectList.css?ver=657" type="text/css" rel="stylesheet" />
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title></title>

</head>
<body>
	<%@include file="../header.jsp"%>
	<%@include file="../mainMenu.jsp"%>
	<%@include file="../closeBoard.jsp"%>

	<div class="content">

		<div class="main-favorite"></div>
		<!-- Projects In a Team -->
		<!-- 팀 정보 -->
		  <c:forEach items="${team}" var="teamList">
			<div class="projectBox">
				<div class="teamInfo">
					<i class="fas fa-users"></i> <span class="title">${teamList.name}</span>
					<a class="tid">${teamList.t_id}</a>
					<a class="uid">${teamList.u_id}</a>
					<a class="memberbtn">팀멤버</a>
				</div>
				<!-- 진행 프로젝트 목록 -->

				<c:forEach items="${result}" var="projectList">
					<c:if test="${ teamList.t_id == projectList.t_id}">
						<c:if test="${projectList.ps_id ==1}">
							<ul class="projects">
								<li><a
									href="http://localhost:9090/board/${teamList.t_id}/${projectList.id}" class="pj-url" "><span
										class="name">${projectList.title}</span>
										<c:choose>
											    <c:when test="${projectList.favorite == 0}">
											      <span ><i class="far fa-star add-favo" id='${projectList.id}' p_id="${projectList.id}" t_id="t${projectList.t_id}"></i></span>
											    </c:when>
											    <c:otherwise>
											          <span ><i class="fas fa-star delete-favo" id='${projectList.id}' p_id="${projectList.id}" t_id="t${projectList.t_id}"></i></span>
											    </c:otherwise>
											
											
										</c:choose>
											
									</a>
								</li>
							</ul>
						</c:if>
					</c:if>
				</c:forEach> 
			

				<!-- 프로젝트 추가 버튼 -->
				<span class="addProject"><button class="createProjectBtn"
						type="button">Create new project…</button></span>
			</div>
		</c:forEach>   
		<div class="teaminsert">
			<a class="teaminsert-a" href="#"> <span>Create a new team…</span>
			</a>
		</div>

		<!--  팀생성 모달창   -->
		<div class="create-modal">
			<div class="modal-contents">
				<div class="headtitle">
					<span class="pop-over-header-title">Create Team</span> <a href="#"
						class="connectmodal"></a>
				</div>
				<div class="content-text">
					<form>
						<input type="input" class="team-title" value=""
							placeholder="team name title">
						<button class="teambtn disabled" disabled="disabled">Create</button>
					</form>
					<span class="tclosebtn"><i class="fas fa-times"></i></span>
				</div>
			</div>
		</div>
		
		<!-- 팀 멤버 모달창 -->
		<div class="member-modal">
			<div class="member-content">
				<h1 class="member-head"></h1>
				<div class="member-list">
				</div>
			</div>
		</div>
	</div>

	<!-- /프로젝트 본문 -->

    <!-- 프로젝트 생성 모달창 -->
    <!-- 띄우기 | is-visible -->
    <div class="project-modal">
        <div class="createProjectBox">
            <form class="createProjectForm">
                <label for="add-prj" class="hidden-txt">Add project title</label>
                <input id="add-prj" class="projectNameInput" placeholder="Add project title" maxlength="20" onkeydown="enterPress(event);" value="">
                <button class="registProjectBtn disabled" disabled type="button">Create Project</button>
            </form>
            <span class="closeBtn"><i class="fas fa-times"></i></span>
        </div>
    </div>
    <!-- /프로젝트 생성 모달창 -->

</body>
<script>
 //즐겨찾기 불러오기
 favoriteList();
 
 var u_id =null;
 var t_id =null;
 //생성한 프로젝트의 부모를 넣기위해서 지정해줌 ajax시 부모를 알기위해서
 var parent =null;
 

    // 프로젝트 생성 모달창 닫기
    function closeProjectModal(){
        var modal = $('.project-modal');
        var projectName = $('.projectNameInput');
        if(modal.hasClass('is-visible')){
            projectName.val('');            // 입력필드 초기화
            projectName.trigger('input');   // 버튼 비활성화
            modal.removeClass('is-visible');
        }
    }

    // 프로젝트 추가 버튼
    $('.createProjectBtn').on('click', function(){
    	/* 프로젝트 모달창이 뜰때 그 객체의  u_id와  t_id의 값을 가져와서 변수에 저장 */
    	  u_id= $(this).parent().parent().children().eq(0).children('.uid').html();
          t_id= $(this).parent().parent().children().eq(0).children('.tid').html();
          //클릭한곳의 부모를 찾아서옴
          parent = $(this).parent().parent().children('.teamInfo');
           console.log(parent);

        $('.project-modal').addClass('is-visible');
    });

    // 프로젝트 생성 모달창 이벤트 처리
    $('.project-modal').on('click', function(event){
        if(event.target.className == $(this).attr('class'))
            closeProjectModal();
    });
    
    // 프로젝트 생성 모달창 닫기버튼
    $('.closeBtn').on('click', function(){
        closeProjectModal();
    });

    // 프로젝트 이름 입력필드
    $('.projectNameInput').on('input', function(){
        var submitBtn = $('.registProjectBtn');
        if($(this).val().length == 0){
        // 입력 내용이 없으면 등록버튼 비활성화
            submitBtn.addClass('disabled');
            submitBtn.attr('disabled', 'disabled');
        }
        else {
        // 입력 내용이 있다면 등록버튼 활성화
            if(submitBtn.hasClass('disabled')){
                submitBtn.removeClass('disabled');
                submitBtn.removeAttr('disabled');
            }
      	  }
   	 });
    
    // 프로젝트 등록버튼
    $('.registProjectBtn').on('click', function(){
    	  registProject();   
    });

    // tooltip left 좌표설정
    $('.teamMembers .tooltip').each(function(){
        var TOOLTIP_POINTER_WIDTH = 5;
        var moveToLeftPos = parseInt($(this).width()/2) - TOOLTIP_POINTER_WIDTH;
        $(this).css('marginLeft', -moveToLeftPos);
    });
    
    //엔터입력시 확인창을 누르는것
    function enterPress(key){
    	if(key.keyCode==13){
    		event.preventDefault(); //기본 이벤트 제거
    		registProject();
    	}
    }
   
    //프로젝트등록 함수로 빼냄
    function registProject(){
    	 
    	var title=$("#add-prj").val();

          $.ajax({
             type : 'POST',
             url : '/main/insertProject',
             headers : {
           	     "X-HTTP-Method-Override" : "POST",   //헤더에 POST방식 
           	     "content-type" : "application/json"   // 서버로 보내는 데이터타입이 JSON객체 타입이라고 지정 
             },
              data:JSON.stringify({       //JSON.stringify()객체를 문자열로 변경해서 보내고 이것이 JSON객체라고 헤더에서 알려줌 문자열이지만 객체다
              	"title" : title,
              	"u_id" : u_id,
              	"t_id" : t_id              	
             }),
             success : function(result) {
          	   if(result != 0){
          		  var str ="<ul class='projects'><li>"
          		       +"<a href='http://localhost:9090/board/"+t_id+"/"+result+"'><span class='name'>"+title+"</span>"
          		       +"</a></li>"
          		       +"</ul>";
          		   $(parent).after(str);
          	   }
   		},error : function() {
          		alert('error');
   				
   			}
          }); 
         closeProjectModal(); //모달창 닫기	
   	 } 
    
    //팀프로젝트 모달창 띄우기
    $('.teaminsert-a').on("click", function(){  	
    	$('.create-modal').addClass('is-visible'); 	
    });
    
    
    
    //팀프로젝트  모달창 닫기 외부클릭시
    $('.create-modal').on("click", function(event){
    	if($(event.target).hasClass("create-modal")){  		
    		$('.create-modal').removeClass('is-visible');	
    	}
    });
    
        //팀프로젝트  모달창 닫기 x자 클릭시
    $('.tclosebtn').on("click", function(){
    	$('.create-modal').removeClass('is-visible');
    });
    
    //입력시 버튼활성화및 비활성화
    $('.team-title').on("input", function(){
    	var teamtitle = $('.team-title').val();
    	 
    	if(teamtitle.length == 0){
    		$('.teambtn').addClass('disabled');
    		$('.teambtn').attr("disabled","disabled");
    		
    	}else{
    		$('.teambtn').removeClass('disabled');
    		$('.teambtn').removeAttr("disabled");	
    	}  	
    });
    
    $('.teambtn').on("click", function(){
    	var titleName= $('.team-title').val();
    		if(titleName == '' || titleName == null){
				alert('이름을 다시 입력해주세요');
             	return;
         	};
          
			$.ajax({
				type : 'POST',
             	url : '/main/team',
             	contentType : 'text/javascript',
             	headers : {
					"X-HTTP-Method-Override" : "POST",
                	"content-type" : "application/json"
          		},
              	dataType : 'json',
              	data:JSON.stringify({
					name : titleName               
          		}),
             	success : function(result) {  
             	console.log(typeof(result));
	           		if(result != null){
	              		alert("팀이 추가되었습니다.");
	              		self.location = '/main/team';
	           		};
          		},
          		error : function(){
                	alert('error');
          		}   
         	});
      	});
	
	//버튼 눌렀을때 팀불러오기
	$(document).on("click",".memberbtn",function(){
		t_id = $(this).parents().children().eq(2).text();
		title =  $(this).parents().children().eq(1).text();
		console.log(t_id);
		$('.member-modal').addClass('is-visible');
		memberlist(t_id);
	});
	//모달창 닫기
	$('.member-modal').on("click",function(e){
		
		if($(e.target).hasClass('member-modal')){
			$('.member-modal').removeClass('is-visible');
		}
	})
	
	//팀  프로필 ajax 불러오기
	function memberlist(t_id){
		$.ajax({
			type : "get",
			url : "/team/list/"+t_id,
			success : function(data){
				if(data.length > 0){
					console.log(data);
					$('.member-head').html(title);
					$('.member-list').html('');
					for(var i = 0; i < data.length; i++ ){		
						var str = "<div class='m-list'>"
						+"<img src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate"+data[i].profile+"' class='profile-img'>"
						+data[i].nickname+"</div>";
						$('.member-list').append(str);
					}
				} else{
					alert("통신오류");	
				}
				
			},error : function(){
				alert("통신오류로인해 실패했습니다.");
			}
		})//ajax	
	}	
	
	//즐겨찾기 해당리스트 함수
	function favoriteList(){
		
		$.ajax({
			type : "get",
			url : "main/favoritelist",
			success : function(data){
				if(data.length > 0 ){
					var str="";
					
					console.log(data);
					for(var i = 0; i < data.length ; i++){
						 
						    str += "<ul class='projects'>"
								  +"<li><a "
								  +"href='http://localhost:9090/board/"+data[i].t_id+"/"+data[i].id+"'><span"
								  +" class='name'>"+data[i].title+"</span>"		
								  +"<span><i class='fas fa-star delete-favo' p_id='"+data[i].id+"'></i></span></a>"
								  +"</li>"
							      +"</ul>";
					}
				    var pre ="<div class='projectBox'>"
								          +"<div class='teamInfo'>"
								    	  +"<i class='fas fa-users'></i> <span class='title'>즐겨찾기</span> </div>";		
			 		var plus="</div><span class='hidden'><button class='favorite-heigth'"
							+"type='button'>hidden</button></span>";
				    var complete =pre+str+plus;
							//태그 깨꿋이 지우기
				    		$('.main-favorite').html('');
							//태그를 붙이기 위해서 하나만듬.
							$('.main-favorite').html(complete);
							
				}
			},error : function(){
				alert("통신오류입니다.")
				
			}
		})// end ajax
	}
	
	//마우스 오버시 별나오기
	$(document).on("mouseenter",".projects",function(){
		$(this).children().children().children().children('.fa-star').addClass('visible');
	})
	//마우스 떠날때 별사라지기
	$(document).on("mouseleave",".projects",function(){
		$('.fa-star').removeClass('visible');
	})
	
	//즐겨찾기 추가
	$(document).on("click", '.add-favo', function(){
		
		p_id = $(this).attr("p_id");
		t_id = $(this).attr("t_id").substring(1);
		title = $(this).parents().parents().children().eq(0).text();
		favorites();
		$(this).addClass('delete-favo');
		$(this).addClass('fas');
		$(this).removeClass('add-favo');
		$(this).removeClass('far');
	
		/* teamList(); */
		//단순히 링크가 동작하지 않게 하기 (고전적인 방법)
		return false;
	})
	
	//ajax 즐겨찾기추가 함수
	function favorites(){	
		
		$.ajax({
				type : "get",
				url : "main/favorite/"+p_id,
				success : function(data){
					console.log(data);
					
					//맨처음 아무것도 없을때는 불러오기 처리	
					if($('.hidden').attr("class") != "hidden"){
						favoriteList();
					}else{
					  str = "<ul class='projects'>"
						  +"<li><a "
						  +"href='http://localhost:9090/board/"+t_id+"/"+p_id+"'><span"
						  +" class='name'>"+title+"</span>"		
						  +"<span><i class='fas fa-star delete-favo' p_id='"+p_id+"' t_id='"+t_id+"'></i></span></a>"
						  +"</li>"
					      +"</ul>";
					  $('.projects').eq(0).prepend(str);
					}
				},error : function(){
					alert("통신 오류 입니다.");
				}				
		})//end ajax
	}
	
	//즐겨찾기 삭제
	$(document).on("click",'.delete-favo',function(){
		
		p_id = $(this).attr("p_id");
		var tag = $(this).parents('li');
		
		$.ajax({
				type : 'delete',
				url : '/main/favoriteDelete',
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "DELETE"
				},
				data : JSON.stringify({id : p_id}),
				dataType : 'text',
				success : function(data){
					if(data == "SUCCESS"){
						favoriteList();
						$('#'+p_id).addClass('add-favo');
						$('#'+p_id).addClass('far');
						$('#'+p_id).removeClass('delete-favo');
						$('#'+p_id).removeClass('is-visible');
						$('#'+p_id).removeClass('fas');
						/* teamList(); */
						/* console.log(tag.children().length); */
						fovalist();
					
					}
				},error : function(){
					alert("통신 오류입니다.");
				}
		
		}); //end ajax
		return false;
	})
	
	//즐겨찾기 갯수 체크함수
	function fovalist(){
		$.ajax({
			type : "get",
			url : "main/favoritelist",
			success : function(data){
				console.log(data.length == 0);
				if(data.length == 0){
					$('.projectBox').eq(0).remove();
					$('.hidden').remove();
					
				}
			},error : function(){
				alert("통신오류입니다.");
			}
		})
	}
	
</script>
</body>
</html>