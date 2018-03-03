package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.TeamVO;
import com.linker.persistence.TeamDAO;

@Service
public class TeamServiceImpl implements TeamService{

	@Inject
	TeamDAO dao;

	@Override
	public int createTeam(TeamVO vo) throws Exception {
		return dao.createTeam(vo);
	}

	@Override
	public List<TeamVO> listTeam(int userId) throws Exception {
		return dao.listTeam(userId);
	}

	@Override
	public int modifyTeam(TeamVO vo) throws Exception {
		return dao.modifyTeam(vo);
	}

	@Override
	public int deleteTeam(TeamVO vo) throws Exception {
		return dao.deleteTeam(vo);
	}
	
	
	
}
