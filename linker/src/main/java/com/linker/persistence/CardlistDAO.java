package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardlistVO;

public interface CardlistDAO {
	// 카드리스트 상태  진행중
	public Integer CARDLIST_STATE_INPROGRESS = 1;
	// 카드리스트 상태  달성
	public Integer CARDLIST_STATE_ACHIEVEMENT = 2;
	// 카드리스트 상태  감추기
	public Integer CARDLIST_STATE_HIDING = 3;
	
	// 카드리스트 생성
	public void createCardlist(CardlistVO vo)throws Exception;
	// 카드리스트 제목 수정
	public void updateTitle(CardlistVO vo)throws Exception;
	// 카드리스트 상태 수정
	public void updateState(CardlistVO vo)throws Exception;
	// 진행중인 카드리스트 조회
	public List<CardlistVO> viewListsInProgress()throws Exception;
}