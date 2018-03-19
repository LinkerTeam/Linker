package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.linker.domain.MemberVO;
import com.linker.domain.TeamVO;
import com.linker.persistence.MemberDAO;
import com.linker.persistence.TeamDAO;

@Service
public class TeamServiceImpl implements TeamService{

	@Inject
	TeamDAO dao;

	//팀생성
	@Override
	public int createTeam(TeamVO vo) throws Exception {
		 return dao.createTeam(vo);
	}

	//팀 목록 리스트 출력
	@Override
	public List<TeamVO> listTeam(int u_id) throws Exception {
		return dao.listTeam(u_id);
	}

	//팀 id 출력
	@Override
	public int selectTeam(String name) throws Exception {
		return dao.selectTeam(name);
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
