package com.linker.service;

import java.util.List;

import com.linker.domain.ProjectVO;

public interface ProjectService {
	// 프로젝트 생성
	public int createProject(ProjectVO vo) throws Exception;
	// 프로젝트 리스트
	public List<ProjectVO> listProject(int teamID) throws Exception;
	// 프로젝트 달성&프로젝트 가리기(숨기기)&프로젝트 이름변경
	public int modifyProject(ProjectVO vo) throws Exception;
}
