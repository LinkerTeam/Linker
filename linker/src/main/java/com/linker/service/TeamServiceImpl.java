/*
 * 작성자 : 김소영
 */
package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.linker.domain.TeamVO;
import com.linker.domain.HistoryVO;
import com.linker.persistence.TeamDAO;
import com.linker.persistence.HistoryDAO;

@Service
public class TeamServiceImpl implements TeamService{
	
	@Inject
	TeamDAO tdao;
	
	@Inject
	HistoryDAO hdao;

	//팀생성 
	@Override
	public TeamVO createTeam(TeamVO vo) throws Exception {
		tdao.createTeam(vo);
		TeamVO tvo = new TeamVO();
		tvo.setName(vo.getName());
		tvo.setId(vo.getId());
		return tvo; 
	}
	
	//팀 정보 출력(id, name, cdate)
	public TeamVO infoTeam(int t_id) throws Exception{
		return tdao.infoTeam(t_id);
	}
	
	//팀 목록 리스트 출력
	@Override
	public List<TeamVO> listTeam(int u_id) throws Exception {
		return tdao.listTeam(u_id);
	}

	//팀수정(이름)
	@Transactional
	@Override
	public HistoryVO modifyTeam(TeamVO vo) throws Exception {
		int h_id = hdao.historyInsertTeamModify(vo);
		tdao.modifyTeam(vo);
		return hdao.historySelectTeamModify(h_id);
	}
	
	//팀삭제
	@Transactional
	@Override
	public HistoryVO deleteTeam(TeamVO vo) throws Exception {
		int h_id = hdao.historyInsertTeamDelete(vo);
		tdao.deleteTeam(vo.getT_id());
		return hdao.historySelectTeamDelete(h_id);
	}
	
}