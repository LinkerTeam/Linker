package com.linker.service;

import java.util.List;

import com.linker.domain.CardlistVO;
import com.linker.domain.ReadCardlistVO;

public interface CardlistService {

	// 카드리스트 생성
	public void registCardlist(CardlistVO cardlist)throws Exception;
	// 카드리스트 수정
	public void modifyCardlist(CardlistVO cardlist)throws Exception;
	// 카드리스트, 카드 전체 조회
	public List<ReadCardlistVO> readCardlist(int p_id) throws Exception;
}
