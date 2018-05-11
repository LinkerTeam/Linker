/*
 * 작성자 : 김소영
 */
package com.linker.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.TeamVO;
import com.linker.domain.HistoryVO;
import com.linker.domain.TeamMemberVO;

@Repository
public class HistoryDAOImpl implements HistoryDAO{

	private static String namespace = "com.linker.mapper.historyMapper";
	
	@Inject
	SqlSession session;
	
	//팀을 생성했을 때
	@Override
	public int historyInsertTeamAdd(int u_id, int t_id, String after) throws Exception {
		HistoryVO vo = new HistoryVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		vo.setAfter(after);
		return session.insert(namespace + ".historyInsertTeamAdd", vo);
	}

	//팀을 삭제했을 때
	@Override
	public int historyInsertTeamDelete(TeamVO vo) throws Exception {
		HistoryVO hvo = new HistoryVO();
		hvo.setU_id(vo.getU_id());
		hvo.setAfter(vo.getName());
		hvo.setT_id(vo.getT_id());
		session.insert(namespace + ".historyInsertTeamDelete", hvo);
		return hvo.getId();//insert한 데이터의 id를 service에서 바로 쓰기 위해 Id를 바로 반환해줌
	}

	//팀을 수정했을 때 / 매개변수 : u_id, t_id, before, after
	@Override
	public int historyInsertTeamModify(TeamVO vo) throws Exception {
		HistoryVO hvo = new HistoryVO();
		hvo.setU_id(vo.getU_id());
		hvo.setT_id(vo.getT_id());
		hvo.setBefore(vo.getBefore());
		hvo.setAfter(vo.getName());
		session.insert(namespace + ".historyInsertTeamModify", hvo);
		return hvo.getId();//insert한 데이터의 id를 service에서 바로 쓰기 위해 Id를 바로 반환해줌
	}

	//팀 생성한 데이터 출력
	@Override
	public HistoryVO historySelectTeamAdd(int u_id, int t_id) throws Exception {
		HistoryVO vo = new HistoryVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		return session.selectOne(namespace + ".historySelectTeamAdd", vo);
	}

	//팀 삭제한 데이터 출력
	@Override
	public HistoryVO historySelectTeamDelete(int id) throws Exception {
		HistoryVO hvo = session.selectOne(namespace + ".historySelectTeamDelete", id);
		return hvo;
	}

	//팀 수정한 데이터 출력
	@Override
	public HistoryVO historySelectTeamModify(int id) throws Exception {
		HistoryVO hvo = session.selectOne(namespace + ".historySelectTeamModify", id);
		return hvo;
	}

	////팀원이 추가됬을 때
	@Override
	public int historyInsertTeamMemberAdd(TeamMemberVO vo) throws Exception {
		HistoryVO hvo = new HistoryVO();
		hvo.setAfter(vo.getNickname());
		hvo.setData_id(vo.getInviteU_id());
		hvo.setU_id(vo.getU_id());
		hvo.setT_id(vo.getT_id());
		session.insert(namespace + ".historyInsertTeamMemberAdd", hvo);
		return hvo.getId();//insert한 데이터의 id를 service에서 바로 쓰기 위해 Id를 바로 반환해줌
	}
	
	//팀원이 탈퇴되었을 때
	@Override
	public int historyInsertTeamMemberDelete(TeamMemberVO vo) throws Exception {
		HistoryVO hvo = new HistoryVO();
		hvo.setAfter(vo.getNickname());
		hvo.setData_id(vo.getLeavU_id());
		hvo.setU_id(vo.getU_id());
		hvo.setT_id(vo.getT_id());
		session.insert(namespace + ".historyInsertTeamMemberDelete", hvo);
		return hvo.getId();//insert한 데이터의 id를 service에서 바로 쓰기 위해 Id를 바로 반환해줌
	}
	
	//팀원이 추가된 데이터 출력
	@Override
	public HistoryVO historySelectTeamMemberAdd(int id) throws Exception{
		return session.selectOne(namespace + ".historySelectTeamMemberAdd", id);
	}

	//팀원이 탈퇴된 데이터 출력
	@Override
	public HistoryVO historySelectTeamMemberDelete(int id) throws Exception{
		return session.selectOne(namespace + ".historySelectTeamMemberDelete", id);
	}
}
