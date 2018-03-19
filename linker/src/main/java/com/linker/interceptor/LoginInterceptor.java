package com.linker.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
       // 세션값을 가져온다
		HttpSession session = request.getSession();
        //modelmap 에는 loginDTO 가 들어있음 입력한 email과 password 그리고 useCookie 가 들어있다 쿠키는 선택시 true 미선택시 false가 들어옴
		ModelMap modelmap = modelAndView.getModelMap();
		System.out.println("모델에 뭐들었니?"+modelmap.toString());
		
		//이메일값으로 그 userVO에 값들을 담아온다. 이메일 패스워드 닉네임 프로필경로  생성시간 업데이트시간을 가져온다.
		Object userVO = modelmap.get("userVO");
		System.out.println("모델에 뭐들었니?"+userVO.toString());
		if (userVO != null) {
			System.out.println("123123123");
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
			response.sendRedirect("/user/userModify");
			// userVO가 null아니면 홈페이지로 넘어간다.
		}
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
		// HttpSession 을 통해서 request.getSession()으로 값을 넣어준다.
		HttpSession session = request.getSession();

		if (session.getAttribute(LOGIN) != null) {
			logger.info("clear login data before");
			session.removeAttribute(LOGIN);
		}
		return true;
	}

}
