package com.linker.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;

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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
import com.linker.util.MediaUtils;
import com.linker.util.UploadFileUtils;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService service;

	@Inject
	SignupService singupService;
	

	@Resource(name="uploadPath")
	  private String uploadPath;

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	// DTO를 자동으로 STS가 매개변수에 넣어줌
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	// @ModelAttribute은 해당객체를 자동으로 view 까지전달
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {

	}

	// 뷰단에서 받아온 DTO(뷰데이터에서 받아온 객체)하는곳 리턴값void로 한이유는 loginInterceptor에서 지정해주기때문
	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {
		// 화면으로 부터 받아온 dto를 service.login(dto)로 넣고 DB까지 다녀왔다가 다시 값을 가져와서
		// UserVO에 넣고 그받아온 값을 model.addAttribute에 담아서 다시 화면으로 보내준다.

	   // 1.	interceptor prehandler() 사용
		
		// DB에서 받아온 값을 vo에 저장함.
		UserVO vo = service.login(dto);

		// 받아온값이 null이면 return값이 없이 메서드를 호출한곳으로보냄
		if (vo == null) {
			return;
		}

		model.addAttribute("userVO", vo);

		// 사용자에게 리멤버를 눌렀을 경우.. 세션을 DB에 저장한다.
		if (dto.isUseCookie()) {
			System.out.println("2");
			int amount = 60 * 60 * 24 * 7;
			System.out.println(1000 * amount);
			// 7일간 세션을 유지하는 시간 지정 (DB에 sessionlimit을 지정함)

			Date sessionLimit = new Date(System.currentTimeMillis() + (1000 * amount));

			
			service.keepLogin(vo.getEmail(), session.getId(), sessionLimit,vo.getProfile());
			
			//4.interceptor posthandler() 사용 
		}
	}

	@RequestMapping(value = "/connect", method = RequestMethod.GET)
	public void connect() {

	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {

		Object obj = session.getAttribute("login");

		if (obj != null) {
			UserVO vo = (UserVO) obj;

			session.removeAttribute("login");
			
			//세션을 강제종료 시킨다.
			session.invalidate();

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

			if (loginCookie != null) {
				loginCookie.setPath("/");
				// 쿠키 삭제하는거 쿠키가 있으면 쿠키시간은 0으로 바꿔줌으로써 쿠키를 삭제시킴
				// 삭제된 쿠키를 브라우저로 보냄
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
				service.keepLogin(vo.getEmail(), session.getId(), new Date(),vo.getProfile());
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
	public String UserUpdate(UserDTO dto, Model model, HttpServletRequest request) throws IOException, Exception{
         //MultipartFile은 POST 방슥으로 들어온 파일 데이터를 의미         
				System.out.println(dto);
				
			
		
				System.out.println(dto.getProfile()); 
				// 화면으로 부터 받아온 파일을  MultipartFile타입 uploadfile에 넣어준다
				 MultipartFile uploadfile = dto.getProfileName();
				 
                       System.out.println("너는 뭐냐?"+uploadfile);

		

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
		
		//오리지날 파일을 검사해서 파일타입을 체크할것 이미지파일만 올리기로
		String imageType = uploadfile.getOriginalFilename().substring(uploadfile.getOriginalFilename().lastIndexOf(".")+1);
	
		
       
		
		System.out.println("imageType는?"+imageType);
		System.out.println("bb는?"+(imageType.equals("jpg")));
        //이미지 타입을 검사해서 이미지인 경우에만 DB에 저장 한다.
		if(imageType.equals("jpg") || imageType.equals("png") || imageType.equals("gif")|| imageType.equals("jpge") ) {
		String realPath=UploadFileUtils.uploadFile(uploadPath, uploadfile.getOriginalFilename(), uploadfile.getBytes());
        //들어온 파일의 주소를 db에 저장하기위해서 set으로 지정해줌 그런데 파일을 넣지않아도 파일이 저장된다.
		dto.setProfile(realPath);
       }
		System.out.println(dto.getProfile());
		
		service.updateUser(dto);
		//들어온 파일을 저장하는 공간.
		
		
		return "redirect:userModify";
	}

	
	
	//닉네임 중복 검사 하는  매소드것
	@ResponseBody
    @RequestMapping(value = "/checkSignup", method = RequestMethod.POST)
    public String checkSignup(HttpServletRequest request, Model model) throws Exception {
        
		//화면으로 부터 받아온 닉네임을 받아옴 request.getParameter("nickname");으로 html태그에 name을 가져옴
		String nickname = request.getParameter("nickname");
		
		//닉네임을 DB에 넣고 받아온 결과를 rowcount에 넣어줌  0이나 1이 들어옴 0이면 중복이 아니고 1이면 닉네임이 있어 중복임
        int rowcount = service.checkSignup(nickname);
        
        //JSON으로 값을 리턴함 
        return String.valueOf(rowcount);
    }


	//get방식으로 URI에서 ?fileName이후에 값을 매개변수로 넣어줌
	//저장한 이미지 파일 불러오기!!!!!!! get방식!!!
	@ResponseBody
	@RequestMapping("/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		 
		
		//자바 인풋스트림 클래스 사용 데이터 전송시 사용함! 
		 InputStream in =null;
		 
		 //데이터 전송과 상태 를전송하는 클래스 선언 
		 ResponseEntity<byte[]> entity = null;
		
		 try {
			 
			 String formatName =fileName.substring(fileName.lastIndexOf(".")+1);
			 
			 MediaType mType = MediaUtils.getMediaType(formatName);
			 
			 HttpHeaders headers = new HttpHeaders();
			 
			 in = new FileInputStream(uploadPath+fileName);
			 System.out.println(in);
			 
			 //타입 검사하는 것 이미지 파일이면  화면에 보이고 아니면 다운로드 처리
			 if(mType != null) {
				 
				 //이미지를 출력
				 headers.setContentType(mType); 
			 }else {
				 //이미지파일이 아닌 경우에는 다운로드
				 fileName = fileName.substring(fileName.indexOf("_")+1);
				 //MIME 타입을 다운로드용으로 사용되는 MediaType.APPLICATION_OCTET_STREAM 으로 지정
				 headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				 headers.add("Content-Disposition", "attachment; filename=\""+
				 new String(fileName.getBytes("UTF-8"),"ISO-8859-1")+"\"");
				   
				  
			 }
			 //가져온 이미지를 확인후에 entity에 새로운 객체를 생성자에 넣어줌으로써 IOUtils.toByteArray(in)에 데이타를 넣고 headers에 정보넣고 마지막으로 상태코드를 넣는다
			 entity = new ResponseEntity<byte []>(IOUtils.toByteArray(in),
					  headers,
					  HttpStatus.CREATED);
					  
		 }catch(Exception e) {
			 e.printStackTrace();
			 //오류 발생시 데이터가 없으니 상태코드로 배드 리퀘스트를 전송한다.
			 entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		 }finally {
			 //inputStream은 열었으면 꼭 닫아줘야한다.그래서 try - catch - finally 문으로 finally에 넣어준다.
			 in.close();
		 }
		
		return entity;
	}

	
	//get 방식으로 함 RequestMethod.GET을 사용 
	@RequestMapping(value="/signup",method=RequestMethod.GET)
	public void Signup() throws Exception{
		logger.info("로그인 페이지............");
		
	}
	//회원가입 POST
	@RequestMapping(value="/signup",method=RequestMethod.POST)
	public String signupPOST(UserVO vo, Model model,RedirectAttributes rttr) throws Exception {
		logger.info("로그인 post............");
		
		logger.info(vo.toString());
		
		singupService.insertMember(vo);
		model.addAttribute("check",vo);
		rttr.addFlashAttribute("result","success");
		
		
		return "redirect:login";
	}
	
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void modifyGET(@ModelAttribute("dto") LoginDTO dto) {
	                 logger.info("수정페이지");
		
	}
	
//	@ResponseBody
//    @RequestMapping(value = "/checkSignup", method = RequestMethod.POST)
//    public String checkSignup2(HttpServletRequest request, Model model) throws Exception {
//         System.out.println(request.toString());
//		//화면으로 부터 받아온 닉네임을 받아옴 request.getParameter("nickname");으로 html태그에 name을 가져옴
//		String nickname = request.getParameter("nickname");
//		 System.out.println(nickname);
//		//닉네임을 DB에 넣고 받아온 결과를 rowcount에 넣어줌  0이나 1이 들어옴 0이면 중복이 아니고 1이면 닉네임이 있어 중복임
//        int rowcount = service.checkSignup(nickname);
//         System.out.println(rowcount);
//        //JSON으로 값을 리턴함 
//        return String.valueOf(rowcount);
//    }
//	
//	
	
	
	
}
