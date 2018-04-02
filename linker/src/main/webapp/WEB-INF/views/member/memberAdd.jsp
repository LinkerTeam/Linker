<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

 <form id="memberAddForm" method="post">
	<div>
		<label for="email">email: </label>
		<input type="text" name="email" placeholder="abc@gmail.com"/>
	</div>
	<input type="submit" value="확인" class="submitBtn"/>
</form> 
</body>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

<script>
$(document).ready(function() {
	$.validator.addMethod("gmail",function(value, element){
		return this.optional(element)||/^[a-zA-Z0-9]+@gmail.com$/.test(value);
	},"gmail계정으로 입력해주세요.");
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
	
 	$('#memberAddForm').validate({
		debug : true,  
		rules:{
			email : {
				required : true,
				minlength : 11,
				//gmail : true,
				email : true
			}
		},
		messages:{
			email : {
				required : "초대할 회원의 이메일을 입력해주세요.",
				minlength : "이메일 양식을 다시 확인해주세요.",
				email : "이메일 양식을 다시 확인해주세요."
			}
		},
		submitHandler : function(form){
			form.submit();
		}	
	});
	  
	});
</script>
</html>