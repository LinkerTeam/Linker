package com.linker.persistence;

import org.springframework.stereotype.Repository;

import com.linker.domain.ProjectVO;

@Repository
public interface ProjectDAO {

	// 프로젝트 생성
	public int createProject(ProjectVO vo) throws Exception;

}
