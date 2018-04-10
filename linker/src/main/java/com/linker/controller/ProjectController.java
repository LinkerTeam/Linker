package com.linker.controller;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
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

import com.linker.domain.CardlistVO;
import com.linker.domain.ProjectVO;
import com.linker.domain.TeamVO;
import com.linker.domain.UserVO;
import com.linker.dto.ProjectDTO;
import com.linker.service.ProjectService;
import com.linker.service.TeamService;

@Controller
@RequestMapping(value = "main")
public class ProjectController {

	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);

	private static final int ResponseEntity = 0;

	@Inject
	private ProjectService service;

	// 팀 목록과 관련된 서비스.
	@Inject
	private TeamService teamService;

	/*
	 * 프로젝트 생성 컨트롤러 프로젝트를 생성한 이후에는 생헝한 프로젝트의 정보를 가지고와야한다.
	 */

	@RequestMapping(value = "", method = RequestMethod.GET)
	public String projectListGET(Model model, HttpSession session) throws Exception {
		System.out.println("나이니다.");

		// 현재 로그인 사용자의 정보를 세션을통해서 가져온다.
		UserVO vo = (UserVO) session.getAttribute("login");

		int userID = vo.getId();

		System.out.println(userID);
		List<TeamVO> vo2 = (List<TeamVO>) teamService.listTeam(userID);

		// 팀멤버의 정보를 가져오기위해서 List<List<UserVO>>를 사용함
		List<List<UserVO>> profile = new ArrayList<List<UserVO>>();

		// 각각의 팀멤버를 불러와서 List에 담는다.
		for (int i = 0; i < vo2.size(); i++) {

			TeamVO tvo = vo2.get(i);
			List<UserVO> member = (List<UserVO>) service.teamProfile(tvo.getT_id());
			profile.add(member);
		}

		// 7번 유저의 모든 팀을 가져온다.
		model.addAttribute("team", teamService.listTeam(userID));
		model.addAttribute("profile", profile);
		// 7번유저의 모든 프젝을 가져온다.
		model.addAttribute("result", service.listProject(userID));

		System.out.println("나입니다.");
		return "main/projectList";
	}

	@ResponseBody
	@RequestMapping(value = "/insertProject", method = RequestMethod.POST)
	public int createProject(@RequestBody ProjectVO vo) throws Exception {
		System.out.println("여기는 프로젝트를 만드는것");

		System.out.println(vo.toString());

		return service.createProject(vo);
	}

	// 팀하나 클릭시 그안에 들어있는 프로젝트들이 나옴
	@ResponseBody
	@RequestMapping(value = "t/{teamID}/p", method = RequestMethod.GET)
	public List<ProjectVO> listProject(@PathVariable int teamID) throws Exception {
		System.out.println("프로젝트를 보자!");

		System.out.println(service.listProject(teamID));
		return service.listProject(teamID);

	}

	// 프로젝트를 감추기
	@ResponseBody
	@RequestMapping(value = "{p_id}", method = RequestMethod.GET)
	public ResponseEntity<String> hiddenProject(@PathVariable int p_id) throws Exception {
		System.out.println("프로젝트 감추기");
		System.out.println(p_id);
		/* System.out.println(vo.toString()); */
		service.hiddenProject(p_id);

		try {
			return new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}

	}

	// 리오픈 ajax처리
	@ResponseBody
	@RequestMapping(value = "reopen/{p_id}", method = RequestMethod.GET)
	public ResponseEntity<String> reopen(@PathVariable int p_id) throws Exception {

		service.reopenProject(p_id);

		try {
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);

		} catch (Exception e) {
			return new ResponseEntity<String>("BAD", HttpStatus.BAD_REQUEST);
		}
	}

	// 완전 삭제 delete
	@ResponseBody
	@RequestMapping(value = "delete/{p_id}", method = RequestMethod.GET)
	public ResponseEntity<String> deleteProject(@PathVariable int p_id) throws Exception {

		service.deleteProject(p_id);
        System.out.println(1);
		try {
			System.out.println(2);
			return new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
		 
			
		} catch (Exception e) {
		    System.out.println(3);
			return new ResponseEntity<String>("BAD", HttpStatus.BAD_REQUEST);
		}
	}

}
