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
	
	@Override
	public List<SearchVO> searchCard(int u_id, String keyword) throws Exception {
		return sdao.searchCard(u_id, keyword);
	}
	
	@Override
	public List<TeamVO> searchMember(int u_id, String keyword) throws Exception {
		List<TeamVO> teamVO = sdao.searchMember(u_id, keyword);
		return teamVO;
	}
	
	@Override
	public List<CardVO> searchArchiveCard(int p_id, String keyword) throws Exception {
		return sdao.searchArchiveCard(p_id, keyword);
	}
	
	@Override
	public List<CardlistVO> searchArchiveCardlist(int p_id, String keyword) throws Exception {
		return sdao.searchArchiveCardlist(p_id, keyword);

	}
	
	@Override
	public List<CardVO> searchHideCard(int p_id, String keyword) throws Exception {
			return sdao.searchHideCard(p_id, keyword);

	}
	
	@Override
	public List<CardlistVO> searchHideCardlist(int p_id, String keyword) throws Exception {
		return sdao.searchHideCardlist(p_id, keyword);
	}

}
