package com.linker.persistence;


import com.linker.domain.TeamVO;
import com.linker.domain.HistoryVO;
import com.linker.domain.TeamMemberVO;

public interface HistoryDAO {

/*	
 * //팀 이력 전체 조회
 *	public List<HistoryVO> historySelectTeam() throws Exception;
*/
	//팀을 생성했을 때
	public int historyInsertTeamAdd(int u_id, int t_id, String after) throws Exception;
	
	//팀을 삭제했을 때
	public int historyInsertTeamDelete(TeamVO vo) throws Exception;
	
	//팀을 수정했을 때 / 매개변수 : u_id, t_id, before, after
	public int historyInsertTeamModify(TeamVO vo) throws Exception;
	
	//팀 생성한 데이터 출력
	public HistoryVO historySelectTeamAdd(int u_id, int t_id) throws Exception;
	
	//팀 삭제한 데이터 출력
	public HistoryVO historySelectTeamDelete(int id) throws Exception;
	
	//팀 수정한 데이터 출력 / 매개변수 : u_id, t_id, before, after
	public HistoryVO historySelectTeamModify(int id) throws Exception;
	
	//팀원이 추가됬을 때
	public int historyInsertTeamMemberAdd(TeamMemberVO vo) throws Exception;
	
	//팀원이 탈퇴되었을 때
	public int historyInsertTeamMemberDelete(TeamMemberVO vo) throws Exception;
	
	//팀원이 추가된 데이터 출력
	public HistoryVO historySelectTeamMemberAdd(int id) throws Exception;
		
	//팀원이 탈퇴된 데이터 출력
	public HistoryVO historySelectTeamMemberDelete(int id) throws Exception;
}
