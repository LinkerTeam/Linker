package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.CardVO;

@Repository
public class CardDAOImpl implements CardDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace="com.linker.mapper.cardMapper";
	
	//카드 생성
	@Override
	public void createCard(CardVO vo) throws Exception {
		session.insert(namespace + ".createCard", vo);
	}
	//카드 수정(제목, 내용)
	@Override
	public void updateCard(CardVO vo) throws Exception {
		session.update(namespace + ".updateCard", vo);
	}
	//카드 수정(상태)
	@Override
	public void updateCardStatus(CardVO vo) throws Exception {
		session.update(namespace + ".updateCardStatus", vo);
	}
	//상태값에 따른 카드 목록 조회
	@Override
	public List<CardVO> statusCardList(CardVO vo) throws Exception {
		return session.selectList(namespace + ".statusCardList", vo);
	}
	//특정 카드리스트에 대한 진행상태의 카드 목록 조회
	@Override
	public List<CardVO> listCards(CardVO vo) throws Exception {
		return session.selectList(namespace + ".listCards", vo);
	}
	//카드 상세내용 조회
	@Override
	public CardVO readPopcard(CardVO vo) throws Exception {
		return session.selectOne(namespace + ".readPopcard", vo);
	}
}
