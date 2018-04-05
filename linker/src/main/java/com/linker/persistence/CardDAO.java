package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardVO;

public interface CardDAO {
	
	//카드 생성
	public void createCard(CardVO vo) throws Exception;
	//카드 수정(제목, 내용)
	public void updateCard(CardVO vo) throws Exception;	
	//카드 수정(상태)
	public void updateCardStatus(CardVO vo) throws Exception;	
	//상태값에 따른 카드 조회
	public List<CardVO> listCard(CardVO vo) throws Exception;
	//팝업카드 조회
	public CardVO readPopcard(CardVO vo) throws Exception;
}
