
/**********************************************************************************
 * 파일명칭 : cardModalAttach.js
 * 기    능 : 카드 상세 내용 조회 모달에서의 첨부파일 기능을 구현하다.
 * 작 성 자 : 오 윤 주
 * 작성일자 : 2018/04
 **********************************************************************************/



/*
* 첨부파일
*	- 확장자 제한 : 이미지 - jpg, gif, png, jpeg
*					기타 - jsp, html, java, class, js, css, zip, ppt, pptx, doc, docx, xlsx, pdf, hwp, rtf, txt
*	- 각 파일의 크기 제한 : 10MB
*	- 한 카드 전체 파일의 크기 제한 : 50MB
*	- 파일명 제한 : 공백과 확장자명 포함 75byte (확장자 제외 70byte, 목록에서의 표시는 45byte까지만) 
*					한글은 1글자로 계산, 영어는 0.5글자로 계산하면
*					75byte = 확장자 최대 5자 빼고 한글 35자, 영문 70자
*/
/****************************************************************************
첨부파일 부분은 유효성 검사할 것도 많고 전체적으로 복잡해서 쉽게 읽기 어려움.
최대한 중복 제거하고 각각의 함수, 이벤트 구분 잘 해서 정리해야 할 듯.
*****************************************************************************/



var ATTACHLISTNUM = 6; //기본 첨부파일 리스트 개수
var ONECARDATTACHLISTBYTE = 52428800; //한 카드에 첨부할 수 있는 총 용량 : 50MB
var popCardAttachAllByte = 0; //한 카드에 대한 모든 첨부파일 용량(byte)
var attachCount = ATTACHLISTNUM; //불러올 첨부파일 개수



/* 목록 조회 */
function allAttach(){
	$.getJSON("/board/" + p_id + "/card/" + popCardId + "/allAttach", function(lists){
    	var str = "";
    	//최대 6개까지만 목록 출력하기 위해 length 결정함
    	if(lists.length <= attachCount) {
    		var listLength = lists.length; //6개보다 작으면 동적 태그 생성하는 for문 length만큼 돌기
    		$(".uploadedList-btn.more").hide(); //더보기 버튼 숨기기
    	} else {
    		var listLength = attachCount; //6개보다 크면 for문은 6번만 돈다
    		$(".uploadedList-btn.more").show(); //더보기 버튼 출력
    	};
    	
    	if(attachCount > ATTACHLISTNUM) { //현재 출력되어있는 파일 개수가 6개보다 많으면
    		$(".uploadedList-btn.short").show(); //접기 버튼 출력
    	} else {
    		$(".uploadedList-btn.short").hide();
    	};
    	
    	//결정된 length만큼 for문을 돌며 동적 목록 태그 생성
    	for(var i = 0; i < listLength; i++) {
    		var list = lists[i];
    	
			var fullFileName = originalFileName(list.file); //원본 파일명
			var miniFileName = checkByte(fullFileName)[1]; //42byte가 넘어서는 글자는 생략된 파일명
			
			var attachInfoStr = "<div class='attachInfo'>" +
							    "	<p class='fullFileName'>" + fullFileName + "</p>" + 
							    "	<p class='miniFileName'>" + miniFileName + "</p>" + 
							    "	<p class='uploadDate'>" + list.cdate + "</p>" +
							    "	<p class='fileSize'>" + fileUnit(list.size) + "</p>";
			if(list.ps_id === 1){ //진행카드만 delete버튼 추가하고 div 닫음
				attachInfoStr += "<button class='attachDeleteBtn' data-src='" + list.file + "'>Delete</button></div>";						
			} else { //진행카드가 아니면 delete버튼 없이 div 닫음
				attachInfoStr += "</div>";	
			};
			
			if(checkFileType(fullFileName) === "image"){ //이미지 파일 일 때(썸네일 img 태그 포함)
				str += "<div class='attachLi'>" +
					   "    <div class='attachThumbnail'>" +
					   "        <a href='#'>" +
					   "            <img class='thumbnail' src='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/uploadFile" + list.file + "'/>" +
					   "        </a>" + 
					   "    </div>" + attachInfoStr +
					   "</div>";
			} else { //일반 파일일 때
				str += "<div class='attachLi'>" +
		  			   "    <div class='attachThumbnail'>" +
					   "        <a href='https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/uploadFile" + list.file + "'>" +
					   "            <p>" + checkFileType(fullFileName) + "</p>" +
					   "        </a>" + 
					   "    </div>" + attachInfoStr +
					   "</div>";
			};
    	}; //for	
    	$(".uploadedList").html(str);
    	//해당 카드에 대한 모든 첨부파일의 총 용량 구함
    	popCardAttachAllByte = 0;
    	$(lists).each(function() {
    		popCardAttachAllByte += this.size;
    	});
	}); //getJSON
};

