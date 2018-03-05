package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.ProjectVO;
import com.linker.persistence.ProjectDAO;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Inject
	ProjectDAO dao;

	// 프로젝트 생성
	@Override
	public int createProject(ProjectVO vo) throws Exception {
		return dao.createProject(vo);
	}

	// 프로젝트 리스트
	@Override
	public List<ProjectVO> listProject(int teamID) throws Exception {
		return dao.listProject(teamID);
	}

	// 프로젝트 달성&프로젝트 가리기(숨기기)&프로젝트 이름변경
	@Override
	public int modifyProject(ProjectVO vo) throws Exception {
		return dao.modifyProject(vo);
	}


}
