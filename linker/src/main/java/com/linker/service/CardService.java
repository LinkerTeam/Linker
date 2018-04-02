package com.linker.service;

import java.util.List;

import com.linker.domain.CardVO;
import com.linker.dto.CardDTO;

public interface CardService {
	
	public void createCard(CardVO card)throws Exception;
	
	public void updateCard(CardVO card)throws Exception;
		
	public CardVO readPopcard(CardDTO dto) throws Exception;
}
