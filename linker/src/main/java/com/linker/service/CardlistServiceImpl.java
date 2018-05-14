package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.CardlistVO;
import com.linker.domain.ReadCardlistVO;
import com.linker.persistence.CardlistDAO;

@Service
public class CardlistServiceImpl implements CardlistService {

	@Inject CardlistDAO cardlist_dao;
	
	// 카드리스트 생성
	@Override
	public void registCardlist(CardlistVO cardlist) throws Exception {
		cardlist_dao.createCardlist(cardlist);
	}

	// 카드리스트 수정
	@Override
	public void updateCardlist(ReadCardlistVO vo) throws Exception {
		cardlist_dao.updateCardlist(vo);
	}

	//카드리스트, 카드 전체 조회
	@Override
	public List<ReadCardlistVO> readCardlistAll(int p_id) throws Exception {
		return cardlist_dao.readCardlistAll(p_id);
	}
	
	//상태값에 따른 카드리스트 조회
	@Override
	public List<CardlistVO> listCardlist(CardlistVO vo) throws Exception {
		return cardlist_dao.listCardlist(vo);
	}
}