package com.linker.service;

import java.util.List;

import com.linker.domain.CardVO;

public interface CardService {
	//카드 생성
	public void createCard(CardVO card) throws Exception;
	//카드 수정(제목, 내용)
	public void updateCard(CardVO card) throws Exception;
	//카드 수정(상태)
	public void updateCardStatus(CardVO vo) throws Exception;
	//상태값에 따른 카드 목록 조회
	public List<CardVO> listCard(CardVO vo) throws Exception;
	//카드 상세내용 조회
	public CardVO readPopcard(CardVO vo) throws Exception;
}
