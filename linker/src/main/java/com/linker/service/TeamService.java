package com.linker.service;

import java.util.List;

import com.linker.domain.TeamVO;

public interface TeamService {

	//팀생성
	public int createTeam(TeamVO vo) throws Exception;
	
	//팀출력
	public List<TeamVO> listTeam(int userId) throws Exception;
	
	//팀수정(이름)
	public int modifyTeam(TeamVO vo) throws Exception;
	
	//팀삭제
	public int deleteTeam(TeamVO vo) throws Exception;
}
