package com.linker.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linker.domain.CardVO;
import com.linker.domain.ProjectVO;
import com.linker.domain.TeamVO;
import com.linker.domain.UserVO;
import com.linker.dto.ProjectDTO;
import com.linker.service.ProjectService;
import com.linker.service.TeamService;

@Controller
@RequestMapping(value ="/main")
public class ProjectController {
 
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Inject
	private ProjectService service;
	
	//팀 목록과 관련된 서비스.
	@Inject
	private TeamService teamService;

	/*
	 * 프로젝트 생성 컨트롤러
	 * 프로젝트를 생성한 이후에는 생헝한 프로젝트의 정보를 가지고와야한다.
	 * */
	//프로젝트 메인페이지
	@RequestMapping(value="", method=RequestMethod.GET)
	public String projectListGET(Model model,HttpSession session) throws Exception{
	   //현재 로그인 사용자의 정보를 세션을통해서 가져온다.
		UserVO vo =(UserVO) session.getAttribute("login");
		int userID = vo.getId();
		//즐겨찾기 리스트 
		model.addAttribute("favoriteList", service.favoriteList(userID));   
		//7번 유저의 모든 팀을 가져온다.
		model.addAttribute("team", teamService.listTeam(userID));
		//7번유저의 모든 프젝을 가져온다.
		model.addAttribute("result",service.listProject(userID));
		return "main/projectList";
	}	
	
	//프로젝트 생성 
	@ResponseBody
	@RequestMapping(value="/insertProject", method= RequestMethod.POST)
	public ResponseEntity<Integer> createProject(@RequestBody ProjectVO vo) throws Exception{
		System.out.println("프로젝트 생성");
		ResponseEntity<Integer> entity = null;
		     service.createProject(vo);
		     // 프로젝트 생성후에 생성된 기본키(PK)를 받아옴 
		     System.out.println(vo);
		     int p_id=vo.getId();
		try {
			entity = new ResponseEntity<Integer>(p_id,HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<Integer>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
			
	//팀멤버 클릭시 그안에 들어있는 프로젝트들이 나옴
	@ResponseBody
	@RequestMapping(value="t/{teamID}/p", method = RequestMethod.GET)
   public List<ProjectVO> listProject(@PathVariable int teamID) throws Exception{
		return service.listProject(teamID);
	}

	// 수정 | 프로젝트 상태 변경(가리기/완전숨기기) & title 변경, ProjectVO에  ps_id값을 받아옴
	@RequestMapping(value="/{p_id}/{u_id}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> modifyProject(@PathVariable("p_id") Integer p_id, @PathVariable("u_id") Integer u_id, @RequestBody ProjectVO vo){
		ResponseEntity<String> entity = null;
		try {
			vo.setId(p_id);
			vo.setU_id(u_id);
			service.modifyProject(vo);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
			return entity;
	}
	
	@ResponseBody
	@RequestMapping(value="projectlist", method = RequestMethod.GET)
	public ResponseEntity<List<ProjectVO>> projectList(HttpServletRequest request) throws Exception{
		HttpSession session = request.getSession();
		UserVO vo = (UserVO)session.getAttribute("login");
		System.out.println("projectlist");
		return new ResponseEntity<List<ProjectVO>>(service.hiddenList(vo.getId()),HttpStatus.OK);
	}
	
	//즐겨찾기 추가
	@ResponseBody
	@RequestMapping(value="favorite/{p_id}", method = RequestMethod.GET)
	public ResponseEntity<String> favorite(@PathVariable int p_id,HttpSession session) throws Exception{
		UserVO vo = (UserVO) session.getAttribute("login");
		service.favoriteAdd(vo.getId(), p_id);
		ResponseEntity<String> entity = null;
		try {
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//즐겨찾기 불러오기
	@ResponseBody
	@RequestMapping(value="favoritelist", method = RequestMethod.GET)
	public ResponseEntity<List<ProjectVO>> favoriteList(HttpSession session)throws Exception{
		ResponseEntity<List<ProjectVO>> entity = null;
		UserVO vo = (UserVO) session.getAttribute("login");
		int u_id = vo.getId();
		try {
			entity = new ResponseEntity<List<ProjectVO>>(service.favoriteList(u_id),HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<List<ProjectVO>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	//즐겨찾기 삭제
	@ResponseBody
	@RequestMapping(value = "/favoriteDelete", method = RequestMethod.DELETE)
	public ResponseEntity<String> favoriteDelete(@RequestBody ProjectVO pvo,HttpSession session) throws Exception{
		System.out.println("즐겨찾기 삭제");
		ResponseEntity<String> entity = null;
		UserVO vo = (UserVO) session.getAttribute("login");
		int u_id = vo.getId();
		int p_id = pvo.getId();
		service.favoriteDelete(u_id, p_id);
		try {
			entity= new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		} catch (Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
