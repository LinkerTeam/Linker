package com.linker.service;
 
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.ProjectVO;
import com.linker.domain.UserVO;
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
	public List<ProjectVO> listProject(int userID) throws Exception {
		return dao.listProject(userID);
	}

	// 프로젝트 상태 변경(가리기/완전숨기기) & title 변경
	@Override
	public void modifyProject(ProjectVO vo) throws Exception {
		dao.modifyProject(vo);
	}

	@Override
	public ProjectVO titleName(int p_id) throws Exception {
		return dao.titleName(p_id);
	}

	@Override
	public List<UserVO> teamProfile(int t_id) throws Exception {
		return dao.teamProfile(t_id);
	}
	
}
