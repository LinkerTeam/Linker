package com.linker.persistence;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.linker.domain.ProjectVO;
import com.linker.domain.UserVO;

@Repository
public interface ProjectDAO {
 
	// 프로젝트 생성
	public int createProject(ProjectVO vo) throws Exception;
	// 프로젝트 리스트
	public List<ProjectVO> listProject(int userID) throws Exception;
	// 프로젝트 상태 변경(가리기/완전숨기기) & title 변경
	public void modifyProject(ProjectVO vo) throws Exception;
	public ProjectVO titleName(int p_id) throws Exception;
	public List<UserVO> teamProfile(int t_id) throws Exception;
	
}
