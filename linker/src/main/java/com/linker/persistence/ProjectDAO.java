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
	// 프로젝트 달성&프로젝트 가리기(숨기기)&프로젝트 이름변경
	public int modifyProject(ProjectVO vo) throws Exception;
	public ProjectVO titleName(int p_id) throws Exception;
	public List<UserVO> teamProfile(int t_id) throws Exception;
	public void hiddenProject(int p_id) throws Exception;
	//프로젝트 다시 불러오기
	public void reopenProject(int p_id) throws Exception;
	//프로젝트 완전히 삭제
	public void deleteProject(int p_id)throws Exception;
	//프로젝트 상태코드 검사
	public ProjectVO projectstatus(int p_id,int t_id)throws Exception;
	
}
