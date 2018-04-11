package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.CardReplyVO;

@Repository
public class CardReplyDAOImpl implements CardReplyDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace = "com.linker.mapper.CardReplyMapper";

	//특정 카드의 모든 댓글 조회
	@Override
	public List<CardReplyVO> listReply(Integer c_id) throws Exception {
		return session.selectList(namespace + ".listReply", c_id);
	}
	//등록
	@Override
	public void createReply(CardReplyVO vo) throws Exception {
		session.insert(namespace + ".createReply", vo);
	}
	//수정
	@Override
	public void updateReply(CardReplyVO vo) throws Exception {
		session.update(namespace + ".updateReply", vo);
	}
	//삭제
	@Override
	public void deleteReply(Integer id) throws Exception {
		session.delete(namespace + ".deleteReply", id);
	}

}