/* 목록 조회 | 더보기 버튼을 눌렀을 경우 */
$(".uploadedList-btn.more").click(function(){
	attachCount += ATTACHLISTNUM;
	allAttach();
});
/* 목록 조회 | 접기 버튼을 눌렀을 경우 */
$(".uploadedList-btn.short").click(function(){
	attachCount = ATTACHLISTNUM;
	allAttach();
});


/* 파일명 정리 | text의 byte 계산, 계산한 byte가 지정한 byte 이상이면 ...으로 생략 표시 */
function checkByte(text, limitByte) {
    var textByte = 0;
    var index = 0;

    if (text == null || text == "") return; //매개변수에 대한 유효성 검사
    if (limitByte == "" || limitByte == null) limitByte = 40; //textByte를 따로 지정해주지 않았을 경우. 기본값
    
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
    
	if (textByte > limitByte)
		text = text.substr(0, index) + "...";
    
    return [textByte, text]; //text의 byte와 생략된 text를 반환
};

/* 파일명 정리 | 원본 파일명 추출하기 */
function originalFileName(fileName){
	var originalName = fileName.indexOf("_") + 1; //파일명 중 _ 의 index값 구함
	return fileName.substr(originalName); //_ 뒤의 문자열 return
};

/* 파일 확인 | 확장자 확인 */
function checkFileType(fileName) {
	var index = fileName.lastIndexOf(".") + 1; //뒤에서부터 . 문자를 찾아 index반환
	var fileType = fileName.substr(index); //index를 이용하여 확장자만 추출
	
	var imgPattern = /jpg$|gif$|png$|jpeg$/i; // 첨부 가능한 이미지파일 확장자(i: 대소문자 구분 안 하도록)
	var basicFilePattern = /jsp$|html$|java$|class$|js$|css$|zip$|ppt$|pptx$|doc$|docx$|xlsx$|pdf$|hwp$|rtf$|txt$/i; //첨부 가능한 기타파일 확장자
	var returnValue;
	
	if(fileType.match(basicFilePattern) !== null){ //기타 파일일 경우
		return fileType.toUpperCase();// 확장자 반환(.toUpperCase() : 대문자로 변환)
	} else if(fileType.match(imgPattern) !== null) { //이미지 파일일 경우
		return "image"; //image 문자열 반환
	} else { //첨부 가능한 확장자가 아니면 경고창 띄우고 return
		hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
		var str = "<div class='fileSizeWarning'><span>" + fileType + " 의 확장자는 첨부가 불가능합니다.</span></div>";
		$("#popupBox").after(str); //경고메시지 띄움
		
		setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
		return false; //ajax 호출 하지 않고 return
	};
};

/* 파일 확인 | 파일 첨부가 불가능할 때 띄우는 경고창을 숨기는 함수 */
function hideDiv (){ 
	$(".fileSizeWarning").css("display", "none");
};

/* 파일 확인 | 파일 크기에 따라 출력 단위 결정 */
function fileUnit(fileSize){
	var str;
	if (fileSize / 1024 > 1) { //1KB 초과일 때 
		if (((fileSize / 1024) / 1024) > 1) { // 1MB 이상
			fileSize = (Math.round(((fileSize / 1024) / 1024) * 100) / 100);
			str = fileSize + "MB";
		} else { // KB
			fileSize = (Math.round((fileSize / 1024) * 100) / 100);
			str = fileSize + "KB";
		};
	} else { //1KB 이하일 때 
		fileSize = (Math.round(fileSize * 100) / 100);
		str = fileSize + "Byte";
	};  
	return str;
};


