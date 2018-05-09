package com.linker.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linker.domain.ProjectVO;
import com.linker.domain.ReadCardlistVO;
import com.linker.domain.TeamVO;
import com.linker.domain.UserVO;
import com.linker.service.CardlistService;
import com.linker.service.MyCardFavoriteService;
import com.linker.service.ProjectService;
import com.linker.service.TeamMemberService;
 
@Controller
public class CardTestController {
	
	private static final Logger logger = LoggerFactory.getLogger(CardTestController.class);
	
	@Inject
	private CardlistService service;
	
	@Inject
	private ProjectService proService;
	
	@Inject
	private TeamMemberService tmService;
	
	@Inject
	private MyCardFavoriteService mcfSerivice; 
	
	//카드리스트와 카드 페이지 
	@RequestMapping(value = "/board/{teamID}/{p_ID}", method = RequestMethod.GET)
	public String ajaxTest(@PathVariable int teamID, @PathVariable int p_ID, Model model, HttpSession session) throws Exception {
		UserVO vo = (UserVO)session.getAttribute("login");    	
		ProjectVO check = new ProjectVO();
		check.setT_id(teamID);
		check.setU_id(vo.getId());
		//해당팀원이 아니면 그 팀에 모든 프로젝트에 들어갈수없게 막는다.
		if(proService.checkProject(check) == 0) {	
			return "redirect:/main";  //redirect:는  해당 jsp가 아니라 해당 mapping을 URI를 찾아감   
		} else {
			ProjectVO pvo = proService.titleName(p_ID);
			pvo.setT_id(teamID);
			pvo.setId(p_ID);
			pvo.setU_id(vo.getId());
			model.addAttribute("project",pvo);
			return "/board/cardTest";
		}
	};
	
	//팀멤버 가져오기
	@ResponseBody
	@RequestMapping(value = "/team/list/{t_id}",method = RequestMethod.GET)
	public ResponseEntity<List<UserVO>> teamProfile(@PathVariable int t_id)throws Exception {
		ResponseEntity<List<UserVO>> entity = null;
		
		try {
			entity = new ResponseEntity<>(tmService.hasTeamProfile(t_id),HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	//나의 즐겨찾기
	@RequestMapping(value = "board/mycard", method = RequestMethod.GET)
	public String myFavoriteCard() throws Exception{
		return "user/favoriteCard";
	}
	
	//즐겨찾기 된 리스트
	@ResponseBody
	@RequestMapping(value = "board/favoteam", method = RequestMethod.GET)
	public ResponseEntity<List<ReadCardlistVO>> myTeam(HttpSession session) throws Exception {

		UserVO vo = (UserVO)session.getAttribute("login");
		
		ResponseEntity<List<ReadCardlistVO>> entity = null;
		
		try {
			entity = new ResponseEntity<List<ReadCardlistVO>>(mcfSerivice.myTeamList(vo.getId()),HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ReadCardlistVO>>(HttpStatus.BAD_REQUEST);		}
		return entity;
	}

}
