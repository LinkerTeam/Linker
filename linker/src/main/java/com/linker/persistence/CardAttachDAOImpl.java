package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.CardAttachVO;

@Repository
public class CardAttachDAOImpl implements CardAttachDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace="com.linker.mapper.cardMapper";
	
	//조회
	@Override
	public List<CardAttachVO> allAttach(Integer c_id) throws Exception {
		return session.selectList(namespace + ".allAttach", c_id);
	}
	//업로드
	@Override
	public void addAttach(CardAttachVO vo) throws Exception {
		session.insert(namespace + ".addAttach", vo);
	}
	//삭제
	@Override
	public void deleteAttach(String file) throws Exception {
		session.delete(namespace + ".deleteAttach", file);
	}
	
}
