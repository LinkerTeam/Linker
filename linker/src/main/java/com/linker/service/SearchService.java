/*
 * 작성자 : 김소영
 */
package com.linker.service;

import java.util.List;

import com.linker.domain.CardVO;
import com.linker.domain.CardlistVO;
import com.linker.domain.SearchVO;
import com.linker.domain.TeamVO;

public interface SearchService {
	
	//전체 검색에서 카드 검색
	public List<SearchVO> searchCard(int u_id, String keyword) throws Exception;
		
	//팀리스트에서 멤버 검색
	public List<TeamVO> searchMember(int u_id, String keyword) throws Exception;
	
	//달성 탭에서 카드 검색
	public List<CardVO> searchArchiveCard(int p_id, String keyword) throws Exception;
	
	//달성 탭에서 카드리스트 검색
	public List<CardlistVO> searchArchiveCardlist(int p_id, String keyword) throws Exception;
	
	//가리기 탭에서 카드 검색
	public List<CardVO> searchHideCard(int p_id, String keyword) throws Exception;
	
	//가리기 탭에서 카드리스트 검색
	public List<CardlistVO> searchHideCardlist(int p_id, String keyword) throws Exception;	
}
