<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<!-- CSS -->
<link href="/resources/css/mainMenu.css?ver=1" type="text/css" rel="stylesheet" />
<style>
.modal {
    display: none;
    position: fixed;
    z-index: 1001; /* 테스트 후 값 조정 */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
  /*  // background-color: rgba(0,0,0,0.7); */
}
.modal.is-visible {
    display: block;
}
.modal-content{
    position: relative;
    box-sizing: border-box;
    width: 300px;
    background: #fff;
    border-radius: 4px;
    padding: 40px 45px 45px 40px;
    margin: 450px 0px 0px 1400px;
    color : black;
    font-size: 15px;

}
.closetitle{
   margin-left:70px;
   padding-bottom: 50px;
   text-align: center;
}
/* 버튼 css   */
.hiddenbtn{
    border: none;
    outline: none;
    height: 40px;
    background: #FA5883;
    color: #fff;
    font-size: 18px;
    margin-left: 15px;
    margin-top: 15px;
    cursor: pointer;
    width: 95%;
    border-radius: 5px;
    
}

</style>

</head>

<body>
	<!--왼쪽 메뉴(확장메뉴, 축소메뉴)-->
	<!--확장 메뉴(글자)-->
	<nav class="mainNav"> <!--확장메뉴 | 상단 프로필영역-->
	<div class="profile-area">
		<a href="#" class="profile-img-area"> 
			<img src="http://localhost:9090/user/displayFile?fileName=${login.profile}" class="profile-img" />
		</a>
		<div class="profile-nickname-area">
			<div class="profile-nickname">${login.nickname}</div>
		</div>
	</div>
	
	
	<!--확장메뉴 | 하단 메뉴영역-->
	<ul class="mainNav-menu">
		<li class="mainNav-menu-header">Main navigation</li>
		<li><a href="#">Project</a></li>
		<li><a href="#">ERD</a></li>
		<li><a href="#">CodeLauncher</a></li>
		<li><a href="#">Chat</a></li>
		<li><a href="#">Postman</a></li>
	</ul>
	</nav>


	<!--축소 메뉴(아이콘)-->
             <nav class="iconBar">
                 <a href="#"><img src="http://localhost:9090/user/displayFile?fileName=${login.profile}"  class="profile-img" /></a>
                 <!--마우스 오버시 아이콘 색변경 되도록-->
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/u765gerlj/icon_project_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/wbqihhlif/icon_project.png'"><img src="https://s5.postimg.org/wbqihhlif/icon_project.png" width="30" border="0" /><span class="icon-menuName">Project</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/beuacuicn/icon_erd_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/6sy64hp3r/icon_erd.png'"><img src="https://s5.postimg.org/6sy64hp3r/icon_erd.png" width="30" border="0" /><span class="icon-menuName">ERD</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/a12ngyix3/icon_code_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/8m12s8a47/icon_code.png'"><img src="https://s5.postimg.org/8m12s8a47/icon_code.png" width="30" border="0" /><span class="icon-menuName">CodeLauncher</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/aqlftbyw7/icon_chat_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/pmjz0x2l3/icon_chat.png'"><img src="https://s5.postimg.org/pmjz0x2l3/icon_chat.png" width="30" border="0" /><span class="icon-menuName">Chat</span></a>
                 <a href="#" onmouseover="this.childNodes[0].src = 'https://s5.postimg.org/b3ctziwlj/icon_post_A.png'" onmouseout="    this.childNodes[0].src = 'https://s5.postimg.org/4pnqw9jzr/icon_post.png'"><img src="https://s5.postimg.org/4pnqw9jzr/icon_post.png" width="30" border="0" /><span class="icon-menuName">Postman</span></a>
             </nav>
            

	<!-- 오른쪽 메뉴 -->
	<!-- .mainAside-open | 열림 상태 -->
	<aside id="mainAside" class="mainAside">
		<div class="nav-tabs-wrap">
			<ul class="nav-tabs">
				<!-- .active | 탭 메뉴 활성화 상태 -->
				<!-- Tab1 | 이력목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#">이력</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<ul class="pic-list">
								<li>
									<!-- 작성자 -->
									<div class="pic-list-writer">
										<div class="profile">
											<img src="http://localhost:9090/user/displayFile?fileName=${login.profile}" 
												alt="프로필 사진" />
										</div>
									</div> <!-- 이력내용 -->
									<div class="pic-list-desc">
										<span class="name">백다방</span> added Checklist to git 수정된 문서
										확인
									</div> <!-- 시간/날짜 -->
									<p class="pic-list-datetime">2 hours ago</p>
								</li>
							</ul>
							<!-- 이력 더 보기 -->
							<a class="show-more" href="#">View all activity…</a>
						</div>
					</div>
				</li>
				<!-- /이력목록 -->
	
				<!-- Tab2 | 달성목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#">달성</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<div class="tab-content-box-controls">
								<input type="search" placeholder="Search archive...">
								<button class="switchCardlist archiveBtn">Switch to lists</button>
							</div>
							<div class="nav-tab-content-Box-card"></div>
						</div>
					</div>
				</li>
				<!-- /Tab2 | 달성목록 -->
	
				<!-- Tab3 | 가리기목록 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#">가리기</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">menu2</div>
					</div>
				</li>
				<!-- /Tab3 | 가리기목록 -->
	
				<!-- Tab4 | 설정 -->
				<li>
					<div class="nav-tab-btn">
						<a href="#">settings</a>
					</div>
					<div class="nav-tab-content">
						<div class="tab-content-box">
							<!--팀 멤버 프로필 사진-->
	                                 <div class="all-members">
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                     <img src="https://s18.postimg.org/8blvbj9tl/profile.png" class="profile-img" />
	                                 </div>
							<!--초대 버튼-->
							<div class="invite">
								<a href="#" class="invite-button"> <span
									class="invite-icon"><i class="fas fa-user-plus"></i></span> <span>invite</span>
								</a>
							</div>
							<!--메뉴-->
							<div class="mainAside-tab4-menu">
								<div class="user-modify">
									<a href="http://localhost:9090/user/userModify">회원정보수정</a>
								</div>
								<div class="user-modify">
									<a href="http://localhost:9090/main/team">팀 정보 수정</a>
								</div>
								<div class="user-modify">
									<a href="http://localhost:9090/user/passwordchange">비밀번호변경</a>
								</div>
								<div class="user-modify">
									<a href="#" class="closeboard">close-board</a>
								</div>
								<div class='modal'>
								 <div class="modal-content">
								  <div class='modal-title'>
								  <span class="closetitle">Close Board?</span>
								  </div>
								  <div>
								   <div class='modal-text'>
								     <p>You can re-open the board by clicking the “Boards” menu from the header
								      , selecting “View Closed Boards,” finding the board and clicking “Re-open.”</p>
								      <button class="hiddenbtn" value="OK">확인</button>
								     </div>
								    </div>
								   </div>
								
								</div>
							</div>
						</div>
					</div>
				</li>
				<!-- /Tab4 | 설정 -->
			</ul>
		</div>
	</aside>
	 
	<script>
		
		var i = 0;
		var j = 0;
	
		//왼쪽 메뉴 확장&축소 이벤트
		function openNav() {
		    var mainNav = document.getElementsByClassName("mainNav"); //확장메뉴
		    var content = document.getElementsByClassName("content"); //본문
		    var iconBar = document.getElementsByClassName("iconBar"); //축소메뉴
		    var logoBg = document.getElementsByClassName("logo-background"); //헤더 로고영역
		    var logoFull = document.getElementsByClassName("logo-full"); //확장로고
		    var logoMini = document.getElementsByClassName("logo-mini"); //축소로고
	
		    i++; //왼쪽 메뉴버튼 클릭할 때마다 i의 값 1씩 증가하도록
	
		    if (i % 2 == 1) { //클릭수가 홀수이면 축소메뉴 노출
		        content[0].style.marginLeft = "60px"; //본문 위치 메뉴너비에 맞춰 옮기기
		        iconBar[0].style.width = "60px"; //메뉴 영역 230px에서 60px로 줄이기
		        logoBg[0].style.width = "60px"; //로고 영역 230px에서 60px로 줄이기
		        mainNav[0].style.width = "0"; //확장메뉴 숨긴다
		        logoFull[0].style.width = "0"; //확장로고 숨긴다
		        logoMini[0].style.width = "60px"; //축소로고 너비 확보
		    }
		    else { //클릭수가 짝수이면 확장메뉴 노출
		        mainNav[0].style.width = "230px"; //확장메뉴 너비 확보
		        content[0].style.marginLeft = "230px"; //본문 위치 메뉴너비에 맞춰 옮기기
		        logoBg[0].style.width = "230px"; //확장시 로고영역 확보
		        logoFull[0].style.width = "230px"; //확장로고 너비 확보
		        logoMini[0].style.width = "0"; //축소로고 숨긴다
		    };
		};
	
	
		
		//오른쪽 메뉴 숨기기&펼치기 이벤트
		function openAside() {
			var mainAside = document.getElementById('mainAside'); //오른쪽 메뉴 전체
		    var content = document.getElementsByClassName('content'); //본문
		    var tabMenu = document.getElementsByClassName('nav-tabs'); //탭 메뉴
		    
		    j++ //오른쪽 메뉴버튼 클릭할 때마다 j의 값 1씩 증가하도록
	
		    if (j % 2 == 1) { //클릭수가 홀수이면 펼치기
		        mainAside.classList.add('mainAside-open'); //클래스 이름 'mainAside-open' 추가
		        mainAside.style.width = "330px";
		        content[0].style.marginRight = "330px";
		        //활성화된 메뉴가 없다면 첫번째 탭 메뉴를 활성화
		        if (tabMenu[0].dataset.activenumber === undefined) {
		        	tabMenu[0].dataset.activenumber = 0;
		        	tabMenu[0].children[0].classList.add('active');
		        };
		    } else { //클릭수가 짝수이면 숨기기
		        mainAside.classList.remove('mainAside-open'); //클래스 이름 'mainAside-open' 제거
		        mainAside.style.width = "0";
		        content[0].style.marginRight = "0";
		    };
		};

		//오른쪽 메뉴 탭버튼 제어
		var tabMenu = document.getElementsByClassName('nav-tabs'); //탭 메뉴
		for(var i=0; i<tabMenu[0].childElementCount; i++){
			tabMenu[0].children[i].addEventListener("click", function(){
				
				var clickedTabIndex = getElementIndex(this); //클릭한 탭 번호
				var currentTabIndex = this.parentElement.dataset.activenumber; //현재 탭 변호
				
				//클릭한 탭이 현재 활성화 된 탭이 아닌 경우에만 탭의 내용 보여주기
				if(currentTabIndex != clickedTabIndex){
					//현재 탭 비활성화
			        tabMenu[0].children[currentTabIndex].classList.remove('active'); 
				    //클릭한 탭 활성화
				    this.classList.add('active');
				  	//클릭한 탭의 번호를 저장
				    this.parentElement.dataset.activenumber = clickedTabIndex;
				}
			});
		}
	
		//해당 노드의 인덱스 반환
		function getElementIndex(node) {
		    var index = 0;
		    while ((node = node.previousElementSibling)) {
		        index++;
		    }
		    return index;
		}
		
	var modal = document.getElementsByClassName('modal');
	var closebtn = document.getElementsByClassName('closeboard');
	var modal2 = document.getElementsByClassName('modal-content');
	
	closebtn[0].onclick = function(){
		
		
		modal[0].classList.add('is-visible');
		
		
	}
  
	//모달창 닫기 자바스크립트 버전
   // 모달 close 이벤트 if문에 자기자신 클릭시에만 이벤트를 발생하게 한다. 모달창 닫기
            $('.modal').on('click', function(e){
            	//클릭했을때 user-modal클래스가 아니면 모달을 닫고 user-modal을 클릭했을때는 if문이 안돈다
            	//event.target은 마우스 클릭시 일어나는 위치찾기
                if ($(e.target).hasClass("modal")) { 
                	modal[0].classList.remove('is-visible');     
                }
            });
	
      //모달 close esc를 누르면 나오게된다. keycode에서 27은 esc이다.
          $(document).keyup(function(event){
                        if(event.which=='27'){
                        	modal[0].classList.remove('is-visible');       
                        }
                      });
             
      var p_id = 4;
      
      $('.hiddenbtn').on('click', function(e){
    	  
    	  
    	   alert("나다");
    	   
    	   $.ajax({
    		 type : 'POST',
    		 url : '/main/'+p_id,
    		 headers : {'X-HTTP-Method-Override' : 'POST'
				},
    		 data: { "p_id":   p_id },
    		 success : function(data){
    			 
    		 },
    		 error : function(){
    			 alert('error');
    		 }
    	   
    	   
    	   
    	   
    	   
    	   });
    	   
       })
       

		
		
	</script>
</body>
</html>