/* 일반 파일첨부 방식 | 파일 첨부창 띄우기 */
$(".chooseFile").click(function(){
	$(".upfileInput").click();
});

/* 일반 파일첨부 방식 | 파일 첨부창에서 업로드할 파일을 선택 후 */
function upfileInput(obj) {
	var file = obj.files[0];
	fileCheck(file); //첨부한 파일크기 측정하여 ajax처리 하는 함수 호출		
};


/* Drag & drop 방식 | 브라우저에 파일을 끌어다 놓았을 때 파일 보여주는 창 띄우는 것을 막음 */
$(".popupCard").on("dragenter dragover", function(event){
	event.preventDefault(); //이벤트 제한
});			
			
/* Drag & drop 방식 | 브라우저의 지정 위치에 파일을 drop했을 때 */
$(".popupCard").on("drop", function(event){
	event.preventDefault(); //기본 이벤트 제한
	
	var files = event.originalEvent.dataTransfer.files; //전달된 파일 데이터를 가져옴
	var file = files[0];
	
	if(file === undefined) return; //알 수 없는 객체를 drop할 경우

	if(popCardPsId === 2 || popCardPsId === 3){ //보관함이나 휴지통에 있는 카드에 drop했을 때
		hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
		var str = "<div class='fileSizeWarning'><span>이 카드는 보관상태로, 파일을 첨부할 수 없습니다.</span></div>";
		$("#popupBox").after(str); //경고메시지 띄움
		
		setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
		return;
	};
	
	fileCheck(file); //파일크기 측정하여 ajax처리 하는 함수 호출			
});


