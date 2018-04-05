package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.CardVO;
import com.linker.persistence.CardDAO;

@Service
public class CardServiceImpl implements CardService{
	
	@Inject
	private CardDAO dao;
	
	//카드 생성
	@Override
	public void createCard(CardVO card) throws Exception {
		dao.createCard(card);
	}
	//카드 수정(제목, 내용)
	@Override
	public void updateCard(CardVO card) throws Exception {
		dao.updateCard(card);
	}
	//카드 수정(상태)
	@Override
	public void updateCardStatus(CardVO card) throws Exception {
		dao.updateCardStatus(card);
	}
	//상태값에 따른 카드 목록 조회
	@Override
	public List<CardVO> listCard(CardVO vo) throws Exception {
		return dao.listCard(vo);
	}
	//카드 상세내용 조회
	@Override
	public CardVO readPopcard(CardVO vo) throws Exception {
		return dao.readPopcard(vo);
	}
}
