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

		
		HttpSession session = request.getSession();
		
		
		ModelMap modelmap = modelAndView.getModelMap();
		Object userVO = modelmap.get("userVO");
		
		if(userVO != null) {
			logger.info("new login success");
			session.setAttribute(LOGIN, userVO);
			 if(request.getParameter("userCookie") != null) {
				 logger.info("remeber me.....");
				 Cookie loginCookie = new Cookie("loginCookie",session.getId());
				 loginCookie.setPath("/");
				 loginCookie.setMaxAge(60*60*24*7);
				 response.addCookie(loginCookie);
			 }
			response.sendRedirect("/");
		  //userVO가 null아니면 홈페이지로 넘어간다.
		}
	}
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		// TODO Auto-generated method stub
	    //HttpSession 을 통해서 request.getSession()으로 값을 넣어준다.
		HttpSession session =request.getSession();
		
		if(session.getAttribute(LOGIN)!=null) {
			logger.info("clear login data before");
			session.removeAttribute(LOGIN);
		}
		return true;
	}
	
}
