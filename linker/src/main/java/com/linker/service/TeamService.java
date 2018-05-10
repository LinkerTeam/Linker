/*
 * 작성자 : 김소영
 */
package com.linker.service;

import java.util.List;
import com.linker.domain.TeamVO;
import com.linker.domain.HistoryVO;

public interface TeamService {
	//팀생성 
	public TeamVO createTeam(TeamVO vo) throws Exception;
	//팀 정보 출력(id, name, cdate)
	public TeamVO infoTeam(int t_id) throws Exception;
	//팀 목록 리스트 출력
	public List<TeamVO> listTeam(int u_id) throws Exception;
	//팀수정(이름)
	public HistoryVO modifyTeam(TeamVO vo) throws Exception;
	//팀삭제
	public HistoryVO deleteTeam(TeamVO vo) throws Exception;
}
