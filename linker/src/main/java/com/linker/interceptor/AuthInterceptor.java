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
	// PreHandle()은 컨트로럴에 Method에 들어가기전에 미리 먼저 preHandle매서드를 실행함 그다음 컨트롤러 실행
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
/*    로그인 처리중 해당 URI를 저장해서 로그인시 다시 그쪽으로 보내주기위한 로직
		String uri = request.getRequestURI();

		String query = request.getQueryString();*/

		HttpSession session = request.getSession();

		// 세션을 체크하는 구간 세션이 없으면 로그인하지않았다고 판단
		if (session.getAttribute("login") == null) {
			//logger.info("current user is not logined");
			//브라우저로부터 자동저장 쿠키를 가져온다!
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			// 세션이없으면서 cookie에 세션id가 저장된경우를 체크 자동로그인처리
			if (loginCookie != null) {
				//브라우저에 저장된 쿠키정보를 가져온다.
				String value = loginCookie.getValue();
				//값이 있으면 자동로그인을위해 값을 넣어줌
				UserVO userVO = service.checkLoginBefore(value);
				//값이 있으면 세션을 생성해준다. 자동로그인처리
				if (userVO != null) {
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
