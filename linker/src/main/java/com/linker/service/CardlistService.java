package com.linker.service;

import java.util.List;

import com.linker.domain.CardlistVO;

public interface CardlistService {

	// 카드리스트 생성
	public void registCardlist(CardlistVO cardlist)throws Exception;
	// 카드리스트 수정
	public void modifyCardlist(CardlistVO cardlist)throws Exception;
	// 진행 상태의 카드리스트 조회
	public List<CardlistVO> selectListInProgress(int projectID)throws Exception;
}
