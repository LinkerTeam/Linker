package com.linker.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.linker.domain.UserVO;
import com.linker.service.UserService;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);
	
	@Inject
	private UserService service;

	// PreHandle()을 이용하여 현재 사용자가 로그인한상태인지 아닌지를 체크하고 컨트롤러를 호출하게 할 것인지 결정
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String uri=request.getRequestURI();
		   System.out.println(uri);
			String query=request.getQueryString();
			System.out.println(query);
		HttpSession session = request.getSession();
         
		 //세션이없으면서 cookie에 세션id가 저장된경우
		if (session.getAttribute("login") == null) {
			logger.info("current user is not logined");
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");

			if (loginCookie != null) {
				
				System.out.println("모모모모모모모모모모");
				System.out.println("미미미미미미친거같애 띄띄띄"+loginCookie.getValue());
				String value =loginCookie.getValue();
				/*System.out.println(service.checkLoginBefore(loginCookie.getValue()).toString());*/
				UserVO userVO = service.checkLoginBefore(value);
            
                 System.out.println(userVO);
				if (userVO != null) {
				  System.out.println("ddddddddddddddddddddddd");
					session.setAttribute("login", userVO);

					return true;
				}
			}
			
			response.sendRedirect("/user/login");
			return false;
		}
		return true;
	}

}
