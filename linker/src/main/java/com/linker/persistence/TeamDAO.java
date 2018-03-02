package com.linker.persistence;

import java.util.List;

import com.linker.domain.TeamVO;

public interface TeamDAO {

	public int createTeamt(TeamVO vo) throws Exception;
	
	public List<TeamVO> listTeam(int teamID) throws Exception;

	public int modifyTeam(TeamVO vo) throws Exception;
	
	public int deleteTeam(TeamVO vo) throws Exception;
	
}
