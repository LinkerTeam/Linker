<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>프로젝트화면</title>
<!-- jQuery 2.1.4 -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<style>
	
	.cardlistContent {
	    line-height: 1.3em;
	    display: flex;
	    overflow-x: hidden;
	    height: calc(100% - 45px);
	}
	.projectTitle {
	    font-size: 18px;
	    height: 40px;
	    line-height: 35px;
	    padding-left: 20px;
	    color: #484848;
	}
	.cardlists {
	    display: -webkit-box;
	    display: -ms-flexbox;
	    display: flex;
	    overflow-y: hidden;
	    overflow-x: auto;
	    min-width: 100%;
	}

    .cardlists > * {
        flex: 0 0 auto;
    }

	::-webkit-scrollbar {
	    width: 10px;
	    height: 12px;
	}

	::-webkit-scrollbar-track {
	    background: rgba(0,0,0,.05);
	    border-radius: 3px;
	}
	
	::-webkit-scrollbar-thumb {
	    background: rgba(0,0,0,.1);
	    border-radius: 10px;
	}

	.cardlist {
	    width: 236px;
	    height: 100%;
	    position: relative;
	    display: inline-block;
	    margin-left: 10px;
	    border-radius: 2px;
	}

    .cardlist > * {
        background-color: #e2e4e6;
        color: #333;
        padding: 0 10px;
    }

    .cardlist header {
        line-height: 35px;
        font-size: 16px;
        font-weight: bold;
        border-top-left-radius: 5px;
        border-top-right-radius: 5px;
        height: 30px;
        color: #484848;
        padding-left: 11px;
    }

	.cardlist footer {
	    height: 40px;
	    line-height: 40px;
	    border-bottom-left-radius: 5px;
	    border-bottom-right-radius: 5px;
	    color: #656565;
	    font-size: 14px;
	    font-weight: 400;
	    cursor: pointer;
	}
    .cardlist footer:hover {
        background-color: #d4d4d4;
    }
    
    .addCard{
    	display: none;
        padding-bottom: 5px;
    }

    .cards {
        list-style: none;
        margin: 0;
        max-height: calc(100% - 26px - 45px - 20px);
        overflow-x: hidden;
        overflow-y: auto;
    }

    .cardtitleLi {
        background-color: #fff;
        border-radius: 3px;
        -webkit-box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
        box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
    }

    .cardtitleLi:not(:last-child) {
        margin-bottom: 7px;
    }

    .cardtitleLi img {
        display: block;
        width: calc(100% + 2 * 10px);
        margin: -10px 0 10px -10px;
        border-top-left-radius: 3px;
        border-top-right-radius: 3px;
    }
	.addList {
	    border-radius: 3px;
	    height: 40px;
	    line-height: 40px;
	    margin-right: 10px;
	    color: #dadada;
	    font-size: 14px;
	    font-weight: 400;
	    background-color: rgba(121, 121, 121, 0.60);
	    cursor: pointer;
	}
    .addList:hover {
        background-color: rgba(121, 121, 121, 0.95);
    }
    
	/* 여기서부터 추가 */
    .cardtitleLi{
        display: block;
    	position: relative; /*수정버튼 position: absolute;로 오른쪽 고정하기 위해*/
        height: 100%;
        margin-top: 3px;
        margin-bottom: 3px;
        padding: 6px;
        background-color: white;
        border-radius: 3px;
    	color: #5e5e5e;
        font-size: 11pt;
        word-break: break-word; /*width 값에 맞춰 강제줄바꿈*/
        cursor: pointer;
    }
    .cardtitleLi:hover{
    	background-color: #edeff0;
    }
    /* 카드 목록에 마우스를 올리면 button태그 보이게 */
    .cardtitleLi:hover button{
    	display: block;
    }
   
    .cardlistTitle {
        font-size: 11pt;
        font-weight: bold;
        padding: 3px 3px 5px 0;
    }
    .create{
    display: none;
    border-radius: 5px;
    padding: 8px;
	}
	
	textarea {
	    border-radius: 2px;
	    border: 0px;
	}
    /* 파란색 테두리 없애기 */
    textarea:focus {
        outline: none;
    }
	#createCardTextarea{
		width: calc(100% - 20px);
		height: 38px;
		padding: 10px;
		border-radius: 3px;
		-webkit-box-shadow: -1px -1px 1px 0px rgba(0, 0, 0, 0.2) inset;
        box-shadow: -1px -1px 1px 0px rgba(0, 0, 0, 0.2) inset;
	}
    #addBtn, #listAddBtn {
        background-color: #5aac44;
        border: none;
        border-radius: 3px;
        color: white;
        padding: 7px 10px 7px 10px;
        text-align: center;
        font-size: 14px;
        margin: 4px 0 0 2px;
        transition: 0.3s;
    }
    #addBtn:hover, #listAddBtn:hover {
        background-color: #519839;
    }
    #cancleBtn, #listCancleBtn {
        background-color: none;
        border: none;
        color: dimgray;
        padding: 3px;
        text-align: center;
        font-size: 18px;
        opacity: 0.6;
        outline: none;
    }
    /* 카드리스트의 카드제목수정 버튼 */
	.cardModifyBtn {
		display: none; 
        height: 22px;
        width: 22px;
        position: absolute;
        top: 4px;
        right: 4px;
        border: none;
        background-color: #edeff0;
        opacity: 0.2;
        border-radius: 2px;
        cursor: pointer;
        font-size: 11px;
    }
	.cardModifyBtn:hover {
	    background-color: #b6b6b6;
	    opacity: 0.4;
	    border-radius: 2px;
	} 
	.cardModifyBtn:focus {
	    outline: none;
	}
	
	/* 모달창 뒷배경 */
	.modifyModal {
	    display: none; /* 기본값: 숨김 */
	    position: fixed; 
	    z-index: 1; 
	    top: 0;
	    left: 0;
	    width: 100%; /* 모달 뒷배경이 화면에 꽉차도록 */
	    height: 100%; /* 모달 뒷배경이 화면에 꽉차도록 */
	    background-color: rgb(0,0,0); /* 모달 뒷배경색 */
	    background-color: rgba(0,0,0,0.4); /* 모달 뒷배경 opacity */
	}
	.modifyModal-title{
		display: none;
	}
	/* 모달창 수정입력란 */
	.modifyModal-content {
	    width: 202px;
	    height: 80px;
	    float: left;
	    position: relative; /*수정란을 원하는 위치로 이동시킬 수 있도록*/
	}
	#modifyTextarea, #createTextarea {
		resize:none; 
	}
	#modifyTextarea {
	    width: 202px;
	    height: 38px;
	}
	.saveBtn {
	    background-color: #5aac44;
	    border: none;
	    border-radius: 3px;
	    color: white;
	    padding: 7px 10px 7px 10px;
	    text-align: center;
	    font-size: 14px;
	    margin: 4px 2px;
	    transition: 0.3s;
	}
	    .saveBtn:hover {
	        background-color: #519839;
	    }
		
	/* 닫힘버튼(X) */
	.closeModal {
	    color: #aaaaaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	.closeModal:hover, .closeModal:focus {
	    color: #000;
	    text-decoration: none;
	    cursor: pointer;
	}
	
