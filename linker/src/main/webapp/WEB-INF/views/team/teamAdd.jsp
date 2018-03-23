<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

 <form id="teamAddform" method="POST">
	<div>
		<label for="name">팀이름: </label>
		<input type="text" name="name" placeholder="write team name here."/>
	</div>
	<input type="submit" value="확인" />
</form> 
</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

<script>
$(document).ready(function() {
	$.validator.setDefaults({
		onkeyup : false,
		onclick : false,
		onfocusout : false,
		showErrors : function(errorMap, errorList){
			if(this.numberOfInvalids()){
				alert(errorList[0].message);
			}
		}
	});
	
 	$('#teamAddform').validate({
		debug : true,  
		rules:{
			name : {
				required : true,
				maxlength : 20,
			}
		},
		messages:{
			name : {
				required : "초대할 회원의 이메일을 입력해주세요.",
				maxlength : "20자 이하로 입력해주세요."
			}
		},
		submitHandler : function(form){
			form.submit();
		}
	});
	  
	});
</script>

</html>