package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	private static String namespace = "com.linker.mapper.memberMapper";

	@Inject
	SqlSession session;

	// 멤버생성
	@Override
	public int createMember(MemberVO vo) throws Exception {
		return session.insert(namespace + ".createMember", vo);
	}

	// 멤버출력
	@Override
	public List<MemberVO> listMember(int userId) throws Exception {
		return session.selectList(namespace + ".listMember", userId);
	}

	// 멤버권한수정
	@Override
	public int modifyMember(MemberVO vo) throws Exception {
		return session.update(namespace + ".modifyMember", vo);
	}

	// 멤버삭제
	@Override
	public int deleteMember(MemberVO vo) throws Exception {
		return session.delete(namespace + ".deleteMember", vo);
	}

}
