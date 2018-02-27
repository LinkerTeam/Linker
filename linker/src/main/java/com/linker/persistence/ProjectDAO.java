package com.linker.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.linker.domain.ProjectVO;

@Repository
public interface ProjectDAO {

	// 프로젝트 생성
	public int createProject(ProjectVO vo) throws Exception;
	// 프로젝트 리스트
	public List<ProjectVO> listProject(int teamID) throws Exception;
	// 프로젝트 달성&프로젝트 가리기(숨기기)&프로젝트 이름변경
	public int modifyProject(ProjectVO vo) throws Exception;
}
