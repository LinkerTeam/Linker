package com.linker.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linker.domain.CardVO;
import com.linker.domain.CardlistVO;
import com.linker.domain.TeamMemberVO;
import com.linker.domain.TeamVO;
import com.linker.domain.UserVO;
import com.linker.service.SearchService;
/* 코드 작성자 : 김소영
 * 주석 작성자 : 김소영*/
@Controller
public class SearchController {

	private static final Logger logger = LoggerFactory.getLogger(SearchController.class);
	
	@Inject
	private SearchService searchService;
	
	//헤더에서 검색하기
	@ResponseBody  
	@RequestMapping(value="/main/search", method=RequestMethod.GET)
	public String searchMemberGET(Model model,HttpSession session) throws Exception{	
		UserVO vo = (UserVO) session.getAttribute("login");
		return "search/search";
	}
	
	//팀 리스트에서 멤버 검색하기
	@ResponseBody  
	@RequestMapping(value="/main/team/search/{keyword}", method=RequestMethod.GET)
	public ResponseEntity<List<TeamVO>> searchMemberGET(@PathVariable("keyword") String keyword, int u_id) throws Exception{
		ResponseEntity<List<TeamVO>> entity = null;
		try {
			List<TeamVO> teamVO = searchService.searchMember(u_id, keyword);
			entity = new ResponseEntity<List<TeamVO>>(teamVO,HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//달성 탭에서 카드 검색하기
	//상태값에 따른 카드 조회 (보관, 가리기 탭에서 조회하는 카드 목록)
	@ResponseBody  
	@RequestMapping(value="/board/{p_id}/searchCard/{keyword}", method = RequestMethod.GET)
	public ResponseEntity<List<CardVO>> searchArchiveCardGET(@PathVariable("p_id") int p_id, @PathVariable("keyword") String keyword, int ps_id){
		ResponseEntity<List<CardVO>> entity = null;
		List<CardVO> cardvo;
		try { 
			if(ps_id == 2) {
				cardvo = searchService.searchArchiveCard(p_id, keyword);
			}else{
				cardvo = searchService.searchHideCard(p_id, keyword);
			}
			entity = new ResponseEntity<List<CardVO>>(cardvo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	//달성 탭에서 카드리스트 검색하기
	//상태값에 따른 카드 조회 (보관, 가리기 탭에서 조회하는 카드 목록)
	@ResponseBody  
	@RequestMapping(value="/board/{p_id}/searchCardlist/{keyword}", method = RequestMethod.GET)
	public ResponseEntity<List<CardlistVO>> searchArchiveCardlistGET(@PathVariable("p_id") int p_id, @PathVariable("keyword") String keyword, int ps_id){
		ResponseEntity<List<CardlistVO>> entity = null;
		List<CardlistVO> cardlistvo;
		try { 
			if(ps_id == 2) {
				cardlistvo = searchService.searchArchiveCardlist(p_id, keyword);				
			}else {
				cardlistvo = searchService.searchHideCardlist(p_id, keyword);
			}
			entity = new ResponseEntity<List<CardlistVO>>(cardlistvo, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
