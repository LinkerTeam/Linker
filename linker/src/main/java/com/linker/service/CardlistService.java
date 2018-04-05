package com.linker.service;

import java.util.List;

import com.linker.domain.CardlistVO;
import com.linker.domain.ReadCardlistVO;

public interface CardlistService {

	// 카드리스트 생성
	public void registCardlist(CardlistVO cardlist)throws Exception;
	// 카드리스트 수정
	public void updateCardlist(ReadCardlistVO vo)throws Exception;
	// 카드리스트, 카드 전체 조회
	public List<ReadCardlistVO> readCardlistAll(int p_id) throws Exception;
	// 상태값에 따른 카드리스트 조회
	public List<CardlistVO> listCardlist(CardlistVO vo) throws Exception;
}
