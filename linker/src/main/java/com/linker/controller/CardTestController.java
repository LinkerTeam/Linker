package com.linker.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.linker.domain.ProjectVO;
import com.linker.domain.UserVO;
import com.linker.service.CardlistService;
import com.linker.service.ProjectService;
 
@Controller
public class CardTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(CardTestController.class);
	
	@Inject
	private CardlistService service;
	
	@Inject
	private ProjectService proService;
	
	//카드리스트와 카드 페이지 
	@RequestMapping(value = "/board/{teamID}/{p_ID}", method = RequestMethod.GET)
	public String ajaxTest(@PathVariable int teamID, @PathVariable int p_ID, Model model, HttpSession session) throws Exception {

		UserVO vo = (UserVO)session.getAttribute("login");    

		ProjectVO pvo = proService.titleName(p_ID);
		pvo.setT_id(teamID);
		pvo.setId(p_ID);
		pvo.setU_id(vo.getId());
		System.out.println(pvo.toString());
		
		model.addAttribute("project",pvo);
		
		return "/board/cardTest";
	};
	
}
