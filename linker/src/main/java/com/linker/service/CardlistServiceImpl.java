package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.CardlistVO;
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
	public void modifyCardlist(CardlistVO cardlist) throws Exception {
		cardlist_dao.updateCardlist(cardlist);
	}

	// 진행 상태의 카드리스트 조회
	@Override
	public List<CardlistVO> selectListInProgress(int projectID) throws Exception {
		return cardlist_dao.selectListInProgress(projectID);
	}
}