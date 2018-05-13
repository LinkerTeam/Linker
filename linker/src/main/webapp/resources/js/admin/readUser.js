
/**********************************************************************************
 * 파일명칭 : readUser.js
 * 기    능 : 관리자 게시판 - 회원관리 게시판의 회원 상세보기 페이지에서의 기능
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/04/26 
 **********************************************************************************/



var userId = $("input[name=id]").val(); //해당 회원의 id(PK)
var profileCheck = true; //프로필 유효성 검사
var nicknameCheck = true; //닉네임 유효성 검사 확인 
var passwordCheck1 = true; //비밀번호 유효성 검사 확인
var passwordCheck2 = true; //비밀번호 재입력 유효성 검사 확인



/* 조회 | 구글회원일 경우 비밀번호 변경 폼 숨기기 */
if($("input[name='google']").val() === "구글")
	$(".row.password").hide();
else
	$(".row.password").show();

/* 조회 | 탈퇴회원일 경우 조회만 가능 */
if($(".statusSelect").val() == 2) {
	$("input").attr("disabled", "true");
	$(".btn.btn-info.btn-fill.btn-wd.profile").css("display", "none");
	$(".btn.btn-info.btn-fill.btn-wd").eq(2).css("display", "none");
};

/*
 * 프로필 사진
 * 	- 파일 확장자 : jpg, jpeg, png, gif (대소분자 구분X)
 * 	- 파일 크기 : 1MB = 1,024KB = 1048576Byte
 * 	- 파일명 길이 : 75byte = 한글 35자, 영어 75자
 * 	- 파일을 새로 첨부하지 않았을 경우 전의 사진 삭제하면 안됨 - controller에서 처리
 */


/* 프로필 | 사진 삭제 버튼 클릭했을 때 */
$(".btn-wd.profile").eq(1).click(function(){
	$(".avatar.border-white").attr("src", "https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate/default.gif");
	/* 월요일날 작업 */
});

/* 프로필 | 사진 변경 버튼 클릭했을 때 */
$(".btn-wd.profile").eq(0).click(function(){
	$(".upfileInput").click();
});

/* 유효성 검사 통과하지 못했을 경우 띄우는 경고메시지 */
function profileWarning(str) {
	$(".author > .error").removeClass("success"); 
	$(".author > .error").text(str); //경고메시지 띄움
};

/* 일반 파일첨부 방식 | 파일 첨부창에서 업로드할 파일을 선택 후 */
function upfileInput(obj) {
	var file = obj.files[0];
	fileCheck(file); //파일 유효성 검사하는 함수 호출
};

/* 파일 확인 | 확장자, 파일 크기, 파일명 길이 확인 */
function fileCheck(file) {
	var maxSize = 1048576; // 최대 첨부 가능 파일 크기 = 1MB
	var fileSize = 0;
	var reader = new FileReader();
	
	fileSize = file.size; //첨부할 file의 size
	console.log("파일사이즈 : " + fileSize + "byte, 최대파일사이즈 : 1048576byte");
	
	//확장자 유효성 검사
	if(checkFileType(file.name) === false) return profileCheck = false; //checkFileType함수 안에 경고창 출력 포함되어 있음
	//파일 크기 유효성 검사
	if (fileSize > maxSize) { //파일 사이즈가 1MB가 넘을 경우
		profileWarning("1MB 이하의 이미지파일만 등록 가능합니다.");
		return profileCheck = false;
	};
	//파일명 길이 유효성 검사
	if(checkByte(file.name) > 75) { //파일명이 75byte를 초과할 경우
		profileWarning("파일명은 한글 35자, 영어 70자까지 가능합니다.");
		return profileCheck = false; 
	};
	
	var str = "하단의 수정버튼을 누르면 저장됩니다.";
	$(".author > .form-control.border-input").val(file.name);
	$(".author > .error").addClass("success"); 
	$(".author > .error").text(str); //경고메시지 띄움
	
	//업로드한 프로필 사진 미리보기
	reader.onload = function (event) { 
		$(".avatar.border-white").attr("src", event.target.result);
	};
	reader.readAsDataURL(file);
	
	return profileCheck = true;
};

/* 파일 확인 | 이미지파일인지 확인 */
function checkFileType(fileName) {
	var index = fileName.lastIndexOf(".") + 1; //뒤에서부터 . 문자를 찾아 index반환
	var fileType = fileName.substr(index); //index를 이용하여 확장자만 추출
	
	var imgPattern = /jpg$|gif$|png$|jpeg$/i; // 첨부 가능한 이미지파일 확장자(i: 대소문자 구분 안 하도록)
	if(fileType.match(imgPattern) === null) { //이미지 파일이 아닌 경우
		profileWarning("이미지파일(.jpg, .jpeg, .png, .gif)만 등록할 수 있습니다.");
		return false; 
	};
	return true;
};

/* 파일 확인 | 파일 첨부가 불가능할 때 띄우는 경고창을 숨기는 함수 */
function hideDiv (){ 
	$(".error").css("display", "none");
};

