package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardlistVO;
import com.linker.domain.ReadCardlistVO;

public interface CardlistDAO {

	// 카드리스트 생성
	public void createCardlist(CardlistVO vo)throws Exception;
	// 카드리스트 수정
	public void updateCardlist(ReadCardlistVO vo)throws Exception;
	// 진행 상태의 카드리스트 조회
	public List<ReadCardlistVO> readCardlistAll(int p_id) throws Exception;
	// 상태값에 따른 카드리스트 조회
	public List<CardlistVO> listCardlist(CardlistVO vo) throws Exception;
}