package com.linker.service;

import java.util.List;

import com.linker.domain.CardAttachVO;
import com.linker.domain.CardVO;

public interface CardService {
	//카드 생성
	public void createCard(CardVO card) throws Exception;
	//카드 수정(제목, 내용)
	public void updateCard(CardVO card) throws Exception;
	//카드 수정(상태)
	public void updateCardStatus(CardVO vo) throws Exception;
	//상태값에 따른 카드 목록 조회
	public List<CardVO> statusCardList(CardVO vo) throws Exception;
	//특정 카드리스트에 대한 진행상태의 카드 목록 조회
	public List<CardVO> listCards(CardVO vo) throws Exception;
	//카드 상세내용 조회
	public CardVO readPopcard(CardVO vo) throws Exception;
	
	//첨부파일 조회
	public List<CardAttachVO> allAttach(Integer c_id) throws Exception;
	//첨부파일 업로드
	public void addAttach(CardAttachVO vo) throws Exception;
	//첨부파일 삭제
	public void deleteAttach(String file) throws Exception;
}
