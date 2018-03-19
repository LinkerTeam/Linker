package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.CardVO;
import com.linker.dto.CardDTO;

@Repository
public class CardDAOImpl implements CardDAO{
	
	@Inject
	private SqlSession session;
	
	private static String namespace="com.linker.mapper.cardMapper";

	@Override
	public void createCard(CardVO vo) throws Exception {
		session.insert(namespace + ".createCard", vo);
	}

	@Override
	public CardVO readCard(int id) throws Exception {
		return session.selectOne(namespace + ".readCard", id);
	}

	@Override
	public void updateCard(CardVO vo) throws Exception {
		session.update(namespace + ".updateCard", vo);
	}

	@Override
	public List<CardVO> listCard(int p_id) throws Exception {
		return session.selectList(namespace + ".listCard", p_id);
	}

	@Override
	public CardVO readPopcard(CardDTO dto) throws Exception {
		return session.selectOne(namespace + ".readPopcard", dto);
	}

	
	
	/*@Override
	public void readPopCard(Integer cardID) throws Exception {
		return session.selectOne(namespace) + 
	}

	@Override
	public void updatePopCard(CardVO vo) throws Exception {
		// TODO Auto-generated method stub
		
	}*/
	
}
