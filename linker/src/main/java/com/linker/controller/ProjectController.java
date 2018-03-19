package com.linker.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linker.domain.ProjectVO;
import com.linker.dto.ProjectDTO;
import com.linker.service.ProjectService;

@Controller
@RequestMapping(value ="/pil/*")
public class ProjectController {

	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);
	
	@Inject
	private ProjectService service;

	/*
	 * 프로젝트 생성 컨트롤러
	 * 프로젝트를 생성한 이후에는 생헝한 프로젝트의 정보를 가지고와야한다.
	 * */

	@ResponseBody
	@RequestMapping(value ="t/{teamID}/p", method = RequestMethod.POST)
	public int createProject(@RequestBody ProjectVO vo) throws Exception {
		// RequestParameter
		logger.info(vo.toString());
		return service.createProject(vo);
	}

	/*
	 * 프로젝트 리스트
	 * */
	//FIXME: 페이징처리추가
	@ResponseBody
	@RequestMapping(value="t/{teamID}/p", method = RequestMethod.GET)
	public List<ProjectVO> listProject(@PathVariable int teamID) throws Exception {
		ProjectDTO dto = new ProjectDTO();
		dto.setT_id(teamID);
		//FIXME:  사용자의 아이디값을 세션에서 가지고오도록해야함.
		dto.setU_id(1);
		return service.listProject(teamID);
	}

//	/*
//	 * 프로젝트 수정
//	 * */
//	@ResponseBody
//	@RequestMapping(value="t/{teamID}/p", method = RequestMethod.PUT)
//	public ProjectVO modifyProject(@RequestBody ProjectVO vo) {
//		return service.modifyProject(vo);
//	}

}
