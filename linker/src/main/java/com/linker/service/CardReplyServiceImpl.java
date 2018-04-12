package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.CardReplyVO;
import com.linker.persistence.CardReplyDAO;

@Service
public class CardReplyServiceImpl implements CardReplyService{
	
	@Inject
	private CardReplyDAO dao;
	
	//특정 카드의 모든 댓글
	@Override
	public List<CardReplyVO> listReply(Integer c_id) throws Exception{
		return dao.listReply(c_id);
	}
	//등록
	@Override
	public void addReply(CardReplyVO vo) throws Exception{
		dao.createReply(vo);
	}
	//수정
	@Override
	public void modifyReply(CardReplyVO vo) throws Exception{
		dao.updateReply(vo);
	}
	//삭제
	@Override
	public void removeReply(Integer id) throws Exception{
		dao.deleteReply(id);
	}

}
