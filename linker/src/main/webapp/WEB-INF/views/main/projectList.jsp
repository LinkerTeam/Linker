<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="/resources/css/project/projectList.css?ver=11" type="text/css" rel="stylesheet" />
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title></title>
</head>

<body>
	<%@include file="../header.jsp"%>
	<%@include file="../mainMenu.jsp"%>
	
	<div class="content">

    <!-- 프로젝트 본문 -->
      <div class="content project">

        <!-- Projects In a Team -->
       
            <!-- 팀 정보 -->
          <c:forEach items="${team}" var="teamList"> 
           <div class="projectBox">
            <div class="teamInfo">
             
           
                <i class="fas fa-users"></i>
              <span class="title">${teamList.name}</span> 
                 <a class="tid" >${teamList.t_id} </a>
                  <a class="uid" >${teamList.u_id} </a>
              
              <!-- 이중 for문을 돌려서 List<List<UserVO>>를 뽑아낸다!! -->
               <c:forEach items="${profile}" var="teamMember">
                <c:forEach items="${teamMember}" var="aaa">
                  <c:if test="${teamList.t_id == aaa.t_id}">
                    <ul class="teamMembers">
               
                 
                      <li><img src="http://localhost:9090/user/displayFile?fileName=${aaa.profile}"><span class="tooltip">${aaa.nickname}</span></li>
                    </ul> 
                   </c:if>
                 </c:forEach>
               </c:forEach>
            </div> 
            <!-- 진행 프로젝트 목록 -->
       
          <c:forEach items="${result}" var="projectList"> 
             <c:if test="${ teamList.t_id == projectList.t_id}"> 
              <c:if test="${projectList.ps_id ==1}">
              <ul class="projects">
                <li><a href="http://localhost:9090/board/${teamList.t_id}/${projectList.id}"><span class="name">${projectList.title}</span></a></li>
              </ul>
              </c:if> 
             </c:if> 
           </c:forEach>
        
            <!-- 프로젝트 추가 버튼 -->
            <span class="addProject"><button class="createProjectBtn" type="button">Create new project…</button></span>
        
       
          </div>
         </c:forEach> 
      </div>
    
    </div>
     
    <!-- /프로젝트 본문 -->


    <!-- 프로젝트 생성 모달창 -->
    <!-- 띄우기 | is-visible -->
    <div class="project-modal">
        <div class="createProjectBox">
            <form class="createProjectForm">
                <label for="add-prj" class="hidden-txt">Add project title</label>
                <input id="add-prj" class="projectNameInput" placeholder="Add project title" maxlength="20" value="">
                <button class="registProjectBtn disabled" disabled type="button">Create Project</button>
            </form>
            <span class="closeBtn"><i class="fas fa-times"></i></span>
        </div>
    </div>
    <!-- /프로젝트 생성 모달창 -->

</body>
<script>


 var u_id =null;
 var t_id =null;

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
       
       
      
        var title=$("#add-prj").val();

   	 
     
      
       console.log(u_id);
       console.log(t_id);
      console.log(title);
      
     
       
       $.ajax({
          type : 'POST',
          url : '/main/insertProject',
          headers : {
        	     "X-HTTP-Method-Override" : "POST",
        	     "content-type" : "application/json"
          },
           data:JSON.stringify({
           	"title" : title,
           	"u_id" : u_id,
           	"t_id" : t_id              	
          }),
          success : function(result) {
			  
       	   if(result != 0){
       		   var name =result;
       		   
       		   alert("프로젝트 생성 완료쿠");
       		   location.reload();
       		   return true;
       	   }
		},
       	error : function() {
       		alert('error');
				
			}
       }); 
       
        console.log('ajax를 날려주세요~~');
        closeProjectModal();
    });

    // tooltip left 좌표설정
    $('.teamMembers .tooltip').each(function(){
        var TOOLTIP_POINTER_WIDTH = 5;
        var moveToLeftPos = parseInt($(this).width()/2) - TOOLTIP_POINTER_WIDTH;
        $(this).css('marginLeft', -moveToLeftPos);
    });
     
</script>
</body>
</html>