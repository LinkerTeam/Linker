package com.linker.service;

import java.util.List;

import com.linker.domain.CardReplyVO;

public interface CardReplyService {
	
	//특정 카드의 모든 댓글 조회
	public List<CardReplyVO> listReply(Integer c_id) throws Exception;
	//등록
	public void addReply(CardReplyVO vo) throws Exception;
	//수정
	public void modifyReply(CardReplyVO vo) throws Exception;
	//삭제
	public void removeReply(Integer id) throws Exception;
	
}
