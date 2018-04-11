package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardReplyVO;

public interface CardReplyDAO {
	
	//특정 카드의 모든 댓글 조회
	public List<CardReplyVO> listReply(Integer c_id) throws Exception;
	//등록
	public void createReply(CardReplyVO vo) throws Exception;
	//수정
	public void updateReply(CardReplyVO vo) throws Exception;
	//삭제
	public void deleteReply(Integer id) throws Exception;
	
}
