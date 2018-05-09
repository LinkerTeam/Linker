package com.linker.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.linker.domain.CardlistVO;
import com.linker.domain.ReadCardlistVO;
import com.linker.service.CardlistService;

@RestController
@RequestMapping("/board")
public class CardlistController {
	
	public static final Logger logger = LoggerFactory.getLogger(CardlistController.class);
	
	@Inject
	private CardlistService service;
	
	
	//카드리스트 조회 (특정 프로젝트에 대한 모든 카드리스트 목록
	//URI에 특정 프로젝트id(p_id)를 넣으면 그 프로젝트에 대한 모든 카드리스트 보이도록 함.
	@RequestMapping(value = "/{p_id}", method = RequestMethod.GET)
	public ResponseEntity<List<ReadCardlistVO>> readCardlistAll(@PathVariable("p_id") int p_id) {
		ResponseEntity<List<ReadCardlistVO>> entity = null;
	
		try { 
			entity = new ResponseEntity<>(service.readCardlistAll(p_id), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	//상태값에 따른 카드 조회 (보관, 가리기 탭에서 조회하는 카드 목록)
	@RequestMapping(value = "/{p_id}/cardlist/{ps_id}", method = RequestMethod.GET)
	public ResponseEntity<List<CardlistVO>> listCardlist(@PathVariable("p_id") int p_id, @PathVariable("ps_id") int ps_id) {
		ResponseEntity<List<CardlistVO>> entity = null;
		
		CardlistVO vo = new CardlistVO();
		vo.setP_id(p_id);
		vo.setPs_id(ps_id);
		
		try { 
			entity = new ResponseEntity<>(service.listCardlist(vo), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	/**
	 * 카드리스트 생성
	 * 
	 * @param vo		비동기 통신으로 전달된 JSON 객체
	 * @return			등록된 카드리스트 아이디
	 * @throws Exception
	 */
	@RequestMapping(value = "/{p_id}", method = RequestMethod.POST)
	public ResponseEntity<Integer> registCardlist(@RequestBody CardlistVO vo) throws Exception {
	
		// 등록 요청 결과를 view에 반환해주는 객체
		ResponseEntity<Integer> entity = null;
	
		try {
			// 데이터베이스에 새로운 카드리스트 등록 요청
			service.registCardlist(vo);
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
	@RequestMapping(value = "/{p_id}/cardlist/{cl_id}", method = { RequestMethod.PUT, RequestMethod.PATCH })
	public ResponseEntity<String> updateCardlist(@PathVariable("cl_id") Integer cl_id, @RequestBody ReadCardlistVO vo) throws Exception {

		// 수정 요청 결과를 view에 반환해주는 객체
		ResponseEntity<String> entity = null;
		
		vo.setCl_id(cl_id);
		
		try {
			// 데이터베이스에 카드리스트 수정 요청
			service.updateCardlist(vo);
			// 요청이 성공적으로 반영됐음을 알리는 문자열를 반환
			entity = new ResponseEntity<>("SUCCESS", HttpStatus.OK);
		} catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}