</style>
</head>


<body>
	<!-- <div class="content"> -->
		<div class="projectTitle"><h2>프로젝트4</h2></div>
        <div class="cardlistContent">

            <div class="cardlists">
                <div class="cardlist">
        			<header class="cardlistTitle">카드리스트4 이름</header>
                    <div class="cards">
	                   
                    </div>
                    <footer class="createCardBox">Add a card...</footer>
                </div>
                
                <div class="cardlist">
	                <div class="addList">Add a list...</div>
	                <div class="cardlistTitle create">
	                    <textarea name="title" id="createTextarea" placeholder="Add a List..."></textarea><br />
	                    <button type="button" id="listAddBtn">add</button>
	                    <button type="button" id="listCancleBtn">&times;</button>
	                </div>
                </div>
            </div>
            
         </div>
      <!-- </div> -->
        
	<!-- 카드리스트 목록에서 카드 title 수정할 때의 모달 -->
	<div id="modifyModal" class="modifyModal">
		<div class="modifyModal-title"></div>
		<!-- 수정 모달 내용 -->
		<span class="closeModal">&times;</span>
		<div class="modifyModal-content" style="top: 0; left: 0;">
		    <textarea name="content" id="modifyTextarea" rows="2" cols="20" style="resize:none"></textarea><br />
		    <button type="button" id="saveBtn" class="saveBtn">save</button>
		</div>
	</div>
	
	<!-- 카드팝업 jsp -->
	<%@include file="readCard.jsp"%>
	
	<script>
	
		//프로젝트4 화면에서 볼 수 있는 카드리스트&카드 화면.
		var p_id=4;
		//u_id, cl_id는 임의의 값(4)을 사용.
		var u_id=4;
		var cl_id=4;
		
		var modifyModal = document.getElementsByClassName('modifyModal')[0]; // 모달창 객체
		var closeModal = document.getElementsByClassName("closeModal")[0]; // 닫힘버튼(X) 객체
		
		var addList = document.getElementsByClassName("addList")[0]; //Add a List...버튼
        var createList = document.getElementsByClassName("create")[0]; //list추가할 때 생기는 미니창
        var createTextarea = document.getElementById("createTextarea"); //list 추가 textarea
        var listAddBtn = document.getElementById("listAddBtn"); //list추가 save버튼
        var cards = document.getElementsByClassName("cards"); //카드리스트
        var scrollControll=false;
        var cardlistIndex;
        
		
        
		/* 전체 카드 출력 (여러 번 반복해서 사용되기 때문에 getAllList함수로 묶음.) */
		function getAllList(){
			$.getJSON("/teams/"+p_id+"/cards", function(data){

				var str="";
				
				//Ajax로 호출된 목록에 대해 루프를 돌면서 <div>태그를 생성하도록 함.
					//<div>태그 안에 <div>태그와 <button>태그가 들어가는 형태.
					//<div><div></div><button></button></div>
				$(data).each(function(){
					str += "<div data-id='" + this.id + "' class='cardtitleLi'>"
					+ "<div id='cardLink' onclick='loadCardData(this)'>" + this.title + "</div>"
					+ "<button class=cardModifyBtn><i class='far fa-edit'></i></button></div>";
				});
				$(".cards").html(str); //내부의 요소를 싹 비우고 새로 추가
				
				//목록 마지막에 카드add창 추가
				var strstr= "<div class='addCard'><textarea name='title' id='createCardTextarea' rows='2' cols='20' style='resize:none'></textarea><br /><button type='button' id='addBtn'>add</button><button type='button' id='cancleBtn'>&times;</button></div>";
				$(".cards").append(strstr); //내부 요소의 제일 마지막에 추가
				
				if(scrollControll == true){
					cards[cardlistIndex].scrollTop=cards[cardlistIndex].scrollHeight;
				}
			});
		};
		

		//일단 전체 목록을 화면에 출력
		getAllList();
		
		
		
		
		/* Add a card... 누르면 카드추가창 생김. */
        $("footer.createCardBox").click(function () {
            var index = $("footer.createCardBox").index(this); //전체 createCardBox 중에서 this의 인덱스값 얻기
            $(this).prev().children(".addCard").css("display", "block");
            
            $(this).css("display", "none"); //Add a card... 숨기기
            $(cards[index]).css("max-height", "calc(100% - 51px)"); //카드리스트 길이 조정
            $(cards[index]).css("border-bottom-left-radius", "5px"); 
            $(cards[index]).css("border-bottom-right-radius", "5px"); 
            $("#createCardTextarea").focus();
            
            cards[index].scrollTop = cards[index].scrollHeight; //추가창 보이도록 스크롤 아래로 이동
        });
		
		
		/* 카드추가창 이외의 영역 클릭하면 추가창 사라짐(-) */
        /* $(document).click(function(e){
        	if(e.target !== $("footer.createCardBox")){
        		console.log("사라짐");	
        	}
        }) */
		
        
        // x버튼 누르면 카드추가창 사라짐
        $(".cards").on("click", ".addCard #cancleBtn", function(){
			$("footer.createCardBox").css("display", "block");
			$(this).parent(".addCard").css("display", "none");
			$(".cards").css("max-height", "calc(100% - 26px - 45px - 20px)"); //카드리스트 길이 조정
			$(".cards").css("border-bottom-left-radius", "0px"); 
            $(".cards").css("border-bottom-right-radius", "05px"); 
		})
		
		
		
		/* 카드 등록 처리 - add버튼을 클릭할 경우 */
		$(".cards").on("click", ".addCard #addBtn", function(){
			scrollControll=true;
			//사용자가 입력한 내용은 변수로 처리(textarea id="createTextarea")
			var title = $("#createCardTextarea").val();
			var createCardTextarea = document.getElementById("createCardTextarea");
			cardlistIndex = $(".addCard #addBtn").index(this);
			
			//아무 값도 입력하지 않을 경우
			if(title==''){ return; }
			
			$.ajax({
				type : 'post',
				url : "/teams/"+p_id+"/cards",
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "POST"
				},
				dataType : 'text',
				data : JSON.stringify({
					u_id : u_id,
					title : title,
					cl_id : cl_id
				}),
				success : function(result){
					if(result == 'SUCCESS'){
						
						getAllList(); //등록에 성공하면 전체 카드 목록 갱신
						$(".addCard").css("display", "none"); //카드추가창 사라짐
						$("footer.createCardBox").css("display", "block"); //Add a card... 생김
						$(".cards").css("max-height", "calc(100% - 26px - 45px - 20px)"); //카드리스트 길이 조정
						$(".cards").css("border-bottom-left-radius", "0px"); 
			            $(".cards").css("border-bottom-right-radius", "0px");
						createCardTextarea.value=''; //textarea 초기화
					}
				},
				error : function(request, status, error ) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});//Ajax
		});
		
		
		
		
		
		
		/* 카드 title 수정 처리 - 수정 버튼 클릭할 경우 */
		$(".cards").on("click", ".cardtitleLi button", function(e){
			// 모달창을 클릭한 카드의 위치에서 뜨도록 함.
	        	// 1. 클릭한 수정버튼의 부모 찾아가서(cardtitleLi) 그 부모의 좌표값을 구하기
	        var cardtitleLiX = $(this).parent("div").offset().left; //그 수정버튼의 부모 태그의 x좌표
	        var cardtitleLiY = $(this).parent("div").offset().top; //그 수정버튼의 부모 태그의 y좌표
	        
	        	// 2. 카드리스트의 전체높이 구하기
	        var listHeight=parseInt($(".cards").css("height")); //카드리스트 중 카드부분 높이
	        var headerHeight=parseInt($(".cardlistTitle").css("height")); //카드리스트 헤더 높이
	        var footerHeight=parseInt($(".createCardBox").css("height")); //카드리스트 푸터 높이
	        var modifyHeight=parseInt($(".modifyModal-content").css("height")); //수정창 높이
	        
	        var x = headerHeight + listHeight + footerHeight; //카드리스트 전체높이
	        
	        if(cardtitleLiY > x){ // 3. 클릭한 카드의 y좌표가 전체높이보다 크면 수정창 위치 조정하여 띄움
	        	$(".modifyModal-content").css({
		            "left": cardtitleLiX,
		            "top": x + 15
		        });
	        }else{ // 4. 클릭한 카드의 y좌표가 전체높이보다 작으면 그 위치에서 수정창 띄움
	        	$(".modifyModal-content").css({
		            "left": cardtitleLiX,
		            "top": cardtitleLiY
		        });
	        }
	        
			// 모달창을 띄운다.
			modifyModal.style.display = "block";
	        
			// 닫힘버튼(X) 누르면 모달창 닫힘.
			closeModal.onclick=function(){
				modifyModal.style.display = "none";
			};
			// 모달창 범위 밖을 클릭하면 모달창 닫힘.
			window.onclick = function(event) {
			    if (event.target == modifyModal) {
			    	modifyModal.style.display = "none";
			    }
			};
			
			var card = $(this).parent(); //수정버튼의 조상-카드
			var id=card.attr("data-id"); //카드의 id값을 담는다.
			var title=card.children("a").text(); //카드의 자손 중 a태그의 내용을 담는다.
			
			$(".modifyModal-title").html(id); //div태그에 카드의 id값 주입(CSS를 hidden으로 줘서 화면 출력은 안되도록 함)
			$("#modifyTextarea").val(title); //카드의 원래 내용을 수정textarea에 담기
		});
		
		
		/* 카드 title 수정 처리 - 수정 내용 입력 후 save버튼 클릭할 경우 */
		$("#saveBtn").on("click", function(){
			
			var id=$(".modifyModal-title").html(); //div태그에 담긴 카드 id값 가져와서 var id에 담기
			var title=$("#modifyTextarea").val(); //수정textarea의 내용 담기
			
			//아무 값도 입력하지 않을 경우
			if(title==''){ return; }
			
			$.ajax({
				type : 'put',
				url : "/teams/"+p_id+"/cards/" + id,
				headers : {
					"Content-Type" : "application/json",
					"X-HTTP-Method-Override" : "PUT"
				},
				data : JSON.stringify({title : title}),
				dataType : 'text', 
				success : function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						$(".modifyModal").hide(); //모달창 감추기
						getAllList(); //전체 목록 갱신
					}
				},
				error : function(request, status, error ) {
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				}
			});//ajax
		});
		
		
		
		
	</script>
	
</body>
</html>