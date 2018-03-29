package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardVO;
import com.linker.dto.CardDTO;

public interface CardDAO {
	
	//카드 생성
	public void createCard(CardVO vo) throws Exception;
	//카드 수정(내용 변경, 달성, 가리기)
	public void updateCard(CardVO vo) throws Exception;	
	//팝업카드 조회
	public CardVO readPopcard(CardDTO dto) throws Exception;
}
