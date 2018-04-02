package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.TeamVO;

@Repository
public class TeamDAOImpl implements TeamDAO {

	private static String namespace = "com.linker.mapper.teamMapper";

	@Inject
	SqlSession session;

	// 팀생성
	@Override
	public int createTeam(TeamVO vo) throws Exception {
		return session.insert(namespace + ".createTeam", vo);
	}

	// 팀 목록 리스트 출력
	@Override
	public List<TeamVO> listTeam(int u_id) throws Exception {
		return session.selectList(namespace + ".listTeam", u_id);
	}

	// 팀이름수정
	@Override
	public int modifyTeam(TeamVO vo) throws Exception {
		return session.update(namespace + ".modifyTeam", vo);
	}

	// 팀삭제
	@Override
	public int deleteTeam(int t_id) throws Exception {
		return session.delete(namespace + ".deleteTeam", t_id);

	}

}