/* 파일 확인 | 파일 크기, 파일명 길이, 확장자 확인하여 적합할 경우 ajax 호출 */
function fileCheck(file) {
	var maxSize = 10485760; // = 10MB
	var fileSize = 0;
	var formData = new FormData(); //FormData객체 : <form>태그로 만든 데이터 전송 방식과 동일하게 파일 데이터 전송
	
	var remain = fileUnit(ONECARDATTACHLISTBYTE - popCardAttachAllByte);
	
	fileSize = file.size; //첨부할 file의 size
	console.log("파일사이즈 : " + fileSize + "byte, 최대파일사이즈 : 10485760byte");

	//해당 카드의 전체 첨부파일 용량(50MB) 확인
	if(popCardAttachAllByte + fileSize > ONECARDATTACHLISTBYTE) {
		hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
		if(parseInt(remain) > 0) { //용량이 남았을 때
			var str = "<div class='fileSizeWarning'><span>이 카드는 총 첨부 용량을 초과했습니다. 기존의 파일을 삭제하거나 " 
											+ remain + " 이하의 파일만 첨부가 가능합니다.</span></div>";
		} else { //용량이 남지 않았을 때
			var str = "<div class='fileSizeWarning'><span>이 카드는 총 첨부 용량을 초과했습니다. 더이상 첨부가 불가능합니다. 다른 파일을 삭제해 주세요.</span></div>";
		};
		$("#popupBox").after(str); //경고메시지 띄움
		
		setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
		return; //ajax 호출 하지 않고 return
	};
	//확장자 유효성 검사
	if(checkFileType(file.name) == false) return; //checkFileType함수 안에 경고창 출력 포함되어 있음
	//파일 크기 유효성 검사
	if (fileSize > maxSize) { //파일 사이즈가 10MB가 넘을 경우
		hideDiv(); //다른 경고창이 떠있을 경우 숨긴다
		var str = "<div class='fileSizeWarning'><span>10MB 이하의 파일만 등록 가능합니다.</span></div>";
		$("#popupBox").after(str); //경고메시지 띄움
		
		setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
		return; //ajax 호출 하지 않고 return
	};
	//파일명 길이 유효성 검사
	if(checkByte(file.name)[0] > 75) { //파일명이 75byte를 초과할 경우
		var str = "<div class='fileSizeWarning'><span>파일명은 한글 35자, 영어 70자까지 가능합니다.</span></div>";
	
		$("#popupBox").after(str); //경고메시지 띄움
		
		setTimeout("hideDiv()", 5000); //5초 뒤에 경고메시지 사라짐
		return; //ajax 호출 하지 않고 return
	};
	
	
	formData.append("file", file); //FormData객체에 파일 데이터 객체를 추가함
	
	$.ajax({
		url : "/board/" + p_id + "/card/" + popCardId + "/addAttach",
		data : formData,
		dataType : "text",
		processData : false, //데이터를 일반적 query string으로 변환할 것인지에 대한 설정. 기본값 true로 설정할 경우 'application/x-www-form-urlencoded' 타입으로 전송하게 된다.
		contentType : false, //기본값인 application/x-www-form-urlencoded 말고 multipart/form-data방식으로 파일전송 하기 위해 false
		type : "POST",
		success : function(data) {
			if (data !== null) {
				var count = $(".attachLi").length; //첨부파일 개수
				//첨부파일 아이콘이 없는 상태에서 새로 등록할 경우 아이콘과 1추가
				if(count === 0)
					$(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").append("<i class='fas fa-paperclip'></i><p>1</p>");
				else //댓글 아이콘이 있는 상태에서 새로 등록할 경우 count +1
					$(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").children(".svg-inline--fa.fa-paperclip.fa-w-14").next("p").html(count + 1);
				allAttach(); //첨부파일 목록 갱신
			};
		},
		error : function() {
			alert("통신 에러가 발생했습니다."); 
		}
	}); //ajax
};
	

/* 삭제 | delete 버튼을 눌렀을 경우 confirm 후 ajax처리 */
$(".uploadedList").on("click", ".attachDeleteBtn", function(e) {
	if(!(confirm("삭제한 첨부파일은 되돌릴 수 없습니다. 정말 삭제하시겠습니까?"))) return;
	
	var deleteBtn = $(this);
	
	$.ajax({
		url : "/board/deleteAttach",
		type : "POST",
		data : {
			fileName : $(this).attr("data-src")
		},
		dataType : "text",
		success : function(result) {
			if (result === "DELETED") {
				
				var count = $(".attachLi").length; //첨부파일 개수
				var attachIcon = $(".cardtitleLi[data-id=" + popCardId + "]").children(".cardIcon").children(".svg-inline--fa.fa-paperclip.fa-w-14");
				
				if(count === 1) { //첨부파일이 1개인 상태에서 삭제했을 경우 아이콘, 개수 p태그 삭제
					$(attachIcon).next("p").remove();
					$(attachIcon).remove();
				} else { //삭제 후에도 첨부파일이 0개가 아니면 count -1
					$(attachIcon).next("p").html(count - 1);
				};
				
				allAttach();
			};
		}
	}); //ajax
});


/* 이미지파일 조회 | img파일 썸네일을 누를 경우 */
$(".uploadedList").on("click", ".thumbnail", function() {
	var fullFileName = $(this).parent().parent().next().children(".fullFileName").text();
	var str = "<img class='originalImg' src='" + $(this).attr("src") + "' /><p>" + fullFileName + "</p>";
	
	$(".imgModal").html(str); //이미지 보여주는 동적 태그 생성하여 삽입
	$(".imgModal").show(); //모달창 출력
	$(".closeModal.imageModal").show(); //X버튼 출력
});

/* 첨부파일 | img 모달창에서 X버튼 누르면 모달창 닫기 */
$(document).on("click", function(e){
	var className = $(e.target).attr("class"); //클릭한 요소의 class이름
	
	//클릭한 요소가 이미지모달창이 아니면 모달창 닫기
	if(className !== "thumbnail" && className !== "originalImg"){
		$(".imgModal").hide();
		$(".closeModal.imageModal").hide(); //X버튼 숨기기				
	};
});

