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

	//팀생성 
	@Override
	public TeamVO createTeam(TeamVO vo) throws Exception {
		dao.createTeam(vo);
		TeamVO tvo = new TeamVO();
		tvo.setName(vo.getName());
		tvo.setId(vo.getId());
		return tvo; 
	}

	//팀 목록 리스트 출력
	@Override
	public List<TeamVO> listTeam(int u_id) throws Exception {
		return dao.listTeam(u_id);
	}

	//팀수정(이름)
	@Override
	public int modifyTeam(TeamVO vo) throws Exception {
		return dao.modifyTeam(vo);
	}

	//팀삭제
	@Override
	public int deleteTeam(int t_id) throws Exception {
		return dao.deleteTeam(t_id);
	}
	
}
