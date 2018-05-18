googlecheck();
		//모달창 띄우기
		$(".closeBoardList").on("click",function(){	
			$('.list-modal').addClass('is-visible');		
			
			$.ajax({
				type:"GET",
				url:"/main/projectlist",
				success : function(data){
					
					if(data.length !== 0){
						$('.content-list').html("");
						for(var i = 0; i < data.length ; i++){
							var str ="<div class='listbox'><div class='list-li'><a href='http://linker.zz.am/board/"
							+data[i].t_id+
							"/"
							+data[i].id+"'>"
							+data[i].title+"</a>"
							+"<div class='option'><a class='preload' p='"+data[i].id+"' u='"+data[i].u_id+"' t='"+data[i].t_id+"'>Re-load</a>"
							+"<a class='pdelete' p='"+data[i].id+"' u='"+data[i].u_id+"'>Delete</a></div></div></div>"
							$('.content-list').append(str);
						} 
					}else{
							nolist();
						 }
				},
				error : function(){
					alert("통신의 오류가 발생했습니다.");
				}
			}); //ajax
		});
	  	
	  	//프로젝트리스트가 없을때
	  	function nolist(){
	  		$('.content-list').html("");
			str ="<div class='no-project'>No Project List</div>"
			$('.content-list').append(str);
	  	}
	  	
		//모달창 닫기
		$(document).on("click",".list-modal",function(e){
			if($(e.target).hasClass("list-modal")){
				$(".list-modal").removeClass("is-visible");		
			}
		})
		
	
	
		
		//리로드했을떄 다시 불러오기
		$(document).on("click",".preload",function(){
			u_id = $(this).attr("u");
			p_id = $(this).attr("p");
			var ps_id = 1;
			var parent = $(this).parent().parent().parent();
			var ppp = $(this).parent().parent().parent().children('.listbox');
			console.log(typeof(ppp) );
			console.log(parent);

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
		    					 var listno=$('.listbox').html();
		    					console.log(listno);
		    					console.log(listno == "");
		    					checkList(); 
		    				}
		    			};//if
		    		},
		    		error : function() {
		    			alert("에러가 발생했습니다.");
		    		}
		    	});//ajax
		});
		
		//종료 된 프로젝트에서 완전히 삭제처리 
		$(document).on("click",".pdelete",function(){
			u_id = $(this).attr("u");
			p_id = $(this).attr("p");
			ps_id = 3;
			var parent = $(this).parent();
			
			if(confirm("모든 카드리스트와 카드가 함께 삭제됩니다. \n삭제된 프로젝트는 복구가 불가능합니다. \n그래도 삭제하시겠습니까?") !== true){
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
	    					parent.parent().html("");
	    					var listno=$('.listbox').html();
	    					console.log(listno == "");
	    					checkList();
	    					
	    				}
	    			};//if
	    		},
	    		error : function() {
	    			alert("에러가 발생했습니다.");
	    		}
	    	});//ajax
		});
		
		//종료된 프로젝트 갯수를 샌다.
		function checkList(){
			
			$.ajax({
				type:"GET",
				url:"/main/projectlist",
				success : function(data){
					if(data.length === 0){
						nolist();
					}
				},
				error : function(){
					alert("통신의 오류가 발생했습니다.");
				}
			}); //ajax
		}
		
		//구글로그인시에 비밀번호 변경 메뉴 가리기
		function googlecheck(){
			
			
			if(key == 0){
				$('.pwd-modify').css("display","block");
			} else{
				$('.pwd-modify').css("display","none");
			}
}
		