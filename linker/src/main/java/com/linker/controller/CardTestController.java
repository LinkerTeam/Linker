package com.linker.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.eclipse.core.internal.resources.Project;
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
		ProjectVO check = new ProjectVO();
		check.setT_id(teamID);
		check.setU_id(vo.getId());
		//해당팀원이 아니면 그 팀에 모든 프로젝트에 들어갈수없게 막는다.
//		if(proService.checkProject(check)==0) {		
//			return "redirect:/main";  //redirect:는  해당 jsp가 아니라 해당 mapping을 URI를 찾아감   
//		} else {
		ProjectVO pvo = proService.titleName(p_ID);
		pvo.setT_id(teamID);
		pvo.setId(p_ID);
		pvo.setU_id(vo.getId());
		System.out.println(pvo.toString());
		model.addAttribute("project",pvo);
		return "/board/cardTest";
//		}
	};
	
}
