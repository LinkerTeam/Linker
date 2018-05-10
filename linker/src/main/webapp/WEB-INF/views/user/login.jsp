<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script defer src="https://use.fontawesome.com/releases/v5.0.6/js/all.js"></script>
    <!-- css초기화 시트 -->
    <link href="/resources/css/common.css" type="text/css" rel="stylesheet" />
    <link href="/resources/css/login.css?ver=32" type="text/css" rel="stylesheet" />
</head>
<body>
    <div class="wrap">
    
        <nav class="main-nav">
			<ul class="image"><img alt="we" src="/resources/image/we.png" class="we-image"/></li> 
			</ul>
			<ul class="image" ><img alt="message" src="/resources/image/message.png" class="message-image"/> 
			</ul>
			<ul class="image"><img alt="mainlogo" src="/resources/image/mainlogo.png" class="mainlogo-image"/></ul>

            <ul>
                <li>
                    <a class="login_btn" href="#modal"><img alt="login" src="/resources/image/login.png" class="login-image" width="60px"/></a>
                </li>
                <li>
                    <a class="signup_btn" href="#0"><img alt="signup" src="/resources/image/signup.png" class="signup-image" width="80px"/></a>
                </li>
            </ul>
        </nav>
        
        <!-- 모달창 -->
        <div class="user-modal" id="modal">
            <div class="user-modal-container">
               <div id="box">
                <ul class="switcher">
                    <li>
                        <a class="login_btn1" href="#0">로그인</a>
                    </li>
                    <li>
                        <a class="signup_btn1" href="#0">회원가입</a>
                    </li>
                </ul>

                <div id="login">
                    <form class="form" name="form1" action ="/user/loginPost" method="post" onsubmit="return login_check();" >
                        <p class="fieldset">
                            <i class="far fa-envelope"></i>
                            <label for="email"> Email </label>
                            <br>
                            <input type="text" class="email" placeholder="Email" name="email" id="email">
                        </p>

                        <p class="fieldset">
                            <i class="fas fa-unlock-alt"></i>
                            <label for="email"> Password </label>
                            <Br>
                            <input type="password" class="password" placeholder="Password" name="password" id="password">
                            <a href="#0" class="hide-password"  id="password1">보이기</a>
                        </p>

                        <p class="fieldset agree">
                           <input type="checkbox" class="checkbox"  name="useCookie">
                            <a>자동로그인</a>
                        </p>

                        <p class="fieldset">
                            <button type="submit" value="Login">Login</button>
                        </p>
                    </form>
                    
                  <!-- 소셜 로그인 -->
				  <div class="social-login">
  					  <a href="${google_url}" class="go-google" title="Connect with Google">
     		 			  <span>Google로 로그인</span>
                	  </a>
				  </div>

                    <p class="form-bottom-message">
                        <a href="#0">Forgot your password?</a>
                    </p>
                </div>


                <div id="signup">

                    <form class="form" name="form2" action="/user/signup" method="post" onsubmit="return signup_check();">


                        <p class="fieldset">
                            <i class="far fa-envelope"></i>
                            <label for="email"> Email </label>
                            <input type="text" class="email" placeholder="Email" name="email" id="email2">
                          <a href="#0" value="중복확인" id="emailcheck" class="check" >중복확인</a><div id="EmailcheckMsg"></div>

                        </p>
                        <p class="fieldset">
                            <i class="far fa-user"></i>
                            <label for="nickname"> Nickname </label>
                            <input type="text" class="nickname" placeholder="Nickname" name="nickname" id="nickname">
                            <a href="#0" value="중복확인" id="checkbtn" class="check" >중복확인</a><div id="checkMsg"></div>
                        </p>

                        <p class="fieldset" id="lastinput">
                            <i class="fas fa-unlock-alt"></i>
                            <label for="email"> Password </label>
                            <input type="password" class="password" placeholder="Password" name="password" id="pw">
                            <a href="#0" class="hide-password" id="password2" >보이기</a>
                            <div class="error-pw"><span class="password-confirm">비밀번호는 8자 이상 영문,숫자,특수문자를 함께 조합하여야 합니다.</span></div>
                       
                            
                            <p class="fieldset agree">
                            <input type="checkbox" id="agree" >
                            I agree to the Terms
                            </p>
                        </p>
                        <p class="fieldset">
                            <button type="submit" id="signupbtn">New account</button>
                        </p>

                    </form>
                </div>
             
            <div id="reset-password">
                    <p class="form-message">비밀번호를 잃어 버렸습니까? 이메일 주소를 넣어주세요.</br> 해당 이메일로 임시 비밀번호를 보내드립니다.</p>
    
                    <form class="form" name="form3" method="post" action="/user/forget" onsubmit="return forgetcheck();" >
                        <p class="fieldset">
                            <i class="far fa-envelope" id="mail"></i>
                            <label class="image-replace email" for="reset-email">E-mail</label>
                            <input class="full-width has-padding has-border" id="reset-email" type="email" name="email" placeholder="E-mail">  
                        </p>
    
                        <p class="fieldset">
                            <input type="submit" class="full-width has-padding input"  value="Reset password">
                        </p>
                    </form>
                   	<p class="form-bottom-message" ><a href="#0" id="back">Back to log-in</a></p>
            </div>
          </div>
        </div>
      </div><!-- 모달창 END -->
    </div>

</body>
    <script src="../../../resources/js/user/login.js" type="text/javascript"></script>

</html>