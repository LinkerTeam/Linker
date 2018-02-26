package com.linker.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.ProjectVO;
import com.linker.persistence.ProjectDAO;

@Service
public class ProjectServiceImpl implements ProjectService {
	
	@Inject
	ProjectDAO dao;

	@Override
	public int createProject(ProjectVO vo) throws Exception {
		return dao.createProject(vo);
	}

}
