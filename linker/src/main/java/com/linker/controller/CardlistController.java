package com.linker.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.linker.domain.CardlistVO;
import com.linker.service.CardlistService;

@Controller
@RequestMapping("krystal/teams/{projectID}")
public class CardlistController {
	
	private static final Logger logger = LoggerFactory.getLogger(CardlistController.class);

	@Inject
	private CardlistService cl_service;

	/**
	 * 진행 상태의 카드리스트 조회
	 * @param projectID	프로젝트 아이디
	 * @param model		조회 결과 데이터를 담는 객체
	 * @return			이동될 화면 페이지명
	 * @throws Exception
	 */
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String listInProgress(@PathVariable("projectID") int projectID, Model model) throws Exception {

		// 데이터베이스에 요청한 조회 결과를 model객체에 담기
		model.addAttribute("cardlist", cl_service.selectListInProgress(projectID));
		return "cardlist";
	}

	/**
	 * 카드리스트 생성
	 * @param vo		비동기 통신으로 전달된 JSON 객체
	 * @return			등록된 카드리스트 아이디
	 * @throws Exception
	 */
	@RequestMapping(value = "", method = RequestMethod.POST)
	public @ResponseBody ResponseEntity<Integer> registCardlist(@RequestBody CardlistVO vo) throws Exception {
	
		// 등록 요청 결과를 view에 반환해주는 객체
		ResponseEntity<Integer> entity = null;
		
		vo.setU_id(1); // 회원 ID를 어떻게 받아와야 할까
	
		try {
			logger.info("============= registCardlist ==========" + vo.toString());
			// 데이터베이스에 새로운 카드리스트 등록 요청
			cl_service.registCardlist(vo);
			// 등록된 카드리스트 아이디를 반환
			entity = new ResponseEntity<>(vo.getId(), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}

	/**
	 * 카드리스트 수정
	 * @param vo		비동기 통신으로 전달된 JSON 객체
	 * @return			수정 요청 결과 문자열
	 * @throws Exception
	 */
	@RequestMapping(value = "/{cardlistID}", method = RequestMethod.PUT)
	public @ResponseBody ResponseEntity<String> changeCardlist(@RequestBody CardlistVO vo) throws Exception {

		// 수정 요청 결과를 view에 반환해주는 객체
		ResponseEntity<String> entity = null;
		
		try {
			logger.info("============= changeCardlist ==========" + vo.toString());
			// 데이터베이스에 카드리스트 수정 요청
			cl_service.modifyCardlist(vo);
			// 요청이 성공적으로 반영됐음을 알리는 문자열를 반환
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}
