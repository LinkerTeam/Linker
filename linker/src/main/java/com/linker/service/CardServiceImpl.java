package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.CardVO;
import com.linker.dto.CardDTO;
import com.linker.persistence.CardDAO;

@Service
public class CardServiceImpl implements CardService{
	
	@Inject
	private CardDAO dao;

	@Override
	public void createCard(CardVO card) throws Exception {
		dao.createCard(card);
	}

	@Override
	public void updateCard(CardVO card) throws Exception {
		dao.updateCard(card);
	}
	
	@Override
	public CardVO readPopcard(CardDTO dto) throws Exception {
		return dao.readPopcard(dto);
	}

}
