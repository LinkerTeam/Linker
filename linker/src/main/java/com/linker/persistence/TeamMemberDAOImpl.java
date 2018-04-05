package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import org.springframework.stereotype.Repository;

import com.linker.domain.TeamMemberVO;

@Repository
public class TeamMemberDAOImpl implements TeamMemberDAO {

	private static String namespace = "com.linker.mapper.teamMemberMapper";

	@Inject
	SqlSession session;

	//멤버 중복 체크
	@Override
	public int checkMember(String email, int t_id) throws Exception{
		System.out.println("TeamMemberDAO Impl start.....checkMember ");
		TeamMemberVO vo = new TeamMemberVO();
		vo.setEmail(email);
		vo.setT_id(t_id);
		return session.selectOne(namespace + ".checkMember", vo);
	}
		
	// 멤버생성
	@Override
	public int createMember(TeamMemberVO vo) throws Exception {
		return session.insert(namespace + ".createMember", vo);
	}
	
	// 멤버추가
	@Override
	public int connectTeamMember(int u_id, int t_id) throws Exception {
		TeamMemberVO vo= new TeamMemberVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		return session.insert(namespace + ".connectTeamMember",vo);
	}
	
	//팀에 속한 멤버 리스트 출력(t_id)
	@Override
	public List<TeamMemberVO> TeamHasUsers(int u_id) throws Exception{
		return session.selectList(namespace+".TeamHasUsers", u_id);
	}

	//멤버출력
	@Override
	public TeamMemberVO userHasTeamUid(int u_id, int t_id) throws Exception{
		//System.out.println("memberDAO implement start.....");
		TeamMemberVO vo = new TeamMemberVO();
		vo.setU_id(u_id);	
		vo.setT_id(t_id);
		return session.selectOne(namespace + ".userHasTeamUid", vo);
	}

	//멤버출력
	@Override
	public TeamMemberVO userHasTeamEmail(String email, int t_id) throws Exception{
		//System.out.println("memberDAO implement start.....");
		//System.out.println("daoImpl 1 : " + email + ", " + t_id);
		TeamMemberVO vo = new TeamMemberVO();
		vo.setEmail(email);
		vo.setT_id(t_id);
		//System.out.println("daoImpl : " + vo.toString());
		//System.out.println("daoImpl 2 : " + vo.getEmail()+ ", " + vo.getT_id());
		return session.selectOne(namespace + ".userHasTeamEmail", vo);
	}

	//멤버출력
	@Override
	public TeamMemberVO userEmail(String email) throws Exception{
		TeamMemberVO vo = new TeamMemberVO();
		vo.setEmail(email);
		return session.selectOne(namespace + ".userEmail", vo);
	}

	// 소유자수정
	@Override
	public int transferMemberAuth(TeamMemberVO vo) throws Exception {
		//System.out.println("transferMemberAuth : " + vo.toString());
		return session.update(namespace + ".modifyMemberAuth", vo);
	}
		
	// 멤버상태코드수정
	@Override
	public int modifyMemberStatus(int u_id, int t_id) throws Exception {
		TeamMemberVO vo = new TeamMemberVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		return session.update(namespace + ".modifyMemberStatus", vo);
	}

	// 멤버권한수정
	@Override
	public int modifyMemberAuth(TeamMemberVO vo) throws Exception {
		return session.update(namespace + ".modifyMemberAuth", vo);
	}

	// 멤버삭제
	@Override
	public int deleteMember(int u_id, int t_id) throws Exception {
		TeamMemberVO vo = new TeamMemberVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		return session.delete(namespace + ".deleteMember", vo);
	}

}
