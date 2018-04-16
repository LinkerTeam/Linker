package com.linker.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Date;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.connect.Connection;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.dto.UserDTO;
import com.linker.service.SignupService;
import com.linker.service.UserService;
import com.linker.util.MailHandler;
import com.linker.util.MediaUtils;
import com.linker.util.S3Util;
import com.linker.util.UploadFileUtils;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService service;

	@Inject
	private SignupService singupService;

	// 메일보내기를위한 객체를 주입 root-context.xml에서 생성후 지정
	@Inject
	private JavaMailSender mailSender;

	/* GoogleLogin 구글로그인 빈 객체 주입! */
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;

	@Inject
	private OAuth2Parameters googleOAuth2Parameters;

	// 스프링시큐리티 암호화 객체
	@Inject
	private BCryptPasswordEncoder pwdEncoder;

	// 파일 저장 주소를 넣어줌
/*	@Resource(name = "uploadPath")
	private String uploadPath;*/
	
	String uploadpath = "linker/certificate";
	
	S3Util s3 = new S3Util();
	
	String bucketName = "linkers104";

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	// DTO를 자동으로 STS가 매개변수에 넣어줌
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	// @ModelAttribute은 해당객체를 자동으로 view 까지전달
	public String loginGET(Model model, HttpSession session, HttpServletResponse response) throws IOException {

		/* 구글code 발행 주소 URL*/
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		System.out.println("구글:" + url);

		model.addAttribute("google_url", url);

		if (session.getAttribute("login") != null) {
			// 로그인 한 상태로 uri접속시 자바스크립트 self.location을 통해서 다른페이지로 넘겨버림 main페이지로 넘김
			PrintWriter out = response.getWriter();

			out.println("<script>  self.location = '/main'; </script>");

			out.flush();
		}

		/* 생성한 인증 URL을 View로 전달 */
		return "user/login";
	}

	// 뷰단에서 받아온 DTO(뷰데이터에서 받아온 객체)하는곳 리턴값void로 한이유는 loginInterceptor에서 지정해주기때문
	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {
		// 화면으로 부터 받아온 dto를 service.login(dto)로 넣고 DB까지 다녀왔다가 다시 값을 가져와서
		// UserVO에 넣고 그받아온 값을 model.addAttribute에 담아서 다시 화면으로 보내준다.

		// 1.interceptor prehandler() 사용 컨트롤러의 매소드보다 먼저 실행

		// DB에서 받아온 값을 vo에 저장함.
		
		// 비밀번호가 맞으면 true 틀리면 false가 나옴
		if ((pwdEncoder.matches(dto.getPassword(), service.getPassword(dto)))) {

			UserVO vo = service.login(dto);

			model.addAttribute("userVO", vo);

			// 사용자에게 리멤버를 눌렀을 경우.. 세션을 DB에 저장한다.
			if (dto.isUseCookie()) {
				int amount = 60 * 60 * 24 * 7;

				System.out.println(1000 * amount);

				// 7일간 세션을 유지하는 시간 지정 (DB에 sessionlimit을 지정함)

				Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));

				service.keepLogin(vo.getEmail(), session.getId(), sessionLimit, vo.getProfile());
			}
		} else {
			UserVO vo = null;
			model.addAttribute("userVO", vo);
		}
		// 4.interceptor posthandler() 사용 //컨트롤러의 매서드 이후에 사용됨
	}

	@RequestMapping(value = "/connect", method = RequestMethod.GET)
	public void connect() {

	}

	// 로그아웃 페이지 세션을 session.invalidate()로 세션을 모두 종료
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model)
			throws Exception {
		// 세션을 가져온다 "login"키값으로 가진 세션을 가져옴
		Object obj = session.getAttribute("login");

		/* 구글code 발행 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		model.addAttribute("google_url", url);

		if (obj != null) {
			UserVO vo = (UserVO) obj;

			session.removeAttribute("login");

			// 세션을 강제종료 시킨다.
			session.invalidate();

			// 쿠키값을 브라우저로 부터 가져온다 WebUtils.getCookie(request, "loginCookie")로 브라우저로부터
			// loginCookie키값의 쿠키를 가져옴
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

			// 쿠키가 있다면 그쿠키를 삭제 시키는것 유효시간을 0으로 조정해줌으로써 쿠키를 삭제시킴
			if (loginCookie != null) {
				loginCookie.setPath("/");
				// 쿠키 삭제하는거 쿠키가 있으면 쿠키시간은 0으로 바꿔줌으로써 쿠키를 삭제시킴
				// 삭제된 쿠키를 브라우저로 보냄
				loginCookie.setMaxAge(0);
				// 설정한 쿠키를 다시 브라우저 클라이언트로 전송해줌
				response.addCookie(loginCookie);
				service.keepLogin(vo.getEmail(), session.getId(), new Date(), vo.getProfile());
			}

		}

		return "user/login";
	}

	// 03 회원 상세정보 조회
	@RequestMapping(value = "/userModify", method = RequestMethod.GET)
	public void memberView(Model model, HttpServletRequest request) {

		// 회원 정보를 DB에서 받아서 model에 저장 후에 뷰단으로 보냄

		// 요청으로부터 세션을 받아와서 저장함 로그인한상태면 세션에 로그인 값이 지정됨
		HttpSession session = request.getSession();

		// 세션으로부터 값을 받아와서 vo에 넣어준다. 그러면 session에는 그 유저의 email,password,nickname등 모든 값들이
		// 들어있다.
		UserVO vo = (UserVO) session.getAttribute("login");

		System.out.println("session에 들어있는 값" + vo);
		// session에 들어있는 값중 이메일만 따로 추출해서 문자열에 넣어준다.

		String email = vo.getEmail();

		// 세션으로부터 받은 email값을 통해서 service.viewUser()매서드를 통해서 다시 DB로부터 값을 받아온다. 세션으로부터
		// 들어있는 값이아닌 DB값으로
		model.addAttribute("vo", service.viewUser(email));
		// System.out.println("클릭한 메일 확인 : "+email);
		logger.info("클릭한 아이디 : " + email);
		logger.info(service.viewUser(email).toString());
		// member_view.jsp로 포워드
		// return "member/member_view";

	}

	// 04. 회원 정보 수정 처리
	@RequestMapping(value = "/userModify", method = RequestMethod.POST)
	public String UserUpdate(UserDTO dto, Model model, HttpServletRequest request) throws IOException, Exception {
		// MultipartFile은 POST 방슥으로 들어온 파일 데이터를 의미
		System.out.println(dto);

		System.out.println(dto.getProfile());
		// 화면으로 부터 받아온 파일을 MultipartFile타입 uploadfile에 넣어준다
		MultipartFile uploadfile = dto.getProfileName();

		System.out.println("너는 뭐냐?" + uploadfile);

		// 요청으로부터 세션을 받아와서 저장함 로그인한상태면 세션에 로그인 값이 지정됨
		HttpSession session = request.getSession();

		// 세션으로부터 값을 받아와서 vo에 넣어준다. 그러면 session에는 그 유저의 email,password,nickname등 모든 값들이
		// 들어있다.
		UserVO user = (UserVO) session.getAttribute("login");

		System.out.println("session에 들어있는 값" + user);
		// session에 들어있는 값중 이메일만 따로 추출해서 문자열에 넣어준다.
		String email = user.getEmail();

		// 세션으로부터 받은 email값을 통해서 service.viewUser()매서드를 통해서 다시 DB로부터 값을 받아온다. 세션으로부터
		// 들어있는 값이아닌 DB값으로
		model.addAttribute("vo", service.viewUser(email));
		// System.out.println("클릭한 메일 확인 : "+email);
		// return "redirect:/member/list.do";

		// 오리지날 파일을 검사해서 파일타입을 체크할것 이미지파일만 올리기로
		String imageType = uploadfile.getOriginalFilename()
				.substring(uploadfile.getOriginalFilename().lastIndexOf(".") + 1);

		System.out.println("imageType는?" + imageType);
		System.out.println("bb는?" + (imageType.equals("jpg")));
		// 이미지 타입을 검사해서 이미지인 경우에만 DB에 저장 한다.
		if (imageType.equals("jpg") || imageType.equals("png") || imageType.equals("gif") || imageType.equals("jpge")) {
			String realPath = UploadFileUtils.uploadFile(uploadpath, uploadfile.getOriginalFilename(),
					uploadfile.getBytes());
			// 들어온 파일의 주소를 db에 저장하기위해서 set으로 지정해줌 그런데 파일을 넣지않아도 파일이 저장된다.
			dto.setProfile(realPath);
		}
		System.out.println(dto.getProfile());

		dto.setEmail(email);

		service.updateUser(dto);
		// 들어온 파일을 저장하는 공간.
		// 업데이트 이후에 DB를 불러와야 변경 된 DB를 session에 새롭게 저장
		// 세션값을 변경해야 다른곳에서 사용시에도 불러올수있다 만약 변경하지않으면 계속 이미지가 변경 되지않는다. 로그아웃후에 다시 재접속까지.
		session.setAttribute("login", service.viewUser(email));

		return "redirect:userModify";
	}

	// 닉네임 중복 검사 하는 매소드것
	@ResponseBody
	@RequestMapping(value = "/checkSignup", method = RequestMethod.POST)
	public String checkSignup(HttpServletRequest request, Model model) throws Exception {

		// 화면으로 부터 받아온 닉네임을 받아옴 request.getParameter("nickname");으로 html태그에 name을 가져옴
		String nickname = request.getParameter("nickname");

		// 닉네임을 DB에 넣고 받아온 결과를 rowcount에 넣어줌 0이나 1이 들어옴 0이면 중복이 아니고 1이면 닉네임이 있어 중복임
		int rowcount = service.checkSignup(nickname);

		// JSON으로 값을 리턴함
		return String.valueOf(rowcount);
	}

	// get방식으로 URI에서 ?fileName이후에 값을 매개변수로 넣어줌
	// 저장한 이미지 파일 불러오기!!!!!!! get방식!!!
	@SuppressWarnings("resource")
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
        InputStream in = null;
        ResponseEntity<byte[]> entity = null;
        HttpURLConnection uCon = null;
        System.out.println("FILE NAME: " + fileName);

        try{
            String formatName = fileName.substring(fileName.lastIndexOf(".")+1);

            MediaType mType = MediaUtils.getMediaType(formatName);
            HttpHeaders headers = new HttpHeaders();

            String inputDirectory = "linker";
            URL url;


            try {
                url = new URL(s3.getFileURL(bucketName, inputDirectory+fileName));
                System.out.println("https://s3.ap-northeast-2.amazonaws.com/"+inputDirectory+"/linker"+fileName);
                //https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate/2018/04/16/2e66c20a-6e93-43ae-93e5-b812a023bc61_avatar.png
                //https://s3.ap-northeast-2.amazonaws.com/linkers104/linker/certificate/2018/04/16/2e66c20a-6e93-43ae-93e5-b812a023bc61_avatar.png
                uCon = (HttpURLConnection) url.openConnection();
                System.out.println("���� :" + uCon);
                in = uCon.getInputStream(); 
                System.out.println("������ :" + in);
            } catch (Exception e) {
                url = new URL(s3.getFileURL(bucketName, "default.jpg"));
                uCon = (HttpURLConnection) url.openConnection();
                in = uCon.getInputStream();
            }

            
            entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
            headers,
            HttpStatus.CREATED);
        }catch (FileNotFoundException effe){
            System.out.println("File Not found Exception");
            String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
            MediaType mType = MediaUtils.getMediaType(formatName);
            HttpHeaders headers = new HttpHeaders();
            in = new FileInputStream(uploadpath+"/noimg.jpg");

                headers.setContentType(mType);

            entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
                    headers,
                    HttpStatus.CREATED);
         
        }catch (Exception e){
            e.printStackTrace();
            entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
        }finally {
            in.close();
        }
        return entity;
    }
	

	// 회원가입 POST 이메일 인증 도 함께함
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String signupPOST(UserVO vo, Model model, RedirectAttributes rttr) throws Exception {
		logger.info("로그인 post............");

		logger.info(vo.toString());

		// 트랜잭션 처리한 서비스 이메일 보내기와 회원가입을 한번에처리함
		singupService.insertMember(vo);

		// model.addAttribute("check",vo);
		// 이메일 alert창을 띄우기위해서 addFlashAttribute()로 보내준다.
		rttr.addFlashAttribute("email", vo.getEmail());

		return "redirect:/user/signupConfirm";
	}

	// alert창을 띄우기 위해서 하나의 jsp를 더만들었다.
	@RequestMapping(value = "/signupConfirm", method = RequestMethod.GET)
	public void signupConfirm(UserVO vo, Model model, RedirectAttributes rttr) throws Exception {
		// void로 해준이유는 jsp에서 다른페이지로 넘어가게 해주는 자바스크립트에서 self.location = '/user/login'; 처리
		// 해주기때문에 void처리해도된다.

		logger.info(vo.toString());

		/* return "/user/login"; */
	}

	// 이메일 확인을 눌렀을떄 나오는 창
	@RequestMapping(value = "/emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(String email, Model model) throws Exception { // 이메일인증

		// service.userAuth(email);
		// 이메일에서 하이퍼태그를 눌렀을때 그메일에 상태코드를 0에서 1로 변환 시켜준다.
		singupService.status(email);
		// 모델을 통해서 email을 보내주고 그쪽에서 alert()창으로 알려준다.
		model.addAttribute("email", email);

		return "/user/emailConfirm";
	}

	// 이메일 중복확인 매서드
	@ResponseBody
	@RequestMapping(value = "/emailcheck", method = RequestMethod.POST)
	public String emailCheck(HttpServletRequest request) throws Exception {

		String email = request.getParameter("email");

		int count = service.emailCheck(email);

		// String.valueOf()는 Int를 스트링으로 바꿔주는 매소드 int -> String 1 -> "1"로 바꿔줌
		return String.valueOf(count);

	}

	// 잃어버린 비밀번호를 찾는 것
	@RequestMapping(value = "/forget", method = RequestMethod.POST)
	public void forgetPOST(UserVO vo, Model model, RedirectAttributes rttr, HttpServletResponse response,
			HttpSession session) throws Exception {

		System.out.println(service.serchEmail(vo.getEmail()));

		// 클라이언트로 부터 받아온 이메일이 DB에 들어있는지 확인하는과정 1이면 가입되어있다고 판단해서 새로운 비밀번호를 설정하고 설정한 비밀번호를
		// 이메일로 전송해줌.
		if (service.serchEmail(vo.getEmail()) == 1) {
			// 해당회원이 탈퇴된 회원인지 체크함
			UserVO vo2 = service.viewUser(vo.getEmail());
			System.out.println(vo2);

            //구글 회원은 비밀번호를 찾기를 못한다.
            if(vo2.getGoogle().equals("1")) {
            	response.setContentType("text/html; charset=UTF-8");
    			PrintWriter out = response.getWriter();
    			out.println("<script>alert('가입되지 않은  Email입니다. 다시 확인해 주세요'); history.go(-1);</script>");
    			out.flush();
    			return;         	
            }
     
			// 해당회원이 탈퇴된 회원인지 체크함
			if (vo2.getStatus() == 2) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('탈퇴된 회원의  Email입니다. 다시 확인해 주세요'); history.go(-1);</script>");
				out.flush();
				return;
			}
			//가입된 상태의 회원의경우 비밀번호를 임의로 변경 후에 해당메일로 비밀번호 발송
			if(vo2.getStatus() == 1) {
		
			// 임의의 문자와 숫자를 뽑아냄
			UUID uid = UUID.randomUUID();

			// 임의의 랜덤의 문자열을 생성
			String randompassword = uid.toString();
			// 생성한 문자열중에서 8자리만 뽑아내서 password로 넣어줌
			String password = randompassword.substring(0, 8);

			// 임의로 생선된 비밀번호 암호화
			String passwordEncoder = pwdEncoder.encode(password);

			// 임의 정한 비밀번호를 DB에 저장
			vo.setPassword(passwordEncoder);

			// 메일을 보내는 것
			MailHandler sendMail = new MailHandler(mailSender); // 메일 핸들러객체생성

			sendMail.setSubject("[Linker 회원가입 서비스 이메일 인증]"); // 메일제목
			sendMail.setText( // 메일본문(내용)을 적음
					new StringBuffer().append("<h1>임시 비밀번호입니다.</h1>").append("<a>").append(password).append("입니다.</a>")
							.append("로그인후에 비밀번호를 변경해주세요.").toString());
			sendMail.setForm("linkerlink104@gmail.com", "Linker"); // 보내는 사람
			sendMail.setTo(vo.getEmail()); // 받을 사람
			sendMail.send(); // 메일보내기

			service.forgetpassword(vo);
			//경고창 뛰움 비밀번호가 임시비밀번호로 바뀌었으니 가서 확인하고 로그인 후에 새로운 비밀번호로 설정하라고 띄움
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('해당 메일로 임시 비밀번호가 발송되었습니다. 임시 비밀번호를 통해서 로그인 후에 비밀번호를 변경해주세요.');history.go(-1);</script>");
			out.flush();
		
			return;
			}
		} else {// Email이 DB에 없으면 0으로 되고 Email이 가입되지않았다는 alert창을 띄우고 다시 history.go(-1)로 로그인페이지로
				// 돌아간다.
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('가입되지 않은  Email입니다. 다시 확인해 주세요'); history.go(-1);</script>");
			out.flush();
			return;
		}
		
	}

	// 구글 Callback호출 메소드
	@RequestMapping(value = "/googlecallback", method = { RequestMethod.GET, RequestMethod.POST })
	public String googleCallback(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {
		// AIzaSyB3Ze-e-nlF4yAM0ca1WS9BbS2E9yz9OXA

		System.out.println("/user/googlecallback");

		// 사용자 정보 가져오는 로직
		String code = request.getParameter("code");

		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();

		AccessGrant accessGrant = oauthOperations.exchangeForAccess(code, googleOAuth2Parameters.getRedirectUri(),
				null);

		String accessToken = accessGrant.getAccessToken();
		Long expireTime = accessGrant.getExpireTime();

		if (expireTime != null && expireTime < System.currentTimeMillis()) {
			accessToken = accessGrant.getRefreshToken();
			logger.info("accessToken is expired. refresh token = {}", accessToken);
		}

		Connection<Google> connection = googleConnectionFactory.createConnection(accessGrant);

		Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();

		PlusOperations plusOperations = google.plusOperations();
		// Person클래스에 사용자에 정보가 담겨져있다 프로필정보 get매서드로 프로필 정보를 가져온다 처음 동의시에만 한번 가져올수있다. 가입된
		// 사람은 프로필정보를 안가져온다.
		Person person = plusOperations.getGoogleProfile();
		// 사용자 정보 가져오는 로직 여기까지

		// 구글로부터 받아온 프로필을 우리 쪽 DB에 저장하고 비교하는 작업 하는 로직
		String email = person.getAccountEmail();
		String nickname = person.getDisplayName();

		System.out.println(nickname);

		UserVO vo = new UserVO();

		vo.setEmail(email);
		vo.setNickname(nickname);

		System.out.println("vo 뭐다냥" + vo.toString());

		System.out.println(singupService.serchGoogle(vo));

		if (singupService.serchGoogle(vo) == null) {
			// 처음 로그인한 사용자.

			UUID uid = UUID.randomUUID();

			// 임의의 랜덤의 문자열을 생성
			String nicknameRandom = uid.toString();
			// 생성한 문자열중에서 8자리만 뽑아내서 password로 넣어줌
			nickname = nicknameRandom.substring(0, 8);
			// 구글용 임의로 아이디를 만듬
			vo.setNickname("#" + nickname);

			singupService.insertGoogle(vo);
		}

		// 만약 처음 접속시 값을 못가져오기때문에 순서가 중요하다.
		UserVO vo2 = service.viewUser(vo.getEmail());
		System.out.println(vo2.toString());
		if (vo2.getStatus() == 2) {
			// 페이지를 따로넘기지않고 alert창을 뛰움
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert(' 탈퇴된 회원입니다. 로그인 정보를 다시 확인해주세요. '); history.go(-1);</script>");
			out.flush();
			return "user/login";
		}
		// DB로부터 정보 받아와서 세션을에 저장하고싶어서 보냄
		vo = singupService.serchGoogle(vo);
		System.out.println("니가 그거냐" + vo.toString());
		session.setAttribute("login", vo);
		/*
		 * vo.setNickname(profile.getAccountEmail());
		 * System.out.println(profile.getDisplayName()==null);
		 */
		return "user/googleSuccess";
	}

	// 비밀번호 변경창
	@RequestMapping(value = "/passwordchange", method = RequestMethod.GET)
	public String passwordconfirm(HttpServletRequest request, HttpSession session) throws Exception {
		System.out.println("현재 비밀번호 확인다");

		UserVO vo = (UserVO) session.getAttribute("login");

		// 로그인 하지않은 세션을 비교
		if (vo == null) {
			System.out.println("로그인하지않은상태에서 url 접속");
			return "redirect:/user/login";
		}

		System.out.println(vo);
		System.out.println(vo.getGoogle());

		// 구글 로그인으로 비밀번호창 으로 들어올땐 여길 들어올수없게 한다.
		if (!(vo.getGoogle() == null)) {
			if(vo.getGoogle().equals("1"))
			return "redirect:/user/connect";
		}
		return "user/passwordchange";
	}

	// 새로운 비밀번호를 받는 창
	@RequestMapping(value = "/passwordchange", method = RequestMethod.POST)
	public String passwordchange(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			RedirectAttributes rttr) throws Exception {

		System.out.println("post 확인 다");

		// 현재 비밀번호 입력시 확인하는 과정 true면 제대로 비밀번호를 입력한거고 false면 비밀번호를 틀림

		UserVO vo = (UserVO) session.getAttribute("login");

		String password = request.getParameter("password");

		String email = vo.getEmail();

		// 두개의 값을 넘겨주기위해서 DTO객체로 받아서 넘긴다.
		UserDTO dto = new UserDTO();

		dto.setEmail(email);
		dto.setPassword(password);

		System.out.println(dto.toString());

		service.updatePassword(dto);

		System.out.println("비밀번호 변경 완료!");

		return "redirect:/user/passwordchange";
	}

	// 현재 비밀번호 ajax처리
	@ResponseBody
	@RequestMapping(value = "/passwordcheck", method = RequestMethod.POST)
	public boolean passwordcheck(@RequestBody String password, HttpSession session) throws Exception {
		// @RequestBody 는 JSP에서부터 JSON파일로 들어오게되면 그것을 받기 위해서 쓰는 애노테이션

		System.out.println(password);

		UserVO vo = (UserVO) session.getAttribute("login");
		// json 형태로 들어와서 값이 password= 비밀번호를 나오게함 그래서 password=을 짤라버림
		String pw = password.substring(9);

		String email = vo.getEmail();

		// dto로 만든이유는 두개이상의 값을 넣기위해서 사용 아니면 map같은걸 사용해야함
		LoginDTO dto = new LoginDTO();
		dto.setEmail(email);
		System.out.println("dto는 뭐들었니" + dto.toString());
		if (pwdEncoder.matches(pw, service.getPassword(dto))) {
			System.out.println("비밀번호 성공");
			return true;
		} else {
			System.out.println("비밀번호 실패");
			return false;
		}

	}

	// 회원 탈퇴 현재 비밀번호 확인
	@RequestMapping(value = "/secessionUser", method = RequestMethod.GET)
	public String secessionUser(HttpSession session) throws Exception {

		UserVO vo = (UserVO) session.getAttribute("login");

		System.out.println("너는 뭐입니까??" + vo.getGoogle() + "+" + vo.getGoogle().equals("1"));

		if (vo.getGoogle().equals("1")) {

			return "redirect:/user/googleSescession";
		}

		return "user/secessionUser";
	}

	// 회원 탈퇴 현재 비밀번호 확인
	@RequestMapping(value = "/secessionUser", method = RequestMethod.POST)
	public String secessionUser(HttpServletRequest request, HttpSession session, HttpServletResponse response)
			throws Exception {

		UserVO vo = (UserVO) session.getAttribute("login");
		String email = vo.getEmail();
		String password = request.getParameter("password");

		System.out.println(email);
		System.out.println(password);

		LoginDTO dto = new LoginDTO();

		dto.setEmail(email);

		System.out.println("dto는 뭐들었니" + dto.toString());

		// 비밀번호가 틀렸을떄 스프링시큐리티 matches() 매서드 사용
		if (pwdEncoder.matches(password, service.getPassword(dto)) == false) {
			System.out.println("비밀번호 틀려");

			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('비밀번호가 틀렸습니다 다시 입력해주세요.');</script>");

			out.flush();

			return "user/secessionUser";
		}

		// 다음 페이지로 들어가기 위해서 임의의 세션을 만들어줌
		session.setAttribute("success", "OK");

		return "redirect:/user/secessionUserConfirm";
	}

	// 회원탈퇴 창
	@RequestMapping(value = "/secessionUserConfirm", method = RequestMethod.GET)
	public String secessionUserConfirm(HttpSession session) throws Exception {

		System.out.println("일개미");
		// 해당페이지에는 success 세션이 있어야만 들어올수있다. 비밀번호를 입력해야지만 들어올수있다.

		if (session.getAttribute("success") == null) {

			return "redirect:/user/secessionUser";
		}

		System.out.println("나다");

		// 구글로 들어온 세션 삭제
		session.removeAttribute("googlekey");
		// 해당페이지로 들어왔으니 다시 못들어오게 바로 세션을 삭제해준다.
		session.removeAttribute("success");

		System.out.println("구글키" + session.getAttribute("googlekey"));
		
		System.out.println("성공" + session.getAttribute("success"));

		return "user/secessionUserConfirm";
	}

	// 회원탈퇴 창
	@RequestMapping(value = "/secessionUserConfirm", method = RequestMethod.POST)
	public String secessionUserConfirm(HttpSession session, HttpServletRequest request) throws Exception {

		UserVO vo = (UserVO) session.getAttribute("login");
		// 해당 사람이 누구인지 알수있게 세션에서 email을 가져옴.
		String email = vo.getEmail();

		// 해당 유저를 탈퇴함 상태코드를 2로 바꿈으로 탈퇴된 회원으로 변한다.
		service.deleteUser(email);
		System.out.println("나나");

		// 회원 탈퇴와 세션을 종료함
		session.invalidate();
		return "redirect:/user/login";
	}
   
	//구글 탈퇴 확인 페이지
	@RequestMapping(value = "/googleSescession", method = RequestMethod.GET)
	public String googleSescession(HttpSession session) throws Exception {

		System.out.println("/googleSescession");

		UserVO vo = (UserVO) session.getAttribute("login");

		System.out.println("너는 뭐입니까??" + vo.getGoogle() + "+" + vo.getGoogle().equals("0"));

		if (vo.getGoogle().equals("0")) {

			return "redirect:/user/secessionUser";
		}

		return "user/googleSescession";
	}

	// 인증키랑 들어온 값이랑 비교해서 맞으면 회원탈퇴 페이지로 넘어가고 아니면 못들어감
	@RequestMapping(value = "/googleSescession", method = RequestMethod.POST)
	public String googleSescession(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		UserVO vo = (UserVO) session.getAttribute("login");

		// 인증키가 들어있는 세션을 가져와서 비교함 .equals()을 하기위해선 값이 null이면 오류남 그래서 null이 아닐경우에만
		// .equals()를 실행하게함
		String googlekey = (String) session.getAttribute("googlekey");

		System.out.println(googlekey != null);

		String confirm = request.getParameter("confirm");

		if (googlekey != null) {

			if (googlekey.equals(confirm)) {
				session.setAttribute("success", "OK");
				return "redirect:/user/secessionUserConfirm";

			} else {
				response.setContentType("text/html; charset=UTF-8");

				PrintWriter out = response.getWriter();

				out.println("<script>alert('인증번호가 틀렸습니다.');</script>");

				out.flush();

				return "user/googleSescession";
			}

		} else {

			response.setContentType("text/html; charset=UTF-8");

			PrintWriter out = response.getWriter();

			out.println("<script>alert('인증번호가 틀렸습니다.');</script>");

			out.flush();

			return "user/googleSescession";
		}

	}

	// email로 인증키 발송
	@ResponseBody
	@RequestMapping(value = "/googlekey", method = RequestMethod.POST)
	public String googlekey(HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
        //세션가져오기
		UserVO vo = (UserVO) session.getAttribute("login");
        //인증키 생성
		UUID uid = UUID.randomUUID();

		// 임의의 랜덤의 문자열을 생성
		String randompassword = uid.toString();
		// 생성한 문자열중에서 6자리만 뽑아내서 googlekey로 넣어줌
		String googlekey = randompassword.substring(0, 6);

		session.setAttribute("googlekey", googlekey);

		MailHandler sendMail = new MailHandler(mailSender);

		sendMail.setSubject("[Linker 회원탈퇴 서비스 이메일 인증]");
		sendMail.setText(

				new StringBuffer().append("<h1>탈퇴 메일 인증번호</h1>").append("<a")
						.append("><div> 인증번호 " + googlekey + " </div></a>").toString());

		sendMail.setForm("linkers104@gmail.com", "Linker");
		sendMail.setTo(vo.getEmail());
		sendMail.send();

		return "true";
	}
} // end메인
