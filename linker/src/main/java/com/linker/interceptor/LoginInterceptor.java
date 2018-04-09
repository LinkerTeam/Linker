package com.linker.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.linker.domain.UserVO;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

 	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
        
		//세션값을 가져온다
		HttpSession session = request.getSession();
        //modelmap 에는 loginDTO 가 들어있음 입력한 email과 password 그리고 useCookie 가 들어있다 쿠키는 선택시 true 미선택시 false가 들어옴
		ModelMap modelmap = modelAndView.getModelMap();
		
		System.out.println(modelAndView.toString());
		
		//이메일값으로 그 userVO에 값들을 담아온다. 이메일 패스워드 닉네임 프로필경로  생성시간 업데이트시간을 가져온다.
		Object userVO = modelmap.get("userVO");
		
		System.out.println("모델에 뭐들었니?"+userVO);
	
		if (userVO != null) {
			
		  UserVO userVO2 = (UserVO)userVO;
		  //이메일 인증을 했는지 안햇는지 판단 0이면 아직 이메일은 인증 안함 1이면 이메일인증함
		  if(userVO2.getStatus()==1) {
			System.out.println("로그인할때 세션값이 뭐니"+userVO.toString());
			logger.info("new login success");
			//session에 LOGIN키값으로 userVO객체를 저장 그럼 세션에는 email password ninkname 등등 다들어있음 
			session.setAttribute(LOGIN, userVO);
	          //쿠키는 값을 값이 들어있으면 on 없으면 false로 찍힘
			System.out.println("쿠키만들자 퀴퀴퀴"+request.getParameter("useCookie"));
			System.out.println("세션아이디!"+session.getId());
			
			//리멤버미를 클릭시 체크온시 쿠키를 생성해서 값을 저장해서 보내준다.
			if (request.getParameter("useCookie") != null) {
				System.out.println("나 오케이했뜸!!");
				logger.info("remeber me.....");
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(loginCookie);
			}	
			// userVO가 null아니면 홈페이지로 넘어간다.	
	        response.sendRedirect("/main");
	           
	        //탈퇴된 회원을 체크한다.
		  }else if (userVO2.getStatus()==2) {
			 
			  //페이지를 따로넘기지않고 alert창을 뛰움
			  response.setContentType("text/html; charset=UTF-8");
				
			  PrintWriter out = response.getWriter();
			  
			  out.println("<script>alert(' 탈퇴된 회원입니다. 로그인 정보를 다시 확인해주세요. '); history.go(-1);</script>");
			  
			  out.flush();
			
			  return;
			  
		}else {
			 
			  //페이지를 따로넘기지않고 alert창을 뛰움
			  response.setContentType("text/html; charset=UTF-8");
				
			  PrintWriter out = response.getWriter();
			  
			  out.println("<script>alert(' Email을 인증해주세요. '); history.go(-1);</script>");
			  
			  out.flush();
			
			  return;
		  }
	  }else{
		  //userVO값이 널이면 DB로 부터 값을 가져오지못한것 아이디또는 암호가 틀려서 DB를 가져오지못한다 그럼 제대로된 로그인이안됐다는 증거
		  response.setContentType("text/html; charset=UTF-8");
		
		  PrintWriter out = response.getWriter();
		  
		  out.println("<script>alert('로그인 정보를 확인해주세요.'); history.go(-1);</script>");
		  
		  out.flush();
		  
	  }
	
	
	}
	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	
		// HttpSession 을 통해서 request.getSession()으로 값을 넣어준다.
		HttpSession session = request.getSession();

		System.out.println("나나 "+session.getAttribute(LOGIN));
		// 로그인하면서 세션이 존재하면 세션을 제거한다. 새로운 세션을 생성하기위해서 
		if (session.getAttribute(LOGIN) != null) {
			
			
			logger.info("clear login data before");
			session.removeAttribute(LOGIN);
		}
		return true;
	}

}
