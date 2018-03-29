package com.linker.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.CardlistVO;
import com.linker.domain.ReadCardlistVO;

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

	// 카드리스트 수정
	@Override
	public void updateCardlist(CardlistVO vo) throws Exception {
		session.update(namespace+".updateCardlist", vo);
	}

	// 진행 상태의 카드리스트 & 카드 조회
	@Override
	public List<ReadCardlistVO> readCardlist(int p_id) throws Exception {
		return session.selectList(namespace + ".readCardlist", p_id);
	}
}
