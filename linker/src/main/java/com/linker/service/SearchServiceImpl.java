/*
 * 작성자 : 김소영
 */
package com.linker.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.linker.domain.CardVO;
import com.linker.domain.CardlistVO;
import com.linker.domain.SearchVO;
import com.linker.domain.TeamVO;
import com.linker.persistence.SearchDAO;

@Service
public class SearchServiceImpl implements SearchService{

	@Inject
	SearchDAO sdao;
	
	String n_filter = "^[0-9\\s]*$"; //number 유효성겁사
	String e_filter = "^[ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9\\s]*$"; //english/한글 유효성 검사
	
	@Override
	public List<SearchVO> searchCard(int u_id, String keyword) throws Exception {
		if(keyword.matches(n_filter)) {
			return sdao.n_searchCard(u_id, keyword);
		}else if(keyword.matches(e_filter)){
			return sdao.e_searchCard(u_id, keyword);
		}
		return null;
	}
	
	@Override
	public List<TeamVO> searchMember(int u_id, String keyword) throws Exception {
		List<TeamVO> teamVO = sdao.searchMember(u_id, keyword);
		return teamVO;
	}
	
	@Override
	public List<CardVO> searchArchiveCard(int p_id, String keyword) throws Exception {
		if(keyword.matches(n_filter)) {
			return sdao.n_searchArchiveCard(p_id, keyword);
		}else if(keyword.matches(e_filter)){
			return sdao.e_searchArchiveCard(p_id, keyword);
		}
		return null;
	}
	
	@Override
	public List<CardlistVO> searchArchiveCardlist(int p_id, String keyword) throws Exception {
		if(keyword.matches(n_filter)) {
			return sdao.n_searchArchiveCardlist(p_id, keyword);
		}else if(keyword.matches(e_filter)){
			return sdao.e_searchArchiveCardlist(p_id, keyword);
		}
		return null;
	}
	
	@Override
	public List<CardVO> searchHideCard(int p_id, String keyword) throws Exception {
		//키워드에 대한 카드가 있는지 검색한다.
		if(keyword.matches(n_filter)) {
			return sdao.n_searchHideCard(p_id, keyword);
		}else if(keyword.matches(e_filter)){
			return sdao.e_searchHideCard(p_id, keyword);
		}
		return null;
	}
	
	@Override
	public List<CardlistVO> searchHideCardlist(int p_id, String keyword) throws Exception {
		if(keyword.matches(n_filter)) {
			return sdao.n_searchHideCardlist(p_id, keyword);
		}else if(keyword.matches(e_filter)){
			return sdao.e_searchHideCardlist(p_id, keyword);
		}
		return null;
	}

}
