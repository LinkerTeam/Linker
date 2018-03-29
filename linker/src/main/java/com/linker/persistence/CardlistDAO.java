package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardlistVO;
import com.linker.domain.ReadCardlistVO;

public interface CardlistDAO {

	// 카드리스트 생성
	public void createCardlist(CardlistVO vo)throws Exception;
	// 카드리스트 수정
	public void updateCardlist(CardlistVO vo)throws Exception;
	// 진행 상태의 카드리스트 조회
	public List<ReadCardlistVO> readCardlist(int p_id) throws Exception;
}