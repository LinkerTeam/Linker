
package com.linker.persistence;

import java.util.List;

import com.linker.domain.CardVO;
import com.linker.domain.CardlistVO;
import com.linker.domain.TeamMemberVO;

public interface SearchDAO {

	//팀리스트에서 멤버 검색
	public List<TeamMemberVO> searchMember(int u_id, String keyword) throws Exception;
	
	//달성 탭에서 카드 검색
	public List<CardVO> e_searchArchiveCard(int p_id, String keyword) throws Exception;
	
	//달성 탭에서 카드 검색
	public List<CardVO> n_searchArchiveCard(int p_id, String keyword) throws Exception;
	
	//달성 탭에서 카드리스트 검색
	public List<CardlistVO> e_searchArchiveCardlist(int p_id, String keyword) throws Exception;
	
	//달성 탭에서 카드리스트 검색
	public List<CardlistVO> n_searchArchiveCardlist(int p_id, String keyword) throws Exception;
		
	//가리기 탭에서 카드 검색
	public List<CardVO> e_searchHideCard(int p_id, String keyword) throws Exception;
	
	//가리기 탭에서 카드 검색
	public List<CardVO> n_searchHideCard(int p_id, String keyword) throws Exception;
	
	//가리기 탭에서 카드리스트 검색
	public List<CardlistVO> e_searchHideCardlist(int p_id, String keyword) throws Exception;	

	//가리기 탭에서 카드리스트 검색
	public List<CardlistVO> n_searchHideCardlist(int p_id, String keyword) throws Exception;	

}
