package com.linker.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.linker.domain.MemberVO;
import com.linker.domain.TeamVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	private static String namespace = "com.linker.mapper.memberMapper";

	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);

	@Inject
	SqlSession session;

	// 멤버생성
	@Override
	public int createMember(MemberVO vo) throws Exception {
		return session.insert(namespace + ".createMember", vo);
	}
	
	// 멤버추가
	@Override
	public int connectTeamMember(int u_id, int t_id) throws Exception {
		MemberVO vo= new MemberVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		return session.insert(namespace + ".connectTeamMember",vo);
	}
	
	//팀에 속한 멤버 리스트 출력(t_id)
	@Override
	public List<MemberVO> TeamHasUsers(int u_id) throws Exception{
		return session.selectList(namespace+".TeamHasUsers", u_id);
	}

	//멤버출력
	@Override
	public MemberVO userHasTeamUid(int u_id, int t_id) throws Exception{
		logger.info("memberDAO implement start.....");
		MemberVO vo = new MemberVO();
		vo.setU_id(u_id);	
		vo.setT_id(t_id);
		return session.selectOne(namespace + ".userHasTeamUid", vo);
	}

	//멤버출력
	@Override
	public MemberVO userHasTeamEmail(String email, int t_id) throws Exception{
		logger.info("memberDAO implement start.....");
		MemberVO vo = new MemberVO();
		vo.setEmail(email);
		vo.setT_id(t_id);
		return session.selectOne(namespace + ".userHasTeamEmail", vo);
	}

	//멤버출력
	@Override
	public MemberVO userEmail(String email) throws Exception{
		logger.info("memberDAO implement start.....");
		MemberVO vo = new MemberVO();
		vo.setEmail(email);
		return session.selectOne(namespace + ".userEmail", vo);
	}

	// 멤버상태코드수정
	@Override
	public int modifyMemberStatus(int u_id, int t_id) throws Exception {
		MemberVO vo = new MemberVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		return session.update(namespace + ".modifyMemberStatus", vo);
	}

	// 멤버권한수정
	@Override
	public int modifyMemberAuth(MemberVO vo) throws Exception {
		return session.update(namespace + ".modifyMemberAuth", vo);
	}

	// 멤버삭제
	@Override
	public int deleteMember(int u_id, int t_id) throws Exception {
		MemberVO vo = new MemberVO();
		vo.setU_id(u_id);
		vo.setT_id(t_id);
		return session.delete(namespace + ".deleteMember", vo);
	}

}
