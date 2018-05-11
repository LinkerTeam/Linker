/*
 * 작성자 : 김소영
 */
package com.linker.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.linker.domain.CardVO;
import com.linker.domain.CardlistVO;
import com.linker.domain.SearchVO;
import com.linker.domain.TeamVO;

@Repository
public class SearchDAOImpl implements SearchDAO{

	private static String namespace = "com.linker.mapper.searchMapper";
	
	@Inject
	SqlSession session;
	
	//전체 검색에서 카드 검색
	public List<SearchVO> searchCard(int u_id, String keyword) throws Exception{
		SearchVO vo = new SearchVO();
		vo.setU_id(u_id);
		vo.setKeyword(keyword);
		return session.selectList(namespace + ".searchCard", vo);
	}

	//팀리스트에서 멤버 검색
	@Override
	public List<TeamVO> searchMember(int u_id, String keyword) throws Exception {
		SearchVO vo = new SearchVO();
		vo.setU_id(u_id);
		vo.setKeyword(keyword);
		return session.selectList(namespace + ".searchMember", vo);
	}

	//달성 탭에서 카드 검색
	@Override
	public List<CardVO> searchArchiveCard(int p_id, String keyword) throws Exception {
		SearchVO vo = new SearchVO();
		vo.setP_id(p_id);
		vo.setKeyword(keyword);
		return session.selectList(namespace + ".searchArchiveCard", vo);
	}

	//달성 탭에서 카드리스트 검색
	@Override
	public List<CardlistVO> searchArchiveCardlist(int p_id, String keyword) throws Exception {
		SearchVO vo = new SearchVO();
		vo.setP_id(p_id);
		vo.setKeyword(keyword);
		return session.selectList(namespace + ".searchArchiveCardlist", vo);
	}
	
	//가리기 탭에서 카드 검색
	@Override
	public List<CardVO> searchHideCard(int p_id, String keyword) throws Exception {
		SearchVO vo = new SearchVO();
		vo.setP_id(p_id);
		vo.setKeyword(keyword);
		return session.selectList(namespace + ".searchHideCard", vo);
	}

	//가리기 탭에서 카드리스트 검색
	@Override
	public List<CardlistVO> searchHideCardlist(int p_id, String keyword) throws Exception {
		SearchVO vo = new SearchVO();
		vo.setP_id(p_id);
		vo.setKeyword(keyword);
		return session.selectList(namespace + ".searchHideCardlist", vo);
	}

}