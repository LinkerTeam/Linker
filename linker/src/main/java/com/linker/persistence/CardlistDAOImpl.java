package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.CardlistVO;

@Repository
public class CardlistDAOImpl implements CardlistDAO{

	@Inject
	private SqlSession session;
	
	private static String namespace = "com.linker.mapper.CardlistMapper";
	
	// 카드리스트 생성
	@Override
	public void createCardlist(CardlistVO vo) throws Exception {
		session.insert(namespace+".createCardlist", vo);
	}

	// 카드리스트 제목 수정
	@Override
	public void updateTitle(CardlistVO vo) throws Exception {
		session.update(namespace+".updateTitle", vo);
	}
	
	// 카드리스트 상태 수정
	@Override
	public void updateState(CardlistVO vo) throws Exception {
		session.update(namespace+".updateState", vo);
	}

	// 진행중인 카드리스트 조회
	@Override
	public List<CardlistVO> viewListsInProgress() throws Exception {
		return session.selectList(namespace+".viewListsInProgress");
	}
	
}
