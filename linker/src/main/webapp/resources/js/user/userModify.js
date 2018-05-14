var file = document.getElementById('file').value;
//파일체인지 이벤트시에 용량을 넣고 유효성검사에 사용하기위해서 외부선언
var fileSize = 0;

//console.log($('#file').val().slice(12));
var orignalNick = document.getElementById('nickname').value;

//유효성 검사 테스트
function subcheck() {
	var nickname = document.getElementById('nickname').value;
	//파일명 가져오기
	var fileValue = $("#file").val().split("\\");
	var fileName = fileValue[fileValue.length-1]; // 업로드한 파일명
	//console.log(fileName);
	
	if (nickname == null || nickname == '') {
		alert('닉네임이 잘못되었습니다. 다시 확인 해주세요.');
		document.getElementById('nickname').focus();
		return false;
	}
	if (!(nickname.length >= 2 && nickname.length < 15)) {
		alert('닉네임은 2자 이상 16자 이내로 입력해주세요.');
		document.getElementById('nickname').focus();
		return false;
	}

	//기존 닉네임을 바꾸지 않았을떄 체크해줌. 
	if (orignalNick != nickname) {
		//닉네임 중복환인 안눌렀을떄
		if (document.getElementById("checkMsg").innerHTML == "") {
			alert("닉네임을 중복 확인 해주세요.");
			return false;
		}

		//닉네임이 중복돼었을때 빨간색이면 중복이라고 나옴 
		if (document.getElementById("check").style.color === 'red') {
			alert("닉네임이 중복되었습니다. 다른 닉네임을 입력해주세요.");
			return false;
		}
	}
	
	//이미지 파일 명 길이 제한 
	if(!(fileName.length < 200)){
		alert("이미지 파일명이 너무 깁니다 이름을 변경후 다시 등록 해주세요.");
		return false;
	}
	//이미지 파일 사이즈  검사 1mb보다 큰지 작은지 체크
	if(!(fileSize < (1*1024*1024))){
		alert('이미지 용량이 너무 큽니다 이미지파일 용량을 다시 확인해주세요.');
		return false;
	}
	alert("회원 정보가 수정되었습니다.");
	return true;
}

//파일 업로드시 이미지 미리보기 
window.onload = function() {
	var upload = document.getElementsByClassName('uploadprofile')[0];
	var holder = document.getElementById('holder');
	var state = document.getElementById('status');
	
	//파일 변경시 해당 함수 실행
	upload.onchange = function(e) {
		//파일 사이즈 가져오기
		fileSize = $("#file")[0].files[0].size;
		
		e.preventDefault(); //기존 이벤트를 제거한다
		//업로드된 이미지 가져와서 변수에 넣기
		var file = upload.files[0];
		
		var reader = new FileReader();
		
		//올린 파일 명에 확장자를 가져와서 체크함
		var fileValue2 = $("#file").val().split("\\");
		var fileName2= fileValue2[fileValue2.length-1]; // 업로드한 파일명
		//이미지 파일인지 체크함
		if(!(checkImageType(fileName2))){
			alert("해당 파일은 이미지 파일이 아닙니다. 다시 확인 해주세요.");
			return;
		}
		//console.log(fileName2);
	
		reader.onload = function(event) {
			var img = new Image();
			$('.profile').attr("src",event.target.result);
			
			
			// note: no onload required since we've got the dataurl...I think! :)
		
			//이미지 크기가 너무크면 그 이미지를 줄여서 보여주는 조건
			if (img.width > 56 && img.height > 56 || img.width == 0
					&& img.height == 0) { // holder width
				img.width = 200;
				img.height = 170;
			}
			//holder값을 삭제후에 자식으로 이미지를 넣어준다.
		
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
	$('#checkbtn').on("click",function() {
		//POST 형식으로 FORM 보내기 작성 $.ajax형식으로 보내기
		$.ajax({
			type : 'POST', // POST 방식
			url : '/user/checkSignup', //보내는 form action을 지정해줌
			data : {
					// 데이터를 지정해줌 nickname의 값을 받아와서 nickname에 넣어줌 매개변수 request.getparameter("nickname")을 여기서 가져옴
					"nickname" : $('#nickname').val()
			},
			headers : {
						"X-HTTP-Method-Override" : "POST"
			},success : function(data) { //요청을 성공시에 함수를 실행함 data는 스프링에서 값을 받아옴
					// 0이면 닉네임중복아니고 0이외에 숫자는 모두 중복임 닉네임은 유니크값이라 1개라도 나오면 닉네임 존재한다는 얘기
					if ($.trim(data) == 0) {
						$('#checkMsg').html('<p id="check" style="color:blue">사용 가능한 닉네임입니다.</p>');
					} else {
						$('#checkMsg').html('<p id="check" style="color:red">사용 불가능한 닉네임입니다.</p>');
					}
			},
			error:function(){
				alert("통신 에러가 발생했습니다.");
			}	   	  
		}); //end ajax    
	}); //end on
	
	//이미지 체크 매개변수에 값을넣어서 맞으면 true 틀리면 false를 반환함 if()에 사용 
	function checkImageType(fileName) {
			// i는 대.소 문자의 구분없음
			var pattern = /jpg$|gif$|png$|jpeg$/i;
			return fileName.match(pattern);
	}
		
	$('#btnDelete').on("click",function(){
		history.go(-1);
	});	
	
	$('.delete-profile').on("click",function(){
		event.preventDefault();
		$.ajax({
			type :"GET",
			url : "/user/deleteProfile",
			success : function(data){
				$('.profile').attr("src","https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate/default.gif");
			},
			error:function(){
				alert("통신 에러가 발생했습니다.");
			}	   	  
		}) //end ajax
	})
	
} // end window.onload