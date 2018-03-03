package com.linker.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter{
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	
	//PreHandle()을 이용하여 현재 사용자가 로그인한상태인지 아닌지를 체크하고 컨트롤러를 호출하게 할 것인지 결정
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		
		
		if(session.getAttribute("login")==null) {
			logger.info("current user is not logined");
			
			response.sendRedirect("/user/login");
			return false;
		}
		return true;
		
	}
	
	
	

}
