package com.linker.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.linker.domain.UserVO;
import com.linker.dto.LoginDTO;
import com.linker.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {

	@Inject
	private UserService service;

	// DTO를 자동으로 STS가 매개변수에 넣어줌
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void loginGET(@ModelAttribute("dto") LoginDTO dto) {
		// @ModelAttribute은 해당객체를 자동으로 view 까지전달

	}

	// 뷰단에서 받아온 DTO(뷰데이터에서 받아온 객체)하는곳
	@RequestMapping(value = "/loginPost", method = RequestMethod.POST)
	public void loginPOST(LoginDTO dto, HttpSession session, Model model) throws Exception {

		UserVO vo = service.login(dto);

		if (vo == null) {
			return;
		}

		model.addAttribute("userVO", vo);

	}

	// @RequestMapping(value="/logout", method =RequestMethod.GET)
	// public String logout(HttpServletRequest request,HttpServletResponse
	// response,HttpSession session) throws Exception{
	// Object obj = session.getAttribute("login");
	// if(obj !=null) {
	// UserVO vo =(UserVO)obj;
	//
	// session.removeAttribute("login");
	// session.invalidate();
	//
	// Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
	//
	// if(loginCookie != null) {
	// loginCookie.setPath("/");
	// loginCookie.setMaxAge(0); //
	// response.addCookie(loginCookie);
	// service.keepLogin(vo.getUid(),session.getId(),new Date());
	// }
	// }
	// return "user/logout";
	//
	// }
	//

}
