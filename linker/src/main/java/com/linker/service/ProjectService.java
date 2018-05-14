package com.linker.service;

import java.util.List;

import com.linker.domain.ProjectVO;
import com.linker.domain.UserVO;
 
public interface ProjectService {
	// 프로젝트 생성
	public int createProject(ProjectVO vo) throws Exception;
	// 프로젝트 리스트
	public List<ProjectVO> listProject(int userID) throws Exception;
	// 프로젝트 상태 변경(가리기/완전숨기기) & title 변경
	public void modifyProject(ProjectVO vo) throws Exception;
	public ProjectVO titleName(int p_id) throws Exception;
	public List<UserVO> teamProfile(int t_id) throws Exception;
	//해당 팀원이 아니면 프로젝트에 들어갈수없음
	public int checkProject(ProjectVO vo)throws Exception;
	//프로젝트 히든리스트
	public List<ProjectVO> hiddenList(int u_id)throws Exception;
	//프로젝트 즐겨찾기
	public void favoriteAdd(int u_id,int p_id)throws Exception;
	//즐겨찾기 프로젝트
	public List<ProjectVO> favoriteList(int u_id)throws Exception;
	//즐겨찾기 삭제
	public void favoriteDelete(int u_id,int p_id) throws Exception;
}
