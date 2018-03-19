package com.linker.service;

import java.util.List;
import com.linker.domain.TeamVO;

public interface TeamService {

	//팀생성
	public int createTeam(TeamVO vo) throws Exception;

	//팀 목록 리스트 출력
	public List<TeamVO> listTeam(int u_id) throws Exception;
	
	//팀 id 출력
	public int selectTeam(String name) throws Exception;
	
	//팀수정(이름)
	public int modifyTeam(TeamVO vo) throws Exception;
	
	//팀삭제
	public int deleteTeam(int t_id) throws Exception;
}