/* 파일명 정리 | text의 byte 계산, 계산한 byte가 지정한 byte 이상이면 ...으로 생략 표시 */
function checkByte(text) {
    var textByte = 0;
    var index = 0;
    var limitByte = 70;

    if (text == null || text == "") return; //매개변수에 대한 유효성 검사
    
    for (var i = 0; i < text.length; i++) {
        var textChar = escape(text.charAt(i)); //각 글자를 하나씩 떼어서 '%16진수코드값' 형태로 변환
        //escape() : 영어, 숫자, 일부 특수문자는 제외하고 한글과 한자, 일부 특수문자만 16진수코드값으로 바꿔준다.
        
        if (textChar.indexOf("%u") !== -1) { //한글은 2byte
        	textByte += 2;
        } else { //영문, 숫자, 16진수코드값 %u로 변환되지 않는 일부특수문자는 1byte
        	textByte++;
        };
        
        if(textByte === limitByte)
        	index = i;
    };
    
    return textByte; //text의 byte와 생략된 text를 반환
};




/*
 * 닉네임
 * 
 *  - 중복 확인 (단, 기존 본인의 닉네임과 같을 경우에는 중복 메시지를 출력하지 않는다.)
 *  - 글자수 제한 : 한글/영문/숫자/특수기호 모두 3글자 이상, 15자 이내
 */


/* 유효성 검사 */
$("input[name=nickname]").on("input", function(){
	var nickname = $(this).val();
	
	if(nickname.length < 3 || nickname.length > 15) {
		$(".error.nickname").text("3자 이상, 15자 이내로 입력하세요.");
		nicknameCheck = false;
	} else {
		$.ajax({
			type : "POST",
			url : "/admin/nicknameCheck?id=" + userId,
			data : {"nickname" : nickname},
			headers : {
				"X-HTTP-Method-Override" : "POST"
			},
			success : function(data) { //중복된 값의 개수를 세어 반환
				if(data === 1) { //중복일 경우
					$(".error.nickname").text("중복된 닉네임입니다.");
					nicknameCheck = false;
				} else { //중복이 아닐 경우 or 기존 본인 닉네임과 동일할 경우
					$(".error.nickname").text(""); 
					nicknameCheck = true;
				}
			},
			error : function() {
				alert("에러가 발생했습니다.");
			}
		}); //ajax
	};
});


/*
 * 비밀번호
 *  - 2번 입력한 값이 같을 것
 *  - 8자 이상, 16자 이하
 *  - 영문 대소문자 구분, 숫자와 특수문자 조합 (한글 X, 공백 X)
 */


var firstPwd; //처음 입력하는 비밀번호
var secondPwd; //비밀번호 재확인

/* 두번째 비밀번호 체크(함수) */
function secondPwdCheck() {
	secondPwd = $("input[name=password]").val();
	
	if(firstPwd !== secondPwd) {
		$(".error.password").eq(1).text("비밀번호가 일치하지 않습니다.");
		passwordCheck2 = false;
	} else {
		$(".error.password").eq(1).text("");
		passwordCheck2 = true;
	};
};

/* 첫번째 비밀번호 체크 */
$(".form-control.border-input.password").first().on("input", function(){
	firstPwd = $(this).val();
	console.log(firstPwd);
	var num = firstPwd.search(/[0-9]/g);
	var eng = firstPwd.search(/[a-z]/ig);
	var spe = firstPwd.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

	if(firstPwd.search(/\s/) != -1){
		$(".error.password").eq(0).text("비밀번호는 공백 없이 입력해주세요.");
		passwordCheck1 = false;
	} else if(firstPwd.length < 8 || firstPwd.length > 16){
		$(".error.password").eq(0).text("8~16자 이내로 입력해주세요.");
		passwordCheck1 = false;
	} else if(num < 0 || eng < 0 || spe < 0 ){
		$(".error.password").eq(0).text("영문/숫자/특문 조합하여 입력해주세요.");
		passwordCheck1 = false;
	} else {
		$(".error.password").eq(0).text("");
		passwordCheck1 = true;
	};
	secondPwdCheck();
});
/* 두번째 비밀번호 체크 */
$("input[name=password]").on("input", function(){
	secondPwdCheck();
});




/* 전체 수정 버튼 */
//전송해야 할 경우 true를 반환하고 하지말아야 할 경우 false를 반환
function check() {
	console.log("프로필 false : " + profileCheck);
	console.log("닉네임 true : " + nicknameCheck);
	console.log("비밀번호 true : " + passwordCheck1);
	console.log("재비밀번호 true : " + passwordCheck2);
	if($(".statusSelect").val() == 2)
		if(confirm("이 회원을 정말 탈퇴 시키시겠습니까?") === false) return false; 
	if(profileCheck === true && nicknameCheck === true && passwordCheck1 === true && passwordCheck2 === true) {
		return true;
	} else {
		$(".error.submit").text("입력하신 정보를 다시 확인해주세요.");
		return false;
	};
};

/* 전체 취소 버튼 */
$(".btn.btn-info.btn-fill.btn-wd").eq(3).on("click", function(){
	//self.location = "/admin/userList";
	var formObj = $("form[role='form']");
	formObj.attr("method", "get");
	formObj.attr("action", "/admin/userList");
	formObj.submit();
});


/* 전체 메뉴 페이지 이동 */
if($(location).attr("pathname") === "/admin/userList" || $(location).attr("pathname") === "/admin/readUser")
	$(".nav > li").eq(0).addClass("active");
else if($(location).attr("pathname") === "/admin/teamList" || $(location).attr("pathname") === "/admin/readTeam")
	$(".nav > li").eq(1).addClass("active");

