package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardVO;
import com.linker.domain.ReadCardlistVO;
import com.linker.dto.CardFavoriteDTO;

public interface CardDAO {
	
	//카드 생성
	public void createCard(CardVO vo) throws Exception;
	//카드 수정(제목, 내용)
	public void updateCard(CardVO vo) throws Exception;	
	//카드 수정(상태)
	public void updateCardStatus(CardVO vo) throws Exception;	
	//상태값에 따른 카드 조회
	public List<ReadCardlistVO> statusCardList(CardVO vo) throws Exception;
	//특정 카드리스트에 대한 진행상태의 카드 목록 조회
	public List<ReadCardlistVO> listCards(CardVO vo) throws Exception;
	//팝업카드 조회
	public CardVO readPopcard(CardVO vo) throws Exception;
	//즐겨찾기 조회
	public List<CardVO> allFavorite(CardFavoriteDTO dto) throws Exception;
	//즐겨찾기 추가
	public void favoriteCard(CardFavoriteDTO dto) throws Exception;
	//즐겨찾기 삭제
	public void cardFavoriteDelete(CardFavoriteDTO dto) throws Exception;
}
